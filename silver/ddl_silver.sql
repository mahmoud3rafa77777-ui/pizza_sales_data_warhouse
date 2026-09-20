/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
*/
IF OBJECT_ID ('silver.pizza_types_info','U') IS NOT NULL
	DROP TABLE silver.pizza_types_info;
Create Table silver.pizza_types_info(
	pizza_type_id varchar(50),
	name varchar(50),
	category varchar(50),
	ingredients varchar(max),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.pizzas_info','U') IS NOT NULL
	DROP TABLE silver.pizzas_info;

Create Table silver.pizzas_info(
	pizza_id Nvarchar(50),
	pizza_type_id Nvarchar(50),
	size Nvarchar (10),
	price Decimal(10,2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	);

IF OBJECT_ID ('silver.order_details_info','U') IS NOT NULL
	DROP TABLE silver.order_details_info;

Create Table silver.order_details_info( 
	order_details_id Int,
	order_id Int,
	pizza_id Nvarchar(50),
	quantity Int ,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	);

IF OBJECT_ID ('silver.orders_info','U') IS NOT NULL
	DROP TABLE silver.orders_info;


Create Table silver.orders_info(
order_id Int,
date DATE,
time Time,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
