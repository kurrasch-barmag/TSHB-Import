-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.projects_id_seq;

CREATE SEQUENCE public.projects_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.sollwert_gruppe_id_seq;

CREATE SEQUENCE public.sollwert_gruppe_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.sollwerte_id_seq;

CREATE SEQUENCE public.sollwerte_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tag_mapping_id_seq;

CREATE SEQUENCE public.tag_mapping_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tags_id_seq;

CREATE SEQUENCE public.tags_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.texte_id_seq;

CREATE SEQUENCE public.texte_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.varianten_id_seq;

CREATE SEQUENCE public.varianten_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.projects definition

-- Drop table

-- DROP TABLE public.projects;

CREATE TABLE public.projects (
	id serial4 NOT NULL,
	project_number text NOT NULL,
	project_name text NULL,
	CONSTRAINT projects_pkey PRIMARY KEY (id),
	CONSTRAINT projects_project_number_key UNIQUE (project_number)
);


-- public.staging_messages definition

-- Drop table

-- DROP TABLE public.staging_messages;

CREATE TABLE public.staging_messages (
	tag_name varchar NULL,
	message_bit float8 NULL,
	text_de varchar NULL,
	text_en varchar NULL,
	text_fr varchar NULL,
	text_tr varchar NULL,
	text_chs varchar NULL,
	tshb_no varchar NULL,
	project_number varchar NULL,
	min_value float8 NULL,
	max_value float8 NULL,
	"precision" float8 NULL,
	unit varchar NULL,
	format varchar NULL,
	tagname_numbers varchar NULL,
	"TagnameBit" varchar NULL,
	variant_name varchar NULL,
	"Duplicate Status TextDE" varchar NULL,
	"Duplicate Chosen" varchar NULL
);


-- public.texte definition

-- Drop table

-- DROP TABLE public.texte;

CREATE TABLE public.texte (
	id serial4 NOT NULL,
	text_en text NULL,
	text_de text NULL,
	text_fr text NULL,
	text_tr text NULL,
	text_chs text NULL,
	CONSTRAINT texte_pkey PRIMARY KEY (id)
);


-- public.varianten definition

-- Drop table

-- DROP TABLE public.varianten;

CREATE TABLE public.varianten (
	id serial4 NOT NULL,
	"name" text NOT NULL,
	CONSTRAINT varianten_name_key UNIQUE (name),
	CONSTRAINT varianten_pkey PRIMARY KEY (id)
);


-- public.sollwert_gruppe definition

-- Drop table

-- DROP TABLE public.sollwert_gruppe;

CREATE TABLE public.sollwert_gruppe (
	id serial4 NOT NULL,
	"name" text NOT NULL,
	description text NULL,
	current_variant_id int4 NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT sollwert_gruppe_name_key UNIQUE (name),
	CONSTRAINT sollwert_gruppe_pkey PRIMARY KEY (id),
	CONSTRAINT sollwert_gruppe_current_variant_id_fkey FOREIGN KEY (current_variant_id) REFERENCES public.varianten(id) ON DELETE SET NULL
);
CREATE INDEX idx_sollwert_gruppe_current_variant ON public.sollwert_gruppe USING btree (current_variant_id);


-- public.sollwerte definition

-- Drop table

-- DROP TABLE public.sollwerte;

CREATE TABLE public.sollwerte (
	id serial4 NOT NULL,
	min_value float4 NULL,
	max_value float4 NULL,
	unit text NULL,
	"precision" int4 NULL,
	format text NULL,
	variant_id int4 NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT sollwerte_pkey PRIMARY KEY (id),
	CONSTRAINT sollwerte_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.varianten(id) ON DELETE RESTRICT
);
CREATE INDEX idx_sollwerte_variant_id ON public.sollwerte USING btree (variant_id);


-- public.tags definition

-- Drop table

-- DROP TABLE public.tags;

CREATE TABLE public.tags (
	id serial4 NOT NULL,
	tag_name text NOT NULL,
	original_tag_name text NULL,
	message_bit int4 NULL,
	project_number text NULL,
	text_id int4 NULL,
	group_id int4 NULL,
	tag_type text NOT NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	tshb_no text NULL,
	tagname_numbers text NULL,
	generalized_tag text NULL,
	CONSTRAINT tags_pkey PRIMARY KEY (id),
	CONSTRAINT tags_tag_name_key UNIQUE (tag_name),
	CONSTRAINT tags_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.sollwert_gruppe(id) ON DELETE SET NULL,
	CONSTRAINT tags_text_id_fkey FOREIGN KEY (text_id) REFERENCES public.texte(id) ON DELETE SET NULL
);
CREATE INDEX idx_tags_group_id ON public.tags USING btree (group_id);
CREATE INDEX idx_tags_tag_name ON public.tags USING btree (tag_name);


-- public.gruppen_varianten_sollwerte definition

-- Drop table

-- DROP TABLE public.gruppen_varianten_sollwerte;

CREATE TABLE public.gruppen_varianten_sollwerte (
	group_id int4 NOT NULL,
	variant_id int4 NOT NULL,
	sollwert_id int4 NOT NULL,
	CONSTRAINT gruppen_varianten_sollwerte_pkey PRIMARY KEY (group_id, variant_id),
	CONSTRAINT gruppen_varianten_sollwerte_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.sollwert_gruppe(id) ON DELETE CASCADE,
	CONSTRAINT gruppen_varianten_sollwerte_sollwert_id_fkey FOREIGN KEY (sollwert_id) REFERENCES public.sollwerte(id) ON DELETE CASCADE,
	CONSTRAINT gruppen_varianten_sollwerte_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.varianten(id) ON DELETE CASCADE
);


-- public.tag_mapping definition

-- Drop table

-- DROP TABLE public.tag_mapping;

CREATE TABLE public.tag_mapping (
	id serial4 NOT NULL,
	tag_id int4 NOT NULL,
	original_number text NOT NULL,
	project_id int4 NOT NULL,
	CONSTRAINT tag_mapping_pkey PRIMARY KEY (id),
	CONSTRAINT tag_mapping_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id),
	CONSTRAINT tag_mapping_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id)
);



-- DROP FUNCTION public.enforce_alarm_tags_only();

CREATE OR REPLACE FUNCTION public.enforce_alarm_tags_only()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
  tag_kind text;
BEGIN
  SELECT tag_type INTO tag_kind FROM public.tags WHERE id = NEW.tag_id;
  IF tag_kind IS DISTINCT FROM 'alarm' THEN
    RAISE EXCEPTION 'alarm_konfiguration erlaubt nur Tags mit tag_type = alarm (tag_id=%)', NEW.tag_id;
  END IF;
  RETURN NEW;
END;
$function$
;

-- DROP FUNCTION public.update_tags_timestamp();

CREATE OR REPLACE FUNCTION public.update_tags_timestamp()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$function$
;