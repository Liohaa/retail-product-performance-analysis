/*
Identifies the top 3 most returned products by category and year, includes:
return count and quantity, revenue loss from returns,
profit loss from returns.
Using the materialized view and the daily cost price table created in the 02_01 query.
*/
WITH prod AS 
(
	SELECT 
	TO_CHAR(DATE_TRUNC('year', s.date),'YYYY') AS year,
	p.category AS category,
	p.name AS name,
	COUNT(sale_return) AS return_count,
	ABS(ROUND(SUM(s.quantity),2)) AS return_kg,
	ABS(ROUND(SUM(s.quantity*s.unit_price),2)) AS loss_revenue,
	COALESCE(ABS(ROUND(SUM((cpd.cost_price-s.unit_price) * ABS (s.quantity)),2)),0) AS loss_profit
	FROM sales s
JOIN products p ON s.item_id=p.item_id
JOIN cost_price_by_day cpd ON s.item_id = cpd.item_id AND s.date = cpd.date
WHERE sale_return ='Return'
GROUP BY year, p.category, p.name
ORDER BY year DESC
),
prod_rk AS
	(SELECT 
	year,category,
	ROW_NUMBER() OVER(PARTITION BY year,category ORDER BY loss_profit DESC) AS rank,
	name, return_count,return_kg,loss_revenue, loss_profit
	FROM prod)
SELECT *
FROM prod_rk
WHERE rank <=3
ORDER BY year DESC, category, rank;
