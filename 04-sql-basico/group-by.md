# GROUP BY e Funções de Agregação

## 1. O que é GROUP BY?

O `GROUP BY` agrupa linhas que têm o mesmo valor em uma ou mais colunas.

Com isso, é possível calcular totais, médias, contagens etc. por grupo.

Estrutura:

```sql
SELECT coluna_agrupamento, FUNÇÃO(coluna)
FROM tabela
WHERE condição
GROUP BY coluna_agrupamento
HAVING condição_do_grupo
ORDER BY coluna;
```

---

## 2. Funções de agregação

Funções que operam sobre um conjunto de linhas e retornam um único valor por grupo.

| Função | O que calcula |
|---|---|
| `COUNT(*)` | Total de linhas |
| `COUNT(coluna)` | Total de valores não-nulos |
| `SUM(coluna)` | Soma dos valores |
| `AVG(coluna)` | Média dos valores |
| `MAX(coluna)` | Maior valor |
| `MIN(coluna)` | Menor valor |

---

## 3. Exemplos básicos

### Contagem total

```sql
SELECT COUNT(*) AS total FROM clientes;
```

### Contagem por grupo

```sql
-- Quantos clientes por cidade
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade
ORDER BY total DESC;
```

| cidade    | total |
|-----------|-------|
| Goiânia   | 2     |
| Brasília  | 1     |
| São Paulo | 1     |
| Cuiabá    | 1     |

### Soma por grupo

```sql
-- Total de vendas por cliente
SELECT c.nome, SUM(p.total) AS total_gasto
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC;
```

### Média por grupo

```sql
-- Preço médio por categoria
SELECT cat.nome AS categoria, ROUND(AVG(p.preco), 2) AS preco_medio
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome;
```

---

## 4. HAVING — filtrando grupos

`WHERE` filtra linhas **antes** de agrupar.  
`HAVING` filtra grupos **depois** de agrupar.

```sql
-- Cidades com mais de 1 cliente
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade
HAVING COUNT(*) > 1;
```

```sql
-- Clientes com mais de R$500 em compras
SELECT c.nome, SUM(p.total) AS total_gasto
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.id, c.nome
HAVING SUM(p.total) > 500
ORDER BY total_gasto DESC;
```

> Regra: use `WHERE` para filtrar linhas individuais; use `HAVING` para filtrar resultados de agregação.

---

## 5. WHERE vs HAVING

```sql
-- WHERE: filtra antes de agrupar
-- Conta pedidos de 2024, por cliente
SELECT c.nome, COUNT(*) AS pedidos_2024
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE EXTRACT(YEAR FROM p.data_pedido) = 2024   -- filtra LINHAS
GROUP BY c.id, c.nome;

-- HAVING: filtra depois de agrupar
-- Clientes com mais de 1 pedido em 2024
SELECT c.nome, COUNT(*) AS pedidos_2024
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE EXTRACT(YEAR FROM p.data_pedido) = 2024
GROUP BY c.id, c.nome
HAVING COUNT(*) > 1;                             -- filtra GRUPOS
```

---

## 6. Agrupamento por múltiplas colunas

```sql
-- Total de pedidos por cliente e por mês
SELECT
    c.nome,
    EXTRACT(MONTH FROM p.data_pedido) AS mes,
    COUNT(*) AS pedidos,
    SUM(p.total) AS total
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.id, c.nome, EXTRACT(MONTH FROM p.data_pedido)
ORDER BY c.nome, mes;
```

---

## 7. Exemplos analíticos com o banco de loja

```sql
-- Receita total e ticket médio
SELECT
    COUNT(*) AS total_pedidos,
    SUM(total) AS receita_total,
    ROUND(AVG(total), 2) AS ticket_medio,
    MAX(total) AS maior_pedido,
    MIN(total) AS menor_pedido
FROM pedidos;

-- Top 3 produtos mais vendidos (por quantidade)
SELECT pr.nome, SUM(ip.quantidade) AS total_vendido
FROM itens_pedido ip
INNER JOIN produtos pr ON ip.produto_id = pr.id
GROUP BY pr.id, pr.nome
ORDER BY total_vendido DESC
LIMIT 3;

-- Receita por categoria
SELECT cat.nome AS categoria, SUM(ip.quantidade * ip.preco_unit) AS receita
FROM itens_pedido ip
INNER JOIN produtos pr  ON ip.produto_id = pr.id
INNER JOIN categorias cat ON pr.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY receita DESC;

-- Clientes sem compras
SELECT c.nome, COUNT(p.id) AS qtd_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
HAVING COUNT(p.id) = 0;
```

---

## 8. Regra importante do GROUP BY

Toda coluna no `SELECT` que **não** está dentro de uma função de agregação **deve** aparecer no `GROUP BY`.

```sql
-- CORRETO
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade;

-- ERRADO — nome não está no GROUP BY nem em função de agregação
SELECT cidade, nome, COUNT(*) AS total
FROM clientes
GROUP BY cidade;
```

---

## 9. O que memorizar

- `GROUP BY` agrupa linhas com o mesmo valor.
- `COUNT`, `SUM`, `AVG`, `MAX`, `MIN` são funções de agregação.
- `WHERE` filtra antes de agrupar; `HAVING` filtra depois.
- Toda coluna no SELECT fora de função de agregação deve estar no GROUP BY.
- `ROUND(AVG(coluna), 2)` arredonda a média para 2 casas decimais.
