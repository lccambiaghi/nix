# §3 — Macchinari Ispezionati

Dynamic section: one subsection per production process (e.g., "Linea 1", "Linea 2").

## Key Questions Sections to Load
Machinery Inspected, Field Observations, Assets Not Suitable

## Grouping


Components are grouped: Process → Asset → Component. For each unique Process, generate one subsection.

## What To Write (per process)

ONE flowing narrative in four parts. Do NOT use explicit part labels or headers within the content.

### Part A — Process overview (written ONCE per process)
- What the line/process produces and its role in the plant
- Generic machine composition shared across all assets (e.g., "every rolling stand consists of: DC motor + gearbox + drive shafts + rolling cage")
- Operating regime (hours/day, shifts, weekly schedule)
- Current maintenance approach and its limitations for this specific process

### Part B — Shared criticalities (written ONCE per process)
- Common failure modes discussed with the customer team
- Recurring observation types (bearing degradation, high replacement costs, etc.)
- Do NOT repeat these per asset below

### Part C — Pilot scope justification (written ONCE per process)
- Total assets in scope, total measurement points
- Selection rationale (criticality, no redundancy, cost of failure)
- Why monitoring all assets in scope is valuable

### Part D — Per-asset specs (ONLY differentiating info)
For each asset in the process:
- Brand, model, power rating, speed (nameplate data) — keep compact
- Any unique configuration (vertical vs horizontal orientation, etc.)
- Monitorability verdict per component (suitable / not suitable + reason)
- Component-specific notes ONLY if not already covered in shared criticalities

Parts A, B, C are written once for the entire process. Part D does NOT repeat operating schedule, process purpose, redundancy impact, or criticalities.

## Do NOT Start With Survey Context
The survey date, customer name, and facility name are already established. Start IMMEDIATELY with the technical description.

## Placeholders for Missing Info
- `[DA COMPILARE: classificazione indoor/outdoor]`
- `[DA COMPILARE: classificazione ATEX dell'area]`
- `[DA COMPILARE: livello di criticità]`
- `[DA COMPILARE: disponibilità asset di backup]`

## Example Files
- `references/examples/sideralba/03_processo.md` — Linea 1 tube line
- `references/examples/beltrame/03_macchinari.md` — Simac/Pomini rolling stands
