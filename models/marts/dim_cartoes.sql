-- Pedidos sem cartão recebem o id 0 ("Sem cartão") para não sumirem dos filtros
with cartoes as (
    select * from {{ ref('stg_erp__cartoes') }}
)

select
    cartao_id
    , tipo_cartao
from cartoes

union all

select
    cast(0 as bigint)                               as cartao_id
    , 'Sem cartão'                                  as tipo_cartao
