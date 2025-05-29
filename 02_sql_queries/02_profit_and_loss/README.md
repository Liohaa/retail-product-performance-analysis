# Block 2: Profit and Loss Analisys

This folder contains SQL queries to analyze financial metrics by **product category**, **year**, and **month**.

## Important Notes on Data

- A materialized view with cost price intervals and a daily cost price table are used for accurate cost calculations.
- Profit margin is expressed as a percentage.
- Losses include both product returns and estimated spoilage.

---

## Queries in this Folder

### 1. Profit and Loss by Year and Category

**Calculates:**

- Gross profit and total revenue by category and year.
- Profit margin percentage.
- Losses from product returns.
- Estimated spoilage losses.
- Real (net) profit after subtracting returns and spoilage losses.

**Useful for:**  
Evaluating yearly financial health and loss impacts per product category.

### 2. Profit and Loss by Month

**Calculates:**

- Gross profit and total revenue by month.
- Profit margin percentage.
- Losses from product returns.
- Estimated spoilage losses.
- Real (net) profit after subtracting returns and spoilage losses.

**Uses:**  
The materialized view and daily cost price table created in the first query.

**Useful for:**  
Tracking monthly financial results and loss management over time.

If you want to modify or add queries, feel free to ask.
