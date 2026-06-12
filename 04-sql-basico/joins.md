# JOINs — Combinando Tabelas

## 1. Por que usar JOIN?

Em um banco normalizado, as informações ficam distribuídas em tabelas separadas.

Para montar uma resposta completa, é necessário combinar essas tabelas.

Exemplo: para listar os pedidos **com os nomes dos clientes**, precisamos combinar `pedidos` e `clientes`.

O `JOIN` é o mecanismo que faz essa combinação.

---

## 2. Visualizando os dados de exemplo

Usaremos o banco de loja (`scripts/criacao-tabelas-exemplo.sql`).

**clientes:**

| id | nome        | cidade   |
|----|-------------|----------|
| 1  | Ana Lima    | Goiânia  |
| 2  | Bruno Costa | Brasília |
| 3  | Carla Souza | São Paulo|
| 4  | Diego Mendes| Goiânia  |
| 5  | Eva Rocha   | Cuiabá   |

**pedidos:**

| id | cliente_id | total   |
|----|-----------|---------|
| 1  | 1         | 3589.90 |
| 2  | 2         |  149.90 |
| 3  | 1         |  299.90 |
| 4  | 3         | 1289.90 |
| 5  | 4         |   89.90 |

> Eva Rocha (id=5) não tem pedidos. Os clientes Ana e Diego têm pedidos, mas nenhum produto do cliente 5.

---

## 3. INNER JOIN

Retorna apenas as linhas que têm correspondência **nos dois lados**.

```sql
SELECT c.nome, p.id AS pedido, p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;
```

| nome        | pedido | total   |
|-------------|--------|---------|
| Ana Lima    | 1      | 3589.90 |
| Bruno Costa | 2      |  149.90 |
| Ana Lima    | 3      |  299.90 |
| Carla Souza | 4      | 1289.90 |
| Diego Mendes| 5      |   89.90 |

Eva Rocha não aparece — ela não tem pedidos.

```
clientes ∩ pedidos = apenas quem tem pedido
```

---

## 4. LEFT JOIN (LEFT OUTER JOIN)

Retorna **todas as linhas da tabela da esquerda**, mais as correspondências da direita.

Onde não há correspondência, os campos da direita ficam NULL.

```sql
SELECT c.nome, p.id AS pedido, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;
```

| nome         | pedido | total   |
|--------------|--------|---------|
| Ana Lima     | 1      | 3589.90 |
| Ana Lima     | 3      |  299.90 |
| Bruno Costa  | 2      |  149.90 |
| Carla Souza  | 4      | 1289.90 |
| Diego Mendes | 5      |   89.90 |
| Eva Rocha    | NULL   | NULL    |

Eva Rocha aparece com NULL — está na esquerda mas sem correspondência na direita.

**Uso mais comum:** encontrar registros "sem par".

```sql
-- Clientes que nunca fizeram pedido
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;
```

---

## 5. RIGHT JOIN (RIGHT OUTER JOIN)

Retorna **todas as linhas da tabela da direita**, mais as correspondências da esquerda.

É o espelho do LEFT JOIN.

```sql
SELECT c.nome, p.id AS pedido
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;
```

Na prática, é mais comum reescrever como LEFT JOIN invertendo as tabelas. O RIGHT JOIN é menos utilizado.

---

## 6. FULL JOIN (FULL OUTER JOIN)

Retorna **todas as linhas dos dois lados**, com NULL onde não há correspondência.

```sql
SELECT c.nome, p.id AS pedido
FROM clientes c
FULL JOIN pedidos p ON c.id = p.cliente_id;
```

Retorna tudo: clientes sem pedido e pedidos sem cliente.

> Suportado pelo PostgreSQL. No MySQL, é necessário simular com `UNION` de LEFT e RIGHT JOIN.

---

## 7. Diagrama visual

```
        LEFT JOIN            INNER JOIN           RIGHT JOIN

    ┌────────┐              ┌──┐                      ┌────────┐
    │ ██████ │              │██│                       │ ██████ │
    │ ████A██│◄── A ──►     │AB│     ◄── B ──►        │ ██B████│
    │ ██████ │              │██│                       │ ██████ │
    └────────┘              └──┘                      └────────┘

             FULL JOIN
    ┌───────────────────────┐
    │ ████████████████████  │
    │ ████  A   ∩   B  ████ │
    │ ████████████████████  │
    └───────────────────────┘
```

---

## 8. JOIN com múltiplas tabelas

É possível encadear vários JOINs para combinar mais de duas tabelas.

```sql
-- Pedidos com nome do cliente e itens com nome do produto
SELECT
    c.nome          AS cliente,
    p.id            AS pedido,
    pr.nome         AS produto,
    ip.quantidade,
    ip.preco_unit
FROM pedidos p
INNER JOIN clientes c   ON p.cliente_id  = c.id
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
INNER JOIN produtos pr  ON ip.produto_id = pr.id
ORDER BY p.id, pr.nome;
```

---

## 9. Aliases para deixar mais limpo

```sql
-- Sem alias — difícil de ler
SELECT clientes.nome, pedidos.total
FROM clientes INNER JOIN pedidos ON clientes.id = pedidos.cliente_id;

-- Com alias — mais limpo
SELECT c.nome, p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;
```

---

## 10. Exemplos práticos com o banco de loja

```sql
-- Pedidos com nome do cliente
SELECT c.nome, p.total, p.data_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.data_pedido;

-- Produtos com nome da categoria
SELECT p.nome AS produto, cat.nome AS categoria, p.preco
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
ORDER BY cat.nome, p.nome;

-- Clientes que nunca compraram
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- Total gasto por cliente
SELECT c.nome, COUNT(p.id) AS qtd_pedidos, SUM(p.total) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC;
```

---

## 11. O que memorizar

| JOIN | O que retorna |
|---|---|
| INNER JOIN | Só linhas com correspondência nos dois lados |
| LEFT JOIN | Todas as linhas da esquerda + correspondências |
| RIGHT JOIN | Todas as linhas da direita + correspondências |
| FULL JOIN | Todas as linhas dos dois lados |

- A condição do JOIN vai no `ON`, não no `WHERE`.
- Use aliases (`c`, `p`, `pr`) para deixar o código limpo.
- LEFT JOIN com `WHERE tabela_direita.id IS NULL` encontra registros sem par.
