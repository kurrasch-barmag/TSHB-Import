-- =============================================
-- Target Table: MainData
-- Description: Main data table for storing processed records
-- =============================================

-- Create MainData table if not exists
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MainData]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[MainData] (
        -- Primary key
        MainDataID INT IDENTITY(1,1) PRIMARY KEY,
        
        -- Business key
        RecordID VARCHAR(50) NOT NULL UNIQUE,
        
        -- Data fields
        Category VARCHAR(100),
        Description NVARCHAR(500),
        Value DECIMAL(18,2),
        Quantity INT,
        StatusCode VARCHAR(20),
        
        -- Audit fields
        CreatedDate DATETIME DEFAULT GETDATE(),
        CreatedBy VARCHAR(100) DEFAULT SYSTEM_USER,
        ModifiedDate DATETIME NULL,
        ModifiedBy VARCHAR(100) NULL,
        
        -- Source tracking
        SourceFileName VARCHAR(255),
        ImportBatch VARCHAR(50),
        ImportDate DATETIME
    );
    
    -- Create indexes
    CREATE INDEX IX_MainData_RecordID ON [dbo].[MainData](RecordID);
    CREATE INDEX IX_MainData_Category ON [dbo].[MainData](Category);
    CREATE INDEX IX_MainData_ImportBatch ON [dbo].[MainData](ImportBatch);
    CREATE INDEX IX_MainData_StatusCode ON [dbo].[MainData](StatusCode);
    
    PRINT 'Table MainData created successfully.';
END
ELSE
BEGIN
    PRINT 'Table MainData already exists.';
END
GO
