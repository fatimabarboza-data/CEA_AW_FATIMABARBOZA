-- Localidade = endereço de entrega do pedido (cidade, estado e país)
with enderecos as (
    select * from {{ ref('stg_erp__enderecos') }}
)

, estados as (
    select * from {{ ref('stg_erp__estados') }}
)

, paises as (
    select * from {{ ref('stg_erp__paises') }}
)

select
    e.endereco_id
    , e.cidade
    , es.nome_estado                                as estado
    , es.sigla_estado
    , pa.nome_pais                                  as pais
    , pa.pais_codigo
from enderecos e
left join estados es
    on e.estado_id = es.estado_id
left join paises pa
    on es.pais_codigo = pa.pais_codigo
