# Subconsultas (Subqueries)

Uma **subconsulta** é uma consulta dentro de outra. Serve para responder perguntas
que precisam de um resultado intermediário — por exemplo: "quais produtos custam
acima da média?". Primeiro calculo a média, depois comparo cada produto com ela.

> Todos os exemplos usam o banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

---

## 1. Subconsulta escalar (devolve um único valor)

Pode aparecer onde um valor único é esperado, como no `WHERE`.

```sql
-- Produtos com preço acima da média geral
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos)
ORDER BY preco DESC;
```

A subconsulta `(SELECT AVG(preco) FROM produtos)` roda primeiro e devolve um número;
o `WHERE` então compara cada linha com esse número.

---

## 2. Subconsulta com IN (lista de valores)

Quando a subconsulta devolve **vários** valores, use `IN`.

```sql
-- Clientes que já fizeram pelo menos um pedido
SELECT nome
FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos);
```

E o oposto, com `NOT IN`:

```sql
-- Clientes que NUNCA fizeram um pedido
SELECT nome
FROM clientes
WHERE id NOT IN (SELECT cliente_id FROM pedidos);
```

> Cuidado com `NOT IN` quando a subconsulta pode retornar `NULL` — nesse caso o
> resultado pode vir vazio. Em produção, muitas vezes `NOT EXISTS` é mais seguro.

---

## 3. EXISTS e NOT EXISTS

`EXISTS` testa se a subconsulta retorna **alguma** linha. É muito eficiente porque
o banco para na primeira correspondência.

```sql
-- Clientes que têm pelo menos um pedido
SELECT c.nome
FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);
```

```sql
-- Produtos que nunca foram vendidos
SELECT pr.nome
FROM produtos pr
WHERE NOT EXISTS (
    SELECT 1 FROM itens_pedido ip WHERE ip.produto_id = pr.id
);
```

---

## 4. Subconsulta correlacionada

É uma subconsulta que **depende** da linha externa (repare no `c.id` usado lá
dentro). Ela roda uma vez para cada linha da consulta principal.

```sql
-- Para cada cliente, quantos pedidos ele tem
SELECT
    c.nome,
    (SELECT COUNT(*) FROM pedidos p WHERE p.cliente_id = c.id) AS qtd_pedidos
FROM clientes c
ORDER BY qtd_pedidos DESC;
```

---

## 5. Subconsulta no FROM (tabela derivada)

A subconsulta vira uma "tabela temporária" da qual eu consulto. Precisa de um
apelido (aqui, `t`).

```sql
-- Ticket médio por cliente, considerando só quem gastou mais de 200
SELECT t.nome, t.total_gasto
FROM (
    SELECT c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
) AS t
WHERE t.total_gasto > 200
ORDER BY t.total_gasto DESC;
```

> Quando a tabela derivada fica complexa, prefira uma **CTE** (`WITH`), que é mais
> legível — ver [ctes.md](ctes.md).

---

## Resumo

| Forma | Quando usar |
|-------|-------------|
| Escalar `(SELECT ...)` | comparar com um único valor (média, máximo) |
| `IN (SELECT ...)` | filtrar por uma lista de valores |
| `EXISTS (SELECT 1 ...)` | testar existência (eficiente) |
| Correlacionada | um cálculo por linha da consulta externa |
| No `FROM` | usar o resultado como tabela |

**Próximo:** [CTEs (WITH)](ctes.md) — uma forma mais limpa de escrever subconsultas.
