# Primeira Forma Normal (1FN)

## 1. O que é a 1FN?

Uma tabela está na **Primeira Forma Normal** quando:

1. Todos os atributos contêm apenas **valores atômicos** — indivisíveis, sem listas.
2. Não há **grupos repetitivos** de colunas.
3. Cada célula contém **um único valor**.

---

## 2. Violação: valores não atômicos

Um valor atômico é um valor que não pode ser dividido em partes menores com significado próprio.

### Exemplo com lista em uma célula

| matricula | nome  | telefones                  |
|-----------|-------|----------------------------|
| 2024001   | Ana   | 9999-1111, 8888-2222       |
| 2024002   | Bruno | 7777-3333                  |

O campo `telefones` contém mais de um valor na mesma célula.

**Viola a 1FN.**

### Correção

Separar os telefones em uma tabela própria:

```sql
-- Tabela principal
CREATE TABLE alunos (
    id        SERIAL PRIMARY KEY,
    matricula VARCHAR(10) UNIQUE NOT NULL,
    nome      VARCHAR(100) NOT NULL
);

-- Tabela de telefones
CREATE TABLE telefones_aluno (
    id        SERIAL PRIMARY KEY,
    aluno_id  INTEGER REFERENCES alunos(id),
    telefone  VARCHAR(20) NOT NULL
);
```

---

## 3. Violação: grupos repetitivos de colunas

Grupos repetitivos são colunas que armazenam dados do mesmo tipo, numeradas sequencialmente.

### Exemplo

| matricula | nome  | disc1  | nota1 | disc2    | nota2 | disc3 | nota3 |
|-----------|-------|--------|-------|----------|-------|-------|-------|
| 2024001   | Ana   | Banco  | 8.5   | Redes    | 7.0   | NULL  | NULL  |
| 2024002   | Bruno | Banco  | 9.0   | Prog.    | 6.5   | Mat.  | 7.5   |

Os pares `disc1/nota1`, `disc2/nota2`, `disc3/nota3` são grupos repetitivos.

**Viola a 1FN.**

### Problemas

- E se um aluno tiver 10 disciplinas? Precisaria de 10 pares de colunas.
- Cells NULL desperdiçam espaço.
- Consultas são complicadas: `WHERE disc1 = 'Banco' OR disc2 = 'Banco' OR disc3 = 'Banco'`.

### Correção

Transformar as linhas em colunas — cada disciplina/nota vira uma linha:

```sql
CREATE TABLE notas (
    id            SERIAL PRIMARY KEY,
    aluno_id      INTEGER REFERENCES alunos(id),
    disciplina_id INTEGER REFERENCES disciplinas(id),
    nota          DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 10)
);
```

---

## 4. Exemplo completo — antes e depois da 1FN

### Antes (violando 1FN)

| matricula | nome  | curso       | tel1      | tel2      | disc1 | nota1 | disc2 | nota2 |
|-----------|-------|-------------|-----------|-----------|-------|-------|-------|-------|
| 2024001   | Ana   | Informática | 9999-1111 | 8888-2222 | Banco | 8.5   | Redes | 7.0   |
| 2024002   | Bruno | Informática | 7777-3333 | NULL      | Banco | 9.0   | Prog. | 6.5   |

### Depois (na 1FN)

**Tabela alunos:**

| id | matricula | nome  | curso       |
|----|-----------|-------|-------------|
| 1  | 2024001   | Ana   | Informática |
| 2  | 2024002   | Bruno | Informática |

**Tabela telefones:**

| id | aluno_id | telefone  |
|----|----------|-----------|
| 1  | 1        | 9999-1111 |
| 2  | 1        | 8888-2222 |
| 3  | 2        | 7777-3333 |

**Tabela notas:**

| id | aluno_id | disciplina | nota |
|----|----------|------------|------|
| 1  | 1        | Banco      | 8.5  |
| 2  | 1        | Redes      | 7.0  |
| 3  | 2        | Banco      | 9.0  |
| 4  | 2        | Prog.      | 6.5  |

---

## 5. Checklist da 1FN

- [ ] Cada célula tem apenas um valor?
- [ ] Nenhuma coluna contém listas ou conjuntos?
- [ ] Não há pares de colunas numeradas (`col1`, `col2`, `col3`)?
- [ ] Cada linha é única (existe uma chave)?

Se todos os itens forem verdadeiros, a tabela está na 1FN.

---

## 6. O que memorizar

- 1FN exige valores atômicos — sem listas em células.
- 1FN elimina grupos repetitivos de colunas.
- A solução costuma ser criar uma tabela separada.
- Uma tabela na 1FN pode ainda ter problemas → veja a 2FN.

---

## 7. Resumo final

A Primeira Forma Normal exige que cada célula contenha um único valor indivisível e que não existam colunas que se repetem para o mesmo tipo de dado.

É o passo inicial da normalização, que transforma estruturas confusas em tabelas limpas e consultáveis.
