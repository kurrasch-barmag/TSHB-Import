-- =============================================
-- Staging Table Schema
-- Description: Temporary table for Excel data imported via KNIME
-- =============================================

-- Drop temp table if exists
IF OBJECT_ID('tempdb..#StagingData') IS NOT NULL
    DROP TABLE #StagingData;

-- Create staging temp table
CREATE TABLE #StagingData (
    -- Unique identifier for each staging record
    StagingID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Import metadata
    ImportDate DATETIME DEFAULT GETDATE(),
    ImportBatch VARCHAR(50),
    SourceFileName VARCHAR(255),
    
    -- Common data fields (customize based on your Excel structure)
    RecordID VARCHAR(50),
    Category VARCHAR(100),
    Description NVARCHAR(500),
    Value DECIMAL(18,2),
    Quantity INT,
    StatusCode VARCHAR(20),
    
    -- Additional fields
    Field1 NVARCHAR(255),
    Field2 NVARCHAR(255),
    Field3 NVARCHAR(255),
    Field4 NVARCHAR(255),
    Field5 NVARCHAR(255),
    
    -- Processing flags
    IsProcessed BIT DEFAULT 0,
    ProcessedDate DATETIME NULL,
    ErrorMessage NVARCHAR(1000) NULL,
    
    -- Audit fields
    CreatedDate DATETIME DEFAULT GETDATE(),
    CreatedBy VARCHAR(100) DEFAULT SYSTEM_USER
);

-- Create indexes for better performance
CREATE INDEX IX_StagingData_ImportBatch ON #StagingData(ImportBatch);
CREATE INDEX IX_StagingData_IsProcessed ON #StagingData(IsProcessed);
CREATE INDEX IX_StagingData_RecordID ON #StagingData(RecordID);

-- Grant permissions (adjust as needed)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON #StagingData TO [YourRole];
