-- =============================================
-- Import Script: Main Data Import
-- Description: Import data from staging table to MainData and AdditionalInfo tables
-- Usage: Execute after loading data into staging table via KNIME
-- =============================================

SET NOCOUNT ON;
GO

DECLARE @ImportBatch VARCHAR(50);
DECLARE @TotalRecords INT = 0;
DECLARE @SuccessfulRecords INT = 0;
DECLARE @FailedRecords INT = 0;
DECLARE @StartTime DATETIME = GETDATE();
DECLARE @ErrorMessage NVARCHAR(1000);

BEGIN TRY
    -- Generate unique import batch ID
    SET @ImportBatch = 'BATCH_' + CONVERT(VARCHAR(20), GETDATE(), 112) + '_' + 
                       REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '');
    
    PRINT 'Starting import process...';
    PRINT 'Import Batch: ' + @ImportBatch;
    
    -- Log import start
    INSERT INTO [dbo].[ImportLog] (ImportBatch, StartTime, StatusCode)
    VALUES (@ImportBatch, @StartTime, 'Started');
    
    DECLARE @LogID INT = SCOPE_IDENTITY();
    
    -- Count total records in staging
    SELECT @TotalRecords = COUNT(*) 
    FROM #StagingData 
    WHERE IsProcessed = 0;
    
    PRINT 'Total records to process: ' + CAST(@TotalRecords AS VARCHAR(10));
    
    -- Update log with total records
    UPDATE [dbo].[ImportLog]
    SET TotalRecords = @TotalRecords,
        StatusCode = 'InProgress'
    WHERE LogID = @LogID;
    
    -- Begin transaction for data import
    BEGIN TRANSACTION;
    
    -- Import into MainData table
    INSERT INTO [dbo].[MainData] (
        RecordID,
        Category,
        Description,
        Value,
        Quantity,
        StatusCode,
        SourceFileName,
        ImportBatch,
        ImportDate,
        CreatedDate,
        CreatedBy
    )
    SELECT 
        s.RecordID,
        s.Category,
        s.Description,
        s.Value,
        s.Quantity,
        s.StatusCode,
        s.SourceFileName,
        @ImportBatch,
        s.ImportDate,
        GETDATE(),
        SYSTEM_USER
    FROM #StagingData s
    WHERE s.IsProcessed = 0
      AND s.RecordID IS NOT NULL
      AND NOT EXISTS (
          SELECT 1 FROM [dbo].[MainData] m 
          WHERE m.RecordID = s.RecordID
      );
    
    SET @SuccessfulRecords = @@ROWCOUNT;
    PRINT 'Inserted ' + CAST(@SuccessfulRecords AS VARCHAR(10)) + ' records into MainData';
    
    -- Import into AdditionalInfo table
    INSERT INTO [dbo].[AdditionalInfo] (
        MainDataID,
        Field1,
        Field2,
        Field3,
        Field4,
        Field5,
        ImportBatch,
        CreatedDate,
        CreatedBy
    )
    SELECT 
        m.MainDataID,
        s.Field1,
        s.Field2,
        s.Field3,
        s.Field4,
        s.Field5,
        @ImportBatch,
        GETDATE(),
        SYSTEM_USER
    FROM #StagingData s
    INNER JOIN [dbo].[MainData] m ON s.RecordID = m.RecordID
    WHERE s.IsProcessed = 0
      AND m.ImportBatch = @ImportBatch
      AND (s.Field1 IS NOT NULL OR s.Field2 IS NOT NULL OR 
           s.Field3 IS NOT NULL OR s.Field4 IS NOT NULL OR s.Field5 IS NOT NULL);
    
    PRINT 'Inserted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records into AdditionalInfo';
    
    -- Mark staging records as processed
    UPDATE s
    SET s.IsProcessed = 1,
        s.ProcessedDate = GETDATE()
    FROM #StagingData s
    INNER JOIN [dbo].[MainData] m ON s.RecordID = m.RecordID
    WHERE m.ImportBatch = @ImportBatch;
    
    -- Commit transaction
    COMMIT TRANSACTION;
    
    -- Calculate failed records
    SET @FailedRecords = @TotalRecords - @SuccessfulRecords;
    
    -- Update import log with success
    UPDATE [dbo].[ImportLog]
    SET EndTime = GETDATE(),
        SuccessfulRecords = @SuccessfulRecords,
        FailedRecords = @FailedRecords,
        StatusCode = 'Completed'
    WHERE LogID = @LogID;
    
    PRINT 'Import completed successfully!';
    PRINT 'Successful: ' + CAST(@SuccessfulRecords AS VARCHAR(10));
    PRINT 'Failed: ' + CAST(@FailedRecords AS VARCHAR(10));
    
END TRY
BEGIN CATCH
    -- Rollback on error
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    -- Capture error details
    SET @ErrorMessage = ERROR_MESSAGE();
    
    PRINT 'Error during import: ' + @ErrorMessage;
    
    -- Update log with error
    UPDATE [dbo].[ImportLog]
    SET EndTime = GETDATE(),
        StatusCode = 'Failed',
        ErrorMessage = @ErrorMessage
    WHERE LogID = @LogID;
    
    -- Re-throw error
    THROW;
END CATCH;

GO
