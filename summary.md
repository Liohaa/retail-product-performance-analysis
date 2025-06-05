### Summary of the Retail Product Performance Analysis Project

This report summarizes key findings from the retail product performance analysis using Python and SQL. 
Visualizations are available in the `03_visualization/visualizations.ipynb` notebook, and all SQL queries are organized in the `02_sql_queries/` folder. 
Data cleaning scripts are in `01_data_cleaning/`.

---

## 1. Sales and Demand Analysis

- The percentage of successful orders is low, at 25% of total orders (50% if excluding those still in process or not delivered).
- Revenue and profit show a stable upward trend.
- There is seasonality in sales, with peak profit observed in Q4 2023 due to holiday sales, followed by a noticeable drop after.
- The average order value (AOV) by category varies, but overall remains stable in the range of 86–90, regardless of the total number of orders.

![General Metrics](powerbi/screenshots/general_metrics.png)

---

## 2. User Analysis

- Most orders come from key European, Asian, and American countries.
- New users significantly contribute to profit, especially in recent quarters.
- There is rapid growth in new user registrations and their orders each month.
- December saw the peak in new user registrations: 52% of new users placed an order, but less than 30% of those orders were successful.

![User Analysis](powerbi/screenshots/user_analysis.png)

---

## 3. Order Analysis

- The overall return rate is around 10%.
- Return rates vary by product category and by country.
- Countries like Spain, Japan, and the UK have significantly higher return rates, requiring further investigation.
- Differences in return rates by demographic groups (e.g., gender, age) are minor and not critical.

![Order Analysis](powerbi/screenshots/order_analysis.png)

---

## 4. Product Analysis

- Certain categories and brands lead in terms of profit and sales, depending on the country.
- In many countries, top brands and products have relatively low market shares, indicating strong market segmentation.
- In the US, top brands vary from quarter to quarter — leadership is not stable.
- Profit margins vary across countries and products. Asian countries show the highest average margin, indicating opportunities for income growth and margin optimization.

![Product Analysis](powerbi/screenshots/product_analysis.png)
