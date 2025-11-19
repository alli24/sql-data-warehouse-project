/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
USE Datawarehouse
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME , @batch_strat_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_strat_time = GETDATE();
		PRINT'=================================================';
		PRINT 'Loding Bronze Layer'
	    PRINT'=================================================';
	
		PRINT '-------------------------------------------';
		PRINT 'Loding CRM Tables';
   		PRINT '-------------------------------------------';
 
        SET @start_time = GETDATE();
		PRINT '>> Truncation Table: Bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT '>> Inserting Data Into: Bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncation Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@strat_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncation Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_crm\bronze.crm_sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@strat_time,@end_time) AS NVARCHAR) + ' seconds';
	    PRINT '>> --------------';

		PRINT '-------------------------------------------';
		PRINT '           Loding CRM Tables';
		PRINT '-------------------------------------------';
	
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
    	SET @end_time = GETDATE();
		PRINT '>> Load Table: bronze.erp_loc_a101; : ' + CAST(DATEDIFF(second,@strat_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncation Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Table: bronze.erp_loc_a101; : ' + CAST(DATEDIFF(second,@strat_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------';

	    SET @start_time = GETDATE();
		PRINT '>> Truncation Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
	    BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@strat_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------'
	
        SET @batch_end_time = GETDATE();    
		PRINT'=================================================';
	    PRINT '>> Loading Bronze Layer Is Completed';
	    PRINT '   - Total Load Duration:  ' + CAST(DATEDIFF(second,@batch_strat_time,@batch_end_time) AS NVARCHAR) + ' seconds';
	    PRINT '>> --------------'
	    PRINT'=================================================';
	END TRY
	BEGIN CATCH 
		PRINT'=================================================';
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'ERROR Message' + ERROR_MESSAGE();
		PRINT'ERROR Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'ERROR State' + CAST(ERROR_STATE() AS NVARCHAR);
		 PRINT'=================================================';
	END CATCH
END

END
