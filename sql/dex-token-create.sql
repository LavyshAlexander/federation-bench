-- Table: public.token

-- DROP TABLE IF EXISTS public.token;

CREATE TABLE IF NOT EXISTS public.token
(
    id bigint NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    address character varying(36) COLLATE pg_catalog."default" NOT NULL,
    token_id numeric NOT NULL,
    symbol character varying(16) COLLATE pg_catalog."default" NOT NULL,
    decimals integer NOT NULL,
    standard character varying(4) COLLATE pg_catalog."default" NOT NULL,
    thumbnail_uri text COLLATE pg_catalog."default",
    CONSTRAINT token_pkey PRIMARY KEY (id)
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.token
    OWNER to dipdup;

CREATE INDEX token_token_is_idx ON public."token" (token_id);

COMMENT ON TABLE public.token
    IS 'FA12/FA2 token contract traded on DEX';

COMMENT ON COLUMN public.token.standard
    IS 'FA12: fa12\nFA2: fa2';
