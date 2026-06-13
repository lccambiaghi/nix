# §4 — Dimensionamento della Soluzione

Seven subsections covering the technical solution proposal.

## Key Questions Sections to Load
Machinery Inspected, Assets Not Suitable, Post Survey, Connectivity, Roadmap

---

## §4.1 — Asset identificati e sensori per ciascun asset

### Standard Sensor Placement Rules
- **Electric Motors**: DE + NDE bearings (2 per motor)
- **Gearboxes**: Input + output shaft bearings (2-4; 1 may suffice if bearings <50cm apart)
- **Pumps**: Motor bearings + pump bearing housing (2-3)
- **Fans/Blowers**: Motor DE + NDE + fan bearing (2-3)
- **Compressors**: Motor bearings + compressor head (2-4)

### Structure
1. **Opening paragraph**: technical criteria for sensor placement — reference the rules above for the component types present in THIS facility
2. **Per-asset narrative**: walk through each asset group explaining component composition, sensor count per component, and running subtotals. Group similar/identical assets. Mention cross-comparison value for similar gearboxes.
3. **Excluded components**: pragmatic explanation (low power, stock spare approach more cost-effective)
4. **Bridge to §4.2**: close with "Di seguito una tabella riassuntiva dei sensori"

Do NOT include sensor technology details (covered in §4.3).

---

## §4.2 — Tabella riepilogativa sensori

One-line intro + narrative summary of sensor deployment. The docx template contains a table for the economic analysis that is populated separately (see §5 guide for the pricing table data).

---

## §4.3 — Tecnologia

SHORT (1-2 paragraphs). Practical, not a product brochure.
- Wireless tri-axial vibration sensors
- Integrated surface temperature
- Configurable transmission intervals (measurements every hour, communicated every 6 hours)
- Wireless: no complex cabling, suitable for industrial environment
- Do NOT include cloud/analytics, data security, or marketing language

---

## §4.4 — Supporto analisti certificati

3-4 paragraphs following this exact structure:

**P1 — Weekly support**: continuous weekly support from certified vibration analysts, transforming data into operational decisions. In a context of reactive maintenance and limited resources, this support focuses on diagnosis.

**P2 — Expert interpretation value**: reading and contextualizing signals, distinguishing transient from degradation. Standardized methodology. Prioritization by criticality. Cat III analyst can conduct RCA.

**P3 — Four elements of the support model**:
1. Periodic review of events/trends for early interception
2. Severity classification and intervention time window
3. Troubleshooting support alongside maintenance team
4. Competence transfer through continuous interaction

**P4 — Scalable model**: access to expertise without training paths, single-person dependencies, or turnover risks. Monitoring produces measurable operational value.

---

## §4.5 — Connettività

2-3 paragraphs:

**P1**: Sensors communicate with gateways through proprietary radio protocol optimized for industrial EMI and metallic structures.

**P2**: Gateway deployment: N gateways for N sensors. Gateway-to-cloud: SIM cards (if cellular coverage good) or WiFi/Ethernet. Power: 220V continuous.

**P3** (conditional): Site-specific notes on indoor/outdoor, access constraints.

Placeholders: `[DA COMPILARE: qualità copertura cellulare]`, `[DA COMPILARE: disponibilità prese elettriche per gateway]`

---

## §4.6 — Dimensionamento del progetto pilota

2-3 persuasive paragraphs:

**P1**: After analysis, eMomentum proposes monitoring ALL N assets. This is optimal pilot sizing: concentrates on the reference area while ensuring sufficient coverage.

**P2**: Three key objectives:
1. Measurably reduce risk of unplanned stoppages
2. Allow customer to verify signal quality against maintenance evidence
3. Accelerate validation by detecting behavioral differences between similar machines

**Closing**: Limiting sensors to fewer assets would DELAY data collection and postpone savings.

Do NOT include success criteria or scaling (those go elsewhere).

---

## §4.7 — La nostra roadmap

SHORT (1-2 paragraphs). Energy efficiency focus only.

**P1**: eMomentum is a technology company in continuous evolution. PRIMARY strategic focus: linking mechanical degradation to energy efficiency. Intervene when consumption increases from degradation → positive CO2 impact. Strategic for the customer given energy cost relevance. Recognized by CDP, Plug and Play, Elis.

**Only if sector = Infrastructure or interest in submersible motors**: mention MCSA development for submersible motors, installation inside electrical panels.

Do NOT include implementation timeline (that's §8).

## Example Files
- `references/examples/sideralba/04_dimensionamento.md`
- `references/examples/beltrame/04_dimensionamento.md`
