# Power BI — Revenue Dashboard

**Goal:** 3 pages — KPI Overview, Region/Product drilldown, YoY trends with a Date table and DAX measures.

## Steps
1) Import `../sql-retail-queries/retail_orders.csv`
2) Create a **Date** table (DAX `CALENDARAUTO()`)
3) Relationships: Date[Date] → Orders[order_date]
4) Measures:
   - Revenue = SUM(Orders[amount])
   - Revenue LY = CALCULATE([Revenue], DATEADD('Date'[Date], -1, YEAR))
   - YoY % = DIVIDE([Revenue] - [Revenue LY], [Revenue LY])
5) Build visuals and export screenshots into `/screenshots`
6) Add 3–5 Findings below
