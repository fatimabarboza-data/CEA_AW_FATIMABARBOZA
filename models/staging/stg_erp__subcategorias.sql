with fonte as (
    select * from {{ source('adventure_works', 'production_productsubcategory') }}
)

select
    cast(productsubcategoryid as bigint)            as subcategoria_id
    , cast(productcategoryid as bigint)             as categoria_id
    , name                                          as nome_subcategoria
from fonte
