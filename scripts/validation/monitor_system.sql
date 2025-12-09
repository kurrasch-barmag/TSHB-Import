-- =============================================
-- Monitoring Script: Import Statistics and Health Check
-- Description: Monitor import performance and data statistics
-- Usage: Run regularly to monitor system health
-- =============================================

SET NOCOUNT ON;
GO

PRINT '========================================';
PRINT 'TSHB Import - System Monitoring Report';
PRINT 'Generated: ' + CONVERT(VARCHAR(20), GETDATE(), 120);
PRINT '========================================';
PRINT '';

-- =============================================
-- Section 1: Import Summary
-- =============================================
PRINT '1. IMPORT SUMMARY (Last 30 days)';
PRINT '----------------------------------------';

SELECT 
    COUNT(*) as TotalImports,
    SUM(TotalRecords) as TotalRecordsProcessed,
    SUM(SuccessfulRecords) as TotalSuccessful,
    SUM(FailedRecords) as TotalFailed,
    AVG(DurationSeconds) as AvgDurationSeconds,
    MAX(DurationSeconds) as MaxDurationSeconds,
    MIN(DurationSeconds) as MinDurationSeconds
FROM [dbo].[ImportLog]
WHERE ImportDate >= DATEADD(day, -30, GETDATE());

PRINT '';

-- =============================================
-- Section 2: Recent Imports
-- =============================================
PRINT '2. RECENT IMPORTS (Last 10)';
PRINT '----------------------------------------';

SELECT TOP 10
    ImportBatch,
    ImportDate,
    SourceFileName,
    TotalRecords,
    SuccessfulRecords,
    FailedRecords,
    StatusCode,
    DurationSeconds,
    CASE 
        WHEN FailedRecords = 0 THEN 'Success'
        WHEN FailedRecords > 0 AND FailedRecords < TotalRecords THEN 'Partial'
        ELSE 'Failed'
    END as Result
FROM [dbo].[ImportLog]
ORDER BY ImportDate DESC;

PRINT '';

-- =============================================
-- Section 3: Failed Imports
-- =============================================
PRINT '3. FAILED IMPORTS (Last 30 days)';
PRINT '----------------------------------------';

SELECT 
    ImportBatch,
    ImportDate,
    SourceFileName,
    StatusCode,
    ErrorMessage
FROM [dbo].[ImportLog]
WHERE StatusCode IN ('Failed', 'Error')
  AND ImportDate >= DATEADD(day, -30, GETDATE())
ORDER BY ImportDate DESC;

IF @@ROWCOUNT = 0
    PRINT 'No failed imports in the last 30 days.';

PRINT '';

-- =============================================
-- Section 4: Data Statistics
-- =============================================
PRINT '4. DATA STATISTICS';
PRINT '----------------------------------------';

-- Total records in MainData
DECLARE @TotalMainData INT;
SELECT @TotalMainData = COUNT(*) FROM [dbo].[MainData];
PRINT 'Total records in MainData: ' + CAST(@TotalMainData AS VARCHAR(10));

-- Total records in AdditionalInfo
DECLARE @TotalAdditionalInfo INT;
SELECT @TotalAdditionalInfo = COUNT(*) FROM [dbo].[AdditionalInfo];
PRINT 'Total records in AdditionalInfo: ' + CAST(@TotalAdditionalInfo AS VARCHAR(10));

-- Records by category
PRINT '';
PRINT 'Records by Category:';
SELECT 
    Category,
    COUNT(*) as RecordCount,
    CAST(COUNT(*) * 100.0 / @TotalMainData as DECIMAL(5,2)) as Percentage
FROM [dbo].[MainData]
GROUP BY Category
ORDER BY RecordCount DESC;

PRINT '';

-- =============================================
-- Section 5: Import Performance Trends
-- =============================================
PRINT '5. IMPORT PERFORMANCE TRENDS (Last 7 days)';
PRINT '----------------------------------------';

SELECT 
    CAST(ImportDate AS DATE) as ImportDay,
    COUNT(*) as NumberOfImports,
    SUM(TotalRecords) as TotalRecords,
    SUM(SuccessfulRecords) as SuccessfulRecords,
    SUM(FailedRecords) as FailedRecords,
    AVG(DurationSeconds) as AvgDurationSec
FROM [dbo].[ImportLog]
WHERE ImportDate >= DATEADD(day, -7, GETDATE())
GROUP BY CAST(ImportDate AS DATE)
ORDER BY ImportDay DESC;

PRINT '';

-- =============================================
-- Section 6: Staging Table Status
-- =============================================
PRINT '6. STAGING TABLE STATUS';
PRINT '----------------------------------------';

IF OBJECT_ID('tempdb..#StagingData') IS NOT NULL
BEGIN
    DECLARE @StagingTotal INT, @StagingProcessed INT, @StagingPending INT;
    
    SELECT @StagingTotal = COUNT(*) FROM #StagingData;
    SELECT @StagingProcessed = COUNT(*) FROM #StagingData WHERE IsProcessed = 1;
    SET @StagingPending = @StagingTotal - @StagingProcessed;
    
    PRINT 'Staging table exists';
    PRINT 'Total records: ' + CAST(@StagingTotal AS VARCHAR(10));
    PRINT 'Processed: ' + CAST(@StagingProcessed AS VARCHAR(10));
    PRINT 'Pending: ' + CAST(@StagingPending AS VARCHAR(10));
    
    IF @StagingPending > 0
        PRINT 'WARNING: There are pending records in staging table!';
END
ELSE
BEGIN
    PRINT 'Staging table does not exist (temp table)';
END

PRINT '';

-- =============================================
-- Section 7: Data Quality Metrics
-- =============================================
PRINT '7. DATA QUALITY METRICS';
PRINT '----------------------------------------';

-- Records with missing values
DECLARE @MissingCategory INT, @MissingDescription INT;

SELECT @MissingCategory = COUNT(*) 
FROM [dbo].[MainData] 
WHERE Category IS NULL OR Category = '';

SELECT @MissingDescription = COUNT(*) 
FROM [dbo].[MainData] 
WHERE Description IS NULL OR Description = '';

PRINT 'Records with missing Category: ' + CAST(@MissingCategory AS VARCHAR(10));
PRINT 'Records with missing Description: ' + CAST(@MissingDescription AS VARCHAR(10));

-- Duplicate check
PRINT '';
PRINT 'Potential duplicate RecordIDs:';
SELECT RecordID, COUNT(*) as OccurrenceCount
FROM [dbo].[MainData]
GROUP BY RecordID
HAVING COUNT(*) > 1;

IF @@ROWCOUNT = 0
    PRINT 'No duplicates found.';

PRINT '';

-- =============================================
-- Section 8: System Recommendations
-- =============================================
PRINT '8. SYSTEM RECOMMENDATIONS';
PRINT '----------------------------------------';

DECLARE @RecommendationCount INT = 0;

-- Check for old logs
IF EXISTS (SELECT 1 FROM [dbo].[ImportLog] WHERE ImportDate < DATEADD(day, -90, GETDATE()))
BEGIN
    SET @RecommendationCount = @RecommendationCount + 1;
    PRINT '• Consider archiving or deleting import logs older than 90 days';
END

-- Check for failed imports
IF EXISTS (SELECT 1 FROM [dbo].[ImportLog] WHERE StatusCode = 'Failed' AND ImportDate >= DATEADD(day, -7, GETDATE()))
BEGIN
    SET @RecommendationCount = @RecommendationCount + 1;
    PRINT '• Review recent failed imports and investigate errors';
END

-- Check data quality
IF @MissingCategory > (@TotalMainData * 0.1)
BEGIN
    SET @RecommendationCount = @RecommendationCount + 1;
    PRINT '• More than 10% of records have missing Category - review data quality';
END

-- Check for pending staging data
IF OBJECT_ID('tempdb..#StagingData') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM #StagingData WHERE IsProcessed = 0)
    BEGIN
        SET @RecommendationCount = @RecommendationCount + 1;
        PRINT '• Pending records in staging table - run import or clear staging';
    END
END

IF @RecommendationCount = 0
    PRINT 'No recommendations at this time. System is healthy!';

PRINT '';
PRINT '========================================';
PRINT 'End of Monitoring Report';
PRINT '========================================';
PRINT '';

GO
