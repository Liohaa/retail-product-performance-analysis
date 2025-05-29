# Block 1: Sales and Demand Analisys

This folder contains SQL queries to analyze sales data by **product category**, **year**, and **month**.

## Important Notes on Data

- Each row in the `sales` table shows either a product sale or a return.
- The `sale_return` column tells if the record is a `'Sale'` or `'Return'`.
- `quantity` is the amount sold or returned in kilograms.
- `unit_price` is the selling price per kilogram (may include discounts).
- `discount` is `'Yes'` if the sale had a discount.
- The `products` table is joined to get product categories.

---

## Queries in this Folder

### 1. Sales Metrics by Year and Category

**Calculates:**

- Total sales volume (kg).
- Number of sales and return transactions.
- Total revenue (only sales).
- Average selling price per kg.
- Percentage of sales with a discount.

**Useful for:**  
Seeing category performance over time and how discounts affect sales.

### 2. Sales Metrics by Month

**Calculates:**

- Total sales volume (kg).
- Number of sales and return transactions.
- Total revenue (only sales).
- Average selling price per kg.
- Discount rate each month (% of sales with discount).

**Useful for:**  
Tracking monthly sales trends, prices, and discount effects.

If you want to change or add queries feel free to ask.
