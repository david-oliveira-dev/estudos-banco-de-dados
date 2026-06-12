# INSERT, UPDATE e DELETE

## 1. INSERT — inserindo dados

O `INSERT` adiciona novas linhas a uma tabela.

### Sintaxe

```sql
INSERT INTO tabela (coluna1, coluna2, ...)
VALUES (valor1, valor2, ...);
```

### Exemplos

```sql
-- Inserir um cliente
INSERT INTO clientes (nome, email, cidade)
VALUES ('João Silva', 'joao@email.com', 'Goiânia');

-- Omitir coluna com DEFAULT ou que aceita NULL
INSERT INTO clientes (nome, cidade)
VALUES ('Maria Souza', 'Brasília');
-- email ficará NULL
```

### Inserindo múltiplos registros

```sql
INSERT INTO categorias (nome) VALUES
('Eletrônicos'),
('Informática'),
('Acessórios');
```

### INSERT com SELECT

Insere dados copiados de outra tabela.

```sql
-- Copiar clientes de Goiânia para uma tabela de clientes_go
INSERT INTO clientes_go (nome, email)
SELECT nome, email
FROM clientes
WHERE cidade = 'Goiânia';
```

### Erros comuns

```sql
-- ERRO: NOT NULL violado
INSERT INTO clientes (email) VALUES ('sem-nome@email.com');

-- ERRO: UNIQUE violado (email já existe)
INSERT INTO clientes (nome, email) VALUES ('Pedro', 'ana@email.com');

-- ERRO: FK violada (categoria_id 99 não existe)
INSERT INTO produtos (nome, preco, categoria_id) VALUES ('Item', 10.00, 99);
```

---

## 2. UPDATE — atualizando dados

O `UPDATE` modifica valores em linhas existentes.

### Sintaxe

```sql
UPDATE tabela
SET coluna1 = valor1, coluna2 = valor2
WHERE condição;
```

> **Atenção:** sempre use `WHERE`. Um `UPDATE` sem `WHERE` atualiza **todas** as linhas da tabela.

### Exemplos

```sql
-- Atualizar o e-mail de um cliente específico
UPDATE clientes
SET email = 'novo@email.com'
WHERE id = 1;

-- Atualizar múltiplos campos
UPDATE produtos
SET preco = 99.90, estoque = 50
WHERE id = 3;

-- Aplicar desconto de 10% em todos os produtos de uma categoria
UPDATE produtos
SET preco = preco * 0.90
WHERE categoria_id = 3;
```

### UPDATE com subquery

```sql
-- Atualizar estoque baseado em vendas
UPDATE produtos
SET estoque = estoque - (
    SELECT SUM(quantidade)
    FROM itens_pedido
    WHERE produto_id = produtos.id
)
WHERE id IN (SELECT DISTINCT produto_id FROM itens_pedido);
```

### Verificando antes de atualizar

Boa prática: rodar o SELECT correspondente antes do UPDATE.

```sql
-- 1. Primeiro, verificar o que será alterado:
SELECT id, nome, preco FROM produtos WHERE categoria_id = 3;

-- 2. Só então, executar o UPDATE:
UPDATE produtos SET preco = preco * 0.90 WHERE categoria_id = 3;
```

---

## 3. DELETE — excluindo dados

O `DELETE` remove linhas de uma tabela.

### Sintaxe

```sql
DELETE FROM tabela WHERE condição;
```

> **Atenção:** sempre use `WHERE`. Um `DELETE` sem `WHERE` remove **todas** as linhas da tabela.

### Exemplos

```sql
-- Excluir um cliente específico
DELETE FROM clientes WHERE id = 5;

-- Excluir pedidos antigos
DELETE FROM pedidos WHERE data_pedido < '2023-01-01';

-- Excluir produtos sem estoque
DELETE FROM produtos WHERE estoque = 0;
```

### Conflito com integridade referencial

```sql
-- ERRO: não é possível excluir cliente que tem pedidos
-- (se a FK for RESTRICT, que é o padrão)
DELETE FROM clientes WHERE id = 1;

-- Solução: excluir os pedidos primeiro, depois o cliente
DELETE FROM itens_pedido WHERE pedido_id IN (
    SELECT id FROM pedidos WHERE cliente_id = 1
);
DELETE FROM pedidos WHERE cliente_id = 1;
DELETE FROM clientes WHERE id = 1;
```

### TRUNCATE — limpar tabela inteira

```sql
-- Remove todas as linhas de forma rápida
TRUNCATE TABLE pedidos;

-- TRUNCATE com CASCADE (apaga tabelas relacionadas também)
TRUNCATE TABLE clientes CASCADE;
```

`TRUNCATE` é mais rápido que `DELETE` sem WHERE, mas não pode ser revertido facilmente em alguns SGBDs.

---

## 4. Transações — protegendo operações críticas

Ao executar múltiplas operações relacionadas, use transações para garantir que todas sejam concluídas ou nenhuma seja.

```sql
BEGIN;

-- Registrar pedido
INSERT INTO pedidos (cliente_id, total) VALUES (1, 299.90);

-- Inserir item
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unit)
VALUES (currval('pedidos_id_seq'), 5, 1, 299.90);

-- Atualizar estoque
UPDATE produtos SET estoque = estoque - 1 WHERE id = 5;

COMMIT;  -- confirma tudo
-- ou ROLLBACK;  -- desfaz tudo se algo der errado
```

---

## 5. Resumo dos comandos

| Comando | Função | Cuidado |
|---|---|---|
| `INSERT INTO ... VALUES` | Adiciona linhas | Respeitar NOT NULL, UNIQUE, FK |
| `UPDATE ... SET ... WHERE` | Modifica linhas | Sempre usar WHERE |
| `DELETE FROM ... WHERE` | Remove linhas | Sempre usar WHERE |
| `TRUNCATE TABLE` | Remove todas as linhas | Não tem WHERE, irreversível |

---

## 6. O que memorizar

- `INSERT` adiciona; `UPDATE` modifica; `DELETE` remove.
- **Sempre use `WHERE`** em UPDATE e DELETE.
- Verifique com SELECT antes de executar UPDATE ou DELETE críticos.
- Use transações (`BEGIN` / `COMMIT` / `ROLLBACK`) para operações que envolvem múltiplas tabelas.
- `DELETE` sem `WHERE` esvazia a tabela — o mesmo que `TRUNCATE`.
