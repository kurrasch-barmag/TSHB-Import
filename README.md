# TSHB-Import

## Beschreibung / Description

Verwaltung von Skripten für den Import von Daten aus einer Staging-Tabelle in andere Datenbanktabellen. Die Staging-Tabelle ist eine temporäre Tabelle, die mit Excel-Dateien über KNIME gefüllt wird.

Management of scripts for importing data from a staging table into other database tables. The staging table is a temporary table filled with Excel files managed by KNIME.

---

## Hauptfunktionen / Key Features

- ✅ **Staging-Tabelle** - Temporäre Tabelle für Excel-Import via KNIME
- ✅ **Import-Skripte** - Automatisierte Datenübertragung in Zieltabellen
- ✅ **Validierung** - Datenqualitätsprüfungen vor dem Import
- ✅ **Protokollierung** - Vollständiges Import-Logging
- ✅ **Rollback** - Möglichkeit, Importe rückgängig zu machen
- ✅ **Dokumentation** - Umfassende Benutzeranleitungen

---

## Schnellstart / Quick Start

### 1. Datenbank einrichten
```sql
:r scripts/setup_database.sql
```

### 2. Daten über KNIME laden
Konfigurieren Sie Ihren KNIME-Workflow zum Laden in `#StagingData`

### 3. Daten validieren
```sql
:r scripts/validation/validate_staging_data.sql
```

### 4. Import ausführen
```sql
:r scripts/import/import_main_data.sql
```

---

## Verzeichnisstruktur / Directory Structure

```
├── schemas/              # Datenbankschemas
│   ├── staging/         # Staging-Tabelle
│   └── target/          # Zieltabellen
├── scripts/             # SQL-Skripte
│   ├── import/         # Import & Rollback
│   └── validation/     # Validierung
└── docs/               # Dokumentation
```

---

## Dokumentation / Documentation

Vollständige Dokumentation: [docs/user_guide.md](docs/user_guide.md)

---

## Anforderungen / Requirements

- Microsoft SQL Server (2016 oder höher / or higher)
- KNIME Analytics Platform (für Excel-Import / for Excel import)
- SQL Server Management Studio (SSMS) oder ähnliches Tool

---

## Lizenz / License

Proprietär / Proprietary
