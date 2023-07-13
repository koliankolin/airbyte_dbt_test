{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mt4_live01_airbyte",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ticks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'symbol',
        'bank',
        'symbol_name',
        'feeder',
        'ask',
        'tm',
        'bid',
        'idx',
    ]) }} as _airbyte_ticks_hashid,
    tmp.*
from {{ ref('ticks_ab2') }} tmp
-- ticks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

