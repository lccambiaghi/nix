#!/usr/bin/env python3
"""Extract structured data from a site survey review workbook.

Reads the review workbook and writes three JSON files to the output directory:
  - qa.json          : All approved Q&A rows (Question ID, section, question, final answer)
  - components.json  : All approved components with Units > 0 (key nameplate fields)
  - observations.json: All observations flagged for inclusion in the report

Usage:
    python extract_workbook.py <workbook_path> <output_dir>

Example:
    python extract_workbook.py ~/Downloads/review_workbook.xlsx docs/reports/sibelco/sections/
"""

import json
import math
import sys
from pathlib import Path

import pandas as pd


def extract_qa(df: pd.DataFrame) -> list[dict]:
    approved = df[df["Review Status"] == "Approved"]
    rows = []
    for _, row in approved.iterrows():
        final = row["Final"]
        # Skip rows where final answer is 0 or NaN (not collected)
        if pd.isna(final) or final == 0:
            final = None
        else:
            final = str(final).strip()
        rows.append(
            {
                "id": int(row["Question ID"]),
                "section": str(row["Section of the report"]).strip(),
                "question": str(row["Question"]).strip(),
                "final": final,
            }
        )
    return rows


def extract_components(df: pd.DataFrame) -> list[dict]:
    approved = df[df["Review Status"] == "Approved"]
    in_scope = approved[approved["Units"] > 0]
    rows = []
    for _, row in in_scope.iterrows():
        def val(col):
            v = row.get(col)
            return None if pd.isna(v) else v

        rows.append(
            {
                "process": str(row["Process"]).strip(),
                "asset": str(row["Asset"]).strip(),
                "component": str(row["Component"]).strip(),
                "units": int(row["Units"]),
                "brand": val("Final_Brand"),
                "model": val("Final_Model"),
                "year": val("Final_Manufacturing_Year"),
                "power_kw": val("Final_Rated_Power_kW"),
                "speed_rpm": val("Final_Rated_Speed_RPM"),
                "frequency_hz": val("Final_Frequency_Hz"),
                "bearing_type": val("Final_Bearing Type"),
                "report_notes": val("Report Notes"),
            }
        )
    return rows


def extract_observations(df: pd.DataFrame) -> list[dict]:
    include = df[df["Include in Report"] == True]  # noqa: E712
    rows = []
    for _, row in include.iterrows():
        rows.append(
            {
                "text": str(row["Observation Text"]).strip(),
                "scope": str(row["Scope"]).strip(),
                "applies_to": str(row["Final Applies To"]).strip(),
            }
        )
    return rows


def compute_sizing(components: list[dict]) -> dict:
    sensor_count = sum(c["units"] for c in components)
    gateway_count = math.ceil(sensor_count / 10)
    return {
        "sensor_count": sensor_count,
        "gateway_count": gateway_count,
        "installation_days": max(1, math.ceil(sensor_count / 10)),
        "support_hours": 50,
    }


def main() -> None:
    if len(sys.argv) < 3:
        print("Usage: extract_workbook.py <workbook_path> <output_dir>")
        sys.exit(1)

    workbook_path = Path(sys.argv[1])
    output_dir = Path(sys.argv[2])

    if not workbook_path.exists():
        print(f"Error: workbook not found: {workbook_path}")
        sys.exit(1)

    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"Reading: {workbook_path}")
    sheets = pd.read_excel(workbook_path, sheet_name=None)

    qa = extract_qa(sheets["Key Questions and Answers"])
    components = extract_components(sheets["Components"])
    observations = extract_observations(sheets["Observations"])
    sizing = compute_sizing(components)

    (output_dir / "qa.json").write_text(json.dumps(qa, ensure_ascii=False, indent=2))
    (output_dir / "components.json").write_text(
        json.dumps(components, ensure_ascii=False, indent=2)
    )
    (output_dir / "observations.json").write_text(
        json.dumps(observations, ensure_ascii=False, indent=2)
    )
    (output_dir / "sizing.json").write_text(
        json.dumps(sizing, ensure_ascii=False, indent=2)
    )

    print(f"  Q&A rows:      {len(qa)}")
    print(f"  Components:    {len(components)} (in scope)")
    print(f"  Observations:  {len(observations)}")
    print(f"  Sensors:       {sizing['sensor_count']}")
    print(f"  Gateways:      {sizing['gateway_count']}")
    print(f"Written to: {output_dir}")


if __name__ == "__main__":
    main()
