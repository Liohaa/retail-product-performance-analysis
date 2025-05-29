# Block 3: Discount Impact Analysis

This folder contains SQL queries to analyze the effect of discounts on sales by **product category**, **year**, and **month**.

## Important Notes on Data

- These queries evaluate how discounts affect quantity sold, revenue, profit, and margins.
- ROI (Return on Investment) of discounts is calculated to measure discount effectiveness.
- Calculations use the materialized view and daily cost price table created in the profit and loss analisys queries.

---

## Queries in this Folder

### 1. Discount Impact by Year and Category

**Calculates:**

- Percentage of sales made with a discount.
- Percentage impact of discounts on average quantity sold per order.
- Percentage impact of discounts on average revenue per order.
- Percentage impact of discounts on average profit per order.
- Difference in profit margin percentage between discounted and non-discounted sales.
- ROI of discounts (%).

**Useful for:**  
Assessing how discounts influence yearly sales volume, revenue, profit, and margin by category.

### 2. Discount Impact by Month

**Calculates:**

- Percentage of sales made with a discount.
- Percentage impact of discounts on average quantity sold per order.
- Percentage impact of discounts on average revenue per order.
- Percentage impact of discounts on average profit per order.
- Difference in profit margin percentage between discounted and non-discounted sales.
- ROI of discounts (%).

**Uses:**  
The materialized view and daily cost price table created earlier.

**Useful for:**  
Assessing how discounts influence monthly sales volume, revenue, profit, and margin.

If you want to modify or add queries, feel free to ask.
