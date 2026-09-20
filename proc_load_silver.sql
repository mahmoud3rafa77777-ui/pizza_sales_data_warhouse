/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

		-- Loading silver.orders_info
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table:silver.orders_info ';
		TRUNCATE TABLE silver.orders_info;
		PRINT '>> Inserting Data Into: silver.orders_info';
		INSERT INTO silver.orders_info (order_id,date,time)
		
		SELECT
			order_id,
			date,
			time
			FROM bronze.orders_info
		
		SET @end_time = GETDATE()
		 PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		;
      
		-- Loading silver.order_details_info
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.order_details_info';
		TRUNCATE TABLE silver.order_details_info;
		PRINT '>> Inserting Data Into: silver.order_details_info';
		INSERT INTO silver.order_details_info (order_details_id,order_id,pizza_id,quantity)
			
		SELECT
		order_details_id, 
		order_id,
		pizza_id,
		quantity	
		FROM bronze.order_details_info;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading pizza types
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.pizza_types_info';
		TRUNCATE TABLE silver.pizza_types_info;
		PRINT '>> Inserting Data Into: silver.pizza_types_info';
		INSERT INTO silver.pizza_types_info (
		pizza_type_id,
		name,
		category,
		ingredients
		)
		SELECT 
		pizza_type_id,
		name,
		category,
		ingredients
			
			
		FROM bronze.pizza_types_info
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading pizzas
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.pizzas_info';
		TRUNCATE TABLE silver.pizzas_info;
		PRINT '>> Inserting Data Into: silver.pizzas_info';
		INSERT INTO silver.pizzas_info (
			pizza_id,
			pizza_type_id,
			size,
			price
		)
		SELECT
			pizza_id,
			pizza_type_id,
			size,
			price
		FROM bronze.pizzas_info;
	    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
