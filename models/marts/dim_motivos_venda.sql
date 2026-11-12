-- Uma linha por COMBINAÇÃO de motivos (ex.: "On Promotion, Price").
-- Assim cada pedido aponta para uma única linha e o faturamento não duplica.
-- As colunas tem_* permitem filtrar qualquer pedido que contenha aquele motivo.
with combinacoes as (
    select distinct motivos_venda
    from {{ ref('int_motivos_por_pedido') }}

    union

    select 'Sem motivo informado' as motivos_venda
)

select
    md5(motivos_venda)                              as motivo_venda_sk
    , motivos_venda
    , motivos_venda like '%Promotion%'              as tem_promocao
    , motivos_venda like '%Price%'                  as tem_preco
    , motivos_venda like '%Quality%'                as tem_qualidade
    , motivos_venda like '%Manufacturer%'           as tem_fabricante
    , motivos_venda like '%Review%'                 as tem_avaliacao
    , motivos_venda like '%Television%'             as tem_televisao
    , motivos_venda like '%Magazine%'               as tem_revista
    , motivos_venda like '%Demo Event%'             as tem_evento
    , motivos_venda like '%Sponsorship%'            as tem_patrocinio
    , motivos_venda like '%Other%'                  as tem_outros
from combinacoes
