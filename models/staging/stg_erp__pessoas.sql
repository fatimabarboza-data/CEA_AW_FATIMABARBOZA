with fonte as (
    select * from {{ source('adventure_works', 'person_person') }}
)

select
    cast(businessentityid as bigint)                as pessoa_id
    , concat_ws(' ', firstname, middlename, lastname) as nome_pessoa
from fonte
