-- Join of two tables in one db

select
	-- token
	token.id,
	token."name",
	token.address,
	token.token_id,
	token.symbol,
	token.decimals,
	token.standard,
	-- token_metadata
	token_metadata.id,
	token_metadata.token_id,
	token_metadata.network,
	token_metadata.contract,
	token_metadata.link,
	token_metadata.metadata,
	token_metadata.retry_count,
	token_metadata.status,
	token_metadata.image_processed,
	token_metadata.error
from public."token"
inner join public."token_metadata"
	on token.token_id = token_metadata.token_id
