/* 
Calculates key sales metrics by month,
including total sales volume (in kg), number of sales transactions,
total revenue, average selling price, and percentage of discounted sales.
*/
SELECT 
	TO_CHAR(DATE_TRUNC('month', date),'YYYY-MM') AS month,
	ROUND(SUM(CASE WHEN sale_return='Sale' THEN quantity END),2) AS sales_kg,
	COUNT(CASE WHEN sale_return='Sale' THEN item_id END) AS sales_records,
	COUNT(CASE WHEN sale_return='Return' THEN item_id END) AS returns_records,
	ROUND(COUNT(CASE WHEN sale_return='Sale' AND discount ='Yes' THEN item_id END)*100.0 /
			NULLIF(COUNT(CASE WHEN sale_return='Sale' THEN item_id END),0),2)::text||'%' AS discount_percent,
	ROUND(SUM(CASE WHEN sale_return='Sale' THEN quantity*unit_price END) / 
			NULLIF(SUM(CASE WHEN sale_return='Sale' THEN quantity END),0),2) AS avg_selling_price,
	ROUND(SUM(CASE WHEN sale_return='Sale' THEN quantity*unit_price END),2) AS revenue
FROM sales
GROUP BY month
ORDER BY month DESC;