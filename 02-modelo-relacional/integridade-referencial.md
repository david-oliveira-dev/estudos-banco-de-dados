# Integridade Referencial

## 1. O que é integridade?

Integridade de dados significa que os dados armazenados são **corretos, consistentes e válidos**.

Um banco sem integridade pode conter:
- pedidos de clientes que não existem;
- notas de alunos sem disciplina associada;
- produtos com preço negativo;
- campos obrigatórios em branco.

O SGBD oferece mecanismos para **impedir** que isso aconteça.

---

## 2. Tipos de restrições de integridade

### 2.1 Integridade de domínio

Garante que os valores de um atributo pertençam ao domínio definido.

Exemplo:

```sql
-- idade deve ser número inteiro entre 0 e 150
idade INTEGER CHECK (idade >= 0 AND idade <= 150)

-- status só aceita dois valores
status VARCHAR(10) CHECK (status IN ('ativo', 'inativo'))

-- preco não pode ser negativo
preco DECIMAL(10,2) CHECK (preco >= 0)
```

### 2.2 Integridade de entidade

Garante que a chave primária seja **única** e **não nula**.

Regras:
- toda tabela deve ter uma chave primária;
- nenhum atributo da chave primária pode ser NULL;
- o valor da chave primária não pode se repetir.

```sql
CREATE TABLE produtos (
    id   SERIAL PRIMARY KEY,   -- NOT NULL + UNIQUE garantido pelo PK
    nome VARCHAR(100) NOT NULL
);
```

### 2.3 Integridade referencial

Garante que os valores de uma chave estrangeira correspondam a valores existentes na tabela referenciada.

Em outras palavras: **não pode existir um registro filho sem um registro pai**.

Exemplo:

```sql
-- Um pedido não pode referenciar um cliente inexistente
INSERT INTO pedidos (cliente_id, total)
VALUES (999, 150.00);
-- ERRO: cliente com id=999 não existe em clientes
```

---

## 3. Como o banco reage a violações referenciais

Quando tentamos inserir, atualizar ou excluir dados que violam a integridade referencial, o SGBD pode reagir de formas diferentes.

Essas reações são configuradas na declaração da chave estrangeira com `ON DELETE` e `ON UPDATE`.

### RESTRICT / NO ACTION (padrão)

Bloqueia a operação. Não permite excluir um registro pai que possui filhos.

```sql
-- Tentativa de excluir cliente que tem pedidos
DELETE FROM clientes WHERE id = 1;
-- ERRO: violação de chave estrangeira
```

### CASCADE

A operação se propaga. Se o pai for excluído, os filhos também são excluídos.

```sql
CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id) ON DELETE CASCADE
);
-- Se o cliente for excluído, todos os seus pedidos também são excluídos
```

### SET NULL

A chave estrangeira no filho é definida como NULL quando o pai é excluído.

```sql
CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id) ON DELETE SET NULL
);
-- Se o cliente for excluído, cliente_id nos pedidos vira NULL
```

### SET DEFAULT

A chave estrangeira recebe um valor padrão quando o pai é excluído.

```sql
CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER DEFAULT 0 REFERENCES clientes(id) ON DELETE SET DEFAULT
);
```

---

## 4. Comparação entre as ações

| Ação | O que acontece ao excluir o pai |
|---|---|
| RESTRICT / NO ACTION | Bloqueia a exclusão se houver filhos |
| CASCADE | Exclui os filhos automaticamente |
| SET NULL | Define NULL nas FKs dos filhos |
| SET DEFAULT | Define um valor padrão nas FKs dos filhos |

---

## 5. Exemplo completo

```sql
CREATE TABLE clientes (
    id    SERIAL PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT,
    total      DECIMAL(10,2) CHECK (total >= 0),
    data       DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE itens_pedido (
    id         SERIAL PRIMARY KEY,
    pedido_id  INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    produto_id INTEGER NOT NULL REFERENCES produtos(id),
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unit DECIMAL(10,2) NOT NULL CHECK (preco_unit >= 0)
);
```

Nesse exemplo:
- não é possível excluir um cliente que tem pedidos (`RESTRICT`);
- se um pedido for excluído, seus itens são excluídos automaticamente (`CASCADE`);
- quantidade e preço unitário não podem ser negativos (`CHECK`).

---

## 6. Restrições de coluna mais usadas

| Restrição | Função |
|---|---|
| `NOT NULL` | O campo não pode estar vazio |
| `UNIQUE` | O valor não pode se repetir |
| `PRIMARY KEY` | Combina NOT NULL + UNIQUE, identifica a tupla |
| `FOREIGN KEY` | Referencia a PK de outra tabela |
| `CHECK` | Define uma condição que o valor deve obedecer |
| `DEFAULT` | Define um valor padrão quando o campo não é informado |

---

## 7. O que memorizar

- Integridade garante que os dados sejam válidos e consistentes.
- Integridade de domínio: valores dentro do tipo/domínio definido.
- Integridade de entidade: chave primária não nula e única.
- Integridade referencial: FK deve referenciar um valor que existe na tabela pai.
- `ON DELETE CASCADE` propaga a exclusão para os filhos.
- `ON DELETE RESTRICT` bloqueia a exclusão se houver filhos.
- `CHECK`, `NOT NULL` e `UNIQUE` são restrições de coluna básicas.

---

## 8. Resumo final

A integridade referencial garante que as relações entre tabelas permaneçam coerentes.

Um banco sem essas restrições pode acumular dados "órfãos" — registros filhos sem pai correspondente — o que gera inconsistências e dificulta consultas.

Declarar corretamente as restrições de integridade é uma das práticas mais importantes no projeto de banco de dados.
