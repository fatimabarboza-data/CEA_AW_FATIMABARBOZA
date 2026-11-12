-- Tabela fato de vendas
-- Grão: 1 linha por ITEM de pedido (produto dentro do pedido)
with itens as (
    select * from {{ ref('stg_erp__pedidos_itens') }}
)

, pedidos as (
    select * from {{ ref('stg_erp__pedidos') }}
)

, motivos as (
    select * from {{ ref('int_motivos_por_pedido') }}
)

select
    -- chaves
    i.pedido_item_id
    , i.pedido_id
    , i.produto_id
    , p.cliente_id
    , p.endereco_entrega_id                         as endereco_id
    , coalesce(p.cartao_id, 0)                      as cartao_id
    , md5(coalesce(m.motivos_venda, 'Sem motivo informado')) as motivo_venda_sk
    , p.data_pedido

    -- atributos do pedido
    , p.status_pedido

    -- métricas
    , i.quantidade
    , i.preco_unitario
    , i.desconto_percentual
    , i.preco_unitario * i.quantidade                              as valor_bruto
    , i.preco_unitario * i.quantidade * i.desconto_percentual      as valor_desconto
    , i.preco_unitario * i.quantidade * (1 - i.desconto_percentual) as valor_liquido
from itens i
inner join pedidos p
    on i.pedido_id = p.pedido_id
left join motivos m
    on i.pedido_id = m.pedido_id
