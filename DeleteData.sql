-- DeleteData.sql
-- This script deletes all data from all tables in the database except the staging_messages table.
-- Ensure you have a backup before running this script.

SET search_path TO public;

-- Disable foreign key checks to avoid constraint violations during deletion
DO $$
BEGIN
    EXECUTE 'ALTER TABLE ' || quote_ident(table_schema || '.' || table_name) || ' DISABLE TRIGGER ALL'
    FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name != 'staging_messages';
END $$;

-- Delete data from specific tables
TRUNCATE TABLE tag_mapping;
TRUNCATE TABLE projects;
TRUNCATE TABLE tags;
TRUNCATE TABLE sollwert_gruppe;
TRUNCATE TABLE sollwerte;
TRUNCATE TABLE gruppen_varianten_sollwerte;
TRUNCATE TABLE varianten;

-- Re-enable foreign key checks
DO $$
BEGIN
    EXECUTE 'ALTER TABLE ' || quote_ident(table_schema || '.' || table_name) || ' ENABLE TRIGGER ALL'
    FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name != 'staging_messages';
END $$;