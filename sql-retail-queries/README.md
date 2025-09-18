# SQL — Retail Sales Analysis

**Goal:** Answer common retail business questions (trends, product performance, regional mix, customer behavior) using SQL on a simple orders dataset.

## Dataset
- **Source:** `retail_orders.csv` (≈300 orders; synthetic sample)
- **Fields:** order_id, order_date, customer_id, product, category, region, quantity, price, amount

## How to run (SQLite)
1. Create a database `retail.db` and a table `retail_orders` (DB Browser recommended).
2. Import `retail_orders.csv` with header row.
3. Open `queries.sql` and run each section.

## Key Questions Covered
1. Monthly revenue trend  
2. Top 10 products by revenue  
3. Revenue by region and month  
4. Average order value (AOV) by month  
5. New vs Returning revenue (overall and by month)  
6. Top customers by lifetime revenue  
7. Category mix by region  
8. Contribution of top 5 products  
9. Cumulative revenue over time (window function)  
10. Top product each month (dense rank)

## Findings (example — replace with your actual results)
- Top 5 products contribute **~X%** of total revenue.
- **Returning** customers drive **~Y%** of monthly revenue on average.
- **[Region]** leads revenue; **[Region]** shows the fastest growth.
- AOV averages **$[value]** and is highest in **[month]**.

