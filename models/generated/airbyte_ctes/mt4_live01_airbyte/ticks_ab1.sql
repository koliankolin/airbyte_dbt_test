{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('mt4_live01_airbyte', '_airbyte_raw_ticks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['symbol'], ['symbol']) }} as symbol,
    {{ json_extract_scalar('_airbyte_data', ['bank'], ['bank']) }} as bank,
    {{ json_extract_scalar('_airbyte_data', ['symbol_name'], ['symbol_name']) }} as symbol_name,
    {{ json_extract_scalar('_airbyte_data', ['feeder'], ['feeder']) }} as feeder,
    {{ json_extract_scalar('_airbyte_data', ['ask'], ['ask']) }} as ask,
    {{ json_extract_scalar('_airbyte_data', ['tm'], ['tm']) }} as tm,
    {{ json_extract_scalar('_airbyte_data', ['bid'], ['bid']) }} as bid,
    {{ json_extract_scalar('_airbyte_data', ['idx'], ['idx']) }} as idx,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('mt4_live01_airbyte', '_airbyte_raw_ticks') }} as table_alias
-- ticks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

