-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

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
	NO CYCLE;-- public.staging_messages definition

-- Drop table

-- DROP TABLE public.staging_messages;

CREATE TABLE public.staging_messages (
	message_bit int4 NULL,
	tag_name varchar NULL,
	text_de varchar NULL,
	text_en varchar NULL,
	text_fr varchar NULL,
	text_tr varchar NULL,
	text_chs varchar NULL,
	project_number varchar NULL,
	min_value int4 NULL,
	max_value float8 NULL,
	"precision" int4 NULL,
	unit varchar NULL,
	format varchar NULL,
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
	text_de text NULL,
	text_en text NOT NULL,
	text_tr text NULL,
	text_chs text NULL,
	text_fr text NULL,
	CONSTRAINT texte_max_length CHECK ((((length(text_de) <= 5000) OR (text_de IS NULL)) AND (length(text_en) <= 5000) AND ((length(text_tr) <= 5000) OR (text_tr IS NULL)) AND ((length(text_chs) <= 5000) OR (text_chs IS NULL)) AND ((length(text_fr) <= 5000) OR (text_fr IS NULL)))),
	CONSTRAINT texte_pkey PRIMARY KEY (id),
	CONSTRAINT texte_text_en_key UNIQUE (text_en)
);
COMMENT ON TABLE public.texte IS 'Mehrsprachige Texte für Tags';


-- public.varianten definition

-- Drop table

-- DROP TABLE public.varianten;

CREATE TABLE public.varianten (
	id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	CONSTRAINT varianten_name_key UNIQUE (name),
	CONSTRAINT varianten_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.varianten IS 'Stammtabelle für Varianten (z.B. Default, Base, Premium, ...)';


-- public.sollwert_gruppe definition

-- Drop table

-- DROP TABLE public.sollwert_gruppe;

CREATE TABLE public.sollwert_gruppe (
	id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	description text NULL,
	current_variant_id int4 NULL,
	CONSTRAINT sollwert_gruppe_name_key UNIQUE (name),
	CONSTRAINT sollwert_gruppe_pkey PRIMARY KEY (id),
	CONSTRAINT sollwert_gruppe_current_variant_id_fkey FOREIGN KEY (current_variant_id) REFERENCES public.varianten(id) ON DELETE SET NULL
);
CREATE INDEX idx_sollwert_gruppe_current_variant ON public.sollwert_gruppe USING btree (current_variant_id);
COMMENT ON TABLE public.sollwert_gruppe IS 'Gruppiert Mess-Tags; hält aktuelle Variante';


-- public.sollwerte definition

-- Drop table

-- DROP TABLE public.sollwerte;

CREATE TABLE public.sollwerte (
	id serial4 NOT NULL,
	min_value float4 NOT NULL,
	max_value float4 NOT NULL,
	unit varchar(50) NULL,
	"precision" int4 NULL,
	format varchar(100) NULL,
	variant_id int4 NOT NULL,
	CONSTRAINT sollwerte_id_variant_unique UNIQUE (id, variant_id),
	CONSTRAINT sollwerte_pkey PRIMARY KEY (id),
	CONSTRAINT sollwerte_precision_check CHECK (("precision" >= 0)),
	CONSTRAINT sollwerte_unique_values UNIQUE (min_value, max_value, unit, "precision", format, variant_id),
	CONSTRAINT sollwerte_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.varianten(id) ON DELETE RESTRICT
);
CREATE INDEX idx_sollwerte_variant_id ON public.sollwerte USING btree (variant_id);
COMMENT ON TABLE public.sollwerte IS 'Grenzwert-Kombinationen (min/max/unit/precision/format) je Variante';


-- public.tags definition

-- Drop table

-- DROP TABLE public.tags;

CREATE TABLE public.tags (
	id serial4 NOT NULL,
	tag_name varchar(255) NOT NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	project_number varchar(50) NULL,
	text_id int4 NULL,
	group_id int4 NULL,
	tag_type varchar(20) NULL,
	CONSTRAINT tags_pkey PRIMARY KEY (id),
	CONSTRAINT tags_tag_name_key UNIQUE (tag_name),
	CONSTRAINT tags_tag_type_check CHECK (((tag_type)::text = ANY ((ARRAY['measurement'::character varying, 'alarm'::character varying])::text[]))),
	CONSTRAINT tags_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.sollwert_gruppe(id) ON DELETE SET NULL,
	CONSTRAINT tags_text_id_fkey FOREIGN KEY (text_id) REFERENCES public.texte(id) ON DELETE SET NULL
);
CREATE INDEX idx_tags_group_id ON public.tags USING btree (group_id);
CREATE INDEX idx_tags_tag_name ON public.tags USING btree (tag_name);
CREATE INDEX idx_tags_tag_type ON public.tags USING btree (tag_type);
CREATE INDEX idx_tags_text_id ON public.tags USING btree (text_id);
COMMENT ON TABLE public.tags IS 'Mess-/Alarm-Tags; Messwerte optional mit Gruppe, Alarme ohne Gruppe';

-- Table Triggers

create trigger trg_update_tags_timestamp before
update
    on
    public.tags for each row execute function update_tags_timestamp();


-- public.alarm_konfiguration definition

-- Drop table

-- DROP TABLE public.alarm_konfiguration;

CREATE TABLE public.alarm_konfiguration (
	tag_id int4 NOT NULL,
	variant_id int4 NOT NULL,
	enabled bool DEFAULT true NOT NULL,
	severity int2 NULL,
	color varchar(20) NULL,
	CONSTRAINT alarm_konfiguration_pkey PRIMARY KEY (tag_id, variant_id),
	CONSTRAINT alarm_konfiguration_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE,
	CONSTRAINT alarm_konfiguration_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.varianten(id) ON DELETE CASCADE
);
CREATE INDEX idx_alarmkonfig_variant ON public.alarm_konfiguration USING btree (variant_id);
COMMENT ON TABLE public.alarm_konfiguration IS 'Per-Variante-Einstellungen für Alarm-Tags (ohne Sollwert-Gruppen)';

-- Table Triggers

create trigger trg_alarm_tags_only before
insert
    or
update
    on
    public.alarm_konfiguration for each row execute function enforce_alarm_tags_only();


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
	CONSTRAINT gruppen_varianten_sollwerte_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.varianten(id) ON DELETE CASCADE,
	CONSTRAINT gvs_sollwert_variant_fk FOREIGN KEY (sollwert_id,variant_id) REFERENCES public.sollwerte(id,variant_id) ON DELETE CASCADE
);
CREATE INDEX idx_gvs_sollwert_id ON public.gruppen_varianten_sollwerte USING btree (sollwert_id);
COMMENT ON TABLE public.gruppen_varianten_sollwerte IS 'Steuert je Gruppe und Variante den verwendeten Sollwert';


-- public.v_all_imported_data source

CREATE OR REPLACE VIEW public.v_all_imported_data
AS SELECT DISTINCT t.tag_name,
    t.project_number,
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
     LEFT JOIN varianten v ON v.id = sw.variant_id;



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