# Views (Visões)

Uma **view** é uma consulta salva com um nome. Depois de criada, você a usa como
se fosse uma tabela — mas ela não guarda dados próprios: roda a consulta por baixo
toda vez que é chamada.

Serve para **esconder complexidade** (uma consulta com vários JOINs vira um nome
simples) e **padronizar** o acesso aos dados.

> Exemplos no banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

---

## 1. Criando uma view

```sql
CREATE VIEW vw_pedidos_detalhados AS
SELECT
    p.id            AS pedido,
    c.nome          AS cliente,
    p.data_pedido,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;
```

Agora consulto como uma tabela qualquer:

```sql
SELECT * FROM vw_pedidos_detalhados
WHERE total > 200
ORDER BY total DESC;
```

Toda vez que os dados das tabelas mudam, a view reflete a mudança
automaticamente — porque ela é só a consulta guardada, não uma cópia.

---

## 2. View com agregação

Ótima para relatórios usados com frequência.

```sql
CREATE VIEW vw_resumo_clientes AS
SELECT
    c.id,
    c.nome,
    COUNT(p.id)              AS qtd_pedidos,
    COALESCE(SUM(p.total),0) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;
```

```sql
-- Os 3 clientes que mais gastaram
SELECT nome, total_gasto
FROM vw_resumo_clientes
ORDER BY total_gasto DESC
LIMIT 3;
```

---

## 3. Substituindo e removendo

```sql
-- Remover uma view
DROP VIEW IF EXISTS vw_resumo_clientes;
```

> No PostgreSQL e MySQL existe `CREATE OR REPLACE VIEW` para alterar sem dropar.
> No SQLite, faça `DROP VIEW` e crie de novo.

---

## 4. Vantagens e cuidados

**Vantagens**
- simplifica consultas repetidas e complexas;
- centraliza regras (todo mundo usa a mesma definição);
- pode restringir colunas/linhas expostas (segurança).

**Cuidados**
- uma view **não** acelera nada — ela roda a consulta por baixo toda vez;
- views empilhadas (view sobre view sobre view) podem ficar difíceis de depurar;
- nem toda view aceita `INSERT/UPDATE` (views com JOIN/agregação geralmente são
  só de leitura).

**Próximo:** [Índices e performance](indices-e-performance.md) — como deixar as consultas rápidas.
