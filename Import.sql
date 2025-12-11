-- 02_import_script.sql
-- Complete import script (single file). Constructs tag_name by appending _<bit> only if bit is numeric (integer).
-- Keeps project_number as text. Float tolerance = 0.0001
SET search_path TO public;

-- Add new table for projects
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    project_number TEXT NOT NULL UNIQUE,
    project_name TEXT
);

-- Add new table for tag mappings
CREATE TABLE IF NOT EXISTS tag_mapping (
    id SERIAL PRIMARY KEY,
    tag_id INT NOT NULL REFERENCES tags(id),
    original_number TEXT NOT NULL,
    project_id INT NOT NULL REFERENCES projects(id)
);

-- Debugging: Check data in staging_messages
SELECT 'Data in staging_messages:', COUNT(*) FROM staging_messages;

-- Debugging: Check raw data in staging_messages
SELECT 'Raw data in staging_messages (first 10 rows):', *
FROM staging_messages
LIMIT 10;

-- TEMP SNAPSHOT
DROP TABLE IF EXISTS tmp_staging_snapshot;

CREATE TEMP TABLE tmp_staging_snapshot AS
SELECT DISTINCT
    -- Generalize tag_name by replacing each digit with '#'
    CASE
      WHEN tag_name IS NULL OR BTRIM(tag_name) = '' THEN NULL
      ELSE REGEXP_REPLACE(BTRIM(tag_name), '[0-9]', '#', 'g')
    END AS generalized_tag,
    BTRIM(tag_name) AS original_tag_name,
    message_bit,
    BTRIM(COALESCE(project_number, '')) AS project_number,
    COALESCE(tshb_no, '') AS tshb_no,
    COALESCE(min_value, 0)::real AS min_value,
    COALESCE(max_value, 0)::real AS max_value,
    NULLIF(unit, '') AS unit,
    "precision"::int AS precision,
    COALESCE(format, '') AS format,
    COALESCE(variant_name, '') AS variant_name,
    CASE WHEN text_en IS NULL OR BTRIM(text_en) = '' THEN NULL ELSE REGEXP_REPLACE(text_en, '[0-9]', '#', 'g') END AS text_en,
    CASE WHEN text_de IS NULL OR BTRIM(text_de) = '' THEN NULL ELSE REGEXP_REPLACE(text_de, '[0-9]', '#', 'g') END AS text_de,
    CASE WHEN text_fr IS NULL OR BTRIM(text_fr) = '' THEN NULL ELSE REGEXP_REPLACE(text_fr, '[0-9]', '#', 'g') END AS text_fr,
    CASE WHEN text_tr IS NULL OR BTRIM(text_tr) = '' THEN NULL ELSE REGEXP_REPLACE(text_tr, '[0-9]', '#', 'g') END AS text_tr,
    CASE WHEN text_chs IS NULL OR BTRIM(text_chs) = '' THEN NULL ELSE REGEXP_REPLACE(text_chs, '[0-9]', '#', 'g') END AS text_chs,
    (
      SELECT string_agg(match_txt, ';' ORDER BY match_order)
      FROM (
        SELECT match_arr[1] AS match_txt, match_order
        FROM regexp_matches(BTRIM(tag_name), '\d+', 'g') WITH ORDINALITY AS m(match_arr, match_order)
      ) ordered_matches
    ) AS tag_numbers
FROM staging_messages;

-- Debugging: Check data in tmp_staging_snapshot after transformations
SELECT 'Data in tmp_staging_snapshot (first 10 rows):', *
FROM tmp_staging_snapshot
LIMIT 10;

-- Ensure `texte` table contains required translation rows
INSERT INTO texte (text_en, text_de, text_fr, text_tr, text_chs)
SELECT DISTINCT s.text_en, s.text_de, s.text_fr, s.text_tr, s.text_chs
FROM tmp_staging_snapshot s
WHERE (s.text_en IS NOT NULL OR s.text_de IS NOT NULL OR s.text_fr IS NOT NULL OR s.text_tr IS NOT NULL OR s.text_chs IS NOT NULL)
  AND NOT EXISTS (
        SELECT 1
        FROM texte t
        WHERE t.text_en IS NOT DISTINCT FROM s.text_en
          AND t.text_de IS NOT DISTINCT FROM s.text_de
          AND t.text_fr IS NOT DISTINCT FROM s.text_fr
          AND t.text_tr IS NOT DISTINCT FROM s.text_tr
          AND t.text_chs IS NOT DISTINCT FROM s.text_chs
  );

-- Ensure `varianten` table contains referenced variant names
INSERT INTO varianten (name)
SELECT DISTINCT s.variant_name
FROM tmp_staging_snapshot s
WHERE s.variant_name IS NOT NULL AND s.variant_name <> ''
ON CONFLICT (name) DO NOTHING;

-- Insert projects into projects table
INSERT INTO projects (project_number)
SELECT DISTINCT s.project_number
FROM tmp_staging_snapshot s
WHERE s.project_number <> ''
  AND NOT EXISTS (
    SELECT 1 FROM projects p WHERE p.project_number = s.project_number
  );

-- Debugging: Check data in projects table
SELECT 'Data in projects table:', COUNT(*) FROM projects;

-- Debugging: Check data in tags table
SELECT 'Data in tags table (first 10 rows):', *
FROM tags
LIMIT 10;


-- Ensure tags fields exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='tags' AND column_name='generalized_tag'
  ) THEN
    ALTER TABLE tags ADD COLUMN generalized_tag TEXT;
  END IF;
END $$;

-- Debugging: Check for duplicate tag_name values in tmp_staging_snapshot
SELECT original_tag_name, COUNT(*)
FROM tmp_staging_snapshot
GROUP BY original_tag_name
HAVING COUNT(*) > 1;

-- Insert generalized tags into tags
INSERT INTO tags(tag_name, generalized_tag, message_bit, project_number, tshb_no, text_id, tag_type)
SELECT DISTINCT ON (s.generalized_tag)
    s.generalized_tag AS tag_name,
    s.generalized_tag,
    CASE
      WHEN s.message_bit IS NOT NULL AND s.message_bit = FLOOR(s.message_bit)
        THEN s.message_bit::int
      ELSE NULL
    END AS message_bit,
    NULLIF(s.project_number, '') AS project_number,
    s.tshb_no,
    txt.id,
    CASE WHEN s.min_value <> 0 OR s.max_value <> 0 THEN 'measurement' ELSE 'alarm' END
FROM tmp_staging_snapshot s
LEFT JOIN LATERAL (
    SELECT id
    FROM texte t
    WHERE t.text_en IS NOT DISTINCT FROM s.text_en
      AND t.text_de IS NOT DISTINCT FROM s.text_de
      AND t.text_fr IS NOT DISTINCT FROM s.text_fr
      AND t.text_tr IS NOT DISTINCT FROM s.text_tr
      AND t.text_chs IS NOT DISTINCT FROM s.text_chs
    ORDER BY id
    LIMIT 1
) txt ON TRUE
WHERE s.generalized_tag IS NOT NULL
ORDER BY s.generalized_tag,
         CASE WHEN (s.min_value <> 0 OR s.max_value <> 0) THEN 0 ELSE 1 END,
         NULLIF(s.project_number, '') NULLS LAST
ON CONFLICT (tag_name) DO UPDATE SET
    generalized_tag = EXCLUDED.generalized_tag,
    tshb_no = EXCLUDED.tshb_no,
    message_bit = EXCLUDED.message_bit,
    project_number = EXCLUDED.project_number,
    text_id = EXCLUDED.text_id,
    tag_type = EXCLUDED.tag_type;

-- Debugging: Check data in tags table
SELECT 'Data in tags table:', COUNT(*) FROM tags;

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

-- Debugging: Check data in varianten table
SELECT 'Data in varianten table (first 10 rows):', *
FROM varianten
LIMIT 10;

-- GVS (Gruppen-Varianten-Sollwerte)
WITH gvs_candidates AS (
  SELECT
    g.id AS group_id,
    sw.variant_id,
    sw.id AS sollwert_id,
    ROW_NUMBER() OVER (
      PARTITION BY g.id, sw.variant_id
      ORDER BY sw.updated_at DESC NULLS LAST, sw.id DESC
    ) AS rn
  FROM tmp_staging_snapshot s
  JOIN sollwert_gruppe g ON g.name =
    CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format)
  JOIN sollwerte sw
   ON ABS(COALESCE(sw.min_value, 0) - s.min_value) < 0.0001
  AND ABS(COALESCE(sw.max_value, 0) - s.max_value) < 0.0001
  AND sw.unit IS NOT DISTINCT FROM NULLIF(s.unit, '')
  AND sw."precision" IS NOT DISTINCT FROM s.precision
  AND sw.format IS NOT DISTINCT FROM NULLIF(s.format, '')
  WHERE sw.variant_id IS NOT NULL
)
INSERT INTO gruppen_varianten_sollwerte(group_id, variant_id, sollwert_id)
SELECT group_id, variant_id, sollwert_id
FROM gvs_candidates
WHERE rn = 1
ON CONFLICT (group_id, variant_id) DO UPDATE
SET sollwert_id = EXCLUDED.sollwert_id;

-- Update tags
UPDATE tags t
SET group_id = g.id,
    tag_type = 'measurement'
FROM tmp_staging_snapshot s
JOIN sollwert_gruppe g
 ON g.name = CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format)
WHERE t.tag_name = s.generalized_tag
  AND (s.min_value <> 0 OR s.max_value <> 0)
  AND (t.group_id IS DISTINCT FROM g.id OR t.group_id IS NULL);

-- Populate tag_mapping with original numbers per project
INSERT INTO tag_mapping (tag_id, original_number, project_id)
SELECT DISTINCT
    t.id,
    s.tag_numbers AS original_number,
    p.id
FROM tmp_staging_snapshot s
JOIN tags t ON t.tag_name = s.generalized_tag
JOIN projects p ON p.project_number = s.project_number
WHERE s.project_number <> ''
  AND s.tag_numbers IS NOT NULL AND s.tag_numbers <> ''
  AND NOT EXISTS (
        SELECT 1
        FROM tag_mapping tm
        WHERE tm.tag_id = t.id
          AND tm.project_id = p.id
          AND tm.original_number = s.tag_numbers
  );

-- Debugging: Check data in tag_mapping table
SELECT 'Data in tag_mapping table:', COUNT(*) FROM tag_mapping;


-- Remove `original_tag_name` column from `tags` table when no longer needed
ALTER TABLE tags DROP COLUMN IF EXISTS original_tag_name;


-- Cleanup temp
DROP TABLE IF EXISTS tmp_staging_snapshot;
-- optional: DROP TABLE IF EXISTS staging_messages;
