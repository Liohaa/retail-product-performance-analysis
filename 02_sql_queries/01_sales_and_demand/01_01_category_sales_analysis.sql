/* 
Calculates key sales metrics by product category and year,
including total sales volume (in kg), number of sales transactions,
total revenue, average selling price, and percentage of discounted sales.
*/
SELECT 
	TO_CHAR(DATE_TRUNC('year', s.date),'YYYY') AS year,
	p.category,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' THEN s.quantity END),2) AS sales_kg,
	COUNT(CASE WHEN s.sale_return='Sale' THEN s.item_id END) AS sales_records,
	COUNT(CASE WHEN s.sale_return='Return' THEN s.item_id END) AS returns_records,
	ROUND(COUNT(CASE WHEN s.sale_return='Sale' AND s.discount ='Yes' THEN s.item_id END)*100.0 /
			NULLIF(COUNT(CASE WHEN s.sale_return='Sale' THEN s.item_id END),0),2)::text||'%' AS discount_percent,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' THEN s.quantity*s.unit_price END) / 
			NULLIF(SUM(CASE WHEN s.sale_return='Sale' THEN s.quantity END),0),2) AS avg_selling_price,
	ROUND(SUM(CASE WHEN s.sale_return='Sale' THEN s.quantity*s.unit_price END),2) AS revenue
FROM sales s
JOIN products p ON s.item_id=p.item_id
GROUP BY year, category 
ORDER BY year DESC, sales_records DESC;
