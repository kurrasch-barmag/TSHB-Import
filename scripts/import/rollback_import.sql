-- =============================================
-- Rollback Script: Rollback Import Batch
-- Description: Rollback a specific import batch
-- Usage: Set @BatchToRollback and execute
-- =============================================

SET NOCOUNT ON;
GO

-- CONFIGURE THIS VARIABLE
DECLARE @BatchToRollback VARCHAR(50) = 'BATCH_20250101_120000'; -- Change this to your batch ID

PRINT 'Starting rollback process...';
PRINT 'Batch to rollback: ' + @BatchToRollback;
PRINT '';

BEGIN TRY
    BEGIN TRANSACTION;
    
    -- Delete from AdditionalInfo (child table first due to foreign key)
    DELETE FROM [dbo].[AdditionalInfo]
    WHERE ImportBatch = @BatchToRollback;
    
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from AdditionalInfo';
    
    -- Delete from MainData
    DELETE FROM [dbo].[MainData]
    WHERE ImportBatch = @BatchToRollback;
    
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from MainData';
    
    -- Reset staging table processed flag if staging still exists
    IF OBJECT_ID('tempdb..#StagingData') IS NOT NULL
    BEGIN
        UPDATE #StagingData
        SET IsProcessed = 0,
            ProcessedDate = NULL
        WHERE ImportBatch = @BatchToRollback;
        
        PRINT 'Reset ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' staging records';
    END
    
    -- Update import log
    UPDATE [dbo].[ImportLog]
    SET StatusCode = 'RolledBack',
        ErrorMessage = 'Manually rolled back on ' + CONVERT(VARCHAR(20), GETDATE(), 120)
    WHERE ImportBatch = @BatchToRollback;
    
    COMMIT TRANSACTION;
    
    PRINT '';
    PRINT 'Rollback completed successfully!';
    
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    PRINT 'Error during rollback: ' + ERROR_MESSAGE();
    THROW;
END CATCH;

GO
