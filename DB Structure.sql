-- DROP SCHEMA public;V34
CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public."Texts_TextID_seq";

CREATE SEQUENCE public."Texts_TextID_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."VariableVariants_VariantID_seq";

CREATE SEQUENCE public."VariableVariants_VariantID_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."Variables_VariableID_seq";

CREATE SEQUENCE public."Variables_VariableID_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public."Texts" definition

-- Drop table

-- DROP TABLE public."Texts";

CREATE TABLE public."Texts" (
	"TextID" serial4 NOT NULL,
	"Text_DE" varchar(255) NULL,
	"Text_EN" varchar(255) NOT NULL,
	"Text_TR" varchar(255) NULL,
	"Text_FR" varchar(255) NULL,
	CONSTRAINT "Texts_pkey" PRIMARY KEY ("TextID"),
	CONSTRAINT unique_spalte UNIQUE ("Text_EN")
);


-- public."VariableTexts" definition

-- Drop table

-- DROP TABLE public."VariableTexts";

CREATE TABLE public."VariableTexts" (
	"VariableID" int4 NOT NULL,
	"TextID" int4 NOT NULL,
	CONSTRAINT "VariableTexts_pkey" PRIMARY KEY ("VariableID", "TextID")
);


-- public."VariableVariants" definition

-- Drop table

-- DROP TABLE public."VariableVariants";

CREATE TABLE public."VariableVariants" (
	"VariantID" serial4 NOT NULL,
	"VariableID" int4 NOT NULL,
	"MinValue" numeric(10, 2) NULL,
	"MaxValue" numeric(10, 2) NULL,
	"Unit" varchar(50) NULL,
	CONSTRAINT "VariableVariants_pkey" PRIMARY KEY ("VariantID")
);


-- public."Variables" definition

-- Drop table

-- DROP TABLE public."Variables";

CREATE TABLE public."Variables" (
	"VariableID" serial4 NOT NULL,
	"TagName" varchar(100) NOT NULL,
	"TSHBNumber" varchar(50) NULL,
	CONSTRAINT "Variables_pkey" PRIMARY KEY ("VariableID")
);


-- public.staging_messages definition

-- Drop table

-- DROP TABLE public.staging_messages;

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


-- public."Texts" foreign keys

-- public."VariableTexts" foreign keys

-- public."VariableVariants" foreign keys

-- public."Variables" foreign keys

-- public.staging_messages foreign keys;