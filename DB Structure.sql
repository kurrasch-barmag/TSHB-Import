
BEGIN;

WITH

-- 1) Neue Variables (nur neue TagName-Werte)
ins_variables AS (
    INSERT INTO public."Variables" ("TagName")
    SELECT DISTINCT s."TagName"
    FROM public.staging_messages s
    WHERE s."TagName" IS NOT NULL AND trim(s."TagName") <> ''
      AND NOT EXISTS (
          SELECT 1
          FROM public."Variables" v
          WHERE v."TagName" = s."TagName"
      )
    RETURNING "VariableID", "TagName"
),

-- 2) Texts einfügen/aktualisieren (EN ist eindeutig) – OHNE text_fr
ins_texts AS (
    INSERT INTO public."Texts" ("Text_DE", "Text_EN", "Text_TR")
    SELECT DISTINCT
        NULLIF(trim(s.text_de), '')::varchar(255),
        NULLIF(trim(s.text_en), '')::varchar(255),
        NULLIF(trim(s.text_tr), '')::varchar(255)
    FROM public.staging_messages s
    WHERE s.text_en IS NOT NULL AND trim(s.text_en) <> ''
    ON CONFLICT ("Text_EN") DO UPDATE
        SET
            "Text_DE" = COALESCE(EXCLUDED."Text_DE", "Texts"."Text_DE"),
            "Text_TR" = COALESCE(EXCLUDED."Text_TR", "Texts"."Text_TR")
    RETURNING "TextID", "Text_EN"
),

-- 3) Alle VariableIDs (neu + bestehend; dedupliziert)
all_vars AS (
    SELECT "VariableID", "TagName" FROM ins_variables
    UNION
    SELECT "VariableID", "TagName" FROM public."Variables"
),

-- 4) Alle TextIDs (neu + bestehend; dedupliziert)
all_texts AS (
    SELECT "TextID", "Text_EN" FROM ins_texts
    UNION
    SELECT "TextID", "Text_EN" FROM public."Texts"
),

-- 5) Zuordnung Variable ↔ Text (nur neue Paare)
map_var_text AS (
    INSERT INTO public."VariableTexts" ("VariableID", "TextID")
    SELECT DISTINCT v."VariableID", t."TextID"
    FROM public.staging_messages s
    JOIN all_vars  v ON v."TagName" = s."TagName"
    JOIN all_texts t ON t."Text_EN"  = s.text_en
    WHERE s."TagName" IS NOT NULL AND trim(s."TagName") <> ''
      AND s.text_en   IS NOT NULL AND trim(s.text_en)   <> ''
      AND NOT EXISTS (
          SELECT 1
          FROM public."VariableTexts" vt
          WHERE vt."VariableID" = v."VariableID"
            AND vt."TextID"     = t."TextID"
      )
    RETURNING "VariableID", "TextID"
),

-- 6) Werte aus staging parsen/bereinigen (Dezimaltrennzeichen, Trimming, Casting)
vals AS (
    SELECT
        s."TagName",

        -- MinValue: int4 -> numeric(10,2), optional Rundung auf 2 Nachkommastellen
        CASE
            WHEN s."MinValue" IS NULL THEN NULL
            ELSE ROUND(s."MinValue"::numeric, 2)
        END AS min_val,

        -- MaxValue: varchar -> numeric(10,2); akzeptiert "12,3" oder "12.3";
        -- Nicht-numerische Inhalte -> NULL (alternativ könnte man die erste Zahl per Regex extrahieren)
        CASE
            WHEN NULLIF(trim(s."MaxValue"), '') IS NULL THEN NULL
            WHEN REPLACE(trim(s."MaxValue"), ',', '.') ~ '^[+-]?\d+(\.\d+)?$'
                 THEN ROUND((REPLACE(trim(s."MaxValue"), ',', '.'))::numeric, 2)
            ELSE NULL
        END AS max_val,

        -- Unit: leere Strings -> NULL, Begrenzung auf varchar(50)
        NULLIF(trim(s."Unit"), '')::varchar(50) AS unit_val
    FROM public.staging_messages s
    WHERE s."TagName" IS NOT NULL AND trim(s."TagName") <> ''
),

-- 7) Mehrere Varianten pro TagName/Variable einfügen (Duplikate vermeiden)
ins_variants AS (
    INSERT INTO public."VariableVariants" ("VariableID", "MinValue", "MaxValue", "Unit")
    SELECT DISTINCT v."VariableID", vals.min_val, vals.max_val, vals.unit_val
    FROM vals
    JOIN all_vars v ON v."TagName" = vals."TagName"
    WHERE (vals.min_val IS NOT NULL OR vals.max_val IS NOT NULL OR vals.unit_val IS NOT NULL)
      AND NOT EXISTS (
          SELECT 1
          FROM public."VariableVariants" vv
          WHERE vv."VariableID" IS NOT DISTINCT FROM v."VariableID"
            AND vv."MinValue"   IS NOT DISTINCT FROM vals.min_val
            AND vv."MaxValue"   IS NOT DISTINCT FROM vals.max_val
            AND vv."Unit"       IS NOT DISTINCT FROM vals.unit_val
      )
    RETURNING "VariantID", "VariableID"
)

SELECT 'OK' AS result;

COMMIT;
