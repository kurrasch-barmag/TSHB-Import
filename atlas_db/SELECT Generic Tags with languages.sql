SELECT 
    htg."hmi_tag_generic_name",
    htg."hmi_tag_generic_desc",
    htg."hmi_tag_generic_tbsh",
    MAX(CASE WHEN lang."language_name" = 'en_US' THEN mht."hmi_tag_generic_translation_desc" END) AS "English",
    MAX(CASE WHEN lang."language_name" = 'de_DE' THEN mht."hmi_tag_generic_translation_desc" END) AS "German",
    MAX(CASE WHEN lang."language_name" = 'fr_FR' THEN mht."hmi_tag_generic_translation_desc" END) AS "French",
    MAX(CASE WHEN lang."language_name" = 'es_ES' THEN mht."hmi_tag_generic_translation_desc" END) AS "Spanish"
FROM 
    public."dim_Orders" o
JOIN 
    public."map_HMIVariants" mhv ON o."order_id_pk" = mhv."order_id_fk"
JOIN 
    public."dim_HMITagsGeneric" htg ON mhv."hmi_tag_generic_id_fk" = htg."hmi_tag_generic_id_pk"
LEFT JOIN 
    public."map_HmitagGenericTranslation" mht ON htg."hmi_tag_generic_id_pk" = mht."hmi_tag_generic_id_fk"
LEFT JOIN 
    public."map_ProjectLanguages" mpl ON mht."project_language_map_id_fk" = mpl."project_language_map_id_pk"
LEFT JOIN 
    public."dim_Languages" lang ON mpl."language_id_fk" = lang."language_id_pk"
WHERE 
    o."order_nbr" = '3572'
GROUP BY 
    htg."hmi_tag_generic_name", 
    htg."hmi_tag_generic_desc", 
    htg."hmi_tag_generic_tbsh";