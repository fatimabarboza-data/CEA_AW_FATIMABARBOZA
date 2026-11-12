-- Cabeçalho dos pedidos: 1 linha por pedido
with fonte as (
    select * from {{ source('adventure_works', 'sales_salesorderheader') }}
)

select
    cast(salesorderid as bigint)                    as pedido_id
    , cast(customerid as bigint)                    as cliente_id
    , cast(shiptoaddressid as bigint)               as endereco_entrega_id
    , cast(creditcardid as bigint)                  as cartao_id
    , to_date(substr(orderdate, 1, 10))             as data_pedido
    , cast(status as int)                           as status_codigo
    , case cast(status as int)
        when 1 then 'Em processamento'
        when 2 then 'Aprovado'
        when 3 then 'Em espera'
        when 4 then 'Rejeitado'
        when 5 then 'Enviado'
        when 6 then 'Cancelado'
        else 'Não informado'
      end                                           as status_pedido
from fonte
