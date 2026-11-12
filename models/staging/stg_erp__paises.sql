with fonte as (
    select * from {{ source('adventure_works', 'person_countryregion') }}
)

-- Correção: o código da Namíbia ('NA') chegou nulo na ingestão
select
    coalesce(countryregioncode, case when name = 'Namibia' then 'NA' end) as pais_codigo
    , name                                          as nome_pais
from fonte
