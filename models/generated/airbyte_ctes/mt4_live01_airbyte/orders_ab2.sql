{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_ab1') }}
select
    cast(magic as {{ dbt_utils.type_bigint() }}) as magic,
    cast(reason as {{ dbt_utils.type_bigint() }}) as reason,
    cast(symbol64 as {{ dbt_utils.type_bigint() }}) as symbol64,
    cast(symbol_name as {{ dbt_utils.type_string() }}) as symbol_name,
    cast(reconciliation_status as {{ dbt_utils.type_bigint() }}) as reconciliation_status,
    cast(close_ts as {{ dbt_utils.type_bigint() }}) as close_ts,
    cast(gw_volume as {{ dbt_utils.type_bigint() }}) as gw_volume,
    cast(margin_rate as {{ dbt_utils.type_float() }}) as margin_rate,
    cast(taxes as {{ dbt_utils.type_float() }}) as taxes,
    cast(open_volume as {{ dbt_utils.type_bigint() }}) as open_volume,
    cast(storage as {{ dbt_utils.type_float() }}) as storage,
    cast(login as {{ dbt_utils.type_bigint() }}) as login,
    cast(mode as {{ dbt_utils.type_bigint() }}) as mode,
    cast(book_type_open as {{ dbt_utils.type_bigint() }}) as book_type_open,
    cast(gw_close_price as {{ dbt_utils.type_bigint() }}) as gw_close_price,
    cast(commission_agent as {{ dbt_utils.type_float() }}) as commission_agent,
    cast(std_lots as {{ dbt_utils.type_float() }}) as std_lots,
    cast(close_price as {{ dbt_utils.type_float() }}) as close_price,
    cast(sl as {{ dbt_utils.type_float() }}) as sl,
    cast(commission as {{ dbt_utils.type_float() }}) as commission,
    cast(state as {{ dbt_utils.type_bigint() }}) as state,
    cast(book_type_close as {{ dbt_utils.type_bigint() }}) as book_type_close,
    cast(open_price as {{ dbt_utils.type_float() }}) as open_price,
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast(conv_rates_0 as {{ dbt_utils.type_float() }}) as conv_rates_0,
    cast(conv_rates_1 as {{ dbt_utils.type_float() }}) as conv_rates_1,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('order') }},
    cast(api_data_1 as {{ dbt_utils.type_bigint() }}) as api_data_1,
    cast(open_ts as {{ dbt_utils.type_bigint() }}) as open_ts,
    cast(api_data_0 as {{ dbt_utils.type_bigint() }}) as api_data_0,
    cast(api_data_3 as {{ dbt_utils.type_bigint() }}) as api_data_3,
    cast(api_data_2 as {{ dbt_utils.type_bigint() }}) as api_data_2,
    cast(internal_id as {{ dbt_utils.type_bigint() }}) as internal_id,
    cast(volume as {{ dbt_utils.type_bigint() }}) as volume,
    cast(expiration_ts as {{ dbt_utils.type_bigint() }}) as expiration_ts,
    cast(gw_open_price as {{ dbt_utils.type_bigint() }}) as gw_open_price,
    cast(gw_order as {{ dbt_utils.type_bigint() }}) as gw_order,
    cast(digits as {{ dbt_utils.type_bigint() }}) as digits,
    cast(comment as {{ dbt_utils.type_string() }}) as comment,
    cast(cmd as {{ dbt_utils.type_bigint() }}) as cmd,
    cast(tp as {{ dbt_utils.type_float() }}) as tp,
    cast(value_ts as {{ dbt_utils.type_bigint() }}) as value_ts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_ab1') }}
-- orders
where 1 = 1

