/*
===============================================================================
Stored Procedure:Load Bronze Layer
===============================================================================
Script Purpose:
    This script creates the raw ingestion tables for the Bronze layer 
    in the Data Warehouse (pizza_types, pizzas, order_details, orders).
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME;
	BEGIN TRY
		print'========================================================================';
		print'Loading bronze layer';
		print'========================================================================';


		SET @start_time=GETDATE();
		print'>> Truncating Table:bronze.order_details_info';
		TRUNCATE TABLE bronze.order_details_info;

		print'>>Inserting Date Into:bronze.order_details_info';
		BULK INSERT bronze.order_details_info
		from 'C:\Users\mahmo\Downloads\Pizza+Place+Sales\pizza_sales\order_details.csv'
		with(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>>Load Duration:'+ cast(DATEDIFF(SECOND,@start_time,@end_time) AS Nvarchar)+' seconds'

		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.orders_info';
		TRUNCATE TABLE bronze.orders_info ;

		print'>>Inserting Date Into:bronze.orders_info';
		BULK INSERT bronze.orders_info 
		from 'C:\Users\mahmo\Downloads\Pizza+Place+Sales\pizza_sales\orders.csv'
		with(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>>Load Duration:'+ cast(DATEDIFF(SECOND,@start_time,@end_time) AS Nvarchar)+' seconds'

		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.pizza_types_info';
		TRUNCATE TABLE bronze.pizza_types_info

		print'>>Inserting Date Into:bronze.pizza_types_info';
		BULK INSERT bronze.pizza_types_info
		from 'C:\Users\mahmo\Downloads\Pizza+Place+Sales\pizza_sales\pizza_types.csv'
		with(   
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>>Load Duration:'+ cast(DATEDIFF(SECOND,@start_time,@end_time) AS Nvarchar)+' seconds'

		SET @start_time= GETDATE();
		print'>> Truncating Table:bronze.pizzas_info';
		TRUNCATE TABLE bronze.pizzas_info

		print'>>Inserting Date Into:bronze.pizzas_info';
		BULK INSERT bronze.pizzas_info
		from 'C:\Users\mahmo\Downloads\Pizza+Place+Sales\pizza_sales\pizzas.csv'
		with(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>>Load Duration:'+ cast(DATEDIFF(SECOND,@start_time,@end_time) AS Nvarchar)+' seconds'
	END TRY
	BEGIN CATCH
	PRINT'=============================================';
	PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'Errorr Message'+ERROR_MESSAGE();
	PRINT 'Errorr Message'+cast(ERROR_Number() AS Nvarchar);
	PRINT 'Errorr Message'+CAST(ERROR_STATE() AS Nvarchar);
	PRINT'============================================='
	END CATCH
END




