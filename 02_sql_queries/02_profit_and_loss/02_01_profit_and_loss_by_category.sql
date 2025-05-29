/*
Сalculates financial performance metrics for each product category by year, including
gross profit and revenue, profit margin percentage, losses due to product returns,
estimated losses due to spoilage, real profit (net of returns and spoilage).
Also includes creation of a materialized view with cost price intervals,
a table with daily cost prices per product
*/
-- 1. Create a materialized view with date intervals and cost price for each item
CREATE MATERIALIZED VIEW cost_price_intervals AS
	SELECT
		item_id,
		cost_price,
		date AS start_date,
		LEAD(date) OVER (PARTITION BY item_id ORDER BY date) AS end_date
	FROM cost_prices;
-- 2. Create a table with daily cost prices for each item
CREATE TABLE cost_price_by_day AS
	SELECT
		item_id,
		cost_price,
		day::date AS date
	FROM cost_price_intervals,
	LATERAL generate_series(start_date, COALESCE(end_date - INTERVAL '1 day', CURRENT_DATE), 
		INTERVAL '1 day') AS day;
-- 3. Main query: calculate profit and losses by category
SELECT
	TO_CHAR(DATE_TRUNC('year', s.date), 'YYYY') AS year,
	p.category,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' THEN s.quantity*s.unit_price END),2) AS revenue,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' 
		THEN(s.unit_price - cpd.cost_price) * s.quantity END), 2) AS profit,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' 
		THEN (s.unit_price - cpd.cost_price) * s.quantity END)*100.0 /
			NULLIF(SUM(CASE WHEN s.sale_return = 'Sale' 
				THEN s.quantity * s.unit_price END),0),2)::text || '%' AS margin_percent,
	ABS(ROUND(SUM(CASE WHEN s.sale_return='Return' 
		THEN (cpd.cost_price-s.unit_price) * ABS (s.quantity) END),2)) AS loss_returns,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' 
		THEN cpd.cost_price*s.quantity*l.loss_rate/100.0 END),2) AS loss_spoilage,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' 
			THEN(s.unit_price - cpd.cost_price) * s.quantity END) 
		- ABS(SUM(CASE WHEN s.sale_return='Return' 
			THEN (cpd.cost_price-s.unit_price) * ABS (s.quantity) END))
		-SUM(CASE WHEN s.sale_return='Sale' 
			THEN cpd.cost_price*s.quantity*l.loss_rate/100.0 END),2) as real_profit
FROM sales s
JOIN cost_price_by_day cpd ON s.item_id = cpd.item_id AND s.date = cpd.date
JOIN products p ON s.item_id=p.item_id
JOIN loss_rates l ON s.item_id=l.item_id
GROUP BY year, p.category
ORDER BY year DESC, real_profit DESC;
