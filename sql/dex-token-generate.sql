-- Generate token table from dex scheme

CREATE OR REPLACE FUNCTION rand_format(str text, subset text)
RETURNS text
LANGUAGE sql
AS $function$
       select
         array_to_string(
           array_agg(
             replace(x, 'A', substring(subset from trunc(random()*length(subset) + 1)::int for 1))
           ),
         '')
       from (select regexp_split_to_table(str, '') as x) a
$function$
;


INSERT INTO public."token"
(id, "name", address, token_id, symbol, decimals, standard, thumbnail_uri)
SELECT
	s,
	rand_format('AAAA AAAAA', 'abcdefghijklmnopqrstuvwxyz'),
	rand_format('KT1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
	s,
	rand_format('AAAA', 'abcdefghijklmnopqrstuvwxyz'),
	trunc(1 + random() * 10),
	'fa12',
	'https://catava.dipdup.net/tz1VUq4YvMSuoLfZoBHNueFhYWwZ1aRiyo9m'
from generate_series(1, 1000000) as s;

--select count(*) from public."token";

--SELECT id, "name", address, token_id, symbol, decimals, standard, thumbnail_uri
--FROM public."token";

--DELETE FROM public."token"
--WHERE true;
