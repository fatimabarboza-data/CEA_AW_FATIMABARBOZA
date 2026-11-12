-- Pedido do CEO (Carlos Silveira): garantir que as vendas brutas de 2011
-- batem com o valor da auditoria contábil: $12.646.112,16.
-- O teste FALHA se esta consulta retornar alguma linha.
with vendas_2011 as (
    select round(sum(valor_bruto), 2) as vendas_brutas
    from {{ ref('fct_vendas') }}
    where year(data_pedido) = 2011
)

select vendas_brutas
from vendas_2011
where vendas_brutas <> 12646112.16
