# KNIME Integration Guide

## Überblick / Overview

Dieses Dokument beschreibt, wie Sie KNIME konfigurieren, um Excel-Daten in die Staging-Tabelle zu laden.

This document describes how to configure KNIME to load Excel data into the staging table.

---

## KNIME Workflow Komponenten / Components

### 1. Excel Reader Node
- **Node Type:** Excel Reader
- **Purpose:** Excel-Dateien einlesen / Read Excel files
- **Configuration:**
  - File location: Wählen Sie Ihre Excel-Datei
  - Sheet selection: Wählen Sie das gewünschte Arbeitsblatt
  - Read headers: Aktiviert
  - Skip rows: 0 (oder nach Bedarf)

### 2. Column Filter Node (Optional)
- **Node Type:** Column Filter
- **Purpose:** Nur benötigte Spalten auswählen
- **Required Columns:**
  - RecordID
  - Category
  - Description
  - Value
  - Quantity
  - StatusCode
  - Field1, Field2, Field3, Field4, Field5

### 3. Column Rename Node
- **Node Type:** Column Rename
- **Purpose:** Spaltennamen an Datenbankschema anpassen
- **Mapping:**
  ```
  Excel Column Name    →  Database Column Name
  ID                   →  RecordID
  Kategorie            →  Category
  Beschreibung         →  Description
  Wert                 →  Value
  Menge                →  Quantity
  Status               →  StatusCode
  ```

### 4. Constant Value Column Nodes
- **Node Type:** Constant Value Column
- **Purpose:** Metadaten hinzufügen
- **Add columns:**
  - `ImportBatch`: Format: BATCH_YYYYMMDD_HHMMSS
  - `SourceFileName`: Name der Excel-Datei
  - `ImportDate`: Aktuelles Datum/Zeit

### 5. Database Writer Node
- **Node Type:** Database Writer
- **Purpose:** Daten in SQL Server schreiben
- **Configuration:**
  - Database connection: SQL Server Connector
  - Table name: `#StagingData` (für temp table) oder permanente Tabelle
  - Write method: Insert
  - Batch size: 1000 (für Performance)

---

## Beispiel KNIME Workflow

```
[Excel Reader] 
    ↓
[Column Filter] (Optional)
    ↓
[Column Rename]
    ↓
[Constant Value: ImportBatch]
    ↓
[Constant Value: SourceFileName]
    ↓
[Constant Value: ImportDate]
    ↓
[Math Formula: IsProcessed = 0]
    ↓
[Database Writer]
```

---

## SQL Server Connection Setup

### Option 1: Using JDBC
```
Driver: Microsoft SQL Server (JDBC)
Server: your-server-name
Port: 1433
Database: your-database-name
Authentication: SQL Server Authentication / Windows Authentication
Username: your-username
Password: your-password
```

### Option 2: Using Connection String
```
jdbc:sqlserver://your-server:1433;databaseName=your-database;integratedSecurity=true
```

---

## Spalten-Mapping / Column Mapping

| Staging Spalte | Datentyp | Pflicht | Beschreibung |
|----------------|----------|---------|--------------|
| RecordID | VARCHAR(50) | Ja | Eindeutige ID |
| Category | VARCHAR(100) | Empfohlen | Kategorie |
| Description | NVARCHAR(500) | Nein | Beschreibung |
| Value | DECIMAL(18,2) | Nein | Numerischer Wert |
| Quantity | INT | Nein | Menge |
| StatusCode | VARCHAR(20) | Nein | Statuscode |
| Field1-5 | NVARCHAR(255) | Nein | Zusatzfelder |
| SourceFileName | VARCHAR(255) | Ja | Dateiname |
| ImportBatch | VARCHAR(50) | Ja | Batch-ID |
| ImportDate | DATETIME | Ja | Import-Datum |
| IsProcessed | BIT | Ja | 0 (Standard) |

---

## Batch-ID Generierung in KNIME

### Java Snippet Node
```java
// Generate unique batch ID
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
String batchId = "BATCH_" + LocalDateTime.now().format(formatter);

// Return batch ID
out_ImportBatch = batchId;
```

---

## Best Practices

### Performance-Optimierung
1. **Batch Size:** Verwenden Sie 1000-5000 für optimale Performance
2. **Indizes:** Stellen Sie sicher, dass Indizes auf der Staging-Tabelle existieren
3. **Parallelisierung:** Verarbeiten Sie mehrere Dateien parallel (mit Vorsicht)

### Fehlerbehandlung
1. **Try-Catch Scope:** Verwenden Sie Try-Catch für Fehlerbehandlung
2. **Empty Table Switch:** Prüfen Sie auf leere Tabellen
3. **Logging:** Aktivieren Sie KNIME-Logging für Debugging

### Datenqualität
1. **Missing Value Filter:** Entfernen oder behandeln Sie fehlende Werte
2. **Row Filter:** Filtern Sie ungültige Zeilen
3. **Type Converter:** Konvertieren Sie Datentypen korrekt

---

## Beispiel Excel-Format

| ID | Kategorie | Beschreibung | Wert | Menge | Status |
|----|-----------|--------------|------|-------|--------|
| REC001 | Typ A | Beispiel 1 | 100.50 | 5 | Aktiv |
| REC002 | Typ B | Beispiel 2 | 250.00 | 10 | Aktiv |
| REC003 | Typ A | Beispiel 3 | 75.25 | 3 | Inaktiv |

---

## Fehlerbehebung / Troubleshooting

### Problem: "Table not found"
**Lösung:** Stellen Sie sicher, dass die Staging-Tabelle existiert oder verwenden Sie eine permanente Tabelle anstelle von `#StagingData`.

### Problem: "Data type mismatch"
**Lösung:** Verwenden Sie String to Number oder Number to String Nodes zur Typkonvertierung.

### Problem: "Connection timeout"
**Lösung:** 
- Erhöhen Sie das Connection Timeout in den DB Connection Settings
- Überprüfen Sie Firewall-Einstellungen
- Verwenden Sie Batch Writing für große Datenmengen

### Problem: "Duplicate key error"
**Lösung:** 
- Stellen Sie sicher, dass RecordIDs eindeutig sind
- Verwenden Sie Row Filter zum Entfernen von Duplikaten
- Überprüfen Sie die Datenquelle

---

## Weitere Ressourcen / Additional Resources

- [KNIME Hub](https://hub.knime.com/)
- [KNIME Database Documentation](https://docs.knime.com/latest/db_extension_guide/)
- [SQL Server JDBC Driver](https://docs.microsoft.com/sql/connect/jdbc/)

---

## Version History

- **v1.0** (2025-12-09) - Initial documentation
