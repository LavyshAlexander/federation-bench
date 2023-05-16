-- Table: public.token_metadata

-- DROP TABLE IF EXISTS public.token_metadata;

CREATE TABLE IF NOT EXISTS public.token_metadata
(
    id bigint NOT NULL,
    token_id numeric,
    network text COLLATE pg_catalog."default",
    contract text COLLATE pg_catalog."default",
    link text COLLATE pg_catalog."default",
    metadata json,
    retry_count smallint,
    status smallint,
    image_processed boolean NOT NULL,
    error text COLLATE pg_catalog."default",
    CONSTRAINT token_metadata_pkey PRIMARY KEY (id),
    CONSTRAINT token_metadata_token_id_network_contract_key UNIQUE (token_id, network, contract)
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.token_metadata
    OWNER to dipdup;
-- Index: token_metadata_idx

-- DROP INDEX IF EXISTS public.token_metadata_idx;

CREATE INDEX IF NOT EXISTS token_metadata_idx
    ON public.token_metadata USING btree
    (
		network COLLATE pg_catalog."default" ASC NULLS LAST,
	 	contract COLLATE pg_catalog."default" ASC NULLS LAST,
	 	token_id ASC NULLS LAST
	)
    TABLESPACE pg_default;
-- Index: token_metadata_network_status_idx

-- DROP INDEX IF EXISTS public.token_metadata_network_status_idx;

CREATE INDEX IF NOT EXISTS token_metadata_network_status_idx
    ON public.token_metadata USING btree
    (
		network COLLATE pg_catalog."default" ASC NULLS LAST,
	 	status ASC NULLS LAST
	)
    TABLESPACE pg_default;
-- Index: token_metadata_sort_idx

-- DROP INDEX IF EXISTS public.token_metadata_sort_idx;

--CREATE INDEX IF NOT EXISTS token_metadata_sort_idx
--    ON public.token_metadata USING btree
--    (
--		retry_count ASC NULLS LAST,
--		updated_at ASC NULLS LAST
--	)
--    TABLESPACE pg_default;
-- Index: token_metadata_update_id_idx

-- DROP INDEX IF EXISTS public.token_metadata_update_id_idx;

--CREATE INDEX IF NOT EXISTS token_metadata_update_id_idx
--    ON public.token_metadata USING btree
--    (update_id ASC NULLS LAST)
--    TABLESPACE pg_default;