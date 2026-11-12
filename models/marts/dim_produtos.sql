with produtos as (
    select * from {{ ref('stg_erp__produtos') }}
)

, subcategorias as (
    select * from {{ ref('stg_erp__subcategorias') }}
)

, categorias as (
    select * from {{ ref('stg_erp__categorias') }}
)

select
    p.produto_id
    , p.nome_produto
    , p.codigo_produto
    , coalesce(p.cor, 'Sem cor')                    as cor
    , coalesce(s.nome_subcategoria, 'Sem subcategoria') as subcategoria
    , coalesce(c.nome_categoria, 'Sem categoria')   as categoria
from produtos p
left join subcategorias s
    on p.subcategoria_id = s.subcategoria_id
left join categorias c
    on s.categoria_id = c.categoria_id
