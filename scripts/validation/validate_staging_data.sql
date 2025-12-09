-- =============================================
-- Validation Script: Data Quality Checks
-- Description: Validate data in staging table before import
-- Usage: Run before executing import scripts
-- =============================================

SET NOCOUNT ON;
GO

PRINT '========================================';
PRINT 'Data Quality Validation Report';
PRINT 'Generated: ' + CONVERT(VARCHAR(20), GETDATE(), 120);
PRINT '========================================';
PRINT '';

-- Check 1: Total records in staging
DECLARE @TotalRecords INT;
SELECT @TotalRecords = COUNT(*) FROM #StagingData;
PRINT 'Total records in staging table: ' + CAST(@TotalRecords AS VARCHAR(10));
PRINT '';

-- Check 2: Records already processed
DECLARE @ProcessedRecords INT;
SELECT @ProcessedRecords = COUNT(*) FROM #StagingData WHERE IsProcessed = 1;
PRINT 'Already processed records: ' + CAST(@ProcessedRecords AS VARCHAR(10));
PRINT 'Pending records: ' + CAST(@TotalRecords - @ProcessedRecords AS VARCHAR(10));
PRINT '';

-- Check 3: Missing RecordID (critical field)
DECLARE @MissingRecordID INT;
SELECT @MissingRecordID = COUNT(*) 
FROM #StagingData 
WHERE RecordID IS NULL AND IsProcessed = 0;

PRINT 'Records with missing RecordID: ' + CAST(@MissingRecordID AS VARCHAR(10));
IF @MissingRecordID > 0
    PRINT 'WARNING: Records without RecordID will not be imported!';
PRINT '';

-- Check 4: Duplicate RecordID in staging
PRINT 'Duplicate RecordID in staging:';
SELECT RecordID, COUNT(*) as DuplicateCount
FROM #StagingData
WHERE RecordID IS NOT NULL AND IsProcessed = 0
GROUP BY RecordID
HAVING COUNT(*) > 1;

IF @@ROWCOUNT = 0
    PRINT 'No duplicates found.';
PRINT '';

-- Check 5: RecordID already exists in MainData
PRINT 'RecordID already exists in MainData (will be skipped):';
SELECT s.RecordID, s.Category, m.ImportBatch as ExistingBatch
FROM #StagingData s
INNER JOIN [dbo].[MainData] m ON s.RecordID = m.RecordID
WHERE s.IsProcessed = 0;

IF @@ROWCOUNT = 0
    PRINT 'No existing records found.';
PRINT '';

-- Check 6: Data quality - empty required fields
DECLARE @EmptyCategory INT;
SELECT @EmptyCategory = COUNT(*) 
FROM #StagingData 
WHERE (Category IS NULL OR Category = '') AND IsProcessed = 0;

PRINT 'Records with empty Category: ' + CAST(@EmptyCategory AS VARCHAR(10));
IF @EmptyCategory > 0
    PRINT 'INFO: These records will be imported but may need review.';
PRINT '';

-- Check 7: Numeric validation
DECLARE @InvalidValue INT;
SELECT @InvalidValue = COUNT(*) 
FROM #StagingData 
WHERE Value IS NOT NULL AND (Value < 0 OR Value > 999999999) AND IsProcessed = 0;

PRINT 'Records with potentially invalid Value: ' + CAST(@InvalidValue AS VARCHAR(10));
IF @InvalidValue > 0
    PRINT 'WARNING: Please review records with extreme values.';
PRINT '';

-- Check 8: Source file tracking
PRINT 'Source files in staging:';
SELECT SourceFileName, COUNT(*) as RecordCount
FROM #StagingData
WHERE IsProcessed = 0
GROUP BY SourceFileName
ORDER BY SourceFileName;
PRINT '';

-- Check 9: Import batch distribution
PRINT 'Import batches in staging:';
SELECT ImportBatch, COUNT(*) as RecordCount
FROM #StagingData
WHERE IsProcessed = 0
GROUP BY ImportBatch
ORDER BY ImportBatch;
PRINT '';

-- Summary
PRINT '========================================';
PRINT 'Validation Summary';
PRINT '========================================';

DECLARE @ReadyToImport INT;
SELECT @ReadyToImport = COUNT(*) 
FROM #StagingData 
WHERE IsProcessed = 0 
  AND RecordID IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[MainData] m WHERE m.RecordID = #StagingData.RecordID);

PRINT 'Records ready for import: ' + CAST(@ReadyToImport AS VARCHAR(10));

IF @ReadyToImport > 0
BEGIN
    PRINT 'Status: READY - You can proceed with the import.';
END
ELSE
BEGIN
    PRINT 'Status: NOT READY - Please review warnings and errors above.';
END

PRINT '========================================';
PRINT '';

GO
