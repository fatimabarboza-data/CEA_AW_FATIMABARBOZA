-- Calendário gerado a partir da menor e da maior data de pedido
with limites as (
    select
        min(data_pedido) as data_inicial
        , max(data_pedido) as data_final
    from {{ ref('stg_erp__pedidos') }}
)

, datas as (
    select explode(sequence(data_inicial, data_final, interval 1 day)) as data
    from limites
)

select
    data
    , year(data)                                    as ano
    , quarter(data)                                 as trimestre
    , month(data)                                   as mes
    , case month(data)
        when 1 then 'Janeiro'   when 2 then 'Fevereiro' when 3 then 'Março'
        when 4 then 'Abril'     when 5 then 'Maio'      when 6 then 'Junho'
        when 7 then 'Julho'     when 8 then 'Agosto'    when 9 then 'Setembro'
        when 10 then 'Outubro'  when 11 then 'Novembro' when 12 then 'Dezembro'
      end                                           as nome_mes
    , date_format(data, 'yyyy-MM')                  as ano_mes
    , dayofmonth(data)                              as dia
from datas
