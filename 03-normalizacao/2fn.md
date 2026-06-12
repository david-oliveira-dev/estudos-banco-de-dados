# Segunda Forma Normal (2FN)

## 1. Pré-requisito

Para estar na 2FN, a tabela deve estar primeiro na **1FN**.

---

## 2. O que é a 2FN?

Uma tabela está na **Segunda Forma Normal** quando:

1. Está na 1FN.
2. Todos os atributos não-chave têm **dependência funcional total** da chave primária.

Em outras palavras: **nenhum atributo não-chave pode depender de apenas uma parte da chave**.

> A 2FN só é relevante quando a chave primária é **composta** (formada por dois ou mais atributos). Se a chave for simples (um único atributo), a tabela já está na 2FN automaticamente ao estar na 1FN.

---

## 3. Identificando o problema

### Exemplo — tabela de notas com chave composta

| **aluno_id** | **disciplina_id** | nota | nome_aluno | nome_disciplina | carga_horaria |
|--------------|-------------------|------|------------|-----------------|---------------|
| 1            | 10                | 8.5  | Ana Lima   | Banco de Dados  | 80h           |
| 1            | 20                | 7.0  | Ana Lima   | Redes           | 60h           |
| 2            | 10                | 9.0  | Bruno      | Banco de Dados  | 80h           |
| 2            | 30                | 6.5  | Bruno      | Programação     | 60h           |

Chave primária: `(aluno_id, disciplina_id)`.

Analisando as dependências:

```
(aluno_id, disciplina_id) → nota          ✅ dependência total
aluno_id → nome_aluno                     ❌ dependência parcial
disciplina_id → nome_disciplina           ❌ dependência parcial
disciplina_id → carga_horaria             ❌ dependência parcial
```

`nome_aluno` depende **só de** `aluno_id`, não da chave inteira.  
`nome_disciplina` e `carga_horaria` dependem **só de** `disciplina_id`.

**Viola a 2FN.**

### Problemas causados

- `nome_aluno` e `nome_disciplina` ficam repetidos em cada linha.
- Se o nome de uma disciplina mudar, precisa ser alterado em todas as linhas.
- Se um aluno não tiver notas, seus dados não podem ser armazenados nessa tabela.

---

## 4. Correção: decompor em tabelas

A solução é separar os atributos com dependências parciais em suas próprias tabelas.

### Tabela: alunos

| id | nome   |
|----|--------|
| 1  | Ana    |
| 2  | Bruno  |

### Tabela: disciplinas

| id | nome            | carga_horaria |
|----|-----------------|---------------|
| 10 | Banco de Dados  | 80h           |
| 20 | Redes           | 60h           |
| 30 | Programação     | 60h           |

### Tabela: notas (apenas a dependência total)

| aluno_id | disciplina_id | nota |
|----------|--------------|------|
| 1        | 10           | 8.5  |
| 1        | 20           | 7.0  |
| 2        | 10           | 9.0  |
| 2        | 30           | 6.5  |

Agora:
- `notas` contém apenas o que depende da chave inteira.
- `alunos` e `disciplinas` existem independentemente.
- Não há redundância.

---

## 5. Em SQL

```sql
CREATE TABLE alunos (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE disciplinas (
    id            SERIAL PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    carga_horaria INTEGER
);

CREATE TABLE notas (
    aluno_id      INTEGER REFERENCES alunos(id),
    disciplina_id INTEGER REFERENCES disciplinas(id),
    nota          DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 10),
    PRIMARY KEY (aluno_id, disciplina_id)
);
```

---

## 6. Checklist da 2FN

- [ ] A tabela está na 1FN?
- [ ] A chave primária é simples? (se sim, já está na 2FN)
- [ ] A chave primária é composta? Se sim:
  - [ ] Cada atributo não-chave depende da chave **inteira**?
  - [ ] Nenhum atributo não-chave depende de apenas **parte** da chave?

---

## 7. O que memorizar

- 2FN elimina dependências **parciais** da chave.
- Só importa quando a chave é **composta**.
- Solução: separar os atributos com dependência parcial em tabelas próprias.
- Após a 2FN, pode ainda haver dependências transitivas → resolvidas na 3FN.

---

## 8. Resumo final

A Segunda Forma Normal garante que, em tabelas com chave composta, todos os atributos não-chave dependam da chave completa — não de apenas uma parte dela.

Isso elimina redundâncias que surgem quando informações de contextos diferentes são misturadas na mesma tabela.
