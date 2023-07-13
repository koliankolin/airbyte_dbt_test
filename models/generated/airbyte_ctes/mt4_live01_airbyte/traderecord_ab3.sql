{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('traderecord_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'magic',
        'reason',
        'symbol',
        'symbol_name',
        'close_ts',
        'gw_volume',
        'margin_rate',
        'taxes',
        'storage',
        'login',
        'mode',
        'gw_close_price',
        'commission_agent',
        'close_price',
        'sl',
        'commission',
        'state',
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
        'sequence',
        'gw_open_price',
        'gw_order',
        'tm',
        'digits',
        'comment',
        'cmd',
        'tp',
        'ts_ms',
        'ts',
        'value_ts',
    ]) }} as _airbyte_traderecord_hashid,
    tmp.*
from {{ ref('traderecord_ab2') }} tmp
-- traderecord
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

