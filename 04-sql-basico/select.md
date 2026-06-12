# SELECT — Consultando Dados

## 1. Estrutura básica

O `SELECT` é o comando mais usado em SQL. Ele consulta dados de uma ou mais tabelas.

```sql
SELECT colunas
FROM tabela
WHERE condição
ORDER BY coluna
LIMIT n;
```

As cláusulas seguem sempre essa ordem.

---

## 2. Selecionando colunas

```sql
-- Todas as colunas
SELECT * FROM clientes;

-- Colunas específicas
SELECT nome, cidade FROM clientes;

-- Com alias (apelido)
SELECT nome AS cliente, cidade AS localidade FROM clientes;
```

> Prefira listar as colunas explicitamente em vez de `*`. É mais claro e eficiente.

---

## 3. WHERE — filtrando linhas

O `WHERE` filtra quais linhas serão retornadas.

### Comparações

```sql
SELECT * FROM produtos WHERE preco = 89.90;
SELECT * FROM produtos WHERE preco > 100;
SELECT * FROM produtos WHERE preco >= 100;
SELECT * FROM produtos WHERE preco < 50;
SELECT * FROM produtos WHERE preco <> 89.90;   -- diferente de
SELECT * FROM produtos WHERE preco != 89.90;   -- diferente de (alternativo)
```

### BETWEEN — intervalo

```sql
SELECT * FROM pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-06-30';

SELECT * FROM produtos WHERE preco BETWEEN 50 AND 200;
```

### LIKE — busca textual

```sql
-- Começa com "Ana"
SELECT * FROM clientes WHERE nome LIKE 'Ana%';

-- Termina com "Silva"
SELECT * FROM clientes WHERE nome LIKE '%Silva';

-- Contém "ou"
SELECT * FROM clientes WHERE nome LIKE '%ou%';

-- Segunda letra é "r"
SELECT * FROM clientes WHERE nome LIKE '_r%';
```

`%` substitui qualquer sequência de caracteres. `_` substitui um único caractere.

### IN — lista de valores

```sql
SELECT * FROM clientes WHERE cidade IN ('Goiânia', 'Brasília', 'São Paulo');

SELECT * FROM produtos WHERE categoria_id IN (1, 2);
```

### IS NULL / IS NOT NULL

```sql
-- Clientes sem e-mail
SELECT * FROM clientes WHERE email IS NULL;

-- Clientes com e-mail
SELECT * FROM clientes WHERE email IS NOT NULL;
```

### AND, OR, NOT

```sql
-- AND: as duas condições precisam ser verdadeiras
SELECT * FROM produtos WHERE preco > 100 AND estoque > 0;

-- OR: pelo menos uma condição verdadeira
SELECT * FROM clientes WHERE cidade = 'Goiânia' OR cidade = 'Brasília';

-- NOT: inverte a condição
SELECT * FROM produtos WHERE NOT categoria_id = 1;
```

---

## 4. ORDER BY — ordenando resultados

```sql
-- Crescente (padrão)
SELECT * FROM produtos ORDER BY preco ASC;
SELECT * FROM produtos ORDER BY preco;         -- ASC é o padrão

-- Decrescente
SELECT * FROM produtos ORDER BY preco DESC;

-- Por múltiplas colunas
SELECT * FROM clientes ORDER BY cidade ASC, nome ASC;

-- Por texto: resultado em ordem alfabética
SELECT * FROM clientes ORDER BY nome;
```

---

## 5. LIMIT e OFFSET — paginação

```sql
-- Primeiros 5 registros
SELECT * FROM produtos LIMIT 5;

-- 5 registros mais caros
SELECT * FROM produtos ORDER BY preco DESC LIMIT 5;

-- Paginação: pula os 10 primeiros, traz os próximos 10
SELECT * FROM clientes LIMIT 10 OFFSET 10;
```

---

## 6. DISTINCT — eliminar duplicatas

```sql
-- Cidades únicas dos clientes (sem repetir)
SELECT DISTINCT cidade FROM clientes;

-- Combinação única de cidade + estado
SELECT DISTINCT cidade, estado FROM enderecos;
```

---

## 7. Funções de agregação

Funções que calculam um valor a partir de um conjunto de linhas.

```sql
-- Contagem
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(email) AS com_email FROM clientes;  -- ignora NULL

-- Soma
SELECT SUM(total) AS receita_total FROM pedidos;

-- Média
SELECT ROUND(AVG(preco), 2) AS preco_medio FROM produtos;

-- Máximo e mínimo
SELECT MAX(preco) AS mais_caro FROM produtos;
SELECT MIN(preco) AS mais_barato FROM produtos;
```

---

## 8. Exemplos com o banco de loja

Usando o banco criado em `scripts/criacao-tabelas-exemplo.sql`:

```sql
-- Todos os produtos em estoque
SELECT nome, preco, estoque FROM produtos WHERE estoque > 0;

-- 3 produtos mais caros
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 3;

-- Clientes de Goiânia com e-mail
SELECT nome, email FROM clientes
WHERE cidade = 'Goiânia' AND email IS NOT NULL;

-- Produtos entre R$50 e R$300
SELECT nome, preco FROM produtos
WHERE preco BETWEEN 50 AND 300
ORDER BY preco;

-- Total de pedidos e valor médio
SELECT COUNT(*) AS qtd_pedidos, ROUND(AVG(total), 2) AS ticket_medio
FROM pedidos;
```

---

## 9. Ordem de execução do SELECT

É importante saber que o banco executa as cláusulas numa ordem diferente da escrita:

```
1. FROM       — identifica a(s) tabela(s)
2. WHERE      — filtra as linhas
3. GROUP BY   — agrupa
4. HAVING     — filtra grupos
5. SELECT     — seleciona as colunas
6. ORDER BY   — ordena
7. LIMIT      — limita a quantidade
```

Isso explica por que não é possível usar alias do `SELECT` dentro do `WHERE`.

---

## 10. O que memorizar

- `SELECT colunas FROM tabela` — base de toda consulta.
- `WHERE` filtra linhas; `HAVING` filtra grupos.
- `ORDER BY coluna DESC` — decrescente; `ASC` — crescente (padrão).
- `LIMIT n OFFSET m` — paginação.
- `DISTINCT` elimina duplicatas.
- `LIKE '%texto%'` — busca textual parcial.
- `IS NULL` — verifica campos vazios (nunca use `= NULL`).
