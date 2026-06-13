# §5 — Analisi Economica

## Key Questions Sections to Load
Economic Analysis

## What To Write

A persuasive but factual economic analysis narrative. This section also includes a **pricing table** rendered inside the docx template — you need to prepare the table data alongside the narrative.

### 1. Offer Summary
- State offer validity date prominently
- Explain trial period (e.g., 60-day evaluation)
- Payment structure overview

### 2. Investment Summary
- Solution components: N sensors, N gateways
- What's included: monitoring, platform access, technical support
- Installation included

### 3. Annual Benefits
For each category, state the benefit range and briefly explain the value driver:
- Failure prevention: €X – €Y
- Emergency vs planned maintenance: €X
- Route measurement replacement: €X
- Energy efficiency: €X – €Y
- Bearing lifetime extension: €X
- Total: €X – €Y

### 4. Key Metrics
- Present ROI and payback prominently
- Conclude with business case strength

## Pricing Table

The docx template contains a table for the economic analysis. Build the table data with these rows:

### Sizing (derive from Components data)
- **sensor_count** = sum of all "Units" across approved components
- **gateway_count** = ceil(sensor_count / 10)
- **installation_days** = max(1, ceil(sensor_count / 10))
- **support_hours** = 50 (base annual support hours)

### Products

| Item | Unit Price | Unit | Default Discount |
|------|-----------|------|-----------------|
| Sensori Seed | €850.00 | unità | 25% |
| Gateway Vento | €500.00 | unità | 100% (free) |

### Services

| Item | Unit Price | Unit | Default Discount |
|------|-----------|------|-----------------|
| Installazione | €600.00 | giorno | 100% (included) |
| Supporto di Personale Qualificato | €120.00 | ore annue | 100% (included) |

### Table Structure
Each row: Descrizione, Quantità, Prezzo Unitario, Totale Annuo, Sconto, Totale Scontato.

When discount = 100%, show `€ -` in the Totale Scontato column.

Add a **Totale** row at the bottom with sums and overall discount percentage.

## Placeholders
- `[DA COMPILARE: data di validità dell'offerta]`
- `[DA COMPILARE: costo orario fermo impianto]` (if using default €1000)

## Example Files
- `references/examples/sideralba/05_analisi_economica.md`
- `references/examples/beltrame/05_analisi_economica.md`
