/*
Analyzes discount impact by month, including:
Percentage of sales with discount, % impact of discount on average quantity sold per order,
% impact of discount on average revenue per order, % impact of discount on average profit per order,
difference in margin % between discounted and non-discounted sales,
ROI of discounts (%)
Using the materialized view and the daily cost price table created in the 02_01 query.
*/
SELECT 
	TO_CHAR(DATE_TRUNC('month', s.date),'YYYY-MM') AS month,
-- Percentage of sales with discounts
	ROUND(COUNT(s.item_id) FILTER(WHERE s.discount ='Yes')*100.0 /
		NULLIF(COUNT(s.item_id),0),2)::text||'%' AS disc_sales_perc,
-- % impact of discount on average quantity sold per order
	ROUND(
		 (AVG(s.quantity) FILTER (WHERE s.discount ='Yes')
		- AVG(s.quantity) FILTER (WHERE s.discount ='No'))*100.0
		/ NULLIF(AVG(s.quantity) FILTER (WHERE s.discount = 'No'), 0),2)
			::text || '%' AS avg_impact_quantity,
-- % impact of discount on average revenue per order
	ROUND(
		 (AVG(s.quantity*s.unit_price) FILTER (WHERE s.discount ='Yes')
		- AVG(s.quantity*s.unit_price) FILTER (WHERE s.discount ='No'))*100.0
		/ NULLIF(AVG(s.quantity*s.unit_price) FILTER (WHERE s.discount = 'No'), 0),2)
			::text || '%' AS avg_impact_revenue,
-- % impact of discount on average profit per order
	ROUND(
		 (AVG((s.unit_price - cpd.cost_price) * s.quantity) FILTER (WHERE s.discount ='Yes')
		- AVG((s.unit_price - cpd.cost_price) * s.quantity) FILTER (WHERE s.discount ='No'))*100.0
		/ NULLIF(AVG((s.unit_price - cpd.cost_price) * s.quantity) FILTER (WHERE s.discount = 'No'), 0),2)
			::text || '%' AS avg_impact_profit,
-- Difference in margin % between discounted and non-discounted sales
	ROUND(
		(SUM((s.unit_price - cpd.cost_price) * s.quantity) 
        FILTER (WHERE s.discount = 'Yes') * 100.0 /
        NULLIF(SUM(s.quantity * s.unit_price) 
        FILTER (WHERE s.discount = 'Yes'), 0))
	  -
    	(SUM((s.unit_price - cpd.cost_price) * s.quantity) 
        FILTER (WHERE s.discount = 'No') * 100.0 /
        NULLIF(SUM(s.quantity * s.unit_price) 
        FILTER (WHERE s.discount = 'No'), 0)),2)::text || '%' AS margin_diff,
-- ROI of discounts (%)
	 ROUND(
        	(SUM((s.unit_price - cpd.cost_price) * s.quantity) 
            FILTER (WHERE s.discount = 'Yes')
            -
            SUM((s.unit_price - cpd.cost_price) * s.quantity) 
            FILTER (WHERE s.discount = 'No')
        ) * 100.0 /
        NULLIF(
            SUM((s.unit_price - cpd.cost_price) * s.quantity) 
            FILTER (WHERE s.discount = 'No'),0),2)::text || '%' AS roi_discount
FROM sales s
JOIN cost_price_by_day cpd ON s.item_id = cpd.item_id AND s.date = cpd.date
WHERE s.sale_return='Sale'
GROUP BY month
ORDER BY month DESC;

