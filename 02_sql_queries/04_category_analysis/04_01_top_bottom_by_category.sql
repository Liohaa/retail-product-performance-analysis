/*
Product analysis by category and year, including:
sales volume in kg, revenue, profit, losses due to returns,
estimated losses due to spoilage, real profit (net of returns and spoilage).
Identifies top 3 leaders and bottom 3 underperformers by category and year, ranked by net profit.
Using the materialized view and the daily cost price table created in the 02_01 query.
*/
WITH prod AS 
(SELECT 
	TO_CHAR(DATE_TRUNC('year', s.date),'YYYY') AS year,
	p.category AS category,
	p.name AS name,
	ROUND(SUM(s.quantity) FILTER(WHERE sale_return ='Sale') ,2) AS sales_kg,
	ROUND(SUM(s.quantity*s.unit_price) FILTER(WHERE sale_return ='Sale'),2) AS revenue,
	ROUND(SUM((s.unit_price - cpd.cost_price) * s.quantity) FILTER(WHERE sale_return ='Sale'), 2) AS profit,
	COALESCE(ABS(ROUND(SUM((cpd.cost_price-s.unit_price) * ABS (s.quantity)) FILTER(WHERE sale_return ='Return'),2)),0) AS loss_returns,
	COALESCE(ROUND(SUM(cpd.cost_price*s.quantity*l.loss_rate/100.0) FILTER(WHERE sale_return ='Sale'),2),0) AS loss_spoilage
FROM sales s
JOIN products p ON s.item_id=p.item_id
JOIN cost_price_by_day cpd ON s.item_id = cpd.item_id AND s.date = cpd.date
JOIN loss_rates l ON s.item_id=l.item_id
GROUP BY year, p.category, p.name
ORDER BY year DESC, profit DESC
),
prod_rk AS
(SELECT 
	year,category,
	ROW_NUMBER() OVER(PARTITION BY year,category ORDER BY profit - loss_returns - loss_spoilage DESC) AS top_rank,
	ROW_NUMBER() OVER(PARTITION BY year,category ORDER BY profit - loss_returns - loss_spoilage ASC) AS bottom_rank,
	name, sales_kg, revenue, profit, loss_returns,loss_spoilage,
	profit - loss_returns - loss_spoilage as real_profit
FROM prod)
SELECT *
FROM prod_rk
WHERE top_rank <=3
OR bottom_rank <=3
ORDER BY 
	year DESC, category,
	CASE WHEN top_rank <= 3 THEN top_rank ELSE bottom_rank + 300
	END;
