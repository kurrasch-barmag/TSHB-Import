# Example Use Case: Import Excel Data

## Szenario / Scenario

Sie haben eine Excel-Datei `Bestellungen_2025.xlsx` mit Bestelldaten, die Sie in die Datenbank importieren möchten.

You have an Excel file `Bestellungen_2025.xlsx` with order data that you want to import into the database.

---

## Schritt-für-Schritt Anleitung / Step-by-Step Guide

### Schritt 1: Excel-Datei vorbereiten

**Excel-Datei Struktur:**
```
| ID     | Kategorie | Beschreibung          | Wert   | Menge | Status |
|--------|-----------|----------------------|--------|-------|--------|
| ORD001 | Hardware  | Laptop Dell XPS 15   | 1499.99| 2     | Aktiv  |
| ORD002 | Software  | Microsoft Office 365 | 99.99  | 5     | Aktiv  |
| ORD003 | Hardware  | Monitor Samsung 27"  | 299.99 | 3     | Aktiv  |
```

### Schritt 2: Datenbank einrichten (einmalig)

```sql
-- In SQL Server Management Studio (SSMS)
-- Verbinden Sie sich mit Ihrer Datenbank
USE YourDatabase;
GO

-- Führen Sie das Setup-Skript aus
:r C:\TSHB-Import\scripts\setup_database.sql
```

**Erwartete Ausgabe:**
```
Creating ImportLog table...
Table ImportLog created successfully.

Creating MainData table...
Table MainData created successfully.

Creating AdditionalInfo table...
Table AdditionalInfo created successfully.

Creating staging table...

Database Setup Completed!
```

### Schritt 3: KNIME Workflow konfigurieren

**Workflow-Komponenten:**

1. **Excel Reader**
   - Datei: `Bestellungen_2025.xlsx`
   - Sheet: "Bestellungen"
   - Headers: Ja

2. **Column Rename**
   - ID → RecordID
   - Kategorie → Category
   - Beschreibung → Description
   - Wert → Value
   - Menge → Quantity
   - Status → StatusCode

3. **Constant Value Columns**
   - ImportBatch: `BATCH_20250109_140000`
   - SourceFileName: `Bestellungen_2025.xlsx`
   - ImportDate: `2025-01-09 14:00:00`
   - IsProcessed: `0`

4. **Database Writer**
   - Connection: SQL Server
   - Table: `#StagingData`
   - Method: INSERT
   - Batch size: 1000

**Führen Sie den KNIME Workflow aus → Daten werden in Staging-Tabelle geladen**

### Schritt 4: Daten validieren

```sql
-- Validierungsskript ausführen
:r C:\TSHB-Import\scripts\validation\validate_staging_data.sql
```

**Beispiel-Ausgabe:**
```
========================================
Data Quality Validation Report
Generated: 2025-01-09 14:05:00
========================================

Total records in staging table: 3
Already processed records: 0
Pending records: 3

Records with missing RecordID: 0

Duplicate RecordID in staging:
No duplicates found.

RecordID already exists in MainData (will be skipped):
No existing records found.

Records with empty Category: 0

Records with potentially invalid Value: 0

Source files in staging:
SourceFileName              RecordCount
Bestellungen_2025.xlsx      3

========================================
Validation Summary
========================================
Records ready for import: 3
Status: READY - You can proceed with the import.
========================================
```

### Schritt 5: Import durchführen

```sql
-- Import-Skript ausführen
:r C:\TSHB-Import\scripts\import\import_main_data.sql
```

**Beispiel-Ausgabe:**
```
Starting import process...
Import Batch: BATCH_20250109_140500
Total records to process: 3
Inserted 3 records into MainData
Inserted 0 records into AdditionalInfo
Import completed successfully!
Successful: 3
Failed: 0
```

### Schritt 6: Import überprüfen

```sql
-- Importierte Daten anzeigen
SELECT 
    RecordID,
    Category,
    Description,
    Value,
    Quantity,
    StatusCode,
    ImportBatch,
    ImportDate
FROM [dbo].[MainData]
WHERE ImportBatch = 'BATCH_20250109_140500'
ORDER BY RecordID;
```

**Ergebnis:**
```
RecordID  Category  Description           Value    Quantity  StatusCode  ImportBatch            ImportDate
ORD001    Hardware  Laptop Dell XPS 15    1499.99  2         Aktiv       BATCH_20250109_140500  2025-01-09 14:05:00
ORD002    Software  Microsoft Office 365  99.99    5         Aktiv       BATCH_20250109_140500  2025-01-09 14:05:00
ORD003    Hardware  Monitor Samsung 27"   299.99   3         Aktiv       BATCH_20250109_140500  2025-01-09 14:05:00
```

### Schritt 7: Import-Log prüfen

```sql
-- Import-Protokoll anzeigen
SELECT 
    ImportBatch,
    ImportDate,
    SourceFileName,
    TotalRecords,
    SuccessfulRecords,
    FailedRecords,
    StatusCode,
    DurationSeconds
FROM [dbo].[ImportLog]
ORDER BY ImportDate DESC;
```

**Ergebnis:**
```
ImportBatch            ImportDate           SourceFileName          TotalRecords  SuccessfulRecords  FailedRecords  StatusCode  DurationSeconds
BATCH_20250109_140500  2025-01-09 14:05:00  Bestellungen_2025.xlsx  3             3                  0              Completed   2
```

### Schritt 8: Staging-Tabelle bereinigen (optional)

```sql
-- Verarbeitete Datensätze löschen
:r C:\TSHB-Import\scripts\import\clear_staging.sql
```

**Ausgabe:**
```
Clearing processed records from staging table...
Processed records found: 3
Deleted 3 processed records.
Remaining records in staging: 0
```

---

## Fehlerszenario: Rollback durchführen

Falls der Import rückgängig gemacht werden muss:

```sql
-- Rollback-Skript öffnen und Batch-ID setzen
-- C:\TSHB-Import\scripts\import\rollback_import.sql

DECLARE @BatchToRollback VARCHAR(50) = 'BATCH_20250109_140500';
-- ... rest des Skripts ausführen
```

**Ausgabe:**
```
Starting rollback process...
Batch to rollback: BATCH_20250109_140500
Deleted 0 records from AdditionalInfo
Deleted 3 records from MainData
Reset 3 staging records

Rollback completed successfully!
```

---

## Monitoring und Statistiken

```sql
-- System-Monitoring ausführen
:r C:\TSHB-Import\scripts\validation\monitor_system.sql
```

**Beispiel-Ausgabe:**
```
========================================
TSHB Import - System Monitoring Report
Generated: 2025-01-09 14:10:00
========================================

1. IMPORT SUMMARY (Last 30 days)
----------------------------------------
TotalImports  TotalRecordsProcessed  TotalSuccessful  TotalFailed  AvgDurationSeconds
1             3                      3                0            2

2. RECENT IMPORTS (Last 10)
----------------------------------------
ImportBatch            ImportDate           SourceFileName          TotalRecords  SuccessfulRecords  FailedRecords  StatusCode  DurationSeconds  Result
BATCH_20250109_140500  2025-01-09 14:05:00  Bestellungen_2025.xlsx  3             3                  0              Completed   2                Success

3. FAILED IMPORTS (Last 30 days)
----------------------------------------
No failed imports in the last 30 days.

4. DATA STATISTICS
----------------------------------------
Total records in MainData: 3
Total records in AdditionalInfo: 0

Records by Category:
Category  RecordCount  Percentage
Hardware  2            66.67
Software  1            33.33

...

8. SYSTEM RECOMMENDATIONS
----------------------------------------
No recommendations at this time. System is healthy!
```

---

## Zusammenfassung / Summary

✅ Excel-Datei vorbereitet  
✅ Datenbank eingerichtet  
✅ KNIME Workflow konfiguriert  
✅ Daten validiert  
✅ Import durchgeführt  
✅ Ergebnisse überprüft  
✅ System gesund  

**Gesamtdauer:** ~10 Minuten für 3 Datensätze

---

## Nächste Schritte

1. **Automatisierung:** KNIME Workflow als scheduled job einrichten
2. **Überwachung:** Regelmäßig Monitoring-Script ausführen
3. **Wartung:** Alte Import-Logs archivieren (>90 Tage)
4. **Skalierung:** Bei größeren Datenmengen Batch-Größe optimieren
