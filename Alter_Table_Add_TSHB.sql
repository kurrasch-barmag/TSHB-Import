-- Alter_Table_Add_TSHB.sql
-- Fügt die TSHB-Nummer Spalte zur tags Tabelle hinzu
-- ist temporär notwendig für den Importprozess
SET search_path TO public;

----------------------------------------------------------------
-- Überprüfe und füge tshb_no Spalte zur tags Tabelle hinzu
----------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='tags' AND column_name='tshb_no'
  ) THEN
    ALTER TABLE tags ADD COLUMN tshb_no TEXT;
    RAISE NOTICE 'Spalte tshb_no erfolgreich zur tags Tabelle hinzugefügt';
  ELSE
    RAISE NOTICE 'Spalte tshb_no existiert bereits in der tags Tabelle';
  END IF;
END $$;
