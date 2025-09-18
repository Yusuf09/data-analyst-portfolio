-- 0) Quick sanity checks
SELECT COUNT(*) AS rows_loaded FROM retail_orders;
SELECT MIN(order_date), MAX(order_date) FROM retail_orders;

-- 1) Monthly revenue trend
SELECT strftime('%Y-%m-01', order_date) AS month,
       ROUND(SUM(amount),2) AS revenue
FROM retail_orders
GROUP BY month
ORDER BY month;

-- 2) Top 10 products by revenue
SELECT product, ROUND(SUM(amount),2) AS revenue
FROM retail_orders
GROUP BY product
ORDER BY revenue DESC
LIMIT 10;

-- 3) Revenue by region and month
SELECT region,
       strftime('%Y-%m-01', order_date) AS month,
       ROUND(SUM(amount),2) AS revenue
FROM retail_orders
GROUP BY region, month
ORDER BY region, month;

-- 4) Average order value (AOV) per month
SELECT strftime('%Y-%m-01', order_date) AS month,
       ROUND(SUM(amount) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM retail_orders
GROUP BY month
ORDER BY month;

-- 5) First order date per customer (helper)
WITH firsts AS (
  SELECT customer_id, MIN(date(order_date)) AS first_date
  FROM retail_orders
  GROUP BY customer_id
)
SELECT *
FROM firsts
LIMIT 5;

-- 6) New vs Returning revenue split (overall)
WITH firsts AS (
  SELECT customer_id, MIN(date(order_date)) AS first_date
  FROM retail_orders
  GROUP BY customer_id
)
SELECT CASE WHEN date(r.order_date) = f.first_date THEN 'New' ELSE 'Returning' END AS cust_type,
       ROUND(SUM(r.amount),2) AS revenue
FROM retail_orders r
JOIN firsts f USING (customer_id)
GROUP BY cust_type
ORDER BY revenue DESC;

-- 7) New vs Returning revenue by month
WITH firsts AS (
  SELECT customer_id, MIN(date(order_date)) AS first_date
  FROM retail_orders
  GROUP BY customer_id
)
SELECT strftime('%Y-%m-01', r.order_date) AS month,
       CASE WHEN date(r.order_date) = f.first_date THEN 'New' ELSE 'Returning' END AS cust_type,
       ROUND(SUM(r.amount),2) AS revenue
FROM retail_orders r
JOIN firsts f USING (customer_id)
GROUP BY month, cust_type
ORDER BY month, cust_type;

-- 8) Top customers by lifetime revenue
SELECT customer_id, ROUND(SUM(amount),2) AS lifetime_revenue
FROM retail_orders
GROUP BY customer_id
ORDER BY lifetime_revenue DESC
LIMIT 10;

-- 9) Category mix by region
SELECT region, category, ROUND(SUM(amount),2) AS revenue
FROM retail_orders
GROUP BY region, category
ORDER BY region, revenue DESC;

-- 10) Contribution of Top-5 products
WITH prod_rev AS (
  SELECT product, SUM(amount) AS revenue
  FROM retail_orders
  GROUP BY product
),
top5 AS (
  SELECT product FROM prod_rev ORDER BY revenue DESC LIMIT 5
)
SELECT CASE WHEN product IN (SELECT product FROM top5) THEN 'Top 5' ELSE 'Others' END AS bucket,
       ROUND(SUM(amount),2) AS revenue
FROM retail_orders
GROUP BY bucket
ORDER BY revenue DESC;

-- 11) Cumulative revenue over time (window function)
WITH by_day AS (
  SELECT date(order_date) AS day, SUM(amount) AS revenue
  FROM retail_orders
  GROUP BY day
)
SELECT day,
       revenue,
       ROUND(SUM(revenue) OVER (ORDER BY day
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS cum_revenue
FROM by_day
ORDER BY day;

-- 12) Top product each month (dense_rank window)
WITH prod_month AS (
  SELECT strftime('%Y-%m-01', order_date) AS month,
         product,
         SUM(amount) AS revenue
  FROM retail_orders
  GROUP BY month, product
),
ranked AS (
  SELECT month, product, revenue,
         DENSE_RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS rnk
  FROM prod_month
)
SELECT month, product, ROUND(revenue,2) AS revenue
FROM ranked
WHERE rnk = 1
ORDER BY month;
