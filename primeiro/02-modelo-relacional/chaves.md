# Chaves em Banco de Dados Relacionais

## 1. Para que servem as chaves?

Em uma tabela, pode haver situações em que duas linhas têm valores parecidos.

Exemplo — tabela de alunos:

| nome        | cidade   |
|-------------|----------|
| João Silva  | Goiânia  |
| João Silva  | Goiânia  |

Como distinguir qual é qual?

As **chaves** resolvem esse problema. Elas identificam registros de forma única e também ligam tabelas entre si.

---

## 2. Superchave

Uma superchave é qualquer conjunto de atributos que identifica unicamente uma tupla.

Exemplo na tabela `alunos`:

- `{id}` → identifica unicamente → é superchave
- `{cpf}` → identifica unicamente → é superchave
- `{id, nome}` → também identifica unicamente (id já basta) → é superchave, mas redundante

Toda chave é uma superchave, mas nem toda superchave é uma chave.

---

## 3. Chave candidata

Uma chave candidata é uma superchave **mínima** — sem atributos desnecessários.

Ela identifica unicamente uma tupla e não tem atributos sobrando.

Exemplo na tabela `alunos`:

- `{id}` → mínima → é chave candidata
- `{cpf}` → mínima → é chave candidata
- `{matricula}` → mínima → é chave candidata
- `{id, nome}` → não é mínima (nome é redundante) → não é chave candidata

Uma tabela pode ter mais de uma chave candidata.

---

## 4. Chave primária (PRIMARY KEY)

A chave primária é a chave candidata **escolhida** para identificar os registros da tabela.

Regras obrigatórias:

- o valor deve ser **único** — não pode se repetir;
- o valor não pode ser **nulo** (NULL);
- cada tabela tem **apenas uma** chave primária.

Exemplo em SQL:

```sql
CREATE TABLE clientes (
    id    SERIAL PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);
```

A coluna `id` é a chave primária. Cada cliente terá um `id` diferente.

### Chave primária composta

Quando nenhuma coluna sozinha identifica unicamente uma linha, pode-se usar duas colunas juntas.

Exemplo — tabela de matrículas:

```sql
CREATE TABLE matriculas (
    aluno_id    INTEGER,
    turma_id    INTEGER,
    data        DATE,
    PRIMARY KEY (aluno_id, turma_id)
);
```

A combinação `aluno_id + turma_id` é única — um aluno não pode estar matriculado duas vezes na mesma turma.

---

## 5. Chave estrangeira (FOREIGN KEY)

A chave estrangeira é um atributo em uma tabela que **referencia** a chave primária de outra tabela.

Ela é o mecanismo que conecta tabelas entre si no modelo relacional.

Exemplo:

```sql
CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    data       DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

- `clientes.id` é a chave primária da tabela `clientes`;
- `pedidos.cliente_id` é a chave estrangeira que aponta para `clientes.id`.

Isso garante que um pedido só pode ser feito por um cliente que **existe** na tabela `clientes`.

### Representação visual

```
┌──────────────┐         ┌───────────────┐
│   clientes   │         │    pedidos    │
│──────────────│         │───────────────│
│ id (PK)  ◄──┼────────── cliente_id (FK)│
│ nome         │         │ id (PK)       │
│ email        │         │ data          │
└──────────────┘         └───────────────┘
```

---

## 6. Chave alternativa

Chave alternativa é qualquer chave candidata que **não** foi escolhida como chave primária.

Exemplo:

Na tabela `alunos`, se `id` foi escolhido como chave primária:
- `cpf` continua sendo uma chave candidata, mas passa a ser **chave alternativa**.

Em SQL, a chave alternativa costuma ser implementada com `UNIQUE`:

```sql
CREATE TABLE alunos (
    id         SERIAL PRIMARY KEY,
    matricula  VARCHAR(20) UNIQUE NOT NULL,
    cpf        CHAR(11) UNIQUE,
    nome       VARCHAR(100) NOT NULL
);
```

---

## 7. Comparação entre os tipos de chave

| Tipo | Descrição | Exemplo |
|---|---|---|
| Superchave | Identifica unicamente, pode ter redundância | `{id, nome}` |
| Chave candidata | Superchave mínima, sem redundância | `{id}`, `{cpf}` |
| Chave primária | Chave candidata escolhida, NOT NULL | `id SERIAL PRIMARY KEY` |
| Chave composta | Chave primária com dois ou mais atributos | `(aluno_id, turma_id)` |
| Chave estrangeira | Referencia a PK de outra tabela | `cliente_id REFERENCES clientes(id)` |
| Chave alternativa | Chave candidata não escolhida como PK | `cpf UNIQUE` |

---

## 8. Boas práticas

**Use chaves artificiais (surrogate keys)** como `id SERIAL` na maioria dos casos. Elas são simples, imutáveis e não dependem de dados do negócio.

**Evite usar dados reais como chave primária** quando possível. CPF pode mudar de formato, e-mail pode ser alterado, nomes se repetem.

**Sempre declare chaves estrangeiras explicitamente.** Além de documentar a relação, o banco de dados vai garantir a integridade automaticamente.

```sql
-- Bom: chave artificial, integridade declarada
CREATE TABLE pedidos (
    id         SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id),
    total      DECIMAL(10,2)
);
```

---

## 9. O que memorizar

- Chave identifica unicamente uma tupla.
- Chave candidata = identificador mínimo sem redundância.
- Chave primária = chave candidata escolhida, única e não nula.
- Chave estrangeira = referência à chave primária de outra tabela.
- Chave alternativa = candidata não escolhida como primária.
- Chave composta = chave primária formada por dois ou mais atributos.

---

## 10. Resumo final

As chaves são o mecanismo central do modelo relacional.

A chave primária garante que cada linha seja única e identificável. A chave estrangeira conecta tabelas e mantém os relacionamentos coerentes.

Sem chaves bem definidas, um banco de dados relacional perde sua consistência e confiabilidade.
