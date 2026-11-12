with fonte as (
    select * from {{ source('adventure_works', 'sales_salesreason') }}
)

select
    cast(salesreasonid as bigint)                   as motivo_id
    , name                                          as nome_motivo
    , reasontype                                    as tipo_motivo
from fonte
