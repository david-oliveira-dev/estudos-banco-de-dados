# 📋 SQL Cheatsheet — Referência Rápida

## SELECT
```sql
-- Todos os campos
SELECT * FROM tabela;

-- Campos específicos
SELECT nome, idade FROM clientes;

-- Com alias
SELECT nome AS cliente, idade AS anos FROM clientes;
```

## WHERE
```sql
-- Igual
SELECT * FROM clientes WHERE cidade = 'Goiânia';

-- Maior / Menor
SELECT * FROM produtos WHERE preco > 100;

-- BETWEEN
SELECT * FROM pedidos WHERE data BETWEEN '2024-01-01' AND '2024-12-31';

-- LIKE (busca parcial)
SELECT * FROM clientes WHERE nome LIKE 'Ana%';

-- IN
SELECT * FROM produtos WHERE categoria IN ('eletrônicos', 'informática');

-- IS NULL
SELECT * FROM clientes WHERE email IS NULL;
```

## JOIN
```sql
-- INNER JOIN (apenas correspondências)
SELECT c.nome, p.descricao
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

-- LEFT JOIN (todos da esquerda + correspondências)
SELECT c.nome, p.descricao
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id;

-- RIGHT JOIN (todos da direita + correspondências)
SELECT c.nome, p.descricao
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;
```

## GROUP BY
```sql
-- Contagem por grupo
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade;

-- Soma por grupo
SELECT categoria, SUM(preco) AS total_vendas
FROM produtos
GROUP BY categoria;

-- HAVING (filtro após agrupamento)
SELECT cidade, COUNT(*) AS total
FROM clientes
GROUP BY cidade
HAVING COUNT(*) > 10;
```

## INSERT
```sql
-- Inserir um registro
INSERT INTO clientes (nome, email, cidade)
VALUES ('João Silva', 'joao@email.com', 'Goiânia');

-- Inserir múltiplos registros
INSERT INTO clientes (nome, cidade) VALUES
('Maria', 'Brasília'),
('Pedro', 'São Paulo');
```

## UPDATE
```sql
-- Atualizar um campo
UPDATE clientes SET email = 'novo@email.com' WHERE id = 1;

-- Atualizar múltiplos campos
UPDATE produtos SET preco = 99.90, estoque = 50 WHERE id = 5;
```

## DELETE
```sql
-- Deletar registro específico
DELETE FROM clientes WHERE id = 1;

-- Deletar com condição
DELETE FROM pedidos WHERE data < '2023-01-01';
```

## Funções de Agregação
```sql
COUNT(*)   -- Conta registros
SUM(campo) -- Soma valores
AVG(campo) -- Média
MAX(campo) -- Maior valor
MIN(campo) -- Menor valor
```

## ORDER BY
```sql
-- Crescente (padrão)
SELECT * FROM produtos ORDER BY preco ASC;

-- Decrescente
SELECT * FROM produtos ORDER BY preco DESC;
```

## LIMIT
```sql
-- Primeiros 10 registros
SELECT * FROM clientes LIMIT 10;

-- Paginação
SELECT * FROM clientes LIMIT 10 OFFSET 20;
```
