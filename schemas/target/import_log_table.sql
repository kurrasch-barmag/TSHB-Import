-- =============================================
-- Target Table: ImportLog
-- Description: Log table for tracking import operations
-- =============================================

-- Create ImportLog table if not exists
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportLog]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[ImportLog] (
        -- Primary key
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        
        -- Import information
        ImportBatch VARCHAR(50) NOT NULL,
        ImportDate DATETIME DEFAULT GETDATE(),
        SourceFileName VARCHAR(255),
        
        -- Statistics
        TotalRecords INT DEFAULT 0,
        SuccessfulRecords INT DEFAULT 0,
        FailedRecords INT DEFAULT 0,
        
        -- Status
        StatusCode VARCHAR(20), -- 'Started', 'InProgress', 'Completed', 'Failed'
        ErrorMessage NVARCHAR(1000),
        
        -- Timing
        StartTime DATETIME,
        EndTime DATETIME,
        DurationSeconds AS DATEDIFF(SECOND, StartTime, EndTime),
        
        -- User tracking
        ExecutedBy VARCHAR(100) DEFAULT SYSTEM_USER
    );
    
    -- Create indexes
    CREATE INDEX IX_ImportLog_ImportBatch ON [dbo].[ImportLog](ImportBatch);
    CREATE INDEX IX_ImportLog_ImportDate ON [dbo].[ImportLog](ImportDate);
    CREATE INDEX IX_ImportLog_StatusCode ON [dbo].[ImportLog](StatusCode);
    
    PRINT 'Table ImportLog created successfully.';
END
ELSE
BEGIN
    PRINT 'Table ImportLog already exists.';
END
GO
