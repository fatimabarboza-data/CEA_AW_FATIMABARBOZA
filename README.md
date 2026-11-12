# Adventure Works — Certificação Analytics Engineer (Indicium)

Projeto da certificação em Analytics Engineering da Indicium AI Academy.
Construí um data warehouse para a área de vendas da Adventure Works, uma
fabricante de bicicletas, usando **Databricks** como data warehouse e **dbt** para
transformação, testes e documentação.

Venho de mais de 10 anos no mercado financeiro. Por isso, antes de modelar qualquer
coisa, a primeira validação que fiz foi a conciliação pedida pelo CEO: as vendas
brutas de 2011 precisam bater com a auditoria contábil (**$12.646.112,16**).

## Arquitetura

```
ERP (PostgreSQL) → Databricks (fea_academy.adventure_works) → dbt → Painel de BI
```

| Camada | O que faz | Materialização |
|---|---|---|
| `staging` | Uma view por tabela de origem: renomeia colunas para português, converte tipos e trata datas | view |
| `intermediate` | Regra intermediária: junta os motivos de venda de cada pedido (`int_motivos_por_pedido`, salvo no schema intermediate) | view |
| `marts` | Modelo dimensional (tabela fato + dimensões) consumido pelo BI | table |

## Modelo dimensional

**Tabela fato:** `fct_vendas`, com uma linha por item de pedido.

| Dimensão | Tabelas de origem |
|---|---|
| `dim_produtos` | product, productsubcategory, productcategory |
| `dim_clientes` | customer, person, store |
| `dim_localidades` | address, stateprovince, countryregion |
| `dim_cartoes` | creditcard |
| `dim_motivos_venda` | salesorderheadersalesreason, salesreason |
| `dim_datas` | gerada a partir das datas dos pedidos |

**Métricas da fato:** quantidade, preço unitário, desconto, valor bruto, valor do
desconto e valor líquido.

## Decisões de modelagem

- **Motivo de venda:** um pedido pode ter mais de um motivo (são 27.647 registros
  para 23.012 pedidos). Se eu ligasse direto na fato, o faturamento seria duplicado.
  Por isso juntei os motivos de cada pedido em uma única combinação
  (ex.: "On Promotion, Price") e criei colunas como `tem_promocao` para filtrar.
  Os pedidos sem motivo aparecem como "Sem motivo informado".
- **Localidade:** usei o **endereço de entrega** do pedido, que representa onde a
  venda chegou ao cliente.
- **Cliente:** clientes podem ser pessoas ou lojas. Quando não há pessoa associada,
  usei o nome da loja.
- **Cartão:** pedidos sem cartão recebem a linha "Sem cartão", para não sumirem dos filtros.
- **Valor líquido:** o dicionário de dados trazia `unitprice * orderqty - (1 - discount)`.
  Usei `unitprice * orderqty * (1 - discount)`, que aplica o desconto como percentual.

## Testes

- **Sources:** `unique` e `not_null` nas chaves primárias de todas as tabelas de origem.
- **Marts:** `unique` e `not_null` nas chaves primárias da fato e das dimensões,
  `relationships` entre a fato e cada dimensão, e `accepted_values` no status.
- **Teste de dados (pedido do CEO):** `tests/teste_vendas_brutas_2011.sql` garante
  que as vendas brutas de 2011 somam $12.646.112,16.

## Como rodar

```bash
dbt run                       # cria todos os modelos
dbt test --select source:*    # testa as fontes
dbt test                      # roda todos os testes
dbt docs generate             # gera a documentação
```
