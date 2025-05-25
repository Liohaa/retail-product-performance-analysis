# Retail Product Performance Analysis
A data analysis project using Python and SQL that analyzes retail sales data to identify top- and underperforming products, calculate profits and losses, and compare sales with and without discounts.

## Goals

This project helps to better understand key aspects of retail product performance, such as:

- Sales and demand – total sales volume (in units and weight), revenue, and sales trends over time  
- Returns – number of returned items and which products have the most returns  
- Discounts – impact of discounts on sales volume, revenue, and profit margins  
- Profitability – gross profit and product-level margins  
- Losses – estimate of money lost because products are spoiled or returned
- Category performance – identification of top- and underperforming product categories  
- Sales dynamics – time-based analysis of key performance indicators

## Project Structure

- `01_data_cleaning/`: Python scripts to load raw CSVs, convert data types, clean data, find anomalies, and save cleaned CSV files
- `data/raw/`: Original raw CSV files (`products.csv`, `sales.csv`, `cost_prices.csv`, `loss_rates.csv`)  
- `data/cleaned/`: Cleaned CSV files after data type conversion, and preprocessing

## Tools

- Python (pandas) for data preprocessing, cleaning, and anomaly detection 

## Datasets

Raw data includes four CSV files:

- `products.csv`:  Product codes, names and categories  
- `sales.csv`: Sales data with dates, quantities and prices  
- `cost_prices.csv`: Wholesale prices of products over time  
- `loss_rates.csv`: Records of product losses  

Cleaned versions of these files are saved in data/cleaned/ after preprocessing.

## How to Use
