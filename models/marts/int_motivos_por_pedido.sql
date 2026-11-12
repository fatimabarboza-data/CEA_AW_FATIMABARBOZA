-- Camada intermediária: fica salva no schema "intermediate" (ver config abaixo).
-- Um pedido pode ter mais de um motivo de venda.
-- Para NÃO duplicar o faturamento na tabela fato, junto todos os motivos
-- de cada pedido em uma única linha (ex.: "On Promotion, Price").
{{ config(materialized='view', schema='intermediate') }}

with pedidos_motivos as (
    select * from {{ ref('stg_erp__pedidos_motivos') }}
)

, motivos as (
    select * from {{ ref('stg_erp__motivos') }}
)

select
    pm.pedido_id
    , concat_ws(', ', array_sort(collect_set(m.nome_motivo)))  as motivos_venda
from pedidos_motivos pm
inner join motivos m
    on pm.motivo_id = m.motivo_id
group by pm.pedido_id
