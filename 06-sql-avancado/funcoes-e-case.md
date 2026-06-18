# Funções e CASE

Além de buscar dados, o SQL transforma e formata valores com **funções** e com a
expressão condicional **CASE**. Aqui estão as mais usadas no dia a dia.

> Exemplos no banco de loja de `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.
> Nomes de funções variam um pouco entre bancos — anoto quando for o caso.

---

## 1. Funções de texto

```sql
SELECT
    UPPER(nome)        AS maiusculo,
    LOWER(nome)        AS minusculo,
    LENGTH(nome)       AS tamanho,
    SUBSTR(nome, 1, 3) AS tres_primeiras
FROM clientes;
```

Concatenação (juntar textos) — o operador padrão é `||`:

```sql
SELECT nome || ' (' || cidade || ')' AS cliente_cidade
FROM clientes;
```

> No MySQL use `CONCAT(nome, ' (', cidade, ')')` no lugar do `||`.

---

## 2. Funções numéricas

```sql
SELECT
    nome,
    preco,
    ROUND(preco, 0)       AS preco_arredondado,
    ROUND(preco * 0.9, 2) AS com_10pct_desconto
FROM produtos;
```

---

## 3. Funções de data

```sql
-- Ano e mês de cada pedido (SQLite)
SELECT
    id,
    data_pedido,
    strftime('%Y', data_pedido) AS ano,
    strftime('%m', data_pedido) AS mes
FROM pedidos;
```

> PostgreSQL/MySQL usam `EXTRACT(YEAR FROM data_pedido)` ou `YEAR(data_pedido)`.

---

## 4. Tratando NULL: COALESCE e NULLIF

`COALESCE` devolve o primeiro valor que **não** é nulo — ótimo para dar um padrão.

```sql
-- Mostra 'sem e-mail' quando o email é NULL
SELECT nome, COALESCE(email, 'sem e-mail') AS email
FROM clientes;
```

`NULLIF(a, b)` devolve `NULL` se `a = b` (útil para evitar divisão por zero):

```sql
SELECT 100 / NULLIF(0, 0);   -- devolve NULL em vez de dar erro
```

---

## 5. CASE — lógica condicional

O `CASE` é o "if/else" do SQL. Cria uma coluna com base em condições.

```sql
SELECT
    nome,
    preco,
    CASE
        WHEN preco >= 1000 THEN 'caro'
        WHEN preco >= 100  THEN 'médio'
        ELSE 'barato'
    END AS faixa_preco
FROM produtos
ORDER BY preco DESC;
```

`CASE` combinado com agregação resolve relatórios poderosos (contagem condicional):

```sql
-- Quantos produtos caros e baratos existem
SELECT
    SUM(CASE WHEN preco >= 1000 THEN 1 ELSE 0 END) AS qtd_caros,
    SUM(CASE WHEN preco <  1000 THEN 1 ELSE 0 END) AS qtd_baratos
FROM produtos;
```

---

## Resumo

| Recurso | Para quê |
|---------|----------|
| `UPPER/LOWER/LENGTH/SUBSTR` | manipular texto |
| `ROUND` | arredondar números |
| `strftime` / `EXTRACT` | extrair partes de datas |
| `COALESCE` | dar valor padrão a NULL |
| `NULLIF` | transformar um valor em NULL |
| `CASE WHEN` | criar categorias / lógica condicional |

**Próximo:** [Funções de janela (window functions)](window-functions.md).
