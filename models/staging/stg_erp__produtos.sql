with fonte as (
    select * from {{ source('adventure_works', 'production_product') }}
)

select
    cast(productid as bigint)                       as produto_id
    , name                                          as nome_produto
    , productnumber                                 as codigo_produto
    , color                                         as cor
    , cast(productsubcategoryid as bigint)          as subcategoria_id
from fonte
