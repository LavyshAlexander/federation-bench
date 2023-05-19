DO
$do$
DECLARE
   _timing1  timestamptz;
   _start_ts timestamptz;
   _end_ts   timestamptz;
   _overhead numeric;     -- in ms
   _timing   numeric;     -- in ms
   dummy     text;
BEGIN
   _timing1  := clock_timestamp();
   _start_ts := clock_timestamp();
   _end_ts   := clock_timestamp();
   -- take minimum duration as conservative estimate
   _overhead := 1000 * extract(epoch FROM LEAST(_start_ts - _timing1
                                              , _end_ts   - _start_ts));

   _start_ts := clock_timestamp();

   select
       id,
       "name",
       address,
       token_id,
       symbol,
       decimals,
       standard,
       thumbnail_uri
   into dummy
   from public."token"
   limit 10000
   offset 900000;

   _end_ts   := clock_timestamp();

--   RAISE NOTICE 'Timing overhead in ms = %', _overhead;
   RAISE NOTICE 'Execution time in ms = %' , 1000 * (extract(epoch FROM _end_ts - _start_ts)) - _overhead;
END
$do$;

-- explain (ANALYZE, COSTS OFF, TIMING OFF) select
--     id,
--     "name",
--     address,
--     token_id,7
--     symbol,
--     decimals,
--     standard,
--     thumbnail_uri
-- from public."token"
-- limit 10000
-- offset 900000;
