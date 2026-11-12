-- Ligação pedido x motivo de venda (um pedido pode ter vários motivos)
with fonte as (
    select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}
)

select
    cast(salesorderid as bigint)                    as pedido_id
    , cast(salesreasonid as bigint)                 as motivo_id
from fonte
