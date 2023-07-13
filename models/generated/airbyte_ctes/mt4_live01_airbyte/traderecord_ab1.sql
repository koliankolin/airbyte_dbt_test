{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('mt4_live01_airbyte', '_airbyte_raw_traderecord') }}
select
    {{ json_extract_scalar('_airbyte_data', ['magic'], ['magic']) }} as magic,
    {{ json_extract_scalar('_airbyte_data', ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar('_airbyte_data', ['symbol'], ['symbol']) }} as symbol,
    {{ json_extract_scalar('_airbyte_data', ['symbol_name'], ['symbol_name']) }} as symbol_name,
    {{ json_extract_scalar('_airbyte_data', ['close_ts'], ['close_ts']) }} as close_ts,
    {{ json_extract_scalar('_airbyte_data', ['gw_volume'], ['gw_volume']) }} as gw_volume,
    {{ json_extract_scalar('_airbyte_data', ['margin_rate'], ['margin_rate']) }} as margin_rate,
    {{ json_extract_scalar('_airbyte_data', ['taxes'], ['taxes']) }} as taxes,
    {{ json_extract_scalar('_airbyte_data', ['storage'], ['storage']) }} as storage,
    {{ json_extract_scalar('_airbyte_data', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('_airbyte_data', ['mode'], ['mode']) }} as mode,
    {{ json_extract_scalar('_airbyte_data', ['gw_close_price'], ['gw_close_price']) }} as gw_close_price,
    {{ json_extract_scalar('_airbyte_data', ['commission_agent'], ['commission_agent']) }} as commission_agent,
    {{ json_extract_scalar('_airbyte_data', ['close_price'], ['close_price']) }} as close_price,
    {{ json_extract_scalar('_airbyte_data', ['sl'], ['sl']) }} as sl,
    {{ json_extract_scalar('_airbyte_data', ['commission'], ['commission']) }} as commission,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['open_price'], ['open_price']) }} as open_price,
    {{ json_extract_scalar('_airbyte_data', ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar('_airbyte_data', ['conv_rates_0'], ['conv_rates_0']) }} as conv_rates_0,
    {{ json_extract_scalar('_airbyte_data', ['conv_rates_1'], ['conv_rates_1']) }} as conv_rates_1,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['api_data_1'], ['api_data_1']) }} as api_data_1,
    {{ json_extract_scalar('_airbyte_data', ['open_ts'], ['open_ts']) }} as open_ts,
    {{ json_extract_scalar('_airbyte_data', ['api_data_0'], ['api_data_0']) }} as api_data_0,
    {{ json_extract_scalar('_airbyte_data', ['api_data_3'], ['api_data_3']) }} as api_data_3,
    {{ json_extract_scalar('_airbyte_data', ['api_data_2'], ['api_data_2']) }} as api_data_2,
    {{ json_extract_scalar('_airbyte_data', ['internal_id'], ['internal_id']) }} as internal_id,
    {{ json_extract_scalar('_airbyte_data', ['volume'], ['volume']) }} as volume,
    {{ json_extract_scalar('_airbyte_data', ['expiration_ts'], ['expiration_ts']) }} as expiration_ts,
    {{ json_extract_scalar('_airbyte_data', ['sequence'], ['sequence']) }} as sequence,
    {{ json_extract_scalar('_airbyte_data', ['gw_open_price'], ['gw_open_price']) }} as gw_open_price,
    {{ json_extract_scalar('_airbyte_data', ['gw_order'], ['gw_order']) }} as gw_order,
    {{ json_extract_scalar('_airbyte_data', ['tm'], ['tm']) }} as tm,
    {{ json_extract_scalar('_airbyte_data', ['digits'], ['digits']) }} as digits,
    {{ json_extract_scalar('_airbyte_data', ['comment'], ['comment']) }} as comment,
    {{ json_extract_scalar('_airbyte_data', ['cmd'], ['cmd']) }} as cmd,
    {{ json_extract_scalar('_airbyte_data', ['tp'], ['tp']) }} as tp,
    {{ json_extract_scalar('_airbyte_data', ['ts_ms'], ['ts_ms']) }} as ts_ms,
    {{ json_extract_scalar('_airbyte_data', ['ts'], ['ts']) }} as ts,
    {{ json_extract_scalar('_airbyte_data', ['value_ts'], ['value_ts']) }} as value_ts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('mt4_live01_airbyte', '_airbyte_raw_traderecord') }} as table_alias
-- traderecord
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

