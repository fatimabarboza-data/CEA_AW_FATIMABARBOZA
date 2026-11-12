with fonte as (
    select * from {{ source('adventure_works', 'sales_store') }}
)

select
    cast(businessentityid as bigint)                as loja_id
    , name                                          as nome_loja
from fonte
