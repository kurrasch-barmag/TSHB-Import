-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP TYPE public.ghstore;

CREATE TYPE public.ghstore (
	INPUT = ghstore_in,
	OUTPUT = ghstore_out,
	ALIGNMENT = 4,
	STORAGE = plain,
	CATEGORY = U,
	DELIMITER = ',');

-- DROP TYPE public."hstore";

CREATE TYPE public."hstore" (
	INPUT = hstore_in,
	OUTPUT = hstore_out,
	RECEIVE = hstore_recv,
	SEND = hstore_send,
	ALIGNMENT = 4,
	STORAGE = any,
	CATEGORY = U,
	DELIMITER = ',');

-- DROP SEQUENCE public.device_blocks_id_seq;

CREATE SEQUENCE public.device_blocks_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_AccessConfig_ac_id_pk_seq";

CREATE SEQUENCE public."dim_AccessConfig_ac_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFieldSetGroups_hmi_field_set_group_id_pk_seq";

CREATE SEQUENCE public."dim_HMIFieldSetGroups_hmi_field_set_group_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFieldSetGroups_hmi_field_set_group_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIFieldSetGroups_hmi_field_set_group_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFieldSets_hmi_field_set_id_pk_seq";

CREATE SEQUENCE public."dim_HMIFieldSets_hmi_field_set_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFieldSets_hmi_field_set_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIFieldSets_hmi_field_set_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFields_hmi_field_id_pk_seq";

CREATE SEQUENCE public."dim_HMIFields_hmi_field_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIFields_hmi_field_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIFields_hmi_field_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIGenericBlockGoups_hmi_generic_block_group_id_pk_seq";

CREATE SEQUENCE public."dim_HMIGenericBlockGoups_hmi_generic_block_group_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIGenericBlockGoups_hmi_generic_block_group_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIGenericBlockGoups_hmi_generic_block_group_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIGenericBlocks_hmi_generic_block_pk_seq";

CREATE SEQUENCE public."dim_HMIGenericBlocks_hmi_generic_block_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIGenericBlocks_hmi_generic_block_pk_seq1";

CREATE SEQUENCE public."dim_HMIGenericBlocks_hmi_generic_block_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIPanelGroups_hmi_panel_group_id_pk_seq";

CREATE SEQUENCE public."dim_HMIPanelGroups_hmi_panel_group_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIPanelGroups_hmi_panel_group_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIPanelGroups_hmi_panel_group_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIPanels_hmi_panel_id_pk_seq";

CREATE SEQUENCE public."dim_HMIPanels_hmi_panel_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIPanels_hmi_panel_id_pk_seq1";

CREATE SEQUENCE public."dim_HMIPanels_hmi_panel_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_HMIXmlProjects_hmi_xml_project_id_pk_seq";

CREATE SEQUENCE public."dim_HMIXmlProjects_hmi_xml_project_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_IC_ic_id_pk_seq";

CREATE SEQUENCE public."dim_IC_ic_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_Languages_language_id_pk_seq";

CREATE SEQUENCE public."dim_Languages_language_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_UnitConversions_unit_conversion_id_pk_seq";

CREATE SEQUENCE public."dim_UnitConversions_unit_conversion_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."dim_XmlUploadLogs_hmi_xml_uploadlogs_id_pk_seq";

CREATE SEQUENCE public."dim_XmlUploadLogs_hmi_xml_uploadlogs_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.dim_alarmcategorys_alarmcategory_id_pk_seq;

CREATE SEQUENCE public.dim_alarmcategorys_alarmcategory_id_pk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.dim_hminavigationpoints_hmi_navigation_point_id_pk_seq;

CREATE SEQUENCE public.dim_hminavigationpoints_hmi_navigation_point_id_pk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.dim_hmixmlprojects_hmi_xml_project_id_pk_seq;

CREATE SEQUENCE public.dim_hmixmlprojects_hmi_xml_project_id_pk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_HMIPicture";

CREATE SEQUENCE public."map_HMIPicture"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_HMIXmltags_hmi_xmltag_id_pk_seq";

CREATE SEQUENCE public."map_HMIXmltags_hmi_xmltag_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_HMIXmltags_hmi_xmltag_id_pk_seq1";

CREATE SEQUENCE public."map_HMIXmltags_hmi_xmltag_id_pk_seq1"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_HmitagGenericTranslation_hmi_tag_generic_map_id_pk_seq";

CREATE SEQUENCE public."map_HmitagGenericTranslation_hmi_tag_generic_map_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_HmitagTranslation_hmi_tag_translation_map_id_pk_seq";

CREATE SEQUENCE public."map_HmitagTranslation_hmi_tag_translation_map_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public."map_ProjectLanguages_project_language_map_id_pk_seq";

CREATE SEQUENCE public."map_ProjectLanguages_project_language_map_id_pk_seq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_attributes;

CREATE SEQUENCE public.seq_attributes
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_attributes_gen;

CREATE SEQUENCE public.seq_attributes_gen
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_device_tag_hst;

CREATE SEQUENCE public.seq_device_tag_hst
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_device_tags;

CREATE SEQUENCE public.seq_device_tags
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_devices;

CREATE SEQUENCE public.seq_devices
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_formats;

CREATE SEQUENCE public.seq_formats
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_hmi;

CREATE SEQUENCE public.seq_hmi
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_hmi_attr_gen;

CREATE SEQUENCE public.seq_hmi_attr_gen
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_hmi_tags_generic;

CREATE SEQUENCE public.seq_hmi_tags_generic
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_hmi_test;

CREATE SEQUENCE public.seq_hmi_test
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_hmishortname_tags;

CREATE SEQUENCE public.seq_hmishortname_tags
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_ic;

CREATE SEQUENCE public.seq_ic
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_ic_map;

CREATE SEQUENCE public.seq_ic_map
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_loads;

CREATE SEQUENCE public.seq_loads
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_machine_comp;

CREATE SEQUENCE public.seq_machine_comp
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_map_hmidevice;

CREATE SEQUENCE public.seq_map_hmidevice
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_map_hmivar;

CREATE SEQUENCE public.seq_map_hmivar
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_orders;

CREATE SEQUENCE public.seq_orders
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_proj_var;

CREATE SEQUENCE public.seq_proj_var
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_sub_machine_comps;

CREATE SEQUENCE public.seq_sub_machine_comps
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_tag_text;

CREATE SEQUENCE public.seq_tag_text
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_test_item;

CREATE SEQUENCE public.seq_test_item
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_testprotocol;

CREATE SEQUENCE public.seq_testprotocol
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_units;

CREATE SEQUENCE public.seq_units
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.seq_variants;

CREATE SEQUENCE public.seq_variants
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.v_map_hmitags_hmitag_order_map_id_pk_seq;

CREATE SEQUENCE public.v_map_hmitags_hmitag_order_map_id_pk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;-- public."dim_AlarmCategorys" definition

-- Drop table

-- DROP TABLE public."dim_AlarmCategorys";

CREATE TABLE public."dim_AlarmCategorys" (
	alarmcategory_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	alarmcategory_name varchar(32) NOT NULL,
	alarmcategory_bitmask int4 NOT NULL,
	alarmcategory_description varchar(256) NULL,
	CONSTRAINT dim_alarmcategory_id_pk PRIMARY KEY (alarmcategory_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_AlarmCategorys" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_AlarmCategorys" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_FormatFunctions" definition

-- Drop table

-- DROP TABLE public."dim_FormatFunctions";

CREATE TABLE public."dim_FormatFunctions" (
	format_function_id_pk uuid DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"function" text NOT NULL,
	CONSTRAINT dim_formatfunctions_pk PRIMARY KEY (format_function_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_FormatFunctions" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_FormatFunctions" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Formats" definition

-- Drop table

-- DROP TABLE public."dim_Formats";

CREATE TABLE public."dim_Formats" (
	format_id_pk int4 DEFAULT nextval('seq_formats'::regclass) NOT NULL,
	format_text varchar(8) NOT NULL,
	CONSTRAINT dim_formats_pk PRIMARY KEY (format_id_pk),
	CONSTRAINT un_format_text UNIQUE (format_text)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Formats" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Formats" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMIAccessBits" definition

-- Drop table

-- DROP TABLE public."dim_HMIAccessBits";

CREATE TABLE public."dim_HMIAccessBits" (
	ac_id_pk int4 DEFAULT nextval('"dim_AccessConfig_ac_id_pk_seq"'::regclass) NOT NULL,
	ac_bitmask int4 NOT NULL,
	ac_description text NULL,
	CONSTRAINT dim_accessconfig_pk PRIMARY KEY (ac_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_HMIAccessBits" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_HMIAccessBits" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMIShortName" definition

-- Drop table

-- DROP TABLE public."dim_HMIShortName";

CREATE TABLE public."dim_HMIShortName" (
	hmi_short_name_id_pk int4 DEFAULT nextval('seq_hmishortname_tags'::regclass) NOT NULL,
	hmi_short_name varchar(16) NOT NULL,
	hmi_short_name_desc varchar(255) NOT NULL,
	CONSTRAINT "dim_HMIShortName_pkey" PRIMARY KEY (hmi_short_name_id_pk),
	CONSTRAINT uni_short_name UNIQUE (hmi_short_name)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_HMIShortName" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_HMIShortName" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMITags" definition

-- Drop table

-- DROP TABLE public."dim_HMITags";

CREATE TABLE public."dim_HMITags" (
	hmi_tag_id_pk int4 DEFAULT nextval('seq_hmi'::regclass) NOT NULL,
	digits _int4 NULL,
	CONSTRAINT "PK_HMITag" PRIMARY KEY (hmi_tag_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_HMITags" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_HMITags" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_IC" definition

-- Drop table

-- DROP TABLE public."dim_IC";

CREATE TABLE public."dim_IC" (
	ic_name varchar(32) NOT NULL,
	ic_bitmask int4 NOT NULL,
	ic_id_pk serial4 NOT NULL,
	ic_description varchar(256) NULL,
	CONSTRAINT dim_ic_pk PRIMARY KEY (ic_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_IC" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_IC" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Languages" definition

-- Drop table

-- DROP TABLE public."dim_Languages";

CREATE TABLE public."dim_Languages" (
	language_id_pk serial4 NOT NULL,
	language_name varchar NOT NULL,
	language_desc varchar NOT NULL,
	language_wincc_id varchar NOT NULL,
	CONSTRAINT dim_languages_pk PRIMARY KEY (language_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Languages" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Languages" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Loads" definition

-- Drop table

-- DROP TABLE public."dim_Loads";

CREATE TABLE public."dim_Loads" (
	load_id_pk int4 DEFAULT nextval('seq_loads'::regclass) NOT NULL,
	load_type varchar(8) NOT NULL,
	load_type_version varchar(32) NOT NULL,
	load_ts timestamp(6) NULL,
	load_path varchar(256) NULL,
	CONSTRAINT "Load_pkey1" PRIMARY KEY (load_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Loads" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Loads" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_MachineComponents" definition

-- Drop table

-- DROP TABLE public."dim_MachineComponents";

CREATE TABLE public."dim_MachineComponents" (
	machine_comp_id_pk int4 DEFAULT nextval('seq_machine_comp'::regclass) NOT NULL,
	machine_comp_name varchar(32) NOT NULL, -- Short name
	machine_comp_desc varchar(256) NOT NULL, -- Description
	machine_comp_number int4 NOT NULL, -- AK number¶
	CONSTRAINT "MachineComp_pkey1" PRIMARY KEY (machine_comp_id_pk),
	CONSTRAINT unique_mc UNIQUE (machine_comp_name, machine_comp_desc, machine_comp_number)
);

-- Column comments

COMMENT ON COLUMN public."dim_MachineComponents".machine_comp_name IS 'Short name';
COMMENT ON COLUMN public."dim_MachineComponents".machine_comp_desc IS 'Description';
COMMENT ON COLUMN public."dim_MachineComponents".machine_comp_number IS 'AK number
';

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_MachineComponents" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_MachineComponents" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Units" definition

-- Drop table

-- DROP TABLE public."dim_Units";

CREATE TABLE public."dim_Units" (
	unit_id_pk int4 DEFAULT nextval('seq_units'::regclass) NOT NULL,
	unit_text varchar(32) NULL,
	CONSTRAINT dim_units_pk PRIMARY KEY (unit_id_pk),
	CONSTRAINT unique_unit_text UNIQUE (unit_text)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Units" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Units" for each statement execute procedure audit.if_modified_func('true');


-- public.request_log definition

-- Drop table

-- DROP TABLE public.request_log;

CREATE TABLE public.request_log (
	log_id_pk uuid DEFAULT uuid_generate_v4() NOT NULL,
	"start" timestamptz DEFAULT now() NULL,
	finished timestamptz NULL,
	status_code int4 NULL,
	tracing_identifier varchar NOT NULL,
	"method" varchar NULL,
	scheme varchar NULL,
	host varchar NULL,
	"path" varchar NULL,
	query_string varchar NULL,
	request_data text NULL,
	error_message text NULL,
	error_details text NULL,
	CONSTRAINT request_log_pk PRIMARY KEY (log_id_pk),
	CONSTRAINT request_log_un_tracing_identifier UNIQUE (tracing_identifier)
);


-- public.test_protocol definition

-- Drop table

-- DROP TABLE public.test_protocol;

CREATE TABLE public.test_protocol (
	testprotocol_tester varchar(128) NULL,
	testprotocol_instruct varchar(256) NULL,
	testprotocol_expect varchar(256) NULL,
	testprotocol_datetime timestamp(6) NULL,
	testprotocol_status varchar(32) DEFAULT 'PENDING'::character varying NOT NULL,
	testprotocol_pk int4 DEFAULT nextval('seq_testprotocol'::regclass) NOT NULL,
	testprotocol_comment text NULL,
	device_tag_name varchar(256) NULL,
	hmi_tag_name varchar(256) NULL,
	hmi_tag_desc varchar(256) NULL,
	ordernbr varchar(64) NULL,
	CONSTRAINT test_protocol_pk PRIMARY KEY (testprotocol_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public.test_protocol for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public.test_protocol for each statement execute procedure audit.if_modified_func('true');


-- public."v_dim_AttributesGeneric" definition

-- Drop table

-- DROP TABLE public."v_dim_AttributesGeneric";

CREATE TABLE public."v_dim_AttributesGeneric" (
	attr_gen_id_pk int4 DEFAULT nextval('seq_attributes_gen'::regclass) NOT NULL,
	attr_gen_name varchar(124) NULL,
	attr_gen_type varchar(32) NOT NULL,
	attr_gen_desc varchar(256) NULL,
	CONSTRAINT "PK_AttrGen" PRIMARY KEY (attr_gen_id_pk),
	CONSTRAINT unique_gen_attr UNIQUE (attr_gen_name, attr_gen_type, attr_gen_desc)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."v_dim_AttributesGeneric" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."v_dim_AttributesGeneric" for each statement execute procedure audit.if_modified_func('true');


-- public."v_map_HMITest" definition

-- Drop table

-- DROP TABLE public."v_map_HMITest";

CREATE TABLE public."v_map_HMITest" (
	test_hmi_map_id_pk int4 DEFAULT nextval('seq_hmi_test'::regclass) NOT NULL,
	test_alarmlight bool NULL,
	test_alarmhorn bool NULL,
	test_postouch bool NULL,
	test_hmi bool NULL,
	test_item_instruct varchar(256) NULL,
	test_item_expect varchar(256) NULL,
	safety_related bool DEFAULT false NOT NULL,
	CONSTRAINT "PK_HMITest" PRIMARY KEY (test_hmi_map_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."v_map_HMITest" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."v_map_HMITest" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Attributes" definition

-- Drop table

-- DROP TABLE public."dim_Attributes";

CREATE TABLE public."dim_Attributes" (
	attr_id_pk int4 DEFAULT nextval('seq_attributes'::regclass) NOT NULL,
	attr_min numeric NOT NULL,
	attr_max numeric NOT NULL,
	attr_default_unit varchar(32) NOT NULL,
	format_id_fk int4 NOT NULL,
	format_function_id_fk uuid NULL,
	CONSTRAINT "PK_Attr" PRIMARY KEY (attr_id_pk),
	CONSTRAINT max_gt_min_check CHECK ((attr_max >= attr_min)),
	CONSTRAINT dim_attributes_fk FOREIGN KEY (format_id_fk) REFERENCES public."dim_Formats"(format_id_pk),
	CONSTRAINT dim_attributes_fk2 FOREIGN KEY (format_function_id_fk) REFERENCES public."dim_FormatFunctions"(format_function_id_pk)
);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Attributes" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Attributes" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMITagsGeneric" definition

-- Drop table

-- DROP TABLE public."dim_HMITagsGeneric";

CREATE TABLE public."dim_HMITagsGeneric" (
	hmi_tag_generic_id_pk int4 DEFAULT nextval('seq_hmi_tags_generic'::regclass) NOT NULL,
	hmi_tag_generic_name varchar(128) NULL,
	hmi_tag_generic_desc varchar(256) NULL,
	machine_comp_id_fk int4 NULL,
	v_map_hmitest_fk int4 NULL,
	hmi_tag_generic_tbsh text NULL,
	processing bool DEFAULT false NOT NULL,
	error bool DEFAULT false NULL, -- The signal represents an error in the machine.
	created timestamptz(0) DEFAULT now() NOT NULL,
	last_modified timestamptz(0) DEFAULT now() NOT NULL,
	CONSTRAINT "HMIGeneric_pkey1" PRIMARY KEY (hmi_tag_generic_id_pk),
	CONSTRAINT cn_name UNIQUE (hmi_tag_generic_name),
	CONSTRAINT dim_hmitagsgeneric_v_map_hmitest_fk FOREIGN KEY (v_map_hmitest_fk) REFERENCES public."v_map_HMITest"(test_hmi_map_id_pk),
	CONSTRAINT fk_hmi_gen_machine FOREIGN KEY (machine_comp_id_fk) REFERENCES public."dim_MachineComponents"(machine_comp_id_pk)
);
CREATE UNIQUE INDEX dim_hmitagsgeneric_hmi_tag_generic_name_idx ON public."dim_HMITagsGeneric" USING btree (hmi_tag_generic_name);

-- Column comments

COMMENT ON COLUMN public."dim_HMITagsGeneric".error IS 'The signal represents an error in the machine.';

-- Table Triggers

create trigger set_timestamp before
update
    on
    public."dim_HMITagsGeneric" for each row execute procedure trigger_set_timestamp();
create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_HMITagsGeneric" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_HMITagsGeneric" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Orders" definition

-- Drop table

-- DROP TABLE public."dim_Orders";

CREATE TABLE public."dim_Orders" (
	order_id_pk int4 DEFAULT nextval('seq_orders'::regclass) NOT NULL,
	order_nbr int4 NOT NULL,
	order_type varchar(8) NOT NULL,
	order_cust_name varchar(32) NULL,
	order_copy_from_id_fk int4 NULL,
	opc_ua_export_customer_individual bool DEFAULT false NOT NULL, -- This flag indicates, if the opc-ua individual configurations will be used on an dpl export.
	dpl_file_version int4 NULL,
	description text NULL,
	CONSTRAINT "Orders_pkey1" PRIMARY KEY (order_id_pk),
	CONSTRAINT unique_orders UNIQUE (order_nbr, order_type, order_cust_name),
	CONSTRAINT dim_orders_dim_orders_fk FOREIGN KEY (order_copy_from_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);

-- Column comments

COMMENT ON COLUMN public."dim_Orders".opc_ua_export_customer_individual IS 'This flag indicates, if the opc-ua individual configurations will be used on an dpl export.';

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Orders" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Orders" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_UnitConversions" definition

-- Drop table

-- DROP TABLE public."dim_UnitConversions";

CREATE TABLE public."dim_UnitConversions" (
	unit_conversion_id_pk serial4 NOT NULL,
	soure_unit_id_fk int4 NOT NULL,
	target_unit_id_fk int4 NOT NULL,
	coefficient numeric DEFAULT 1 NULL,
	constant numeric DEFAULT 0 NULL,
	CONSTRAINT dim_unitconversions_pk PRIMARY KEY (unit_conversion_id_pk),
	CONSTRAINT dim_unitconversions_un UNIQUE (soure_unit_id_fk, target_unit_id_fk),
	CONSTRAINT dim_unitconversions_dim_units_fk FOREIGN KEY (soure_unit_id_fk) REFERENCES public."dim_Units"(unit_id_pk),
	CONSTRAINT dim_unitconversions_dim_units_fk_1 FOREIGN KEY (target_unit_id_fk) REFERENCES public."dim_Units"(unit_id_pk)
);
CREATE INDEX dim_unitconversions_soure_unit_id_fk_idx ON public."dim_UnitConversions" USING btree (soure_unit_id_fk);
CREATE INDEX dim_unitconversions_target_unit_id_fk_idx ON public."dim_UnitConversions" USING btree (target_unit_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_UnitConversions" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_UnitConversions" for each statement execute procedure audit.if_modified_func('true');


-- public."map_HMIVariants" definition

-- Drop table

-- DROP TABLE public."map_HMIVariants";

CREATE TABLE public."map_HMIVariants" (
	hmi_var_map_id_pk int4 DEFAULT nextval('seq_map_hmivar'::regclass) NOT NULL,
	hmi_tag_generic_id_fk int4 NOT NULL,
	attr_id_fk int4 NULL,
	order_id_fk int4 NULL,
	copied_from_hmi_var_map_id_fk int4 NULL, -- If this was created as a copy, that's the id of the original row.
	CONSTRAINT "PK_HMIVariants" PRIMARY KEY (hmi_var_map_id_pk),
	CONSTRAINT only_one_per_order UNIQUE (hmi_tag_generic_id_fk, order_id_fk),
	CONSTRAINT copy_from_fk FOREIGN KEY (copied_from_hmi_var_map_id_fk) REFERENCES public."map_HMIVariants"(hmi_var_map_id_pk) ON DELETE SET NULL,
	CONSTRAINT fk_hmi_var FOREIGN KEY (hmi_tag_generic_id_fk) REFERENCES public."dim_HMITagsGeneric"(hmi_tag_generic_id_pk),
	CONSTRAINT fk_hmi_var_attr FOREIGN KEY (attr_id_fk) REFERENCES public."dim_Attributes"(attr_id_pk),
	CONSTRAINT map_hmivariants_fk3 FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE INDEX map_hmivariants_attr_id_fk_idx ON public."map_HMIVariants" USING btree (attr_id_fk);
CREATE INDEX map_hmivariants_order_id_fk_idx ON public."map_HMIVariants" USING btree (order_id_fk);

-- Column comments

COMMENT ON COLUMN public."map_HMIVariants".copied_from_hmi_var_map_id_fk IS 'If this was created as a copy, that''s the id of the original row.';

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."map_HMIVariants" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."map_HMIVariants" for each statement execute procedure audit.if_modified_func('true');


-- public."map_ProjectLanguages" definition

-- Drop table

-- DROP TABLE public."map_ProjectLanguages";

CREATE TABLE public."map_ProjectLanguages" (
	project_language_map_id_pk serial4 NOT NULL,
	language_id_fk int4 NOT NULL,
	order_id_fk int4 NULL,
	CONSTRAINT map_projectlanguage_pk PRIMARY KEY (project_language_map_id_pk),
	CONSTRAINT map_projectlanguages_un UNIQUE (language_id_fk, order_id_fk),
	CONSTRAINT map_projectlanguages_fk FOREIGN KEY (language_id_fk) REFERENCES public."dim_Languages"(language_id_pk),
	CONSTRAINT map_projectlanguages_fk_1 FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE UNIQUE INDEX map_projectlanguages_language_id_fk_idx ON public."map_ProjectLanguages" USING btree (language_id_fk, order_id_fk);
CREATE INDEX map_projectlanguages_order_id_fk_idx ON public."map_ProjectLanguages" USING btree (order_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."map_ProjectLanguages" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."map_ProjectLanguages" for each statement execute procedure audit.if_modified_func('true');


-- public.v_map_hmitags definition

-- Drop table

-- DROP TABLE public.v_map_hmitags;

CREATE TABLE public.v_map_hmitags (
	hmi_tag_id_fk int4 NOT NULL,
	order_id_fk int4 NOT NULL,
	ignore_xml bool NULL,
	hmitag_order_map_id_pk serial4 NOT NULL,
	CONSTRAINT v_map_hmitags_pk PRIMARY KEY (hmitag_order_map_id_pk),
	CONSTRAINT v_map_hmitags_dim_hmitags_fk FOREIGN KEY (hmi_tag_id_fk) REFERENCES public."dim_HMITags"(hmi_tag_id_pk),
	CONSTRAINT v_map_hmitags_dim_orders_fk FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE INDEX v_map_hmitags_hmi_tag_id_fk_idx ON public.v_map_hmitags USING btree (hmi_tag_id_fk);
CREATE INDEX v_map_hmitags_order_id_fk_idx ON public.v_map_hmitags USING btree (order_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public.v_map_hmitags for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public.v_map_hmitags for each statement execute procedure audit.if_modified_func('true');


-- public."dim_Devices" definition

-- Drop table

-- DROP TABLE public."dim_Devices";

CREATE TABLE public."dim_Devices" (
	device_id_pk int4 DEFAULT nextval('seq_devices'::regclass) NOT NULL,
	device_name varchar(32) NOT NULL,
	device_com varchar(32) NULL,
	device_version varchar(32) NULL,
	device_project_name varchar(32) NULL,
	device_sps_name varchar(32) NULL,
	device_communication_type varchar(32) NOT NULL,
	device_line varchar(32) NULL,
	order_id_fk int4 NOT NULL,
	device_driver_number int4 DEFAULT 1 NOT NULL,
	created timestamptz(0) DEFAULT now() NOT NULL,
	last_modified timestamptz(0) DEFAULT now() NOT NULL,
	deleted bool DEFAULT false NOT NULL,
	CONSTRAINT "Device_pkey1" PRIMARY KEY (device_id_pk),
	CONSTRAINT fk_device_order FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE INDEX dim_devices_order_id_fk_idx ON public."dim_Devices" USING btree (order_id_fk);

-- Table Triggers

create trigger set_timestamp before
update
    on
    public."dim_Devices" for each row execute procedure trigger_set_timestamp();
create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_Devices" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_Devices" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMINavigationPoints" definition

-- Drop table

-- DROP TABLE public."dim_HMINavigationPoints";

CREATE TABLE public."dim_HMINavigationPoints" (
	hmi_navigation_point_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	panel_id varchar(256) NOT NULL,
	panel_name varchar(256) NULL,
	focus_id varchar(256) NULL,
	focus_name varchar(256) NULL,
	"permission" int4 NOT NULL,
	order_id_fk int4 NOT NULL,
	CONSTRAINT dim_hminavigationpoints_pk PRIMARY KEY (hmi_navigation_point_id_pk),
	CONSTRAINT dim_hminavigationpoints_dim_orders_fk FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE INDEX dim_hminavigationpoints_order_id_fk_idx ON public."dim_HMINavigationPoints" USING btree (order_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_HMINavigationPoints" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_HMINavigationPoints" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMIXmlProjects" definition

-- Drop table

-- DROP TABLE public."dim_HMIXmlProjects";

CREATE TABLE public."dim_HMIXmlProjects" (
	hmi_xml_project_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	order_id_fk int4 NOT NULL,
	git_repository varchar(1024) NULL,
	git_branch varchar(1024) NULL,
	git_index varchar(256) NULL,
	CONSTRAINT dim_hmixmlprojects_pk PRIMARY KEY (hmi_xml_project_id_pk),
	CONSTRAINT dim_hmixmlprojects_dim_orders_fk FOREIGN KEY (order_id_fk) REFERENCES public."dim_Orders"(order_id_pk)
);
CREATE INDEX dim_hmixmlprojects_order_id_fk_idx ON public."dim_HMIXmlProjects" USING btree (order_id_fk);


-- public."dim_XmlUploadLogs" definition

-- Drop table

-- DROP TABLE public."dim_XmlUploadLogs";

CREATE TABLE public."dim_XmlUploadLogs" (
	hmi_xml_uploadlogs_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	hmi_xml_project_id_fk int4 NOT NULL,
	message varchar(2048) NULL,
	CONSTRAINT xmluploadlogs_pk PRIMARY KEY (hmi_xml_uploadlogs_id_pk),
	CONSTRAINT dim_xmluploadlogs_dim_hmixmlprojects_fk FOREIGN KEY (hmi_xml_project_id_fk) REFERENCES public."dim_HMIXmlProjects"(hmi_xml_project_id_pk)
);
CREATE INDEX dim_xmluploadlogs_hmi_xml_project_id_fk_idx ON public."dim_XmlUploadLogs" USING btree (hmi_xml_project_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_XmlUploadLogs" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_XmlUploadLogs" for each statement execute procedure audit.if_modified_func('true');


-- public."map_HmitagGenericTranslation" definition

-- Drop table

-- DROP TABLE public."map_HmitagGenericTranslation";

CREATE TABLE public."map_HmitagGenericTranslation" (
	hmi_tag_generic_map_id_pk serial4 NOT NULL,
	project_language_map_id_fk int4 NOT NULL,
	hmi_tag_generic_translation_desc varchar NULL,
	hmi_tag_generic_id_fk int4 NOT NULL,
	hmi_tag_generic_translation_created date DEFAULT now() NULL,
	hmi_tag_generic_translation_modified timestamptz DEFAULT now() NULL,
	hmi_tag_generic_translation_checked bool DEFAULT false NOT NULL,
	"hmi_tag_generic_map_id_pk"",""project_language_map_id_fk"",""hmi_ta" varchar(128) NULL,
	CONSTRAINT map_hmitaggenericlanguage_pk PRIMARY KEY (hmi_tag_generic_map_id_pk),
	CONSTRAINT map_hmitaggenerictranslation_un UNIQUE (project_language_map_id_fk, hmi_tag_generic_id_fk),
	CONSTRAINT map_hmitaggenerictranslation_fk FOREIGN KEY (hmi_tag_generic_id_fk) REFERENCES public."dim_HMITagsGeneric"(hmi_tag_generic_id_pk),
	CONSTRAINT map_hmitaggenerictranslation_fk_1 FOREIGN KEY (project_language_map_id_fk) REFERENCES public."map_ProjectLanguages"(project_language_map_id_pk)
);
CREATE INDEX map_hmitaggenerictranslation_hmi_tag_generic_id_fk_idx ON public."map_HmitagGenericTranslation" USING btree (hmi_tag_generic_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."map_HmitagGenericTranslation" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."map_HmitagGenericTranslation" for each statement execute procedure audit.if_modified_func('true');


-- public."map_HmitagTranslation" definition

-- Drop table

-- DROP TABLE public."map_HmitagTranslation";

CREATE TABLE public."map_HmitagTranslation" (
	hmi_tag_translation_map_id_pk serial4 NOT NULL,
	project_language_map_id_fk int4 NOT NULL,
	hmi_tag_id_fk int4 NOT NULL,
	hmi_tag_translation_desc text NULL,
	hmi_tag_translation_created timestamptz DEFAULT now() NOT NULL,
	hmi_tag_translation_modified timestamptz DEFAULT now() NOT NULL,
	device_tag_block varchar DEFAULT ''::character varying NOT NULL,
	CONSTRAINT hmi_tag_translation_map_id_pk PRIMARY KEY (hmi_tag_translation_map_id_pk),
	CONSTRAINT map_hmitagtranslation_un UNIQUE (project_language_map_id_fk, hmi_tag_id_fk, device_tag_block),
	CONSTRAINT map_hmitagtranslation_fk FOREIGN KEY (project_language_map_id_fk) REFERENCES public."map_ProjectLanguages"(project_language_map_id_pk),
	CONSTRAINT map_hmitagtranslation_fk_1 FOREIGN KEY (hmi_tag_id_fk) REFERENCES public."dim_HMITags"(hmi_tag_id_pk)
);
CREATE INDEX map_hmitagtranslation_hmi_tag_id_fk_idx ON public."map_HmitagTranslation" USING btree (hmi_tag_id_fk);
CREATE INDEX map_hmitagtranslation_project_language_map_id_fk_idx ON public."map_HmitagTranslation" USING btree (project_language_map_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."map_HmitagTranslation" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."map_HmitagTranslation" for each statement execute procedure audit.if_modified_func('true');


-- public.device_blocks definition

-- Drop table

-- DROP TABLE public.device_blocks;

CREATE TABLE public.device_blocks (
	id serial4 NOT NULL,
	device_id_fk int4 NOT NULL,
	"name" varchar NOT NULL,
	created_at timestamptz DEFAULT now() NOT NULL,
	modified_at timestamptz DEFAULT now() NOT NULL,
	deleted bool DEFAULT false NOT NULL,
	CONSTRAINT dim_deviceblocks_pk PRIMARY KEY (id),
	CONSTRAINT dim_deviceblocks_dim_devices_device_id_pk_fk FOREIGN KEY (device_id_fk) REFERENCES public."dim_Devices"(device_id_pk)
);
CREATE UNIQUE INDEX device_and_block_unique ON public.device_blocks USING btree (device_id_fk, name);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public.device_blocks for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public.device_blocks for each statement execute procedure audit.if_modified_func('true');


-- public."dim_DeviceTags" definition

-- Drop table

-- DROP TABLE public."dim_DeviceTags";

CREATE TABLE public."dim_DeviceTags" (
	device_tag_id_pk int4 DEFAULT nextval('seq_device_tags'::regclass) NOT NULL,
	device_tag_name varchar(256) NOT NULL,
	device_tag_data_type varchar(32) NOT NULL,
	device_tag_parent varchar(256) NOT NULL,
	device_tag_comment varchar(256) NULL,
	device_tag_ext_accessible bool NULL,
	device_tag_ext_visible bool NOT NULL,
	device_tag_setpoint bool NULL,
	device_tag_name_generic varchar(256) NOT NULL,
	device_tag_creat_time timestamp(6) NULL,
	device_tag_updat_time timestamp(6) NULL,
	device_tag_unit varchar(16) NULL,
	device_tag_resolution varchar(32) NULL,
	load_id_fk int4 NOT NULL,
	deleted bool DEFAULT false NOT NULL, -- soft delete flag
	"ignore" bool DEFAULT false NOT NULL, -- ignore by hmi
	device_tag_ext_writable bool NULL, -- flag if writable by pls
	device_tag_startvalue varchar(32) NULL,
	device_tag_trace_value int4 NULL,
	digits _int4 NULL,
	internal bool DEFAULT false NULL, -- If true, tag has no SPS address.
	error bool DEFAULT false NOT NULL,
	processing bool DEFAULT false NOT NULL,
	testing bool DEFAULT false NOT NULL,
	machine_component_fk int4 NULL,
	block_fk int4 NULL,
	CONSTRAINT "DeviceTag_pkey1" PRIMARY KEY (device_tag_id_pk),
	CONSTRAINT dim_devicetags_unique_address_idx UNIQUE (device_tag_name, block_fk),
	CONSTRAINT fk_device_blocks FOREIGN KEY (block_fk) REFERENCES public.device_blocks(id),
	CONSTRAINT fk_device_tag_load FOREIGN KEY (load_id_fk) REFERENCES public."dim_Loads"(load_id_pk),
	CONSTRAINT fk_devicetags_machine_component FOREIGN KEY (machine_component_fk) REFERENCES public."dim_MachineComponents"(machine_comp_id_pk)
);
CREATE INDEX dim_devicetags_device_tag_trace_value_idx ON public."dim_DeviceTags" USING btree (device_tag_trace_value);
CREATE INDEX dim_devicetags_load_id_fk_idx ON public."dim_DeviceTags" USING btree (load_id_fk);
CREATE INDEX unique_address ON public."dim_DeviceTags" USING btree (block_fk, device_tag_name);

-- Column comments

COMMENT ON COLUMN public."dim_DeviceTags".deleted IS 'soft delete flag';
COMMENT ON COLUMN public."dim_DeviceTags"."ignore" IS 'ignore by hmi';
COMMENT ON COLUMN public."dim_DeviceTags".device_tag_ext_writable IS 'flag if writable by pls';
COMMENT ON COLUMN public."dim_DeviceTags".internal IS 'If true, tag has no SPS address.';

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."dim_DeviceTags" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."dim_DeviceTags" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMIPanelGroups" definition

-- Drop table

-- DROP TABLE public."dim_HMIPanelGroups";

CREATE TABLE public."dim_HMIPanelGroups" (
	hmi_panel_group_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	id varchar(256) NULL,
	filepath varchar(1024) NULL,
	isreference bool NULL,
	hmi_xml_project_id_fk int4 NULL,
	"name" varchar(256) NULL,
	variables_mapping text NULL,
	navigation varchar(2048) NULL,
	CONSTRAINT dim_hmipanelgroups_pk PRIMARY KEY (hmi_panel_group_id_pk),
	CONSTRAINT dim_hmipanelgroups_dim_hmixmlprojects_fk FOREIGN KEY (hmi_xml_project_id_fk) REFERENCES public."dim_HMIXmlProjects"(hmi_xml_project_id_pk)
);
CREATE INDEX dim_hmipanelgroups_hmi_xml_project_id_fk_idx ON public."dim_HMIPanelGroups" USING btree (hmi_xml_project_id_fk);


-- public."dim_HMIPanels" definition

-- Drop table

-- DROP TABLE public."dim_HMIPanels";

CREATE TABLE public."dim_HMIPanels" (
	hmi_panel_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	focusref varchar(256) NOT NULL,
	hmi_panel_group_id_fk int4 NOT NULL,
	component_filepath varchar(1024) NULL,
	"name" varchar(256) NULL,
	CONSTRAINT dim_hmipanels_pk PRIMARY KEY (hmi_panel_id_pk),
	CONSTRAINT dim_hmipanels_dim_hmipanelgroups_fk FOREIGN KEY (hmi_panel_group_id_fk) REFERENCES public."dim_HMIPanelGroups"(hmi_panel_group_id_pk)
);


-- public."map_HMIDevice" definition

-- Drop table

-- DROP TABLE public."map_HMIDevice";

CREATE TABLE public."map_HMIDevice" (
	hmi_device_map_id_pk int4 DEFAULT nextval('seq_map_hmidevice'::regclass) NOT NULL,
	device_tag_id_fk int4 NOT NULL,
	hmi_tag_id_fk int4 NOT NULL,
	hmi_var_map_id_fk int4 NOT NULL,
	attr_id_fk int4 NULL,
	testprotocol_fk int4 NULL,
	CONSTRAINT "PK_HMIDevice" PRIMARY KEY (hmi_device_map_id_pk),
	CONSTRAINT map_hmidevice_un UNIQUE (device_tag_id_fk),
	CONSTRAINT map_hmidevice_un_hmi_tag UNIQUE (hmi_tag_id_fk),
	CONSTRAINT fk_hmi_device_attr FOREIGN KEY (attr_id_fk) REFERENCES public."dim_Attributes"(attr_id_pk),
	CONSTRAINT fk_hmi_device_tag FOREIGN KEY (device_tag_id_fk) REFERENCES public."dim_DeviceTags"(device_tag_id_pk),
	CONSTRAINT fk_hmi_device_variant FOREIGN KEY (hmi_var_map_id_fk) REFERENCES public."map_HMIVariants"(hmi_var_map_id_pk),
	CONSTRAINT fk_hmi_hmi_tag FOREIGN KEY (hmi_tag_id_fk) REFERENCES public."dim_HMITags"(hmi_tag_id_pk),
	CONSTRAINT map_hmidevice_test_protocol_fk FOREIGN KEY (testprotocol_fk) REFERENCES public.test_protocol(testprotocol_pk)
);
CREATE INDEX map_hmidevice_attr_id_fk_idx ON public."map_HMIDevice" USING btree (attr_id_fk);
CREATE INDEX map_hmidevice_device_tag_id_fk_idx ON public."map_HMIDevice" USING btree (device_tag_id_fk);
CREATE INDEX map_hmidevice_hmi_tag_id_fk_idx ON public."map_HMIDevice" USING btree (hmi_tag_id_fk);
CREATE INDEX map_hmidevice_hmi_var_map_id_fk_idx ON public."map_HMIDevice" USING btree (hmi_var_map_id_fk);
CREATE INDEX map_hmidevice_testprotocol_fk_idx ON public."map_HMIDevice" USING btree (testprotocol_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."map_HMIDevice" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."map_HMIDevice" for each statement execute procedure audit.if_modified_func('true');


-- public."v_map_HMIAttrGen" definition

-- Drop table

-- DROP TABLE public."v_map_HMIAttrGen";

CREATE TABLE public."v_map_HMIAttrGen" (
	hmi_attr_map_id_pk int4 DEFAULT nextval('seq_hmi_attr_gen'::regclass) NOT NULL,
	attr_gen_id_fk int4 NOT NULL,
	hmi_device_map_id_fk int4 NULL,
	attr_val varchar(256) NOT NULL,
	attr_unit varchar(16) NULL,
	hmi_var_map_id_fk int4 NULL,
	CONSTRAINT "PK_HMIAttrGen" PRIMARY KEY (hmi_attr_map_id_pk),
	CONSTRAINT v_map_hmiattrgen_un UNIQUE (attr_gen_id_fk, hmi_device_map_id_fk),
	CONSTRAINT v_map_hmiattrgen_un2 UNIQUE (hmi_var_map_id_fk, attr_gen_id_fk),
	CONSTRAINT fk FOREIGN KEY (hmi_var_map_id_fk) REFERENCES public."map_HMIVariants"(hmi_var_map_id_pk),
	CONSTRAINT fk_attr_gen_hmi_device FOREIGN KEY (hmi_device_map_id_fk) REFERENCES public."map_HMIDevice"(hmi_device_map_id_pk),
	CONSTRAINT fk_hmi_attr_gen FOREIGN KEY (attr_gen_id_fk) REFERENCES public."v_dim_AttributesGeneric"(attr_gen_id_pk)
);
CREATE INDEX v_map_hmiattrgen_attr_gen_id_fk_idx ON public."v_map_HMIAttrGen" USING btree (attr_gen_id_fk);
CREATE INDEX v_map_hmiattrgen_hmi_device_map_id_fk_idx ON public."v_map_HMIAttrGen" USING btree (hmi_device_map_id_fk);
CREATE INDEX v_map_hmiattrgen_hmi_var_map_id_fk_idx ON public."v_map_HMIAttrGen" USING btree (hmi_var_map_id_fk);

-- Table Triggers

create trigger audit_trigger_row after
insert
    or
delete
    or
update
    on
    public."v_map_HMIAttrGen" for each row execute procedure audit.if_modified_func('true');
create trigger audit_trigger_stm after
truncate
    on
    public."v_map_HMIAttrGen" for each statement execute procedure audit.if_modified_func('true');


-- public."dim_HMIFieldSetGroups" definition

-- Drop table

-- DROP TABLE public."dim_HMIFieldSetGroups";

CREATE TABLE public."dim_HMIFieldSetGroups" (
	hmi_field_set_group_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	id varchar NULL,
	hmi_panel_id_fk int4 NULL,
	CONSTRAINT dim_hmifieldsetgroups_pk PRIMARY KEY (hmi_field_set_group_id_pk),
	CONSTRAINT dim_hmifieldsetgroups_dim_hmipanels_fk FOREIGN KEY (hmi_panel_id_fk) REFERENCES public."dim_HMIPanels"(hmi_panel_id_pk)
);
CREATE INDEX dim_hmifieldsetgroups_hmi_panel_id_fk_idx ON public."dim_HMIFieldSetGroups" USING btree (hmi_panel_id_fk);


-- public."dim_HMIFieldSets" definition

-- Drop table

-- DROP TABLE public."dim_HMIFieldSets";

CREATE TABLE public."dim_HMIFieldSets" (
	id varchar NULL,
	hmi_field_set_group_id_fk int4 NULL,
	hmi_field_set_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	hmi_panel_id_fk int4 NULL,
	CONSTRAINT dim_hmifieldsets_pk PRIMARY KEY (hmi_field_set_id_pk),
	CONSTRAINT dim_hmifieldsets_dim_hmifieldsetgroups_fk FOREIGN KEY (hmi_field_set_group_id_fk) REFERENCES public."dim_HMIFieldSetGroups"(hmi_field_set_group_id_pk),
	CONSTRAINT dim_hmifieldsets_dim_hmipanels_fk FOREIGN KEY (hmi_panel_id_fk) REFERENCES public."dim_HMIPanels"(hmi_panel_id_pk)
);
CREATE INDEX dim_hmifieldsets_hmi_field_set_group_id_fk_idx ON public."dim_HMIFieldSets" USING btree (hmi_field_set_group_id_fk);
CREATE INDEX dim_hmifieldsets_hmi_panel_id_fk_idx ON public."dim_HMIFieldSets" USING btree (hmi_panel_id_fk);


-- public."dim_HMIGenericBlockGoups" definition

-- Drop table

-- DROP TABLE public."dim_HMIGenericBlockGoups";

CREATE TABLE public."dim_HMIGenericBlockGoups" (
	hmi_generic_block_group_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	filepath varchar(1024) NULL,
	isreference bool NULL,
	hmi_panel_id_fk int4 NULL,
	CONSTRAINT dim_hmigenericblockgoups_pk PRIMARY KEY (hmi_generic_block_group_id_pk),
	CONSTRAINT dim_hmigenericblockgroups_dim_hmipanels_fk FOREIGN KEY (hmi_panel_id_fk) REFERENCES public."dim_HMIPanels"(hmi_panel_id_pk)
);
CREATE INDEX dim_hmigenericblockgoups_hmi_panel_id_fk_idx ON public."dim_HMIGenericBlockGoups" USING btree (hmi_panel_id_fk);


-- public."dim_HMIGenericBlocks" definition

-- Drop table

-- DROP TABLE public."dim_HMIGenericBlocks";

CREATE TABLE public."dim_HMIGenericBlocks" (
	hmi_generic_block_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	id varchar NOT NULL,
	hmi_generic_block_group_id_fk int4 NOT NULL,
	CONSTRAINT dim_hmigenericblocks_pk PRIMARY KEY (hmi_generic_block_pk),
	CONSTRAINT dim_hmigenericblocks_dim_hmigenericblockgoups_fk FOREIGN KEY (hmi_generic_block_group_id_fk) REFERENCES public."dim_HMIGenericBlockGoups"(hmi_generic_block_group_id_pk)
);
CREATE INDEX dim_hmigenericblocks_hmi_generic_block_group_id_fk_idx ON public."dim_HMIGenericBlocks" USING btree (hmi_generic_block_group_id_fk);


-- public."dim_HMIFields" definition

-- Drop table

-- DROP TABLE public."dim_HMIFields";

CREATE TABLE public."dim_HMIFields" (
	hmi_field_set_id_fk int4 NULL,
	id varchar(256) NULL,
	"type" varchar(256) NOT NULL,
	hmi_field_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	hmi_panel_id_fk int4 NULL,
	hmi_generic_block_fk int4 NULL,
	trend_refs varchar(512) NULL,
	layoutref varchar(256) NULL,
	"row" varchar(256) NULL,
	"column" varchar(256) NULL,
	CONSTRAINT dim_hmifields_pk PRIMARY KEY (hmi_field_id_pk),
	CONSTRAINT dim_hmifields_dim_hmifieldsets_fk FOREIGN KEY (hmi_field_set_id_fk) REFERENCES public."dim_HMIFieldSets"(hmi_field_set_id_pk),
	CONSTRAINT dim_hmifields_dim_hmigenericblocks_fk FOREIGN KEY (hmi_generic_block_fk) REFERENCES public."dim_HMIGenericBlocks"(hmi_generic_block_pk),
	CONSTRAINT dim_hmifields_dim_hmipanels_fk FOREIGN KEY (hmi_panel_id_fk) REFERENCES public."dim_HMIPanels"(hmi_panel_id_pk)
);
CREATE INDEX dim_hmifields_hmi_field_id_pk_idx ON public."dim_HMIFields" USING btree (hmi_field_id_pk);
CREATE INDEX dim_hmifields_hmi_generic_block_fk_idx ON public."dim_HMIFields" USING btree (hmi_generic_block_fk);
CREATE INDEX dim_hmifields_hmi_panel_id_fk_idx ON public."dim_HMIFields" USING btree (hmi_panel_id_fk);


-- public."map_HMIXmltags" definition

-- Drop table

-- DROP TABLE public."map_HMIXmltags";

CREATE TABLE public."map_HMIXmltags" (
	hmi_xmltag_id_pk int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	hmi_xmltag_orgname varchar(256) NOT NULL,
	hmi_xmltag_fullname varchar(256) NULL,
	hmi_tag_id_fk int4 NULL,
	hmi_xmltag_shortname varchar(256) NULL,
	dpe_type varchar(256) NOT NULL,
	hmi_field_id_fk int4 NULL,
	hmi_field_set_id_fk int4 NULL,
	hmi_field_set_group_id_fk int4 NULL,
	hmi_generic_block_id_fk int4 NULL,
	xml_file_line int4 NULL,
	CONSTRAINT map_hmixmltags_pk PRIMARY KEY (hmi_xmltag_id_pk),
	CONSTRAINT map_hmixmltags_dim_hmifields_fk FOREIGN KEY (hmi_field_id_fk) REFERENCES public."dim_HMIFields"(hmi_field_id_pk),
	CONSTRAINT map_hmixmltags_dim_hmifieldsetgroups_fk FOREIGN KEY (hmi_field_set_group_id_fk) REFERENCES public."dim_HMIFieldSetGroups"(hmi_field_set_group_id_pk),
	CONSTRAINT map_hmixmltags_dim_hmifieldsets_fk FOREIGN KEY (hmi_field_set_id_fk) REFERENCES public."dim_HMIFieldSets"(hmi_field_set_id_pk),
	CONSTRAINT map_hmixmltags_dim_hmigenericblocks_fk FOREIGN KEY (hmi_generic_block_id_fk) REFERENCES public."dim_HMIGenericBlocks"(hmi_generic_block_pk),
	CONSTRAINT map_hmixmltags_dim_hmitags_fk FOREIGN KEY (hmi_tag_id_fk) REFERENCES public."dim_HMITags"(hmi_tag_id_pk)
);
CREATE INDEX map_hmixmltags_hmi_field_id_fk_idx ON public."map_HMIXmltags" USING btree (hmi_field_id_fk);
CREATE INDEX map_hmixmltags_hmi_field_set_group_id_fk_idx ON public."map_HMIXmltags" USING btree (hmi_field_set_group_id_fk);
CREATE INDEX map_hmixmltags_hmi_field_set_id_fk_idx ON public."map_HMIXmltags" USING btree (hmi_field_set_id_fk);
CREATE INDEX map_hmixmltags_hmi_generic_block_id_fk_idx ON public."map_HMIXmltags" USING btree (hmi_generic_block_id_fk);
CREATE INDEX map_hmixmltags_hmi_tag_id_fk_idx ON public."map_HMIXmltags" USING btree (hmi_tag_id_fk);
CREATE INDEX map_hmixmltags_xml_file_line_idx ON public."map_HMIXmltags" USING btree (xml_file_line);


-- public.performance source

CREATE OR REPLACE VIEW public.performance
AS SELECT rl.method,
    "substring"(rl.path::text, '^(.*?)(/[0-9\.]+)*$'::text) AS "substring",
    sum(rl.finished - timezone('utc'::text, rl.start)::timestamp with time zone) AS total,
    count(*) AS count,
    avg(rl.finished - timezone('utc'::text, rl.start)::timestamp with time zone) AS average,
    max(rl.finished - timezone('utc'::text, rl.start)::timestamp with time zone) AS max,
    min(rl.finished - timezone('utc'::text, rl.start)::timestamp with time zone) AS min
   FROM request_log rl
  WHERE rl.start > '2022-03-01 00:00:00+01'::timestamp with time zone AND rl.method::text <> 'OPTIONS'::text
  GROUP BY ("substring"(rl.path::text, '^(.*?)(/[0-9\.]+)*$'::text)), rl.method
  ORDER BY (avg(rl.finished - timezone('utc'::text, rl.start)::timestamp with time zone)) DESC;


-- public.process_table source

CREATE OR REPLACE VIEW public.process_table
AS SELECT (do2.order_type::text || '.'::text) || do2.order_nbr AS "order",
    build_hmi_tag_name(dhg.hmi_tag_generic_name::text, dh.digits) AS hmi_tag_name,
    (hstore(da.*) - ARRAY['attr_id_pk'::text]) || hstore(array_agg(vdag.attr_gen_name)::text[], array_agg(vmhg.attr_val)::text[]) AS process_values
   FROM "map_HMIDevice" mh
     JOIN "dim_HMITags" dh ON mh.hmi_tag_id_fk = dh.hmi_tag_id_pk
     JOIN "map_HMIVariants" mh2 ON mh.hmi_var_map_id_fk = mh2.hmi_var_map_id_pk
     JOIN "dim_Orders" do2 ON mh2.order_id_fk = do2.order_id_pk
     JOIN "dim_Attributes" da ON mh2.attr_id_fk = da.attr_id_pk
     JOIN "dim_Formats" df ON da.format_id_fk = df.format_id_pk
     JOIN "v_map_HMIAttrGen" vmhg ON mh2.hmi_var_map_id_pk = vmhg.hmi_var_map_id_fk
     JOIN "v_dim_AttributesGeneric" vdag ON vmhg.attr_gen_id_fk = vdag.attr_gen_id_pk
     JOIN "dim_HMITagsGeneric" dhg ON mh2.hmi_tag_generic_id_fk = dhg.hmi_tag_generic_id_pk
  GROUP BY do2.order_type, do2.order_nbr, dhg.hmi_tag_generic_name, dh.digits, da.*
  ORDER BY dhg.hmi_tag_generic_name;


-- public.replay_curl source

CREATE OR REPLACE VIEW public.replay_curl
AS SELECT (((((((('curl -d '::text || rl.request_data) || ' -H "Content-Type: application/json" -X '::text) || rl.method::text) || ' '::text) || rl.scheme::text) || '://'::text) || rl.host::text) || rl.path::text) || rl.query_string::text AS "?column?"
   FROM request_log rl
  WHERE (rl.method::text <> ALL (ARRAY['GET'::character varying::text, 'OPTIONS'::character varying::text])) AND rl.path::text !~~ '/hangfire%'::text;



-- DROP FUNCTION public.akeys(hstore);

CREATE OR REPLACE FUNCTION public.akeys(hstore)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_akeys$function$
;

-- DROP FUNCTION public.avals(hstore);

CREATE OR REPLACE FUNCTION public.avals(hstore)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_avals$function$
;

-- DROP FUNCTION public.build_device_tag_name(text, _int4);

CREATE OR REPLACE FUNCTION public.build_device_tag_name(generic_name text, digits integer[])
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare digit int;

hmi_tag_name text;

begin
		if digits is null
or (length(generic_name)-length(replace(generic_name, '##', '')))/2 != array_length(digits, 1) then
			return generic_name;
end if;

hmi_tag_name := generic_name;

foreach digit in array digits
		loop
			hmi_tag_name := overlay(hmi_tag_name placing '[' || digit::text || ']' from position('##' in hmi_tag_name) for 2);
end loop;

return hmi_tag_name;
end;

$function$
;

-- DROP FUNCTION public.build_hmi_tag_name(text, _int4);

CREATE OR REPLACE FUNCTION public.build_hmi_tag_name(generic_name text, digits integer[])
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare digit int;

hmi_tag_name text;

begin
		if digits is null
or (length(generic_name)-length(replace(generic_name, '##', '')))/2 != array_length(digits, 1) then
			return generic_name;
end if;

hmi_tag_name := generic_name;

foreach digit in array digits
		loop
			hmi_tag_name := overlay(hmi_tag_name placing right('00' || digit::text, 2) from position('##' in hmi_tag_name) for 2);
end loop;

return hmi_tag_name;
end;

$function$
;

-- DROP FUNCTION public.check_duplicate_hmi_tag();

CREATE OR REPLACE FUNCTION public.check_duplicate_hmi_tag()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
begin
	if exists (select
	1
from "map_HMIVariants" variant 
join "dim_HMITags" ht on
	new.hmi_tag_id_fk = ht.hmi_tag_id_pk
join (
	select
		variant.order_id_fk,
		variant.hmi_tag_generic_id_fk,
		ht.digits,
		mh.hmi_device_map_id_pk
	from
		"map_HMIDevice" mh
	join "map_HMIVariants" variant on
		mh.hmi_var_map_id_fk = variant.hmi_var_map_id_pk
	join "dim_HMITags" ht on
		mh.hmi_tag_id_fk = ht.hmi_tag_id_pk) duplicates on
	duplicates.order_id_fk = variant.order_id_fk
	and duplicates.hmi_tag_generic_id_fk = variant.hmi_tag_generic_id_fk
	and duplicates.digits = ht.digits
	and duplicates.hmi_device_map_id_pk <> new.hmi_device_map_id_pk
	where variant.hmi_var_map_id_pk = new.hmi_var_map_id_fk
)
	then 
		raise exception 'duplicate hmi tag for map_HMIDevice % detected', new.hmi_device_map_id_pk;
	end if;
return new;
end;
$function$
;

-- DROP FUNCTION public.compare_orders(text, text);

CREATE OR REPLACE FUNCTION public.compare_orders(order1 text, order2 text)
 RETURNS TABLE(hmi_tag_name text, diff1 hstore, diff2 hstore)
 LANGUAGE plpgsql
AS $function$
begin
	return query
select
	pt.hmi_tag_name ,
	pt.process_values - pt2.process_values,
	pt2.process_values - pt.process_values
from
	process_table pt
join process_table pt2 on
	pt.hmi_tag_name = pt2.hmi_tag_name
	and pt2."order" = order2
where
	pt."order" = order1
	and ((pt.process_values - pt2.process_values) ?| akeys(pt.process_values)
		or (pt2.process_values - pt.process_values) ?| akeys(pt2.process_values));
end;

$function$
;

-- DROP FUNCTION public.copy_device_tags(int4, int4, int4, int4);

CREATE OR REPLACE FUNCTION public.copy_device_tags(source_device_id_fk integer, target_device_id_fk integer, source_order_id_fk integer, target_order_id_fk integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
	source_device_tag integer;
	target_device_tag integer;
	source_var_map record;
	target_var_map integer;
	new_attr_id_fk integer;
	source_hmi_device record;
begin 
	for source_var_map in select distinct v.* from "map_HMIVariants" v
	join public."map_HMIDevice" mh on mh.hmi_var_map_id_fk = v.hmi_var_map_id_pk 
	join public."dim_DeviceTags" ddt on mh.device_tag_id_fk = ddt.device_tag_id_pk 
	where order_id_fk = source_order_id_fk and ddt.device_id_fk = source_device_id_fk
	loop 
		--todo, check if map_variant already exists
		if exists(select 1 from public."map_HMIVariants" where order_id_fk = target_order_id_fk and hmi_tag_generic_id_fk = source_var_map.hmi_tag_generic_id_fk)
		then 
			select hmi_var_map_id_pk from public."map_HMIVariants" where order_id_fk = target_order_id_fk and hmi_tag_generic_id_fk = source_var_map.hmi_tag_generic_id_fk into target_var_map;
		else
			-- copy map_HMIVariants entry
			INSERT INTO public."dim_Attributes"
				(attr_min, attr_max, attr_default_unit, format_id_fk, format_function_id_fk)
				select attr_min, attr_max, attr_default_unit, format_id_fk, format_function_id_fk from public."dim_Attributes" where attr_id_pk = source_var_map.attr_id_fk
				returning attr_id_pk into new_attr_id_fk;
			INSERT INTO public."map_HMIVariants"
					(hmi_tag_generic_id_fk, attr_id_fk, order_id_fk)
					values( source_var_map.hmi_tag_generic_id_fk, new_attr_id_fk, target_order_id_fk)
					returning hmi_var_map_id_pk into target_var_map;
			-- generic attributes
			INSERT INTO public."v_map_HMIAttrGen"
			(attr_gen_id_fk, hmi_device_map_id_fk, attr_val, attr_unit, hmi_var_map_id_fk)
			select attr_gen_id_fk, hmi_device_map_id_fk, attr_val, attr_unit, target_var_map 
			from public."v_map_HMIAttrGen" where hmi_var_map_id_fk = source_var_map.hmi_var_map_id_pk;
		end	if;	
		-- mapping and device_tags
		for source_hmi_device in select hd.* from "map_HMIDevice" hd
		join public."dim_DeviceTags" ddt on hd.device_tag_id_fk = ddt.device_tag_id_pk 
		where hmi_var_map_id_fk = source_var_map.hmi_var_map_id_pk and ddt.device_id_fk = source_device_id_fk
		loop 
			declare 				
				new_device_tag_id_fk integer;
				new_hmi_tag_id_fk integer;
				new_attr_id_fk integer;
				new_testprotocol_fk integer;
				new_hmi_device_id_fk integer;
			begin				
				-- create new device_tag
				INSERT INTO public."dim_DeviceTags"
				(device_tag_name, device_tag_data_type, device_tag_parent, device_tag_comment, device_tag_ext_accessible, device_tag_ext_visible, device_tag_setpoint, device_tag_name_generic, device_id_fk, device_tag_creat_time, device_tag_updat_time, device_tag_unit, device_tag_resolution, device_tag_block, load_id_fk, deleted, "ignore", device_tag_ext_writable, device_tag_startvalue, device_tag_trace_value, digits, internal)
				select device_tag_name, device_tag_data_type, device_tag_parent, device_tag_comment, device_tag_ext_accessible, device_tag_ext_visible, device_tag_setpoint, device_tag_name_generic, target_device_id_fk, now(), now(), device_tag_unit, device_tag_resolution, device_tag_block, load_id_fk, deleted, "ignore", device_tag_ext_writable, device_tag_startvalue, null, digits, internal
				from public."dim_DeviceTags" where device_tag_id_pk = source_hmi_device.device_tag_id_fk
				returning device_tag_id_pk into new_device_tag_id_fk;
				-- create new hmi_tag
				INSERT INTO public."dim_HMITags"
				(digits)
				select digits from public."dim_HMITags" where hmi_tag_id_pk = source_hmi_device.hmi_tag_id_fk
				returning hmi_tag_id_pk into new_hmi_tag_id_fk;
				-- create new attribute
				INSERT INTO public."dim_Attributes"
				(attr_min, attr_max, attr_default_unit, format_id_fk, format_function_id_fk)
				select attr_min, attr_max, attr_default_unit, format_id_fk, format_function_id_fk from public."dim_Attributes"
				where attr_id_pk = source_hmi_device.attr_id_fk
				returning attr_id_pk into new_attr_id_fk;
				-- create new testprotocol
				INSERT INTO public.test_protocol (testprotocol_comment) values ('PENDING') returning testprotocol_pk into new_testprotocol_fk;
				-- create new hmi_device
				INSERT INTO public."map_HMIDevice"
				(device_tag_id_fk, hmi_tag_id_fk, hmi_var_map_id_fk, attr_id_fk, testprotocol_fk)
				VALUES(new_device_tag_id_fk, new_hmi_tag_id_fk, target_var_map, new_attr_id_fk, new_testprotocol_fk)
				returning hmi_device_map_id_pk into new_hmi_device_id_fk;
				-- generic attributes
				INSERT INTO public."v_map_HMIAttrGen"
				(attr_gen_id_fk, hmi_device_map_id_fk, attr_val, attr_unit)
				select attr_gen_id_fk, new_hmi_device_id_fk, attr_val, attr_unit
				from public."v_map_HMIAttrGen" where hmi_device_map_id_fk = source_hmi_device.hmi_device_map_id_pk;
			end;
		end loop;
	end loop;
	--copy all device_tags without a mapping
	INSERT INTO public."dim_DeviceTags"
	(device_tag_name, device_tag_data_type, device_tag_parent, device_tag_comment, device_tag_ext_accessible, device_tag_ext_visible, device_tag_setpoint, device_tag_name_generic, device_id_fk, device_tag_creat_time, device_tag_updat_time, device_tag_unit, device_tag_resolution, device_tag_block, load_id_fk, deleted, "ignore", device_tag_ext_writable, device_tag_startvalue, device_tag_trace_value, digits, internal)
	select ddt1.device_tag_name, ddt1.device_tag_data_type, ddt1.device_tag_parent, ddt1.device_tag_comment, ddt1.device_tag_ext_accessible, ddt1.device_tag_ext_visible, ddt1.device_tag_setpoint, ddt1.device_tag_name_generic, target_device_id_fk, now(), now(), ddt1.device_tag_unit, ddt1.device_tag_resolution, ddt1.device_tag_block, ddt1.load_id_fk, ddt1.deleted, ddt1."ignore", ddt1.device_tag_ext_writable, ddt1.device_tag_startvalue, null, ddt1.digits, ddt1.internal
	from public."dim_DeviceTags" ddt1
	left join public."dim_DeviceTags" ddt2 on 
		ddt1.device_tag_name = ddt2.device_tag_name 
		and ddt1.device_tag_block = ddt2.device_tag_block
		and ddt2.device_id_fk = target_device_id_fk 
	where ddt1.device_id_fk = source_device_id_fk and ddt2.device_tag_id_pk is null;

end;
$function$
;

-- DROP FUNCTION public.copy_devices(int4, int4);

CREATE OR REPLACE FUNCTION public.copy_devices(source_order_id_fk integer, target_order_id_fk integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare source_device integer;
declare target_device integer;
begin
	for source_device in select device_id_pk from "dim_Devices" where order_id_fk = source_order_id_fk
	loop
		-- insert new device returning new device_id_pk
		insert
			into
			public."dim_Devices" (device_name,
			device_com,
			device_version,
			device_project_name,
			device_sps_name,
			device_sps_type,
			device_line,
			order_id_fk,
			device_driver_count,
			device_driver_start)
		select
			device_name,
			device_com,
			device_version,
			device_project_name,
			device_sps_name,
			device_sps_type,
			device_line,
			target_order_id_fk as order_id_fk,
			device_driver_count,
			device_driver_start
		from
			"dim_Devices" dd
		where
			device_id_pk = source_device 
		returning device_id_pk into target_device;
		-- copy device_tags
		perform copy_device_tags(source_device, target_device, source_order_id_fk, target_order_id_fk);
		-- copy mappings
	end loop;
end;
$function$
;

-- DROP FUNCTION public.copy_ec_values(int4, int4, text);

CREATE OR REPLACE FUNCTION public.copy_ec_values(source_order_nbr integer, target_order_nbr integer, name_filter text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
	update
	"dim_DeviceTags"
set
	device_tag_startvalue = ddt2.device_tag_startvalue
from
	"dim_DeviceTags" ddt
join "dim_Devices" dd on
	ddt.device_id_fk = dd.device_id_pk
join "dim_Orders" o on
	dd.order_id_fk = o.order_id_pk
join "dim_DeviceTags" ddt2 on
	ddt.device_tag_name = ddt2.device_tag_name
join "dim_Devices" dd2 on
	ddt2.device_id_fk = dd2.device_id_pk
join "dim_Orders" o2 on
	dd2.order_id_fk = o2.order_id_pk
where
	"dim_DeviceTags".device_tag_id_pk = ddt.device_tag_id_pk
	and o.order_nbr = target_order_nbr
	and o2.order_nbr = source_order_nbr
	and o.order_type = o2.order_type 
	and ddt.device_tag_name like name_filter
	and ddt.device_tag_name like '%.IC[%]'
	and ddt.device_tag_startvalue <> ddt2.device_tag_startvalue;
end;
$function$
;

-- DROP FUNCTION public."defined"(hstore, text);

CREATE OR REPLACE FUNCTION public.defined(hstore, text)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_defined$function$
;

-- DROP FUNCTION public."delete"(hstore, text);

CREATE OR REPLACE FUNCTION public.delete(hstore, text)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_delete$function$
;

-- DROP FUNCTION public."delete"(hstore, hstore);

CREATE OR REPLACE FUNCTION public.delete(hstore, hstore)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_delete_hstore$function$
;

-- DROP FUNCTION public."delete"(hstore, _text);

CREATE OR REPLACE FUNCTION public.delete(hstore, text[])
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_delete_array$function$
;

-- DROP FUNCTION public."each"(in hstore, out text, out text);

CREATE OR REPLACE FUNCTION public.each(hs hstore, OUT key text, OUT value text)
 RETURNS SETOF record
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_each$function$
;

-- DROP FUNCTION public.exist(hstore, text);

CREATE OR REPLACE FUNCTION public.exist(hstore, text)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_exists$function$
;

-- DROP FUNCTION public.exists_all(hstore, _text);

CREATE OR REPLACE FUNCTION public.exists_all(hstore, text[])
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_exists_all$function$
;

-- DROP FUNCTION public.exists_any(hstore, _text);

CREATE OR REPLACE FUNCTION public.exists_any(hstore, text[])
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_exists_any$function$
;

-- DROP FUNCTION public.fetchval(hstore, text);

CREATE OR REPLACE FUNCTION public.fetchval(hstore, text)
 RETURNS text
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_fetchval$function$
;

-- DROP FUNCTION public.ghstore_compress(internal);

CREATE OR REPLACE FUNCTION public.ghstore_compress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_compress$function$
;

-- DROP FUNCTION public.ghstore_consistent(internal, hstore, int2, oid, internal);

CREATE OR REPLACE FUNCTION public.ghstore_consistent(internal, hstore, smallint, oid, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_consistent$function$
;

-- DROP FUNCTION public.ghstore_decompress(internal);

CREATE OR REPLACE FUNCTION public.ghstore_decompress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_decompress$function$
;

-- DROP FUNCTION public.ghstore_in(cstring);

CREATE OR REPLACE FUNCTION public.ghstore_in(cstring)
 RETURNS ghstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_in$function$
;

-- DROP FUNCTION public.ghstore_out(ghstore);

CREATE OR REPLACE FUNCTION public.ghstore_out(ghstore)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_out$function$
;

-- DROP FUNCTION public.ghstore_penalty(internal, internal, internal);

CREATE OR REPLACE FUNCTION public.ghstore_penalty(internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_penalty$function$
;

-- DROP FUNCTION public.ghstore_picksplit(internal, internal);

CREATE OR REPLACE FUNCTION public.ghstore_picksplit(internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_picksplit$function$
;

-- DROP FUNCTION public.ghstore_same(ghstore, ghstore, internal);

CREATE OR REPLACE FUNCTION public.ghstore_same(ghstore, ghstore, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_same$function$
;

-- DROP FUNCTION public.ghstore_union(internal, internal);

CREATE OR REPLACE FUNCTION public.ghstore_union(internal, internal)
 RETURNS ghstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$ghstore_union$function$
;

-- DROP FUNCTION public.gin_consistent_hstore(internal, int2, hstore, int4, internal, internal);

CREATE OR REPLACE FUNCTION public.gin_consistent_hstore(internal, smallint, hstore, integer, internal, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$gin_consistent_hstore$function$
;

-- DROP FUNCTION public.gin_extract_hstore(hstore, internal);

CREATE OR REPLACE FUNCTION public.gin_extract_hstore(hstore, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$gin_extract_hstore$function$
;

-- DROP FUNCTION public.gin_extract_hstore_query(hstore, internal, int2, internal, internal);

CREATE OR REPLACE FUNCTION public.gin_extract_hstore_query(hstore, internal, smallint, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$gin_extract_hstore_query$function$
;

-- DROP FUNCTION public.hs_concat(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hs_concat(hstore, hstore)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_concat$function$
;

-- DROP FUNCTION public.hs_contained(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hs_contained(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_contained$function$
;

-- DROP FUNCTION public.hs_contains(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hs_contains(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_contains$function$
;

-- DROP FUNCTION public."hstore"(_text, _text);

CREATE OR REPLACE FUNCTION public.hstore(text[], text[])
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/hstore', $function$hstore_from_arrays$function$
;

-- DROP FUNCTION public."hstore"(text, text);

CREATE OR REPLACE FUNCTION public.hstore(text, text)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/hstore', $function$hstore_from_text$function$
;

-- DROP FUNCTION public."hstore"(_text);

CREATE OR REPLACE FUNCTION public.hstore(text[])
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_from_array$function$
;

-- DROP FUNCTION public."hstore"(record);

CREATE OR REPLACE FUNCTION public.hstore(record)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/hstore', $function$hstore_from_record$function$
;

-- DROP FUNCTION public.hstore_cmp(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_cmp(hstore, hstore)
 RETURNS integer
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_cmp$function$
;

-- DROP FUNCTION public.hstore_eq(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_eq(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_eq$function$
;

-- DROP FUNCTION public.hstore_ge(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_ge(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_ge$function$
;

-- DROP FUNCTION public.hstore_gt(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_gt(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_gt$function$
;

-- DROP FUNCTION public.hstore_hash(hstore);

CREATE OR REPLACE FUNCTION public.hstore_hash(hstore)
 RETURNS integer
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_hash$function$
;

-- DROP FUNCTION public.hstore_in(cstring);

CREATE OR REPLACE FUNCTION public.hstore_in(cstring)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_in$function$
;

-- DROP FUNCTION public.hstore_le(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_le(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_le$function$
;

-- DROP FUNCTION public.hstore_lt(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_lt(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_lt$function$
;

-- DROP FUNCTION public.hstore_ne(hstore, hstore);

CREATE OR REPLACE FUNCTION public.hstore_ne(hstore, hstore)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_ne$function$
;

-- DROP FUNCTION public.hstore_out(hstore);

CREATE OR REPLACE FUNCTION public.hstore_out(hstore)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_out$function$
;

-- DROP FUNCTION public.hstore_recv(internal);

CREATE OR REPLACE FUNCTION public.hstore_recv(internal)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_recv$function$
;

-- DROP FUNCTION public.hstore_send(hstore);

CREATE OR REPLACE FUNCTION public.hstore_send(hstore)
 RETURNS bytea
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_send$function$
;

-- DROP FUNCTION public.hstore_to_array(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_array(hstore)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_array$function$
;

-- DROP FUNCTION public.hstore_to_json(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_json(hstore)
 RETURNS json
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_json$function$
;

-- DROP FUNCTION public.hstore_to_json_loose(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_json_loose(hstore)
 RETURNS json
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_json_loose$function$
;

-- DROP FUNCTION public.hstore_to_jsonb(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_jsonb(hstore)
 RETURNS jsonb
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_jsonb$function$
;

-- DROP FUNCTION public.hstore_to_jsonb_loose(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_jsonb_loose(hstore)
 RETURNS jsonb
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_jsonb_loose$function$
;

-- DROP FUNCTION public.hstore_to_matrix(hstore);

CREATE OR REPLACE FUNCTION public.hstore_to_matrix(hstore)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_to_matrix$function$
;

-- DROP FUNCTION public.hstore_version_diag(hstore);

CREATE OR REPLACE FUNCTION public.hstore_version_diag(hstore)
 RETURNS integer
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_version_diag$function$
;

-- DROP FUNCTION public.isdefined(hstore, text);

CREATE OR REPLACE FUNCTION public.isdefined(hstore, text)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_defined$function$
;

-- DROP FUNCTION public.isexists(hstore, text);

CREATE OR REPLACE FUNCTION public.isexists(hstore, text)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_exists$function$
;

-- DROP FUNCTION public.populate_record(anyelement, hstore);

CREATE OR REPLACE FUNCTION public.populate_record(anyelement, hstore)
 RETURNS anyelement
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/hstore', $function$hstore_populate_record$function$
;

-- DROP FUNCTION public.skeys(hstore);

CREATE OR REPLACE FUNCTION public.skeys(hstore)
 RETURNS SETOF text
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_skeys$function$
;

-- DROP FUNCTION public.slice(hstore, _text);

CREATE OR REPLACE FUNCTION public.slice(hstore, text[])
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_slice_to_hstore$function$
;

-- DROP FUNCTION public.slice_array(hstore, _text);

CREATE OR REPLACE FUNCTION public.slice_array(hstore, text[])
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_slice_to_array$function$
;

-- DROP FUNCTION public.svals(hstore);

CREATE OR REPLACE FUNCTION public.svals(hstore)
 RETURNS SETOF text
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/hstore', $function$hstore_svals$function$
;

-- DROP FUNCTION public.tconvert(text, text);

CREATE OR REPLACE FUNCTION public.tconvert(text, text)
 RETURNS hstore
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/hstore', $function$hstore_from_text$function$
;

-- DROP FUNCTION public.trigger_set_timestamp();

CREATE OR REPLACE FUNCTION public.trigger_set_timestamp()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin 
	new.last_modified = NOW();
	return new;
end;
$function$
;

-- DROP FUNCTION public.uuid_generate_v1();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

-- DROP FUNCTION public.uuid_generate_v1mc();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

-- DROP FUNCTION public.uuid_generate_v3(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

-- DROP FUNCTION public.uuid_generate_v4();

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

-- DROP FUNCTION public.uuid_generate_v5(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

-- DROP FUNCTION public.uuid_nil();

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

-- DROP FUNCTION public.uuid_ns_dns();

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

-- DROP FUNCTION public.uuid_ns_oid();

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

-- DROP FUNCTION public.uuid_ns_url();

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

-- DROP FUNCTION public.uuid_ns_x500();

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;