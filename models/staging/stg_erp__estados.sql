with fonte as (
    select * from {{ source('adventure_works', 'person_stateprovince') }}
)

select
    cast(stateprovinceid as bigint)                 as estado_id
    , name                                          as nome_estado
    , trim(stateprovincecode)                       as sigla_estado
    , countryregioncode                             as pais_codigo
from fonte
