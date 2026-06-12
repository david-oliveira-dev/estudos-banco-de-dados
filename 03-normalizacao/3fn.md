# Terceira Forma Normal (3FN)

## 1. Pré-requisito

Para estar na 3FN, a tabela deve estar primeiro na **2FN**.

---

## 2. O que é a 3FN?

Uma tabela está na **Terceira Forma Normal** quando:

1. Está na 2FN.
2. Nenhum atributo não-chave depende **transitivamente** de outro atributo não-chave.

Em outras palavras: **todo atributo não-chave deve depender diretamente da chave, e apenas dela**.

---

## 3. Identificando o problema

### Exemplo — tabela de alunos com curso

| **matricula** | nome  | curso        | coord_curso  | sala_coord |
|---------------|-------|--------------|--------------|------------|
| 2024001       | Ana   | Informática  | Prof. João   | Sala 12    |
| 2024002       | Bruno | Informática  | Prof. João   | Sala 12    |
| 2024003       | Carla | Mecânica     | Prof. Maria  | Sala 08    |
| 2024004       | Diego | Mecânica     | Prof. Maria  | Sala 08    |

Chave primária: `matricula`.

Analisando as dependências:

```
matricula → nome            ✅ direto
matricula → curso           ✅ direto
matricula → coord_curso     ⚠️ transitivo: matricula → curso → coord_curso
matricula → sala_coord      ⚠️ transitivo: matricula → curso → coord_curso → sala_coord
```

`coord_curso` depende de `curso`, não diretamente de `matricula`.  
`sala_coord` depende de `coord_curso`, que depende de `curso`.

**Viola a 3FN.**

### Problemas causados

- `Prof. João` aparece repetido para cada aluno de Informática.
- Se o coordenador mudar de sala, é necessário atualizar várias linhas.
- Se todos os alunos de um curso forem excluídos, perde-se também os dados do coordenador.

---

## 4. Correção: decompor em tabelas

A solução é separar os atributos transitivos em suas próprias tabelas.

### Tabela: cursos

| id | nome         | coord_curso  | sala_coord |
|----|--------------|--------------|------------|
| 1  | Informática  | Prof. João   | Sala 12    |
| 2  | Mecânica     | Prof. Maria  | Sala 08    |

### Tabela: alunos

| matricula | nome  | curso_id |
|-----------|-------|----------|
| 2024001   | Ana   | 1        |
| 2024002   | Bruno | 1        |
| 2024003   | Carla | 2        |
| 2024004   | Diego | 2        |

Agora:
- `alunos` contém apenas dados do aluno e a FK para o curso.
- `cursos` contém os dados do coordenador e sala.
- Se o coordenador mudar de sala, atualiza-se apenas uma linha.

---

## 5. Em SQL

```sql
CREATE TABLE cursos (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    coordenador VARCHAR(100),
    sala        VARCHAR(20)
);

CREATE TABLE alunos (
    matricula  VARCHAR(10) PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    curso_id   INTEGER REFERENCES cursos(id)
);
```

---

## 6. Outro exemplo — tabela de pedidos com cidade

### Antes (viola 3FN)

| pedido_id | cliente | cidade      | estado |
|-----------|---------|-------------|--------|
| 1         | Ana     | Goiânia     | GO     |
| 2         | Bruno   | Brasília    | DF     |
| 3         | Carla   | Goiânia     | GO     |

`estado` depende de `cidade`, não de `pedido_id` diretamente.

```
pedido_id → cidade
cidade → estado     ← dependência transitiva
```

### Depois (3FN)

**Tabela: cidades**

| id | nome     | estado |
|----|----------|--------|
| 1  | Goiânia  | GO     |
| 2  | Brasília | DF     |

**Tabela: pedidos**

| pedido_id | cliente | cidade_id |
|-----------|---------|-----------|
| 1         | Ana     | 1         |
| 2         | Bruno   | 2         |
| 3         | Carla   | 1         |

---

## 7. Checklist da 3FN

- [ ] A tabela está na 2FN?
- [ ] Existe algum atributo não-chave que determina outro atributo não-chave?
- [ ] Todos os atributos não-chave dependem **apenas** da chave primária?

---

## 8. Comparação entre as três formas normais

| Forma Normal | O que verifica | O que elimina |
|---|---|---|
| 1FN | Valores atômicos, sem grupos repetitivos | Células com listas, colunas repetidas |
| 2FN | Dependências parciais (chave composta) | Atributos que dependem de parte da chave |
| 3FN | Dependências transitivas | Atributos que dependem de outros não-chave |

---

## 9. O que memorizar

- 3FN elimina dependências **transitivas**.
- Dependência transitiva: `A → B → C` onde B não é chave.
- Solução: separar os atributos transitivos em uma tabela própria, com FK.
- Após a 3FN, o banco está adequadamente normalizado para a maioria dos casos.

---

## 10. Resumo final

A Terceira Forma Normal garante que cada atributo não-chave dependa exclusivamente da chave primária — sem passar por outros atributos não-chave no caminho.

Junto com a 1FN e 2FN, a 3FN elimina as principais fontes de redundância e inconsistência em um banco de dados relacional.
