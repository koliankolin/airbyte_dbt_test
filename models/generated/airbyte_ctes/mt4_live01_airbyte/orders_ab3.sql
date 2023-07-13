{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'magic',
        'reason',
        'symbol64',
        'symbol_name',
        'reconciliation_status',
        'close_ts',
        'gw_volume',
        'margin_rate',
        'taxes',
        'open_volume',
        'storage',
        'login',
        'mode',
        'book_type_open',
        'gw_close_price',
        'commission_agent',
        'std_lots',
        'close_price',
        'sl',
        'commission',
        'state',
        'book_type_close',
        'open_price',
        'profit',
        'conv_rates_0',
        'conv_rates_1',
        adapter.quote('order'),
        'api_data_1',
        'open_ts',
        'api_data_0',
        'api_data_3',
        'api_data_2',
        'internal_id',
        'volume',
        'expiration_ts',
        'gw_open_price',
        'gw_order',
        'digits',
        'comment',
        'cmd',
        'tp',
        'value_ts',
    ]) }} as _airbyte_orders_hashid,
    tmp.*
from {{ ref('orders_ab2') }} tmp
-- orders
where 1 = 1

