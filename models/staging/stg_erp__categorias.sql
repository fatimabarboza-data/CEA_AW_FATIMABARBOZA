with fonte as (
    select * from {{ source('adventure_works', 'production_productcategory') }}
)

select
    cast(productcategoryid as bigint)               as categoria_id
    , name                                          as nome_categoria
from fonte
