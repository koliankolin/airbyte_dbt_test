{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "mt4_live01_airbyte",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('traderecord_ab3') }}
select
    magic,
    reason,
    symbol,
    symbol_name,
    close_ts,
    gw_volume,
    margin_rate,
    taxes,
    storage,
    login,
    mode,
    gw_close_price,
    commission_agent,
    close_price,
    sl,
    commission,
    state,
    open_price,
    profit,
    conv_rates_0,
    conv_rates_1,
    {{ adapter.quote('order') }},
    api_data_1,
    open_ts,
    api_data_0,
    api_data_3,
    api_data_2,
    internal_id,
    volume,
    expiration_ts,
    sequence,
    gw_open_price,
    gw_order,
    tm,
    digits,
    comment,
    cmd,
    tp,
    ts_ms,
    ts,
    value_ts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_traderecord_hashid
from {{ ref('traderecord_ab3') }}
-- traderecord from {{ source('mt4_live01_airbyte', '_airbyte_raw_traderecord') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

