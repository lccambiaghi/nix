#!/usr/bin/env python3
"""Render the site survey report DOCX from a completed sections directory.

Reads all section markdown files from the sections/ directory, builds the
Jinja2 context, constructs the pricing table, and renders the DOCX template.

Usage:
    python render_docx.py <sections_dir> <output_path> [options]

Options:
    --customer      Customer name (default: read from qa.json)
    --facility      Facility name (default: read from qa.json)
    --survey-date   Survey date string (default: read from qa.json)
    --participants  Participants string (default: read from qa.json)
    --sensors       Sensor count (default: read from sizing.json)
    --gateways      Gateway count (default: read from sizing.json)
    --install-days  Installation days (default: read from sizing.json)
    --template      Path to DOCX template (default: skill assets/report_template.docx)

Example:
    python render_docx.py docs/reports/sibelco/sections/ docs/reports/sibelco/output/report.docx
"""

import argparse
import json
import math
import re
import sys
import zipfile
from pathlib import Path

from docxtpl import DocxTemplate

SKILL_DIR = Path(__file__).parent.parent
DEFAULT_TEMPLATE = SKILL_DIR / "assets" / "report_template.docx"

# Sensor unit price, discount, gateway price, install day rate, support hourly
PRICE_SENSOR = 850.0
DISCOUNT_SENSOR = 0.25
PRICE_GATEWAY = 500.0
PRICE_INSTALL_DAY = 600.0
PRICE_SUPPORT_HOUR = 120.0
SUPPORT_HOURS = 50


def read_json(path: Path) -> dict | list | None:
    if path.exists():
        return json.loads(path.read_text())
    return None


def between(text: str, start: str, end: str | None = None) -> str:
    """Extract text between two section header lines."""
    lines = text.split("\n")
    capturing = False
    result = []
    for line in lines:
        if line.strip() == start:
            capturing = True
            continue
        if capturing:
            if end and line.strip() == end:
                break
            result.append(line)
    return "\n".join(result).strip()


def parse_section_1(sections_dir: Path) -> str:
    return (sections_dir / "01_impianto.md").read_text().strip()


def parse_section_2(sections_dir: Path) -> tuple[str, str]:
    raw = (sections_dir / "02_obiettivi.md").read_text().strip()
    parts = raw.split("\n\n")
    s2_1 = "\n\n".join(parts[:3]).strip()
    s2_2 = "\n\n".join(parts[3:]).strip()
    return s2_1, s2_2


def parse_section_3(sections_dir: Path) -> list[dict]:
    raw = (sections_dir / "03_macchinari.md").read_text().strip()
    proc_sections = re.split(r"\n\n(?=[A-Z][A-Z\s]+—)", raw)
    processes = []
    for ps in proc_sections:
        ps = ps.strip()
        if not ps:
            continue
        lines = ps.split("\n")
        title = lines[0].strip()
        content = "\n".join(lines[1:]).strip()
        processes.append({"title": title, "content": content})
    return processes


def parse_section_4(sections_dir: Path) -> dict:
    raw = (sections_dir / "04_dimensionamento.md").read_text().strip()
    return {
        "4_1": between(raw, "ASSET IDENTIFICATI E SENSORI PER CIASCUN ASSET", "TABELLA RIEPILOGATIVA SENSORI"),
        "4_2": between(raw, "TABELLA RIEPILOGATIVA SENSORI", "TECNOLOGIA"),
        "4_3": between(raw, "TECNOLOGIA", "SUPPORTO ANALISTI CERTIFICATI"),
        "4_4": between(raw, "SUPPORTO ANALISTI CERTIFICATI", "CONNETTIVITÀ"),
        "4_5": between(raw, "CONNETTIVITÀ", "DIMENSIONAMENTO DEL PROGETTO PILOTA"),
        "4_6": between(raw, "DIMENSIONAMENTO DEL PROGETTO PILOTA", "LA NOSTRA ROADMAP"),
        "4_7": between(raw, "LA NOSTRA ROADMAP"),
    }


def parse_section_6(sections_dir: Path) -> dict:
    raw = (sections_dir / "06_roi.md").read_text().strip()
    return {
        "6_1": between(raw, "AMBITO DI CALCOLO", "BENEFICI ECONOMICI ANNUALI STIMATI"),
        "6_2": between(raw, "BENEFICI ECONOMICI ANNUALI STIMATI", "VALORE ECONOMICO COMPLESSIVO"),
        "6_3": between(raw, "VALORE ECONOMICO COMPLESSIVO", "PAYBACK E ROI"),
        "6_4": between(raw, "PAYBACK E ROI"),
    }


def parse_section_7(sections_dir: Path) -> dict:
    raw = (sections_dir / "07_rischi.md").read_text().strip()
    return {
        "7_1": between(raw, "METODOLOGIA", "ANALISI DEI PRINCIPALI RISCHI"),
        "7_2": between(raw, "ANALISI DEI PRINCIPALI RISCHI", "SINTESI: TRASFORMAZIONE DEL PROFILO DI RISCHIO"),
        "7_3": between(raw, "SINTESI: TRASFORMAZIONE DEL PROFILO DI RISCHIO"),
    }


def fmt_eur(amount: float) -> str:
    return f"€ {amount:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")


def build_pricing_table(sensor_count: int, gateway_count: int, install_days: int) -> tuple[list[dict], dict]:
    sensor_total = sensor_count * PRICE_SENSOR
    sensor_discounted = sensor_total * (1 - DISCOUNT_SENSOR)
    gateway_total = gateway_count * PRICE_GATEWAY
    install_total = install_days * PRICE_INSTALL_DAY
    support_total = SUPPORT_HOURS * PRICE_SUPPORT_HOUR

    list_total = sensor_total + gateway_total + install_total + support_total
    net_total = sensor_discounted

    overall_discount = round((1 - net_total / list_total) * 100)

    rows = [
        {
            "Descrizione": "Sensori Seed",
            "Quantità": sensor_count,
            "Prezzo Unitario": fmt_eur(PRICE_SENSOR),
            "Totale Annuo": fmt_eur(sensor_total),
            "Sconto": f"{int(DISCOUNT_SENSOR * 100)}%",
            "Totale Scontato": fmt_eur(sensor_discounted),
        },
        {
            "Descrizione": "Gateway Vento",
            "Quantità": gateway_count,
            "Prezzo Unitario": fmt_eur(PRICE_GATEWAY),
            "Totale Annuo": fmt_eur(gateway_total),
            "Sconto": "100%",
            "Totale Scontato": "€ -",
        },
        {
            "Descrizione": "Installazione",
            "Quantità": install_days,
            "Prezzo Unitario": fmt_eur(PRICE_INSTALL_DAY),
            "Totale Annuo": fmt_eur(install_total),
            "Sconto": "100%",
            "Totale Scontato": "€ -",
        },
        {
            "Descrizione": "Supporto di Personale Qualificato",
            "Quantità": f"{SUPPORT_HOURS} h",
            "Prezzo Unitario": fmt_eur(PRICE_SUPPORT_HOUR),
            "Totale Annuo": fmt_eur(support_total),
            "Sconto": "100%",
            "Totale Scontato": "€ -",
        },
    ]
    totals = {
        "Descrizione": "Totale",
        "Quantità": "",
        "Prezzo Unitario": "",
        "Totale Annuo": fmt_eur(list_total),
        "Sconto": f"~{overall_discount}%",
        "Totale Scontato": fmt_eur(net_total),
    }
    return rows, totals


def get_qa_value(qa: list[dict], question_id: int) -> str | None:
    for item in qa:
        if item["id"] == question_id:
            return item["final"]
    return None


def verify_output(output_path: Path) -> None:
    with zipfile.ZipFile(output_path) as z:
        content = z.read("word/document.xml").decode("utf-8", errors="replace")
    clean = re.sub(r"<[^>]+>", "", content)
    remaining = re.findall(r"\{\{[^}]+\}\}", clean)
    if remaining:
        print(f"WARNING: unfilled placeholders: {set(remaining)}")
    else:
        print("All placeholders filled.")


def main() -> None:
    parser = argparse.ArgumentParser(description="Render site survey report DOCX")
    parser.add_argument("sections_dir", type=Path)
    parser.add_argument("output_path", type=Path)
    parser.add_argument("--customer", default=None)
    parser.add_argument("--facility", default=None)
    parser.add_argument("--survey-date", default=None)
    parser.add_argument("--participants", default=None)
    parser.add_argument("--sensors", type=int, default=None)
    parser.add_argument("--gateways", type=int, default=None)
    parser.add_argument("--install-days", type=int, default=None)
    parser.add_argument("--template", type=Path, default=DEFAULT_TEMPLATE)
    args = parser.parse_args()

    sections_dir = args.sections_dir
    if not sections_dir.exists():
        print(f"Error: sections directory not found: {sections_dir}")
        sys.exit(1)

    # Load extracted data if available
    qa = read_json(sections_dir / "qa.json") or []
    sizing = read_json(sections_dir / "sizing.json") or {}

    # Resolve metadata: CLI args > qa.json > fallback
    customer = args.customer or get_qa_value(qa, 1) or "[DA COMPILARE: nome cliente]"
    facility = args.facility or get_qa_value(qa, 2) or "[DA COMPILARE: nome impianto]"
    survey_date = args.survey_date or get_qa_value(qa, 23) or "[DA COMPILARE: data sopralluogo]"
    participants = args.participants or "[DA COMPILARE: partecipanti]"
    sensor_count = args.sensors or sizing.get("sensor_count", 0)
    gateway_count = args.gateways or sizing.get("gateway_count", math.ceil(sensor_count / 10))
    install_days = args.install_days or sizing.get("installation_days", max(1, math.ceil(sensor_count / 10)))

    print(f"Customer:  {customer}")
    print(f"Facility:  {facility}")
    print(f"Sensors:   {sensor_count}  Gateways: {gateway_count}  Install days: {install_days}")

    # Parse sections
    s4 = parse_section_4(sections_dir)
    s6 = parse_section_6(sections_dir)
    s7 = parse_section_7(sections_dir)
    pricing_table, pricing_totals = build_pricing_table(sensor_count, gateway_count, install_days)

    context = {
        "customer_name": customer,
        "facility_name": facility,
        "survey_date": survey_date,
        "participants": participants,
        "optional_reactive_maintenance_cycle_of_doom": "",
        "section_1_content": parse_section_1(sections_dir),
        "section_2_1_obiettivi": parse_section_2(sections_dir)[0],
        "section_2_2_attivita_svolte": parse_section_2(sections_dir)[1],
        "section_3_processes": parse_section_3(sections_dir),
        "section_4_1_sensori": s4["4_1"],
        "section_4_2_tabella_sensori": s4["4_2"],
        "section_4_2_table": pricing_table,
        "section_4_2_totals": pricing_totals,
        "section_4_3_tecnologia": s4["4_3"],
        "section_4_4_supporto_analisti": s4["4_4"],
        "section_4_5_connettivita": s4["4_5"],
        "section_4_6_pilota": s4["4_6"],
        "section_4_7_roadmap": s4["4_7"],
        "section_5_content": (sections_dir / "05_analisi_economica.md").read_text().strip(),
        "section_6_1_ambito": s6["6_1"],
        "section_6_2_benefici": s6["6_2"],
        "section_6_3_valore": s6["6_3"],
        "section_6_4_payback": s6["6_4"],
        "section_7_1_metodologia": s7["7_1"],
        "section_7_2_analisi_rischi": s7["7_2"],
        "section_7_3_sintesi": s7["7_3"],
    }

    args.output_path.parent.mkdir(parents=True, exist_ok=True)
    doc = DocxTemplate(str(args.template))
    doc.render(context)
    doc.save(str(args.output_path))

    size_kb = args.output_path.stat().st_size // 1024
    print(f"Saved: {args.output_path} ({size_kb} KB)")
    verify_output(args.output_path)


if __name__ == "__main__":
    main()
