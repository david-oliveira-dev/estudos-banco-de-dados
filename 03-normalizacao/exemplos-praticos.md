# Exemplos Práticos de Normalização

Dois exemplos completos do processo de normalização: uma nota fiscal e um formulário de remanejamento escolar.

---

## Exemplo 1 — Nota Fiscal

### Situação inicial

Uma loja guarda dados de vendas numa única tabela de nota fiscal:

| nf     | data       | cod_cliente | nome_cliente | cidade_cliente | cod_prod | desc_produto | qtd | preco_unit |
|--------|------------|-------------|--------------|----------------|----------|--------------|-----|------------|
| NF-001 | 2024-01-10 | C01         | Ana Lima     | Goiânia        | P01      | Notebook     | 1   | 3500,00    |
| NF-001 | 2024-01-10 | C01         | Ana Lima     | Goiânia        | P02      | Mouse        | 2   | 89,90      |
| NF-002 | 2024-01-15 | C02         | Bruno Costa  | Brasília       | P03      | Teclado      | 1   | 149,90     |
| NF-003 | 2024-02-01 | C01         | Ana Lima     | Goiânia        | P04      | Monitor      | 1   | 1200,00    |

---

### Aplicando a 1FN

A tabela já tem valores atômicos e sem grupos repetitivos. **Está na 1FN.**

Porém, a chave composta seria `(nf, cod_prod)`.

---

### Aplicando a 2FN

Verificando dependências com chave `(nf, cod_prod)`:

```
(nf, cod_prod) → qtd               ✅ total
(nf, cod_prod) → preco_unit        ✅ total
nf             → data              ❌ parcial
nf             → cod_cliente       ❌ parcial
nf             → nome_cliente      ❌ parcial
nf             → cidade_cliente    ❌ parcial
cod_prod       → desc_produto      ❌ parcial
```

Existem dependências parciais. Solução — dividir em três tabelas:

**notas_fiscais** `(nf, data, cod_cliente, nome_cliente, cidade_cliente)`  
**produtos** `(cod_prod, desc_produto)`  
**itens_nf** `(nf, cod_prod, qtd, preco_unit)`

---

### Aplicando a 3FN

Agora verificamos a tabela `notas_fiscais`:

```
nf → data                    ✅ direto
nf → cod_cliente             ✅ direto
nf → nome_cliente            ⚠️ transitivo: nf → cod_cliente → nome_cliente
nf → cidade_cliente          ⚠️ transitivo: nf → cod_cliente → cidade_cliente
```

Solução — separar os dados do cliente:

**clientes** `(cod_cliente, nome_cliente, cidade_cliente)`  
**notas_fiscais** `(nf, data, cod_cliente)` ← FK para clientes

---

### Resultado final — estrutura normalizada (3FN)

```sql
CREATE TABLE clientes (
    cod_cliente VARCHAR(10) PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    cidade      VARCHAR(50)
);

CREATE TABLE produtos (
    cod_prod    VARCHAR(10) PRIMARY KEY,
    descricao   VARCHAR(100) NOT NULL
);

CREATE TABLE notas_fiscais (
    nf          VARCHAR(10) PRIMARY KEY,
    data        DATE NOT NULL,
    cod_cliente VARCHAR(10) REFERENCES clientes(cod_cliente)
);

CREATE TABLE itens_nf (
    nf          VARCHAR(10)  REFERENCES notas_fiscais(nf),
    cod_prod    VARCHAR(10)  REFERENCES produtos(cod_prod),
    qtd         INTEGER      NOT NULL CHECK (qtd > 0),
    preco_unit  DECIMAL(10,2) NOT NULL CHECK (preco_unit >= 0),
    PRIMARY KEY (nf, cod_prod)
);
```

---

### Diagrama da estrutura final

```
┌────────────┐         ┌──────────────────┐
│  clientes  │         │  notas_fiscais   │
│────────────│         │──────────────────│
│ cod_cliente│◄────────│ nf (PK)          │
│ nome       │         │ data             │
│ cidade     │         │ cod_cliente (FK) │
└────────────┘         └────────┬─────────┘
                                │ 1
                                │
                                │ N
                        ┌───────┴──────────┐
                        │    itens_nf      │
                        │──────────────────│
                        │ nf (FK, PK)      │
                        │ cod_prod (FK, PK)│
                        │ qtd              │
                        │ preco_unit       │
                        └────────┬─────────┘
                                 │ N
                                 │
                                 │ 1
                        ┌────────┴─────────┐
                        │    produtos      │
                        │──────────────────│
                        │ cod_prod (PK)    │
                        │ descricao        │
                        └──────────────────┘
```

---

## Exemplo 2 — Formulário de Remanejamento Escolar

### Situação inicial

Uma escola usa este formulário para registrar remanejamentos de alunos entre turmas:

| matricula | nome_aluno | turma_origem | serie_origem | prof_origem | turma_destino | serie_destino | prof_destino | data_reman |
|-----------|------------|--------------|--------------|-------------|---------------|---------------|--------------|------------|
| 2024001   | Ana Lima   | T01          | 1° Ano       | Prof. João  | T02           | 1° Ano        | Prof. Maria  | 2024-03-01 |
| 2024002   | Bruno      | T03          | 2° Ano       | Prof. Ana   | T04           | 2° Ano        | Prof. Pedro  | 2024-03-05 |
| 2024001   | Ana Lima   | T02          | 1° Ano       | Prof. Maria | T05           | 1° Ano        | Prof. Lucas  | 2024-04-10 |

---

### Aplicando a 1FN

Valores atômicos, sem grupos repetitivos. **Está na 1FN.**

Chave candidata: `(matricula, data_reman)`.

---

### Aplicando a 2FN

Verificando dependências:

```
(matricula, data_reman) → turma_origem      ✅ total
(matricula, data_reman) → turma_destino     ✅ total
matricula               → nome_aluno        ❌ parcial
turma_origem            → serie_origem      ❌ parcial (depende só de turma_origem)
turma_origem            → prof_origem       ❌ parcial
turma_destino           → serie_destino     ❌ parcial
turma_destino           → prof_destino      ❌ parcial
```

Solução após 2FN:

**alunos** `(matricula, nome_aluno)`  
**turmas** `(id_turma, serie, professor)`  
**remanejamentos** `(matricula, data_reman, id_turma_origem, id_turma_destino)`

---

### Aplicando a 3FN

Verificando `turmas(id_turma, serie, professor)`:

Supondo que `serie → faixa_etaria` (uma série determina uma faixa etária):

```
id_turma → serie         ✅ direto
id_turma → professor     ✅ direto
id_turma → faixa_etaria  ⚠️ transitivo via serie
```

Solução:

**series** `(id_serie, descricao, faixa_etaria)`  
**turmas** `(id_turma, id_serie, professor)`

---

### Resultado final

```sql
CREATE TABLE alunos (
    matricula  VARCHAR(10) PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL
);

CREATE TABLE series (
    id          SERIAL PRIMARY KEY,
    descricao   VARCHAR(20) NOT NULL,
    faixa_etaria VARCHAR(20)
);

CREATE TABLE turmas (
    id         SERIAL PRIMARY KEY,
    codigo     VARCHAR(10) UNIQUE NOT NULL,
    serie_id   INTEGER REFERENCES series(id),
    professor  VARCHAR(100)
);

CREATE TABLE remanejamentos (
    id              SERIAL PRIMARY KEY,
    matricula       VARCHAR(10) REFERENCES alunos(matricula),
    data_reman      DATE NOT NULL,
    turma_origem    INTEGER REFERENCES turmas(id),
    turma_destino   INTEGER REFERENCES turmas(id)
);
```

---

## Resumo do processo completo

```
Tabela original (sem normalizar)
    ↓
1FN: valores atômicos, sem grupos repetitivos
    ↓
2FN: sem dependências parciais (chave composta)
    ↓
3FN: sem dependências transitivas
    ↓
Banco normalizado, sem redundância
```

| Passo | Pergunta-chave | Ação |
|---|---|---|
| 1FN | Toda célula tem só um valor? | Separar listas em tabelas |
| 2FN | Todo não-chave depende da chave inteira? | Separar dependências parciais |
| 3FN | Todo não-chave depende só da chave? | Separar dependências transitivas |
