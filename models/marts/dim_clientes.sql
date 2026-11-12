-- Cliente pode ser uma pessoa ou uma loja (revenda).
-- Quando não há pessoa associada, uso o nome da loja.
with clientes as (
    select * from {{ ref('stg_erp__clientes') }}
)

, pessoas as (
    select * from {{ ref('stg_erp__pessoas') }}
)

, lojas as (
    select * from {{ ref('stg_erp__lojas') }}
)

select
    c.cliente_id
    , coalesce(p.nome_pessoa, l.nome_loja, 'Não informado') as nome_cliente
    , case
        when c.pessoa_id is not null then 'Pessoa física'
        else 'Loja'
      end                                           as tipo_cliente
from clientes c
left join pessoas p
    on c.pessoa_id = p.pessoa_id
left join lojas l
    on c.loja_id = l.loja_id
