# CTEs — Common Table Expressions (WITH)

Uma **CTE** é uma consulta temporária com nome, definida com `WITH` antes do
`SELECT` principal. Serve para o mesmo que uma subconsulta no `FROM`, mas é muito
mais **legível** — especialmente quando há vários passos.

> Exemplos no banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

---

## 1. CTE simples

```sql
WITH gastos_por_cliente AS (
    SELECT c.id, c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
)
SELECT nome, total_gasto
FROM gastos_por_cliente
WHERE total_gasto > 200
ORDER BY total_gasto DESC;
```

Leia de cima para baixo: primeiro defino `gastos_por_cliente`, depois consulto
essa "tabela" como se fosse real. Compare com a tabela derivada em
[subconsultas.md](subconsultas.md) — mesmo resultado, bem mais claro.

---

## 2. Várias CTEs encadeadas

Separe a lógica em etapas. Uma CTE pode usar a anterior.

```sql
WITH receita_por_cliente AS (
    SELECT cliente_id, SUM(total) AS receita
    FROM pedidos
    GROUP BY cliente_id
),
media_geral AS (
    SELECT AVG(receita) AS receita_media
    FROM receita_por_cliente
)
SELECT c.nome, rc.receita
FROM receita_por_cliente rc
INNER JOIN clientes c ON c.id = rc.cliente_id
WHERE rc.receita > (SELECT receita_media FROM media_geral)
ORDER BY rc.receita DESC;
```

---

## 3. CTE recursiva

Resolve problemas hierárquicos (organogramas, categorias-pai/filho) ou gera
sequências. A estrutura tem duas partes unidas por `UNION ALL`:
o **caso base** e o **passo recursivo**.

```sql
-- Gera os números de 1 a 5 (exemplo didático de recursão)
WITH RECURSIVE contador(n) AS (
    SELECT 1                       -- caso base
    UNION ALL
    SELECT n + 1 FROM contador     -- passo recursivo
    WHERE n < 5                    -- condição de parada
)
SELECT n FROM contador;
```

> Sempre inclua uma **condição de parada** (`WHERE n < 5`), senão a recursão é
> infinita.

---

## 4. Quando usar CTE em vez de subconsulta

| Situação | Prefira |
|----------|---------|
| Lógica em vários passos | CTE (`WITH`) — mais legível |
| Reaproveitar o resultado no mesmo SELECT | CTE |
| Hierarquia / sequência | CTE **recursiva** |
| Comparação rápida com um valor | subconsulta escalar |

CTEs não deixam a consulta mais rápida por si só — o ganho é de **clareza** e
**organização**.

**Próximo:** [Views](views.md) — quando você quer guardar uma consulta para reusar sempre.
