{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "mt4_live01_airbyte",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='orders_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_ab3') }}
select
    magic,
    reason,
    symbol64,
    symbol_name,
    reconciliation_status,
    close_ts,
    gw_volume,
    margin_rate,
    taxes,
    open_volume,
    storage,
    login,
    mode,
    book_type_open,
    gw_close_price,
    commission_agent,
    std_lots,
    close_price,
    sl,
    commission,
    state,
    book_type_close,
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
    gw_open_price,
    gw_order,
    digits,
    comment,
    cmd,
    tp,
    value_ts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_orders_hashid
from {{ ref('orders_ab3') }}
-- orders from {{ source('mt4_live01_airbyte', '_airbyte_raw_orders') }}
where 1 = 1

