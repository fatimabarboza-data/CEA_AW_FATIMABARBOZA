-- Itens dos pedidos: 1 linha por produto dentro de um pedido
with fonte as (
    select * from {{ source('adventure_works', 'sales_salesorderdetail') }}
)

select
    cast(salesorderdetailid as bigint)              as pedido_item_id
    , cast(salesorderid as bigint)                  as pedido_id
    , cast(productid as bigint)                     as produto_id
    , cast(orderqty as int)                         as quantidade
    , cast(unitprice as decimal(18, 4))             as preco_unitario
    , cast(unitpricediscount as decimal(18, 4))     as desconto_percentual
from fonte
