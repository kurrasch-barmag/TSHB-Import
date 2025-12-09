SELECT DISTINCT
    t.tag_name,
    t.project_number,
    t.tshb_no,
    txt.text_de,
    txt.text_en,
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
ORDER by t.tag_name;