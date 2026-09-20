/*
===============================================================================
DDL Script: Create Gold Layer Views (Star Schema)
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_pizzas
-- =============================================================================
IF OBJECT_ID('gold.dim_pizzas', 'V') IS NOT NULL
    DROP VIEW gold.dim_pizzas;
GO
create view gold.dim_pizzas as
select
p.pizza_id,
p.pizza_type_id,
pt.name AS Pizza_name,
pt.category,
p.size,
pt.ingredients
 from silver.pizzas_info p 
LEFT JOIN silver.pizza_types_info pt
 ON p.pizza_type_id = pt.pizza_type_id
 GO
 -- =============================================================================
-- Create Dimension: gold.dim_orders
-- =============================================================================

IF OBJECT_ID('gold.dim_orders', 'V') IS NOT NULL
    DROP VIEW gold.dim_orders;
GO
create view gold.dim_orders as
select 
order_id,
date,
time
from silver.orders_info
GO
-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
create view gold.fact_sales AS
select 
od.order_details_id,
od.order_id,
od.pizza_id,
od.quantity,
p.size,
p.price AS unit_price,
(od.quantity*p.price) AS total_price
from silver.order_details_info od
LEFT JOIN silver.pizzas_info p 
ON od.pizza_id = p.pizza_id
GO
