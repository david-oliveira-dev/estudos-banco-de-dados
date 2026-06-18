# Índices e Performance

Um **índice** é uma estrutura auxiliar que o banco mantém para encontrar linhas
rapidamente — como o índice remissivo no fim de um livro: em vez de ler tudo, você
vai direto na página.

Sem índice, para achar `WHERE email = 'ana@email.com'` o banco percorre **todas**
as linhas (_full table scan_). Com índice na coluna `email`, ele vai quase direto.

> Exemplos no banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

---

## 1. Criando um índice

```sql
-- Acelera buscas e filtros por email
CREATE INDEX idx_clientes_email ON clientes(email);

-- Acelera os JOINs/filtros por cliente nos pedidos
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
```

Depois disso, consultas como esta ficam mais rápidas em tabelas grandes:

```sql
SELECT * FROM pedidos WHERE cliente_id = 1;
```

---

## 2. Índice composto (várias colunas)

Útil quando você filtra por mais de uma coluna juntas. A **ordem importa**: o
índice serve para filtros que começam pela primeira coluna.

```sql
CREATE INDEX idx_itens_pedido_produto ON itens_pedido(pedido_id, produto_id);
```

Esse índice ajuda filtros por `pedido_id` (sozinho) e por `pedido_id + produto_id`,
mas **não** ajuda um filtro só por `produto_id`.

---

## 3. Índice único

Garante que não haja valores repetidos (além de acelerar a busca).

```sql
CREATE UNIQUE INDEX idx_clientes_email_unico ON clientes(email);
```

> Chaves primárias (`PRIMARY KEY`) e colunas `UNIQUE` já criam um índice
> automaticamente — não precisa criar de novo.

---

## 4. Vendo o plano de execução

O comando `EXPLAIN` (no SQLite, `EXPLAIN QUERY PLAN`) mostra **como** o banco vai
executar a consulta — se vai usar índice ou varrer a tabela inteira.

```sql
EXPLAIN QUERY PLAN
SELECT * FROM pedidos WHERE cliente_id = 1;
```

- Saída com `SCAN pedidos` → varredura completa (lento em tabela grande).
- Saída com `SEARCH pedidos USING INDEX ...` → está usando o índice (bom!).

> No PostgreSQL use `EXPLAIN ANALYZE`; no MySQL, `EXPLAIN`.

---

## 5. Quando NÃO criar índice

Índice não é de graça: ele ocupa espaço e **deixa `INSERT/UPDATE/DELETE` mais
lentos** (o banco precisa atualizar o índice também). Evite índices:

- em tabelas muito pequenas (a varredura já é rápida);
- em colunas que quase nunca aparecem em `WHERE`/`JOIN`/`ORDER BY`;
- em excesso — só crie os que resolvem consultas reais e lentas.

---

## 6. Boas práticas de performance

- indexe as colunas usadas em `WHERE`, `JOIN` e `ORDER BY`;
- evite `SELECT *` — traga só as colunas necessárias;
- prefira `EXISTS` a `IN` em subconsultas grandes;
- meça antes de otimizar: use `EXPLAIN` para confirmar o gargalo;
- cuidado com funções na coluna do filtro (ex.: `WHERE UPPER(nome) = ...`),
  pois isso pode impedir o uso do índice.

| Conceito | Efeito |
|----------|--------|
| Índice | acelera leitura, desacelera escrita |
| Índice composto | bom para filtros combinados (ordem importa) |
| `EXPLAIN` | mostra se o índice está sendo usado |

**Próximo:** [Funções e CASE](funcoes-e-case.md).
