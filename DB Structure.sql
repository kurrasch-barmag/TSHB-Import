-- Drop existing objects (safe)
DROP TABLE IF EXISTS public."VariableTexts" CASCADE;
DROP TABLE IF EXISTS public."VariableVariants" CASCADE;
DROP TABLE IF EXISTS public."Variables" CASCADE;
DROP TABLE IF EXISTS public."Texts" CASCADE;
DROP TABLE IF EXISTS public.staging_messages CASCADE;

---------------------------------------------------
-- Tables
---------------------------------------------------

CREATE TABLE public."Texts" (
    "TextID" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "Text_DE" VARCHAR(255),
    "Text_EN" VARCHAR(255) NOT NULL,
    "Text_TR" VARCHAR(255),
    "Text_FR" VARCHAR(255),
    CONSTRAINT unique_text_en UNIQUE ("Text_EN")
);

CREATE TABLE public."Variables" (
    "VariableID" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "TagName" VARCHAR(100) NOT NULL,
    "TSHBNumber" VARCHAR(50)
);

CREATE TABLE public."VariableVariants" (
    "VariantID" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "VariableID" INT NOT NULL,
    "MinValue" NUMERIC(10,2),
    "MaxValue" NUMERIC(10,2),
    "Unit" VARCHAR(50),
    CONSTRAINT fk_variablevariants_variableid FOREIGN KEY ("VariableID")
        REFERENCES public."Variables" ("VariableID")
        ON DELETE CASCADE
);

CREATE TABLE public."VariableTexts" (
    "VariableID" INT NOT NULL,
    "TextID" INT NOT NULL,
    PRIMARY KEY ("VariableID", "TextID"),
    CONSTRAINT fk_variabletexts_variableid FOREIGN KEY ("VariableID")
        REFERENCES public."Variables" ("VariableID")
        ON DELETE CASCADE,
    CONSTRAINT fk_variabletexts_textid FOREIGN KEY ("TextID")
        REFERENCES public."Texts" ("TextID")
        ON DELETE CASCADE
);

---------------------------------------------------
-- Staging Table (unchanged)
---------------------------------------------------
CREATE TABLE public.staging_messages (
	"TagName" varchar NULL,
	"MinValue" int4 NULL,
	"MaxValue" varchar NULL,
	"ValuePrecision" int4 NULL,
	"Unit" varchar NULL,
	text_de varchar NULL,
	text_en varchar NULL,
	text_tr varchar NULL
);


