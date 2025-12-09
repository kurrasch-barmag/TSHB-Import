-- =============================================
-- Target Table: AdditionalInfo
-- Description: Additional information table for extended data
-- =============================================

-- Create AdditionalInfo table if not exists
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdditionalInfo]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[AdditionalInfo] (
        -- Primary key
        InfoID INT IDENTITY(1,1) PRIMARY KEY,
        
        -- Foreign key to MainData
        MainDataID INT NOT NULL,
        
        -- Additional fields
        Field1 NVARCHAR(255),
        Field2 NVARCHAR(255),
        Field3 NVARCHAR(255),
        Field4 NVARCHAR(255),
        Field5 NVARCHAR(255),
        
        -- Audit fields
        CreatedDate DATETIME DEFAULT GETDATE(),
        CreatedBy VARCHAR(100) DEFAULT SYSTEM_USER,
        
        -- Source tracking
        ImportBatch VARCHAR(50),
        
        -- Foreign key constraint
        CONSTRAINT FK_AdditionalInfo_MainData 
            FOREIGN KEY (MainDataID) 
            REFERENCES [dbo].[MainData](MainDataID)
            ON DELETE CASCADE
    );
    
    -- Create indexes
    CREATE INDEX IX_AdditionalInfo_MainDataID ON [dbo].[AdditionalInfo](MainDataID);
    CREATE INDEX IX_AdditionalInfo_ImportBatch ON [dbo].[AdditionalInfo](ImportBatch);
    
    PRINT 'Table AdditionalInfo created successfully.';
END
ELSE
BEGIN
    PRINT 'Table AdditionalInfo already exists.';
END
GO
