
-- 02_import_script.sql
-- Complete import script (single file). Constructs tag_name by appending _<bit> only if bit is numeric (integer).
-- Keeps project_number as text. Float tolerance = 0.0001
SET search_path TO public;

-- TEMP SNAPSHOT
DROP TABLE IF EXISTS tmp_staging_snapshot;

CREATE TEMP TABLE tmp_staging_snapshot AS
SELECT DISTINCT
    -- tag_name: nur Bit anhängen, wenn message_bit eine Ganzzahl ist
    CASE
      WHEN message_bit IS NOT NULL AND message_bit = FLOOR(message_bit)
        THEN CONCAT(TRIM(tag_name), '_', (message_bit::int)::text)
      ELSE TRIM(tag_name)
    END AS tag_name,
    -- original_tag_name bleibt das ursprüngliche Tag aus staging_messages
    TRIM(tag_name) AS original_tag_name,
    message_bit,
    COALESCE(project_number, '') AS project_number,
    COALESCE(min_value,0)::real AS min_value,
    COALESCE(max_value,0)::real AS max_value,
    unit,
    "precision"::int AS precision,
    COALESCE(format,'') AS format,
    COALESCE(variant_name,'') AS variant_name,
    NULLIF(text_en,'') AS text_en,
    text_de, text_fr, text_tr, text_chs
FROM staging_messages
WHERE tag_name IS NOT NULL;  -- TagnameBit nicht mehr nötig

-- Ensure variants exist (including Default)
INSERT INTO varianten(name)
SELECT DISTINCT variant_name
FROM tmp_staging_snapshot
WHERE variant_name <> ''
  AND NOT EXISTS (SELECT 1 FROM varianten v WHERE v.name = tmp_staging_snapshot.variant_name);

INSERT INTO varianten(name)
SELECT 'Default'
WHERE NOT EXISTS (SELECT 1 FROM varianten WHERE name ILIKE 'Default');

-- Import texts (text_en always present)
INSERT INTO texte(text_en, text_de, text_fr, text_tr, text_chs)
SELECT DISTINCT text_en, text_de, text_fr, text_tr, text_chs
FROM tmp_staging_snapshot s
WHERE text_en IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM texte t WHERE t.text_en = s.text_en);

-- Ensure tags fields exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='tags' AND column_name='original_tag_name'
  ) THEN
    ALTER TABLE tags ADD COLUMN original_tag_name TEXT;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='tags' AND column_name='message_bit'
  ) THEN
    ALTER TABLE tags ADD COLUMN message_bit INT;
  END IF;
END $$;

-- Insert tags
INSERT INTO tags(tag_name, original_tag_name, message_bit, project_number, text_id, tag_type)
SELECT DISTINCT
    s.tag_name,
    s.original_tag_name,
    CASE
      WHEN s.message_bit IS NOT NULL AND s.message_bit = FLOOR(s.message_bit)
        THEN s.message_bit::int
      ELSE NULL
    END AS message_bit,
    s.project_number,
    (SELECT id FROM texte t WHERE t.text_en = s.text_en LIMIT 1),
    CASE WHEN s.min_value <> 0 OR s.max_value <> 0 THEN 'measurement' ELSE 'alarm' END
FROM tmp_staging_snapshot s
LEFT JOIN tags tg ON tg.tag_name = s.tag_name
WHERE tg.id IS NULL;

-- Sollwertgruppen
INSERT INTO sollwert_gruppe(name, description, current_variant_id)
SELECT DISTINCT
    CONCAT(s.project_number,'_',s.min_value,'_',s.max_value,'_',s.format),
    CONCAT('min=',s.min_value,', max=',s.max_value,', format=',s.format),
    (SELECT id FROM varianten WHERE name ILIKE 'Default' LIMIT 1)
FROM tmp_staging_snapshot s
WHERE (s.min_value <> 0 OR s.max_value <> 0)
  AND NOT EXISTS (
    SELECT 1 FROM sollwert_gruppe g
    WHERE g.name = CONCAT(s.project_number,'_',s.min_value,'_',s.max_value,'_',s.format)
  );

-- Sollwerte
INSERT INTO sollwerte(min_value, max_value, unit, "precision", format, variant_id)
SELECT DISTINCT
    s.min_value, s.max_value,
    NULLIF(s.unit,''), s.precision, NULLIF(s.format,''),
    COALESCE((SELECT id FROM varianten v WHERE v.name = s.variant_name LIMIT 1),
             (SELECT id FROM varianten v WHERE v.name ILIKE 'Default' LIMIT 1))
FROM tmp_staging_snapshot s
WHERE (s.min_value <> 0 OR s.max_value <> 0)
  AND NOT EXISTS (
    SELECT 1 FROM sollwerte sw
    WHERE ABS(COALESCE(sw.min_value,0) - s.min_value) < 0.0001
      AND ABS(COALESCE(sw.max_value,0) - s.max_value) < 0.0001
      AND sw.unit IS NOT DISTINCT FROM NULLIF(s.unit,'')
      AND sw."precision" IS NOT DISTINCT FROM s.precision
      AND sw.format IS NOT DISTINCT FROM NULLIF(s.format,'')
      AND sw.variant_id = COALESCE((SELECT id FROM varianten v WHERE v.name = s.variant_name LIMIT 1),
                                   (SELECT id FROM varianten v WHERE v.name ILIKE 'Default' LIMIT 1))
  );

-- GVS (Gruppen-Varianten-Sollwerte)
INSERT INTO gruppen_varianten_sollwerte(group_id,variant_id,sollwert_id)
SELECT DISTINCT
    g.id, sw.variant_id, sw.id
FROM tmp_staging_snapshot s
JOIN sollwert_gruppe g ON g.name =
    CONCAT(s.project_number,'_',s.min_value,'_',s.max_value,'_',s.format)
JOIN sollwerte sw
 ON ABS(COALESCE(sw.min_value,0) - s.min_value) < 0.0001
AND ABS(COALESCE(sw.max_value,0) - s.max_value) < 0.0001
AND sw.unit IS NOT DISTINCT FROM NULLIF(s.unit,'')
AND sw."precision" IS NOT DISTINCT FROM s.precision
AND sw.format IS NOT DISTINCT FROM NULLIF(s.format,'')
ON CONFLICT DO NOTHING;

-- Update tags
UPDATE tags t
SET group_id = g.id,
    tag_type='measurement'
FROM tmp_staging_snapshot s
JOIN sollwert_gruppe g
 ON g.name = CONCAT(s.project_number,'_',s.min_value,'_',s.max_value,'_',s.format)
WHERE t.tag_name = s.tag_name
  AND (s.min_value <> 0 OR s.max_value <> 0)
  AND (t.group_id IS DISTINCT FROM g.id OR t.group_id IS NULL);

-- Cleanup temp
DROP TABLE IF EXISTS tmp_staging_snapshot;
-- optional: DROP TABLE IF EXISTS staging_messages;
