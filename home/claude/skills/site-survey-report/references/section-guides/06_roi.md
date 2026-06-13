# §6 — Ritorno dell'Investimento

Four subsections with detailed ROI analysis. This section is heavily data-driven — use the formulas below to compute all figures before writing the narrative.

## Key Questions Sections to Load
Economic Analysis

---

## ROI Calculation Formulas

Compute these before writing the subsections. All input parameters come from the Key Questions in the workbook (look for questions about downtime cost, energy cost, failures, inspections, etc.).

### Input Parameters (from workbook)
- **downtime_cost**: €/hour of unplanned downtime (default €1000 if not provided)
- **energy_cost_kwh**: €/kWh (default €0.15)
- **operating_hours**: annual operating hours (default 8000)
- **failures_per_year**: historical annual failures (default 0)
- **downtime_days_per_failure**: days of downtime per failure event (default 0)
- **emergency_cost_difference**: extra € for emergency vs planned repair (default 0)
- **inspections_per_year**: manual vibration inspections per year (default 4)
- **time_per_inspection_hours**: hours per inspection route (default 2.0)
- **technician_hourly_cost**: €/hour for maintenance technician (default €50)

### 1. Failure Prevention Savings (20-40% range)

```
downtime_hours = failures_per_year × downtime_days_per_failure × 24
downtime_cost_total = downtime_hours × downtime_cost

maintenance_cost_per_failure = 8h × technician_hourly_cost + €500 (spare parts)
total_maintenance_cost = failures_per_year × maintenance_cost_per_failure

total_failure_cost = downtime_cost_total + total_maintenance_cost

min_savings = total_failure_cost × 0.20
max_savings = total_failure_cost × 0.40
```

### 2. Emergency vs Planned Maintenance Savings

```
prevention_rate = 0.50
expected_prevented = failures_per_year × prevention_rate
savings = emergency_cost_difference × expected_prevented
```

### 3. Route-based Measurement Replacement (80% reduction)

```
annual_inspection_cost = inspections_per_year × time_per_inspection_hours × technician_hourly_cost
savings = annual_inspection_cost × 0.80
```

### 4. Energy Savings (±20% range)

```
total_power_kw = sum(rated_power_kw) for monitored components (Units > 0)
load_factor = 0.75
annual_energy_kwh = total_power_kw × operating_hours × load_factor
avg_fault_impact = 0.05  (5% average power waste from mechanical faults)
wasted_energy_kwh = annual_energy_kwh × avg_fault_impact
energy_savings = wasted_energy_kwh × energy_cost_kwh

co2_saved_kg = wasted_energy_kwh × 0.4  (Italy grid average kg CO2/kWh)

min_savings = energy_savings × 0.8
max_savings = energy_savings × 1.2
```

Reference fault impacts for the narrative: misalignment +5%, imbalance +3%, bearing defects +8%, lubrication issues +4%.

### 5. Bearing Lifetime Extension (17.5%)

```
monitored_count = count of components with Units > 0
bearing_count = monitored_count × 2  (DE + NDE bearings)
annual_savings = bearing_count × €250 × 0.175
```

### Totals and ROI

```
total_annual_benefit_min = sum of all min savings
total_annual_benefit_max = sum of all max savings
avg_annual_benefit = (min + max) / 2

# Investment (for ROI calc — different from the customer-facing pricing table)
hardware = sensor_count × €250 + gateway_count × €800
installation = sensor_count × €50
subscription_annual = sensor_count × €120
initial_investment = hardware + installation

ROI = (avg_annual_benefit / subscription_annual) × 100  (percentage)
net_annual_benefit = avg_annual_benefit - subscription_annual
payback_months = ceil((initial_investment / net_annual_benefit) × 12)
```

### 5-Year Projection (for §6.3)

```
total_5year_benefits_min = total_annual_benefit_min × 5
total_5year_benefits_max = total_annual_benefit_max × 5
total_5year_investment = initial_investment + subscription_annual × 5
net_value_min = total_5year_benefits_min - total_5year_investment
net_value_max = total_5year_benefits_max - total_5year_investment
```

---

## §6.1 — Ambito di calcolo

1-2 paragraphs:
- Business parameters used (operating hours, energy pricing, downtime costs) — reference where these came from in the customer's answers
- Solution sizing (sensors, gateways, coverage)
- Calculations based on conservative industry benchmarks
- Actual benefits may vary based on specific operating conditions

---

## §6.2 — Benefici economici annuali stimati

Detailed breakdown by category. For each, write 1-2 paragraphs with the specific euro amounts computed above and explain the data sources.

### Categories

**1. Prevention of Unplanned Failures (20-40% reduction)**
Based on failures/year, days of downtime per failure, and €/hour cost. Maintenance cost includes technician labor + spare parts. Explain how predictive maintenance prevents these failures.

**2. Emergency vs Planned Maintenance Savings**
Emergency repairs cost €X more than planned ones. Predictive maintenance allows planning, avoiding emergency premiums.

**3. Route-based Measurement Replacement (80% reduction)**
Continuous sensors replace N manual inspections/year, each taking X hours at €Y/hour.

**4. Energy Efficiency**
Mechanical faults increase consumption (misalignment 5%, bearing defects 8%, etc.). Early detection maintains optimal efficiency. Include CO2 reduction figure.

**5. Bearing Lifetime Extension (17.5%)**
Early detection extends bearing life. Direct annual savings = bearings × €250 × 17.5%.

End with bullet summary of all categories and their ranges.

Note data transparency: calculations use customer-provided data, site survey measurements, and conservative industry benchmarks.

---

## §6.3 — Valore economico complessivo

2-3 paragraphs:
- Upfront investment breakdown (hardware + installation)
- 5-year cumulative benefits vs investment
- Net value over 5 years
- Year-by-year progression described in prose

Emphasize long-term value beyond payback.

---

## §6.4 — Payback e ROI

2-3 paragraphs:
- Payback period in months and what it means
- ROI percentage compared to typical industrial investments
- Key metrics in bullet format: Investment, Annual Benefit, Payback, ROI
- Business case strength statement
