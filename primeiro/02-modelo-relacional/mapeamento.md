# Mapeamento: do Modelo Conceitual ao Relacional

## 1. O que é mapeamento?

Mapeamento é o processo de transformar o **modelo conceitual** (diagrama ER) em um **modelo relacional** (tabelas SQL).

O diagrama ER representa o que precisa ser armazenado.
O modelo relacional define como isso será armazenado em tabelas.

---

## 2. Regras de mapeamento

### Regra 1 — Cada entidade vira uma tabela

Cada entidade do diagrama ER se torna uma tabela no banco.

Os atributos da entidade viram colunas. O atributo-chave vira a chave primária.

Exemplo:

```
Entidade: ALUNO
Atributos: id, nome, email, data_nascimento

→ Tabela: alunos(id, nome, email, data_nascimento)
```

```sql
CREATE TABLE alunos (
    id             SERIAL PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    data_nascimento DATE
);
```

---

### Regra 2 — Relacionamento 1:N

O lado **N** recebe uma chave estrangeira que aponta para o lado **1**.

Exemplo — um professor ministra várias disciplinas (1:N):

```
PROFESSOR (1) ──── ministra ──── (N) DISCIPLINA
```

A tabela `disciplinas` recebe a chave estrangeira `professor_id`:

```sql
CREATE TABLE professores (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE disciplinas (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    carga_horaria INTEGER,
    professor_id  INTEGER REFERENCES professores(id)
);
```

---

### Regra 3 — Relacionamento N:M

Cria-se uma **tabela intermediária** (tabela de junção) com as chaves estrangeiras de ambos os lados.

Exemplo — alunos se matriculam em várias disciplinas, e disciplinas têm vários alunos (N:M):

```
ALUNO (N) ──── matriculado_em ──── (M) DISCIPLINA
```

```sql
CREATE TABLE aluno_disciplina (
    aluno_id      INTEGER REFERENCES alunos(id),
    disciplina_id INTEGER REFERENCES disciplinas(id),
    data_matricula DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (aluno_id, disciplina_id)
);
```

A tabela intermediária pode ter atributos próprios do relacionamento, como `data_matricula`.

---

### Regra 4 — Relacionamento 1:1

Uma das tabelas recebe a chave estrangeira da outra. Geralmente a FK fica na entidade menos independente, com `UNIQUE`.

Exemplo — cada funcionário tem um único crachá:

```
FUNCIONARIO (1) ──── possui ──── (1) CRACHA
```

```sql
CREATE TABLE funcionarios (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE crachas (
    id             SERIAL PRIMARY KEY,
    numero         VARCHAR(20) UNIQUE NOT NULL,
    funcionario_id INTEGER UNIQUE REFERENCES funcionarios(id)
);
```

---

### Regra 5 — Atributos multivalorados

Atributos multivalorados (aqueles que podem ter mais de um valor por registro) viram uma **tabela separada**.

Exemplo — um cliente pode ter vários telefones:

```sql
CREATE TABLE telefones_cliente (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    telefone   VARCHAR(20) NOT NULL
);
```

---

## 3. Exemplo completo — sistema de loja

### Diagrama ER (simplificado)

```
CLIENTE (1) ──── realiza ──── (N) PEDIDO
PEDIDO  (1) ──── contém  ──── (N) ITEM_PEDIDO
PRODUTO (1) ──── aparece ──── (N) ITEM_PEDIDO
PRODUTO (N) ──── pertence──── (1) CATEGORIA
```

### Mapeamento para SQL

```sql
CREATE TABLE categorias (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE clientes (
    id     SERIAL PRIMARY KEY,
    nome   VARCHAR(100) NOT NULL,
    email  VARCHAR(100) UNIQUE,
    cidade VARCHAR(50)
);

CREATE TABLE produtos (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    preco        DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    estoque      INTEGER DEFAULT 0 CHECK (estoque >= 0),
    categoria_id INTEGER REFERENCES categorias(id)
);

CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id),
    data       DATE DEFAULT CURRENT_DATE,
    total      DECIMAL(10,2) CHECK (total >= 0)
);

CREATE TABLE itens_pedido (
    id         SERIAL PRIMARY KEY,
    pedido_id  INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    produto_id INTEGER NOT NULL REFERENCES produtos(id),
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unit DECIMAL(10,2) NOT NULL CHECK (preco_unit >= 0)
);
```

---

## 4. Resumo das regras

| Situação no ER | Como mapear para SQL |
|---|---|
| Entidade | Tabela |
| Atributo | Coluna |
| Atributo-chave | PRIMARY KEY |
| Relacionamento 1:N | FK no lado N |
| Relacionamento N:M | Tabela intermediária |
| Relacionamento 1:1 | FK com UNIQUE |
| Atributo multivalorado | Tabela separada |

---

## 5. O que memorizar

- Mapeamento = transformar o diagrama ER em tabelas SQL.
- Cada entidade → uma tabela.
- 1:N → FK no lado N.
- N:M → tabela intermediária.
- 1:1 → FK com UNIQUE.
- Atributo multivalorado → tabela própria.

---

## 6. Resumo final

O mapeamento transforma o modelo conceitual em estruturas concretas de banco de dados.

Seguindo as regras de mapeamento, é possível converter qualquer diagrama ER em tabelas SQL bem estruturadas, com chaves e relacionamentos corretamente definidos.
