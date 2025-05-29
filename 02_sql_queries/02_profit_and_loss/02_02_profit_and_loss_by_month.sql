/*
Сalculates financial performance metrics by month, including
gross profit and revenue, profit margin percentage, losses due to product returns,
estimated losses due to spoilage, real profit (net of returns and spoilage).
Using the materialized view and the daily cost price table created in the 02_01 query.
*/
SELECT
	TO_CHAR(DATE_TRUNC('month', s.date), 'YYYY-MM') AS month,
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
JOIN loss_rates l ON s.item_id=l.item_id
GROUP BY month
ORDER BY month DESC;
