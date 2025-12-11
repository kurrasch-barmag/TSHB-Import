WITH RECURSIVE base AS (
    SELECT
        t.id AS tag_id,
        t.generalized_tag,
        t.message_bit::float8 AS message_bit,
        t.tshb_no,
        txt.text_de AS initial_text_de,
        txt.text_en AS initial_text_en,
        txt.text_fr AS initial_text_fr,
        txt.text_tr AS initial_text_tr,
        txt.text_chs AS initial_text_chs,
        COALESCE(p.project_number, t.project_number) AS project_number,
        sw.min_value::float8 AS min_value,
        sw.max_value::float8 AS max_value,
        sw.unit,
        sw."precision" AS precision_value,
        sw.format,
        v.name AS variant_name,
        tm.original_number,
        nums.digits,
        nums.digit_count
    FROM tags t
    INNER JOIN tag_mapping tm ON tm.tag_id = t.id
    LEFT JOIN projects p ON p.id = tm.project_id
    LEFT JOIN texte txt ON txt.id = t.text_id
    LEFT JOIN sollwert_gruppe g ON g.id = t.group_id
    LEFT JOIN gruppen_varianten_sollwerte gvs ON gvs.group_id = g.id
    LEFT JOIN sollwerte sw ON sw.id = gvs.sollwert_id
    LEFT JOIN varianten v ON v.id = sw.variant_id
    LEFT JOIN LATERAL (
        SELECT arr AS digits, COALESCE(array_length(arr, 1), 0) AS digit_count
        FROM (
            SELECT COALESCE(string_to_array(tm.original_number, ';'), ARRAY[]::text[]) AS arr
        ) AS raw
    ) AS nums ON TRUE
),
reconstructed AS (
    SELECT
        b.tag_id,
        b.generalized_tag,
        b.message_bit,
        b.tshb_no,
        b.project_number,
        b.min_value,
        b.max_value,
        b.unit,
        b.precision_value,
        b.format,
        b.variant_name,
        b.original_number,
        b.digits,
        b.digit_count,
        1 AS idx,
        b.generalized_tag AS current_tag,
        b.initial_text_de AS current_text_de,
        b.initial_text_en AS current_text_en,
        b.initial_text_fr AS current_text_fr,
        b.initial_text_tr AS current_text_tr,
        b.initial_text_chs AS current_text_chs
    FROM base b
    UNION ALL
    SELECT
        r.tag_id,
        r.generalized_tag,
        r.message_bit,
        r.tshb_no,
        r.project_number,
        r.min_value,
        r.max_value,
        r.unit,
        r.precision_value,
        r.format,
        r.variant_name,
        r.original_number,
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
        END AS current_text_en,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 AND r.current_text_fr IS NOT NULL THEN regexp_replace(r.current_text_fr, '#+', r.digits[r.idx], '')
            ELSE r.current_text_fr
        END AS current_text_fr,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 AND r.current_text_tr IS NOT NULL THEN regexp_replace(r.current_text_tr, '#+', r.digits[r.idx], '')
            ELSE r.current_text_tr
        END AS current_text_tr,
        CASE
            WHEN r.idx <= r.digit_count AND r.digit_count > 0 AND r.current_text_chs IS NOT NULL THEN regexp_replace(r.current_text_chs, '#+', r.digits[r.idx], '')
            ELSE r.current_text_chs
        END AS current_text_chs
    FROM reconstructed r
    WHERE r.idx <= r.digit_count
)
SELECT
    rec.current_tag AS tag_name,
    rec.message_bit,
    rec.current_text_de AS text_de,
    rec.current_text_en AS text_en,
    rec.current_text_fr AS text_fr,
    rec.current_text_tr AS text_tr,
    rec.current_text_chs AS text_chs,
    rec.tshb_no,
    rec.project_number,
    rec.min_value,
    rec.max_value,
    rec.precision_value AS "precision",
    rec.unit,
    rec.format,
    rec.original_number AS tagname_numbers,
    CASE WHEN rec.message_bit IS NOT NULL THEN rec.current_tag || '_' || rec.message_bit::text ELSE NULL END AS "TagnameBit",
    rec.variant_name,
    NULL::text AS "Duplicate Status TextDE",
    NULL::text AS "Duplicate Chosen"
FROM reconstructed rec
WHERE rec.idx = rec.digit_count + 1
ORDER BY rec.project_number, rec.current_tag;
