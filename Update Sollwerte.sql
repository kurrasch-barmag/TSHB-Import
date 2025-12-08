----------------------------------------------------------------
-- FINAL FULL IMPORT PIPELINE (One File)
----------------------------------------------------------------

SET search_path TO public;

-- 0) Cleanup Temp
DROP TABLE IF EXISTS tmp_staging_snapshot;

-- 1) Temp Snapshot der Staging Tabelle
CREATE TEMP TABLE tmp_staging_snapshot AS
SELECT DISTINCT
    TRIM(tag_name) AS tag_name,
    project_number,
    min_value::numeric AS min_value,
    max_value::numeric AS max_value,
    unit,
    "precision"::int AS precision,
    COALESCE(format, '') AS format,
    COALESCE(variant_name, '') AS variant_name,
    NULLIF(text_en, '') AS text_en,
    text_de, text_fr, text_tr, text_chs
FROM staging_messages
WHERE tag_name IS NOT NULL;

----------------------------------------------------------------
-- VARIANTEN importieren
----------------------------------------------------------------
INSERT INTO varianten(name)
SELECT DISTINCT variant_name
FROM tmp_staging_snapshot
WHERE variant_name <> ''
  AND NOT EXISTS (SELECT 1 FROM varianten v WHERE v.name = variant_name);

INSERT INTO varianten(name)
SELECT 'Default'
WHERE NOT EXISTS (SELECT 1 FROM varianten WHERE name ILIKE 'Default');

----------------------------------------------------------------
-- TEXTE importieren
----------------------------------------------------------------
INSERT INTO texte(text_en, text_de, text_fr, text_tr, text_chs)
SELECT DISTINCT text_en, text_de, text_fr, text_tr, text_chs
FROM tmp_staging_snapshot s
WHERE text_en IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM texte t WHERE t.text_en = s.text_en);

----------------------------------------------------------------
-- TAGS importieren
----------------------------------------------------------------
INSERT INTO tags(tag_name, project_number, text_id, tag_type)
SELECT DISTINCT
    s.tag_name,
    s.project_number,
    COALESCE((SELECT id FROM texte t WHERE t.text_en = s.text_en LIMIT 1), NULL),
    CASE WHEN s.min_value IS NOT NULL AND s.max_value IS NOT NULL
           AND (s.min_value <> 0 OR s.max_value <> 0)
         THEN 'measurement' ELSE 'alarm' END
FROM tmp_staging_snapshot s
LEFT JOIN tags t ON t.tag_name = s.tag_name
WHERE t.id IS NULL;

----------------------------------------------------------------
-- SOLLWERT-GRUPPEN erstellen
----------------------------------------------------------------
INSERT INTO sollwert_gruppe(name, description, current_variant_id)
SELECT DISTINCT
    CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format),
    CONCAT('min=', s.min_value, ', max=', s.max_value, ', format=', s.format),
    (SELECT id FROM varianten WHERE name ILIKE 'Default' LIMIT 1)
FROM tmp_staging_snapshot s
WHERE s.min_value IS NOT NULL AND s.max_value IS NOT NULL
  AND (s.min_value <> 0 OR s.max_value <> 0)
  AND NOT EXISTS (
      SELECT 1 FROM sollwert_gruppe g
      WHERE g.name =
            CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format)
  );

----------------------------------------------------------------
-- SOLLWERTE erstellen
----------------------------------------------------------------
INSERT INTO sollwerte(min_value,max_value,unit,"precision",format,variant_id)
SELECT DISTINCT
    s.min_value::real, s.max_value::real, s.unit, s.precision,
    NULLIF(s.format,''),
    COALESCE((SELECT id FROM varianten v WHERE v.name = s.variant_name LIMIT 1),
             (SELECT id FROM varianten v WHERE v.name ILIKE 'Default' LIMIT 1))
FROM tmp_staging_snapshot s
WHERE s.min_value IS NOT NULL AND s.max_value IS NOT NULL
  AND (s.min_value <> 0 OR s.max_value <> 0)
  AND NOT EXISTS (
    SELECT 1 FROM sollwerte sw
    WHERE sw.min_value=s.min_value::real
      AND sw.max_value=s.max_value::real
      AND sw.variant_id = COALESCE((SELECT id FROM varianten v WHERE v.name = s.variant_name LIMIT 1),
                                   (SELECT id FROM varianten v WHERE v.name ILIKE 'Default' LIMIT 1))
      AND sw.format IS NOT DISTINCT FROM NULLIF(s.format,'')
      AND sw.unit IS NOT DISTINCT FROM s.unit
      AND sw."precision" IS NOT DISTINCT FROM s.precision
  );

----------------------------------------------------------------
-- GVS (Gruppen-Varianten-Sollwerte) zuordnen
----------------------------------------------------------------
INSERT INTO gruppen_varianten_sollwerte(group_id,variant_id,sollwert_id)
SELECT DISTINCT
    g.id,
    sw.variant_id,
    sw.id
FROM tmp_staging_snapshot s
JOIN sollwert_gruppe g
    ON g.name = CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format)
JOIN sollwerte sw
    ON sw.min_value=s.min_value::real
   AND sw.max_value=s.max_value::real
   AND sw.unit IS NOT DISTINCT FROM s.unit
   AND sw."precision" IS NOT DISTINCT FROM s.precision
   AND sw.format IS NOT DISTINCT FROM NULLIF(s.format,'')
ON CONFLICT DO NOTHING;

----------------------------------------------------------------
-- TAGS final verknüpfen
----------------------------------------------------------------
UPDATE tags t
SET group_id = g.id,
    tag_type='measurement'
FROM tmp_staging_snapshot s
JOIN sollwert_gruppe g
  ON g.name = CONCAT(s.project_number, '_', s.min_value, '_', s.max_value, '_', s.format)
WHERE t.tag_name = s.tag_name
  AND (s.min_value IS NOT NULL AND s.max_value IS NOT NULL)
  AND (s.min_value <> 0 OR s.max_value <> 0)
  AND t.group_id IS DISTINCT FROM g.id;

----------------------------------------------------------------
-- Entferne Staging nach erfolgreichem Import
----------------------------------------------------------------
DROP TABLE IF EXISTS staging_messages;
DROP TABLE IF EXISTS tmp_staging_snapshot;
----------------------------------------------------------------
-- END IMPORT
----------------------------------------------------------------
