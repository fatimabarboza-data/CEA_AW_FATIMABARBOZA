with fonte as (
    select * from {{ source('adventure_works', 'person_address') }}
)

select
    cast(addressid as bigint)                       as endereco_id
    , cast(stateprovinceid as bigint)               as estado_id
    , city                                          as cidade
from fonte
