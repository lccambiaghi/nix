# §1 — L'Impianto

## Key Questions Sections to Load
Cover Page, Executive Summary, Operational Context, Current Maintenance Activities

## What To Write

A comprehensive facility description in 4-6 paragraphs of plain text. This section sets the stage for the entire report — the reader should understand the facility, why it matters, and why predictive maintenance is needed.

### Paragraph 1 — Facility identity
- Location, company name, industry sector
- Strategic importance within the group/network
- Key features (surface area, production type)

### Paragraph 2 — Operational characteristics
- Operating regime (shifts, days/week, continuous vs batch)
- Production capacity (tons/day, annual throughput)
- Role in the supply chain (single site? multi-site?)
- SCADA/telecontrol presence
- Staffing model

### Paragraph 3 — Current maintenance practices (CRITICAL)
This is the most important paragraph — it establishes the pain point.
- Current maintenance model (reactive? time-based? condition-based?)
- Execution model (internal team? external contractors? mixed?)
- Team composition and size
- Reliability/vibration team presence (usually absent)
- Existing monitoring (SCADA-only? ampere monitoring? nothing?)
- Concrete limitations (no root cause analysis, no predictive capability)

### Paragraph 4 — Impact of current approach
- Estimated downtime rate (if available from Q&A)
- Cost impact of current approach (€/hour × hours lost)
- Recurring failure patterns
- Maintenance team stretched thin / doing non-core work
- Cannibalization of spares (if applicable)

### Optional: "Reactive Maintenance Cycle of Doom"
If the facility fits the reactive pattern strongly (high downtime, small team, no structured prevention), include the theoretical framework from the Sideralba example. Set the template variable `optional_reactive_maintenance_cycle_of_doom` with this content.

## Tone
Professional, technical, empathetic to the customer's situation. Avoid being critical — frame problems as opportunities.

## Example Files
- `references/examples/sideralba/01_impianto.md` — extensive example with Cycle of Doom
- `references/examples/beltrame/01_impianto.md` — shorter, more factual
