-- Generate token_metadata table from metadata scheme

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

INSERT INTO public.token_metadata
(id, token_id, network, contract, link, metadata, retry_count, status, image_processed, error)
select
	s,
	s,
	'mainnet',
	rand_format('KT1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
	'https://better-call.dev/mainnet/KT1TxqZ8QtKvLu3V3JH7Gx58n7Co8pgtpQU5/details',
	'{"name":"Hello ducky token"}',
	10,
	1,
	false,
	''
from generate_series(1, 1000000) as s;

--select count(*) from public."token_metadata";

--SELECT id, token_id, network, contract, link, metadata, retry_count, status, image_processed, error FROM public."token_metadata";

--DELETE FROM public."token_metadata" WHERE true;
