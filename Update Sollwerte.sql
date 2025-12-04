
SELECT
    v."VariableID",
    v."TagName",

    vv."VariantID",
    vv."MinValue",
    vv."MaxValue",
    vv."Unit",

    -- Texte (optional, abhängig von Zuordnung in VariableTexts)
    t."TextID",
    t."Text_DE",
    t."Text_EN",
    t."Text_TR"
FROM public."Variables" AS v
JOIN public."VariableVariants" AS vv
  ON vv."VariableID" = v."VariableID"
LEFT JOIN public."VariableTexts" AS vt
  ON vt."VariableID" = v."VariableID"
LEFT JOIN public."Texts" AS t
  ON t."TextID" = vt."TextID"
ORDER BY
    v."TagName",
    vv."VariantID";