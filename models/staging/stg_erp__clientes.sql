with fonte as (
    select * from {{ source('adventure_works', 'sales_customer') }}
)

select
    cast(customerid as bigint)                      as cliente_id
    , cast(personid as bigint)                      as pessoa_id
    , cast(storeid as bigint)                       as loja_id
from fonte
