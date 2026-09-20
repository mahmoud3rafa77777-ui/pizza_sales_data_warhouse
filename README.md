# pizza_sales_data_warhouse
# 🍕 Pizza Sales Data Warehouse Project

An End-to-End Data Warehousing & Business Intelligence solution built on Microsoft SQL Server using the **Medallion Architecture (Bronze, Silver, Gold)**.

---

## 🏗️ Architecture Overview

The data pipeline processes raw operational data through three structured layers:

1. **Bronze Layer (Raw Data):**
   - Ingests raw data directly from source CSV files using SQL `BULK INSERT`.
   - Preserves original dataset structure with minimal transformations.

2. **Silver Layer (Cleansed & Transformed Data):**
   - Applies data quality checks, filtering, data type enforcement, and structure normalization.
   - Orchestrated via stored procedures (`silver.load_silver`).
   - Tables: `silver.pizza_types_info`, `silver.pizzas_info`, `silver.orders_info`, and `silver.order_details_info`.

3. **Gold Layer (Business & Analytical Star Schema):**
   - Models data into a Star Schema optimized for Business Intelligence & Reporting.
   - Dimensions & Facts exposed via Database Views:
     - **`gold.dim_pizzas`**: Consolidates pizza details, categories, sizes, prices, and ingredients.
     - **`gold.dim_orders`**: Captures order dates and timestamp attributes.
     - **`gold.fact_sales`**: Stores transaction-level sales data, computing metrics like `unit_price` and `total_price`.

---

## 📁 Repository Structure

```text
.
├── bronze/
│   ├── ddl_bronze.sql         # DDL scripts for raw tables
│   └── proc_load_bronze.sql   # Stored procedure to bulk load CSVs
├── silver/
│   ├── ddl_silver.sql         # DDL scripts for cleansed tables
│   └── proc_load_silver.sql   # Stored procedure for Bronze -> Silver ETL
├── gold/
│   └── ddl_gold.sql           # Star Schema views for analytics
└── README.md                  # Project Documentation
