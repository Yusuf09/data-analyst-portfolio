# Excel — Employee Salary Dashboard

**Goal:** 1-page dashboard showing Base Pay, Overtime, Bonus, and Total Compensation by Dept and Role.

## Steps
1) Open `employees.csv` in Excel and **Format as Table**.
2) Add columns:
   - BasePay = HourlyRate * Hours
   - OTPay = 1.5 * HourlyRate * OvertimeHours
   - BonusAmt = BonusPct * (BasePay + OTPay)
   - TotalComp = BasePay + OTPay + BonusAmt
3) Insert **PivotTable** summarizing TotalComp by Dept and Role. Add slicers for Dept and Role.
4) Add a KPI chart of TotalComp by Dept.
5) Save `dashboard.xlsx` and `dashboard.png` screenshot.

## Findings (add 2–4 bullets)
- Dept ____ has the highest total comp...
- Overtime contributes ~__% in Dept ____...
