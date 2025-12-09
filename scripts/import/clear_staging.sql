-- =============================================
-- Clear Staging Script
-- Description: Clear processed records from staging table
-- Usage: Execute to clean up staging table after successful import
-- =============================================

SET NOCOUNT ON;
GO

PRINT 'Clearing processed records from staging table...';

DECLARE @RecordsToDelete INT;

-- Count processed records
SELECT @RecordsToDelete = COUNT(*) 
FROM #StagingData 
WHERE IsProcessed = 1;

PRINT 'Processed records found: ' + CAST(@RecordsToDelete AS VARCHAR(10));

IF @RecordsToDelete > 0
BEGIN
    -- Delete processed records
    DELETE FROM #StagingData
    WHERE IsProcessed = 1;
    
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' processed records.';
END
ELSE
BEGIN
    PRINT 'No processed records to delete.';
END

-- Show remaining records
DECLARE @RemainingRecords INT;
SELECT @RemainingRecords = COUNT(*) FROM #StagingData;

PRINT 'Remaining records in staging: ' + CAST(@RemainingRecords AS VARCHAR(10));

GO
