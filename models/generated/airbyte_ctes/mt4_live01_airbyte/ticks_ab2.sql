{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ticks_ab1') }}
select
    cast(symbol as {{ dbt_utils.type_bigint() }}) as symbol,
    cast(bank as {{ dbt_utils.type_string() }}) as bank,
    cast(symbol_name as {{ dbt_utils.type_string() }}) as symbol_name,
    cast(feeder as {{ dbt_utils.type_string() }}) as feeder,
    cast(ask as {{ dbt_utils.type_float() }}) as ask,
    cast({{ empty_string_to_null('tm') }} as {{ type_timestamp_without_timezone() }}) as tm,
    cast(bid as {{ dbt_utils.type_float() }}) as bid,
    cast(idx as {{ dbt_utils.type_bigint() }}) as idx,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ticks_ab1') }}
-- ticks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

