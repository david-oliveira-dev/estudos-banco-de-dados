# Entidades, Atributos e Relacionamentos

## 1. Modelagem de dados

Antes de criar um banco de dados, é necessário planejar **o que** será armazenado e **como** as informações se relacionam.

Esse processo é chamado de **modelagem de dados**.

A modelagem usa um modelo chamado **Entidade-Relacionamento (ER)**, proposto por Peter Chen em 1976.

O modelo ER é representado por um diagrama — o **Diagrama ER** — que serve como "planta baixa" do banco de dados.

---

## 2. Entidade

Uma entidade é qualquer coisa do mundo real sobre a qual queremos armazenar dados.

Exemplos:

- Aluno
- Professor
- Produto
- Cliente
- Pedido
- Curso

Cada entidade vira uma **tabela** no banco de dados.

---

## 3. Atributos de uma entidade

Atributos são as características de uma entidade.

Exemplo — entidade **Aluno**:

- `nome`
- `data_nascimento`
- `email`
- `cidade`
- `ano_ingresso`

Cada atributo vira uma **coluna** na tabela.

### Tipos de atributos

| Tipo | Descrição | Exemplo |
|---|---|---|
| Simples | Não pode ser dividido | `nome`, `preco` |
| Composto | Pode ser dividido em partes | `endereço` = rua + número + bairro + CEP |
| Monovalorado | Tem apenas um valor por registro | `data_nascimento` |
| Multivalorado | Pode ter vários valores | `telefone` (pode ter mais de um) |
| Derivado | Calculado a partir de outros | `idade` (derivada de `data_nascimento`) |
| Chave | Identifica unicamente o registro | `id`, `cpf`, `matricula` |

---

## 4. Relacionamento

Um relacionamento é uma associação entre duas ou mais entidades.

Exemplo:

- Um **aluno** se **matricula** em uma **turma**.
- Um **professor** **ministra** uma **disciplina**.
- Um **cliente** **realiza** um **pedido**.

No diagrama ER, relacionamentos são representados por losangos.

---

## 5. Cardinalidade dos relacionamentos

A cardinalidade define quantas instâncias de uma entidade podem se relacionar com instâncias de outra.

### 1:1 — Um para um

Cada instância de A se relaciona com no máximo uma instância de B, e vice-versa.

Exemplo:

```
Funcionário 1 -------- 1 Carteira de Trabalho
```

Um funcionário possui uma carteira de trabalho. Uma carteira de trabalho pertence a um funcionário.

### 1:N — Um para muitos

Uma instância de A pode se relacionar com várias instâncias de B, mas cada instância de B se relaciona com apenas uma de A.

Exemplo:

```
Turma 1 -------- N Alunos
```

Uma turma possui vários alunos. Cada aluno pertence a uma única turma.

### N:M — Muitos para muitos

Uma instância de A pode se relacionar com várias de B, e cada instância de B pode se relacionar com várias de A.

Exemplo:

```
Alunos N -------- M Disciplinas
```

Um aluno pode estar matriculado em várias disciplinas. Uma disciplina pode ter vários alunos matriculados.

> No banco de dados, relacionamentos N:M precisam de uma **tabela intermediária** para representar a associação.

---

## 6. Diagrama ER — exemplo completo

Abaixo um diagrama simplificado de um sistema escolar:

```
┌─────────────┐       matricula        ┌─────────────┐
│    ALUNO    │ N ──────────────── M   │    TURMA    │
│─────────────│                        │─────────────│
│ id          │                        │ id          │
│ nome        │                        │ codigo      │
│ email       │                        │ periodo     │
│ nascimento  │                        │ ano         │
└─────────────┘                        └──────┬──────┘
                                              │ 1
                                              │ pertence
                                              │ N
                                       ┌──────┴──────┐
                                       │  DISCIPLINA │
                                       │─────────────│
                                       │ id          │
                                       │ nome        │
                                       │ carga_hora  │
                                       └──────┬──────┘
                                              │ N
                                              │ ministra
                                              │ 1
                                       ┌──────┴──────┐
                                       │  PROFESSOR  │
                                       │─────────────│
                                       │ id          │
                                       │ nome        │
                                       │ titulacao   │
                                       └─────────────┘
```

---

## 7. Da entidade para a tabela

Cada entidade do diagrama vira uma tabela no banco.

Exemplo — entidade **Aluno** → tabela SQL:

```sql
CREATE TABLE alunos (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE,
    nascimento  DATE,
    turma_id    INTEGER REFERENCES turmas(id)
);
```

Para relacionamentos **N:M**, cria-se uma tabela intermediária:

```sql
-- Tabela intermediária: aluno_disciplina
CREATE TABLE aluno_disciplina (
    aluno_id      INTEGER REFERENCES alunos(id),
    disciplina_id INTEGER REFERENCES disciplinas(id),
    PRIMARY KEY (aluno_id, disciplina_id)
);
```

---

## 8. O que memorizar

- Entidade = coisa do mundo real sobre a qual queremos guardar dados → vira tabela.
- Atributo = característica de uma entidade → vira coluna.
- Relacionamento = associação entre entidades.
- 1:1 = um para um.
- 1:N = um para muitos (o mais comum).
- N:M = muitos para muitos → precisa de tabela intermediária.
- O diagrama ER é o mapa do banco antes de criá-lo.

---

## 9. Resumo final

Modelar um banco de dados começa por identificar as entidades (coisas do mundo real), seus atributos (características) e os relacionamentos entre elas.

O diagrama ER documenta essa estrutura visualmente e serve de base para criar as tabelas do banco.

Compreender entidades, atributos e relacionamentos é o passo mais importante antes de escrever qualquer linha de SQL.
