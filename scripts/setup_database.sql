-- =============================================
-- Master Setup Script
-- Description: Create all database objects in correct order
-- Usage: Execute once to setup all tables and objects
-- NOTE: This script uses :r command which is specific to SQL Server Management Studio (SSMS)
--       For other SQL clients, execute the individual schema files manually in the order shown below
-- =============================================

SET NOCOUNT ON;
GO

PRINT '========================================';
PRINT 'TSHB Import - Database Setup';
PRINT 'Started: ' + CONVERT(VARCHAR(20), GETDATE(), 120);
PRINT '========================================';
PRINT '';

-- Step 1: Create target tables
PRINT 'Step 1: Creating target tables...';
PRINT '';

-- Create ImportLog table (no dependencies)
PRINT 'Creating ImportLog table...';
:r ../schemas/target/import_log_table.sql
PRINT '';

-- Create MainData table (no dependencies)
PRINT 'Creating MainData table...';
:r ../schemas/target/main_data_table.sql
PRINT '';

-- Create AdditionalInfo table (depends on MainData)
PRINT 'Creating AdditionalInfo table...';
:r ../schemas/target/additional_info_table.sql
PRINT '';

-- Step 2: Create staging table
PRINT 'Step 2: Creating staging table...';
:r ../schemas/staging/staging_table.sql
PRINT '';

PRINT '========================================';
PRINT 'Database Setup Completed!';
PRINT 'Completed: ' + CONVERT(VARCHAR(20), GETDATE(), 120);
PRINT '========================================';
PRINT '';
PRINT 'Next Steps:';
PRINT '1. Load data into staging table using KNIME';
PRINT '2. Run validation script: scripts/validation/validate_staging_data.sql';
PRINT '3. Run import script: scripts/import/import_main_data.sql';
PRINT '';

GO
