### Summary of the Retail Product Performance Analysis Project

This report summarizes key findings from the retail product performance analysis using Python and SQL. 
Visualizations are available in the `03_visualization/visualizations.ipynb` notebook, and all SQL queries are organized in the `02_sql_queries/` folder. 
Data cleaning scripts are in `01_data_cleaning/`.

---

## 1. Sales and Demand Analysis

- Some product categories (Flower/Leaf Vegetables and Capsicum) lead in both revenue and sales volume, even though their average selling price is lower than in other categories.
- Total sales volume is measured in kilograms and shows seasonal fluctuations, though there are drops even during expected high seasons.
- Revenue trends show moderate growth with occasional dips caused by discount campaigns and seasonality.
- Discounted sales make up a large part of total sales, affecting the average selling price per kilogram.

---

## 2. Profit and Loss Analysis

- Gross profit margins differ a lot between categories.
- Losses due to product returns and estimated spoilage impact net profitability, with some categories suffering higher spoilage rates (Flower/Leaf Vegetables and Capsicum).
- Real (net) profit after losses shows areas to improve inventory management.
- Monthly profit trends follow sales peaks and discount times.

---

## 3. Discount Impact Analysis

- Discounts often lead to higher sales volumes but significantly reduce revenue and profit.
- ROI on discount campaigns varies by category, with some resulting in consistent losses.
- The impact of discounts on revenue and profit per order is tracked monthly and yearly.
- Discounted sales generally boost customer demand but require balancing against profitability.

---

## 4. Category and Product-Level Analysis

- Top 3 and bottom 3 products (in 2023) in each category are identified based on net (real) profit.
- Products with many returns and financial losses (in 2023) are noted for analysis.
- Underperforming and “long tail” products (in 2023) with low sales but positive profit are noted based on profit.

---

### Visualizations Notebook

All key visualizations for this project can be found in the notebook:  
`03_visualization/visualizations.ipynb`
