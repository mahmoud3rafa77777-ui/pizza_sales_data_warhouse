/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
*/
IF OBJECT_ID ('bronze.pizza_types_info','U') IS NOT NULL
	DROP TABLE bronze.pizza_types_info;
Create Table bronze.pizza_types_info(
	pizza_type_id varchar(50),
	name varchar(50),
	category varchar(50),
	ingredients varchar(max)
);

IF OBJECT_ID ('bronze.pizzas_info','U') IS NOT NULL
	DROP TABLE bronze.pizzas_info;

Create Table bronze.pizzas_info(
	pizza_id Nvarchar(50),
	pizza_type_id Nvarchar(50),
	size Nvarchar (10),
	price Decimal(10,2) );

IF OBJECT_ID ('bronze.order_details_info','U') IS NOT NULL
	DROP TABLE bronze.order_details_info;

Create Table bronze.order_details_info( 
	order_details_id Int,
	order_id Int,
	pizza_id Nvarchar(50),
	quantity Int );

IF OBJECT_ID ('bronze.orders_info','U') IS NOT NULL
	DROP TABLE bronze.orders_info;


Create Table bronze.orders_info(
order_id Int,
date DATE,
time Time
);
