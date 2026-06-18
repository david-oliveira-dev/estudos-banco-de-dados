# Funções de Janela (Window Functions)

Funções de janela fazem cálculos **sobre um conjunto de linhas relacionadas à
linha atual** — sem agrupar tudo em uma só. A diferença para o `GROUP BY` é
importante:

- `GROUP BY` **reduz** as linhas (uma por grupo);
- window function **mantém** todas as linhas e ainda traz o cálculo do grupo.

A palavra-chave é `OVER (...)`.

> Exemplos no banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.
> Funcionam em SQLite (3.25+), PostgreSQL e MySQL (8+).

---

## 1. OVER () — agregação sem perder as linhas

```sql
-- Cada produto ao lado do preço médio geral (todas as linhas continuam aparecendo)
SELECT
    nome,
    preco,
    ROUND(AVG(preco) OVER (), 2) AS preco_medio_geral
FROM produtos;
```

Com `GROUP BY` eu teria só uma linha; com `OVER ()` mantenho todos os produtos e
ainda mostro a média ao lado.

---

## 2. PARTITION BY — calcular por grupo

`PARTITION BY` divide as linhas em grupos (como o `GROUP BY`), mas sem colapsá-las.

```sql
-- Preço médio dentro de cada categoria, ao lado de cada produto
SELECT
    cat.nome AS categoria,
    pr.nome  AS produto,
    pr.preco,
    ROUND(AVG(pr.preco) OVER (PARTITION BY pr.categoria_id), 2) AS media_categoria
FROM produtos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.id
ORDER BY categoria, pr.preco DESC;
```

---

## 3. Ranqueamento: ROW_NUMBER, RANK, DENSE_RANK

Numeram as linhas dentro de cada partição, segundo uma ordem.

```sql
-- Posição de cada produto por preço, dentro da categoria
SELECT
    cat.nome AS categoria,
    pr.nome  AS produto,
    pr.preco,
    ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS posicao
FROM produtos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.id
ORDER BY categoria, posicao;
```

Diferença entre eles quando há empate:
- `ROW_NUMBER` → 1, 2, 3, 4 (sempre único);
- `RANK` → 1, 2, 2, 4 (pula após empate);
- `DENSE_RANK` → 1, 2, 2, 3 (não pula).

---

## 4. Total acumulado (running total)

Somar progressivamente seguindo uma ordem — clássico em relatórios financeiros.

```sql
-- Receita acumulada dos pedidos ao longo do tempo
SELECT
    id          AS pedido,
    data_pedido,
    total,
    SUM(total) OVER (ORDER BY data_pedido, id) AS receita_acumulada
FROM pedidos;
```

---

## 5. Comparar com a linha anterior: LAG e LEAD

`LAG` pega o valor da linha **anterior**; `LEAD`, da **próxima**.

```sql
-- Variação do total de um pedido para o seguinte
SELECT
    id AS pedido,
    total,
    LAG(total) OVER (ORDER BY data_pedido, id) AS total_anterior,
    total - LAG(total) OVER (ORDER BY data_pedido, id) AS variacao
FROM pedidos;
```

---

## Resumo

| Função | O que faz |
|--------|-----------|
| `AVG/SUM ... OVER ()` | agrega mantendo todas as linhas |
| `PARTITION BY` | calcula por grupo, sem colapsar |
| `ROW_NUMBER/RANK/DENSE_RANK` | ranqueia dentro do grupo |
| `SUM(...) OVER (ORDER BY ...)` | total acumulado |
| `LAG/LEAD` | comparar com linha anterior/seguinte |

Window functions são uma das ferramentas mais valiosas para **análise de dados** —
exatamente o caminho que estou trilhando.

**Voltar ao índice do módulo:** [README.md](README.md)
