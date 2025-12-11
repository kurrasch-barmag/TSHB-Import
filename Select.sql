SELECT
    t.generalized_tag AS tag_template,
    t.tag_type,
    t.message_bit,
    p.project_number,
    p.project_name,
    tm.original_number AS number_mapping,
    t.tshb_no,
    txt.text_de,
    txt.text_en,
    txt.text_fr,
    txt.text_tr,
    txt.text_chs,
    g.name AS sollwertgruppe,
    sw.min_value,
    sw.max_value,
    sw.unit,
    sw."precision",
    sw.format,
    v.name AS variant_name
FROM tags t
LEFT JOIN texte txt ON txt.id = t.text_id
LEFT JOIN sollwert_gruppe g ON g.id = t.group_id
LEFT JOIN gruppen_varianten_sollwerte gvs ON gvs.group_id = g.id
LEFT JOIN sollwerte sw ON sw.id = gvs.sollwert_id
LEFT JOIN varianten v ON v.id = sw.variant_id
LEFT JOIN tag_mapping tm ON tm.tag_id = t.id
LEFT JOIN projects p ON p.id = tm.project_id
ORDER BY t.generalized_tag, p.project_number NULLS LAST, tm.original_number;
