/*
Analyzes "long tail" and unprofitable products by quarter and category, includes:
identification of low-selling but profitable products ("long tail"),
products with negative profit, metrics: sales volume (kg), revenue, and profit,
segmentation by performance
Using the materialized view and the daily cost price table created in the 02_01 query.
*/
WITH prod AS (
  SELECT 
    TO_CHAR(DATE_TRUNC('quarter', s.date), 'YYYY "Q"Q') AS quarter,
    p.category AS category,
    p.name AS name,
    ROUND(SUM(s.quantity), 2) AS sales_kg,
    ROUND(SUM(s.quantity * s.unit_price), 2) AS revenue,
    ROUND(SUM((s.unit_price - cpd.cost_price) * s.quantity), 2) AS profit
  FROM sales s
  JOIN products p ON s.item_id = p.item_id
  JOIN cost_price_by_day cpd ON s.item_id = cpd.item_id AND s.date = cpd.date
  WHERE s.sale_return = 'Sale'
  GROUP BY quarter, p.category, p.name
)
SELECT *,
	CASE WHEN sales_kg < 100 AND revenue > 1000 AND profit > 0 THEN 'Long_tail'
    	WHEN profit <0  THEN 'Negative_profit' ELSE NULL END AS segment
FROM prod
WHERE (sales_kg < 100 AND revenue > 1000 AND profit > 0) OR profit <0
ORDER BY quarter DESC, profit DESC;
