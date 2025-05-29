# Block 4: Category Analysis

This folder contains SQL queries to analyze product-level performance by **category**, **year**, and **quarter**.

## Important Notes on Data

- Uses the materialized view and daily cost price table created in the profit and loss analysis queries.
- Focuses on sales volume, revenue, profit, and losses including returns and spoilage.
- Identifies top and bottom performers as well as return-heavy and low-performing products.

---

## Queries in this Folder

### 1. Product Analisys by Category and Year

**Calculates:**

- Sales volume (kg), revenue, profit.
- Losses due to product returns.
- Estimated losses due to spoilage.
- Real (net) profit after subtracting returns and spoilage.
- Identifies top 3 best and bottom 3 worst performing products by category and year, ranked by net profit.

**Useful for:**  
Spotting product leaders and laggards within each category yearly.

### 2. Top Returned Products by Category and Year

**Calculates:**

- Count and quantity of product returns.
- Revenue loss caused by returns.
- Profit loss caused by returns.

**Useful for:**  
Identifying which products have the highest return impact on financials annually.

### 3. Long Tail and Unprofitable Products by Quarter and Category

**Calculates:**

- Identification of low-selling but profitable products (“long tail”).
- Identification of products with negative profit.
- Metrics include sales volume (kg), revenue, and profit.
- Segments products by performance to highlight risks and opportunities.

**Useful for:**  
Managing inventory and focusing on product profitability per quarter.

If you want to modify or add queries, feel free to ask.
