-- Sicheres Löschen aller Daten aus allen Tabellen

BEGIN;

-- Reihenfolge beachten, um Fremdschlüsselverletzungen zu vermeiden
TRUNCATE TABLE public.gruppen_varianten_sollwerte CASCADE;
TRUNCATE TABLE public.tag_mapping CASCADE;
TRUNCATE TABLE public.tags CASCADE;
TRUNCATE TABLE public.sollwerte CASCADE;
TRUNCATE TABLE public.sollwert_gruppe CASCADE;
TRUNCATE TABLE public.texte CASCADE;
TRUNCATE TABLE public.varianten CASCADE;
TRUNCATE TABLE public.projects CASCADE;

COMMIT;