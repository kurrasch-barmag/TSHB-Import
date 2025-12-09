-- 01_create_schema.sql (fixed)
-- Schema creation for import target tables
SET search_path TO public;

----------------------------------------------------------------
-- 1) Varianten
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS varianten (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

----------------------------------------------------------------
-- 2) Texte (multilingual)
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS texte (
    id SERIAL PRIMARY KEY,
    text_en TEXT,
    text_de TEXT,
    text_fr TEXT,
    text_tr TEXT,
    text_chs TEXT
);

----------------------------------------------------------------
-- 3) Sollwertgruppen (wird von Tags referenziert!)
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sollwert_gruppe (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    current_variant_id INT REFERENCES varianten(id) ON DELETE SET NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----------------------------------------------------------------
-- 4) Sollwerte (wird von GVS referenziert)
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sollwerte (
    id SERIAL PRIMARY KEY,
    min_value REAL,
    max_value REAL,
    unit TEXT,
    "precision" INT,
    format TEXT,
    variant_id INT REFERENCES varianten(id) ON DELETE RESTRICT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----------------------------------------------------------------
-- 5) Tags (darf jetzt auf sollwert_gruppe referenzieren)
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tags (
    id SERIAL PRIMARY KEY,
    tag_name TEXT UNIQUE NOT NULL,       -- TagnameBit
    original_tag_name TEXT,
    message_bit INT,
    project_number TEXT,                 -- stays as TEXT
    tshb_no TEXT,                        -- TSHB Nummer aus staging_messages
    text_id INT REFERENCES texte(id) ON DELETE SET NULL,
    group_id INT REFERENCES sollwert_gruppe(id) ON DELETE SET NULL,
    tag_type TEXT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----------------------------------------------------------------
-- 6) Mapping: Gruppe ↔ Variante ↔ Sollwert
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS gruppen_varianten_sollwerte (
    group_id INT NOT NULL REFERENCES sollwert_gruppe(id) ON DELETE CASCADE,
    variant_id INT NOT NULL REFERENCES varianten(id) ON DELETE CASCADE,
    sollwert_id INT NOT NULL REFERENCES sollwerte(id) ON DELETE CASCADE,
    PRIMARY KEY (group_id, variant_id)
);

----------------------------------------------------------------
-- INDEXE
----------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_tags_tag_name ON tags(tag_name);
CREATE INDEX IF NOT EXISTS idx_tags_group_id ON tags(group_id);
CREATE INDEX IF NOT EXISTS idx_sollwerte_variant_id ON sollwerte(variant_id);
CREATE INDEX IF NOT EXISTS idx_sollwert_gruppe_current_variant ON sollwert_gruppe(current_variant_id);
