with fonte as (
    select * from {{ source('adventure_works', 'sales_creditcard') }}
)

select
    cast(creditcardid as bigint)                    as cartao_id
    , cardtype                                      as tipo_cartao
from fonte
