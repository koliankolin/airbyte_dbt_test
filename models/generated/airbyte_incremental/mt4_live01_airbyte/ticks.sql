{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "mt4_live01_airbyte",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticks_ab3') }}
select
    symbol,
    bank,
    symbol_name,
    feeder,
    ask,
    tm,
    bid,
    idx,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ticks_hashid
from {{ ref('ticks_ab3') }}
-- ticks from {{ source('mt4_live01_airbyte', '_airbyte_raw_ticks') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

