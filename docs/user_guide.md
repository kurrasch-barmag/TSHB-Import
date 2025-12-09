# TSHB-Import - Benutzerhandbuch / User Guide

## Übersicht / Overview

Dieses Repository verwaltet Skripte und Datenbankschemas für den Import von Excel-Daten über KNIME in eine SQL Server-Datenbank.

This repository manages scripts and database schemas for importing Excel data via KNIME into a SQL Server database.

---

## Projektstruktur / Project Structure

```
TSHB-Import/
│
├── schemas/                      # Database schema definitions
│   ├── staging/                  # Staging table schema
│   │   └── staging_table.sql     # Temporary table for Excel data
│   └── target/                   # Target table schemas
│       ├── main_data_table.sql   # Main data table
│       ├── additional_info_table.sql  # Additional information table
│       └── import_log_table.sql  # Import logging table
│
├── scripts/                      # SQL scripts
│   ├── setup_database.sql        # Master setup script
│   ├── import/                   # Import scripts
│   │   ├── import_main_data.sql  # Main import script
│   │   ├── rollback_import.sql   # Rollback a batch
│   │   └── clear_staging.sql     # Clear staging table
│   └── validation/               # Validation scripts
│       └── validate_staging_data.sql  # Data quality checks
│
└── docs/                         # Documentation
    └── user_guide.md             # This file
```

---

## Schnellstart / Quick Start

### 1. Datenbank einrichten / Setup Database

Führen Sie das Master-Setup-Skript aus:
```sql
-- Execute in SQL Server Management Studio (SSMS)
:r scripts/setup_database.sql
```

Oder führen Sie die Skripte manuell in dieser Reihenfolge aus:
```sql
:r schemas/target/import_log_table.sql
:r schemas/target/main_data_table.sql
:r schemas/target/additional_info_table.sql
:r schemas/staging/staging_table.sql
```

### 2. Daten über KNIME laden / Load Data via KNIME

Konfigurieren Sie Ihren KNIME-Workflow, um Excel-Daten in die `#StagingData` Tabelle zu laden.

Erforderliche Felder:
- `RecordID` - Eindeutige Kennung (erforderlich)
- `Category` - Kategorie
- `Description` - Beschreibung
- `Value` - Numerischer Wert
- `Quantity` - Menge
- `StatusCode` - Statuscode
- `Field1-5` - Zusätzliche Felder
- `SourceFileName` - Name der Quelldatei
- `ImportBatch` - Batch-Kennung

### 3. Daten validieren / Validate Data

Vor dem Import validieren:
```sql
:r scripts/validation/validate_staging_data.sql
```

Das Skript überprüft:
- Fehlende oder doppelte RecordIDs
- Bereits vorhandene Datensätze
- Datenqualität
- Anzahl der zu importierenden Datensätze

### 4. Import ausführen / Execute Import

```sql
:r scripts/import/import_main_data.sql
```

Der Import-Prozess:
1. Erstellt eine eindeutige Batch-ID
2. Protokolliert den Import-Start
3. Importiert Daten in `MainData` Tabelle
4. Importiert zusätzliche Informationen in `AdditionalInfo` Tabelle
5. Markiert verarbeitete Datensätze
6. Protokolliert Erfolg/Fehler

### 5. Staging-Tabelle bereinigen / Clear Staging Table

Nach erfolgreichem Import:
```sql
:r scripts/import/clear_staging.sql
```

---

## Erweiterte Funktionen / Advanced Features

### Import rückgängig machen / Rollback Import

Falls ein Import rückgängig gemacht werden muss:

1. Öffnen Sie `scripts/import/rollback_import.sql`
2. Setzen Sie `@BatchToRollback` auf die Batch-ID
3. Führen Sie das Skript aus

```sql
DECLARE @BatchToRollback VARCHAR(50) = 'BATCH_20250109_093000';
:r scripts/import/rollback_import.sql
```

### Import-Protokoll anzeigen / View Import Log

```sql
SELECT 
    LogID,
    ImportBatch,
    ImportDate,
    SourceFileName,
    TotalRecords,
    SuccessfulRecords,
    FailedRecords,
    StatusCode,
    DurationSeconds,
    ErrorMessage
FROM [dbo].[ImportLog]
ORDER BY ImportDate DESC;
```

### Datenanalyse / Data Analysis

Importierte Daten anzeigen:
```sql
-- View all imported data
SELECT 
    m.RecordID,
    m.Category,
    m.Description,
    m.Value,
    m.Quantity,
    m.ImportBatch,
    m.ImportDate,
    a.Field1,
    a.Field2,
    a.Field3
FROM [dbo].[MainData] m
LEFT JOIN [dbo].[AdditionalInfo] a ON m.MainDataID = a.MainDataID
ORDER BY m.ImportDate DESC;
```

Nach Batch filtern:
```sql
-- Filter by import batch
SELECT * FROM [dbo].[MainData]
WHERE ImportBatch = 'BATCH_20250109_093000';
```

---

## Fehlerbehebung / Troubleshooting

### Problem: "Staging-Tabelle nicht gefunden"
**Lösung:** Führen Sie `schemas/staging/staging_table.sql` aus, um die temporäre Tabelle zu erstellen.

### Problem: "Duplikat RecordID"
**Lösung:** 
- Führen Sie das Validierungsskript aus, um Duplikate zu identifizieren
- Bereinigen Sie die Daten in Excel/KNIME
- Laden Sie die Daten erneut

### Problem: "Foreign Key Constraint Fehler"
**Lösung:** Stellen Sie sicher, dass die Tabellen in der richtigen Reihenfolge erstellt wurden (ImportLog, MainData, dann AdditionalInfo).

### Problem: "Import schlägt fehl"
**Lösung:**
- Überprüfen Sie das ImportLog auf Fehlermeldungen
- Stellen Sie sicher, dass alle RecordIDs eindeutig sind
- Validieren Sie die Datentypen

---

## Anpassung / Customization

### Staging-Tabelle anpassen

Bearbeiten Sie `schemas/staging/staging_table.sql`, um Felder hinzuzufügen oder zu ändern:

```sql
ALTER TABLE #StagingData
ADD CustomField1 VARCHAR(100),
    CustomField2 DECIMAL(10,2);
```

### Import-Logik anpassen

Bearbeiten Sie `scripts/import/import_main_data.sql`, um die Import-Logik anzupassen.

### Zusätzliche Zieltabellen

Erstellen Sie neue Tabellenskripte in `schemas/target/` und passen Sie die Import-Skripte entsprechend an.

---

## Best Practices

1. **Immer validieren vor dem Import** - Führen Sie das Validierungsskript aus
2. **Batch-IDs verfolgen** - Notieren Sie Batch-IDs für spätere Referenz
3. **Regelmäßige Bereinigung** - Löschen Sie alte Import-Logs periodisch
4. **Backup** - Erstellen Sie Backups vor großen Importen
5. **Testen** - Testen Sie neue Datenstrukturen mit kleinen Datensätzen

---

## Support und Kontakt / Support and Contact

Bei Fragen oder Problemen:
1. Überprüfen Sie dieses Benutzerhandbuch
2. Prüfen Sie die ImportLog-Tabelle auf Fehlermeldungen
3. Kontaktieren Sie Ihr Datenbank-Team

---

## Changelog

- **v1.0** (2025-12-09)
  - Initiale Implementierung
  - Staging-Tabelle Schema
  - Basis-Import-Skripte
  - Validierungs- und Rollback-Funktionalität
  - Dokumentation
