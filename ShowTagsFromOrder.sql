-- Abfrage zur Ausgabe von Tags eines spezifischen Projekts
WITH RECURSIVE base_project AS (
    SELECT
        t.id AS tag_id,
        t.generalized_tag,
        t.message_bit::float8 AS message_bit,
        t.tshb_no,
        txt.text_de AS initial_text_de,
        txt.text_en AS initial_text_en,
        COALESCE(p.project_number, t.project_number) AS project_number,
        sw.min_value::float8 AS min_value,
        sw.max_value::float8 AS max_value,
        nums.digits,
        nums.digit_count
    FROM tags t
    INNER JOIN tag_mapping tm ON tm.tag_id = t.id
    LEFT JOIN projects p ON p.id = tm.project_id
    LEFT JOIN texte txt ON txt.id = t.text_id
    LEFT JOIN sollwert_gruppe g ON g.id = t.group_id
    LEFT JOIN gruppen_varianten_sollwerte gvs ON gvs.group_id = g.id
    LEFT JOIN sollwerte sw ON sw.id = gvs.sollwert_id
    LEFT JOIN LATERAL (
        SELECT arr AS digits, COALESCE(array_length(arr, 1), 0) AS digit_count
        FROM (
            SELECT COALESCE(string_to_array(tm.original_number, ';'), ARRAY[]::text[]) AS arr
        ) AS raw
    ) AS nums ON TRUE
),
reconstructed_project AS (
    SELECT
        b.tag_id,
        b.generalized_tag,
        b.message_bit,
        b.project_number,
        b.min_value,
        b.max_value,
        b.digits,
        b.digit_count,
        1 AS idx,
        b.generalized_tag AS current_tag,
        b.initial_text_de AS current_text_de,
        b.initial_text_en AS current_text_en
    FROM base_project b
    UNION ALL
    SELECT
        r.tag_id,
        r.generalized_tag,
        r.message_bit,
        r.project_number,
        r.min_value,
        r.max_value,
        r.digits,
        r.digit_count,
        r.idx + 1 AS idx,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 THEN regexp_replace(r.current_tag, '#+', r.digits[r.idx], '')
            ELSE r.current_tag
        END AS current_tag,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 AND r.current_text_de IS NOT NULL THEN regexp_replace(r.current_text_de, '#+', r.digits[r.idx], '')
            ELSE r.current_text_de
        END AS current_text_de,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 AND r.current_text_en IS NOT NULL THEN regexp_replace(r.current_text_en, '#+', r.digits[r.idx], '')
            ELSE r.current_text_en
        END AS current_text_en
    FROM reconstructed_project r
    WHERE r.idx <= r.digit_count
)
SELECT
    rec.current_tag AS tag_name,
    rec.min_value AS min,
    rec.max_value AS max,
    rec.current_text_de AS text_de,
    rec.current_text_en AS text_en
FROM reconstructed_project rec
WHERE rec.idx = rec.digit_count + 1
  AND rec.project_number = 'DEIN_PROJEKTNUMMER' -- Hier die gewünschte Projektnummer einfügen
ORDER BY rec.current_tag;