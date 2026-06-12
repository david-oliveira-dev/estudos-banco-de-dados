# Conceitos do Modelo Relacional

## 1. O que é o modelo relacional?

O modelo relacional é a forma mais usada de organizar dados em bancos de dados modernos.

Ele representa os dados como **tabelas**, também chamadas de **relações**.

Foi proposto por Edgar F. Codd em 1970 e desde então se tornou o padrão dominante para sistemas de banco de dados.

SGBDs como PostgreSQL, MySQL, MariaDB, Oracle e SQL Server são todos relacionais.

---

## 2. Tabela (Relação)

Uma tabela é uma estrutura formada por linhas e colunas.

Cada tabela representa um conjunto de informações sobre um mesmo assunto.

Exemplo — tabela de alunos:

| id | nome        | cidade    | ano_ingresso |
|----|-------------|-----------|--------------|
| 1  | Ana Lima    | Goiânia   | 2023         |
| 2  | Bruno Costa | Brasília  | 2024         |
| 3  | Carla Souza | São Paulo | 2022         |

Nessa tabela:
- cada **coluna** representa um tipo de dado (atributo);
- cada **linha** representa um registro específico (tupla).

---

## 3. Tupla (Linha)

Uma tupla é uma linha da tabela.

Ela representa um único registro — um objeto do mundo real.

No exemplo acima, a linha:

```
| 1 | Ana Lima | Goiânia | 2023 |
```

É uma tupla que representa a aluna Ana Lima.

Cada tabela contém zero ou mais tuplas.

---

## 4. Atributo (Coluna)

Um atributo é uma coluna da tabela.

Ele representa uma característica dos dados armazenados.

No exemplo acima, os atributos são:

- `id` — identificador único
- `nome` — nome do aluno
- `cidade` — cidade de origem
- `ano_ingresso` — ano em que o aluno ingressou

Cada atributo possui um **tipo de dado** associado, como texto, número inteiro ou data.

---

## 5. Domínio

O domínio é o conjunto de valores possíveis para um atributo.

Exemplos:

| Atributo | Domínio |
|---|---|
| nome | texto com até 100 caracteres |
| idade | número inteiro positivo menor que 150 |
| email | texto com formato de e-mail |
| data_nascimento | data válida entre 1900 e hoje |
| ativo | verdadeiro ou falso |

O domínio limita quais valores podem ser armazenados em um atributo.

Se uma coluna aceita apenas números inteiros, não é possível inserir letras.

---

## 6. Grau e cardinalidade

**Grau** é o número de atributos (colunas) de uma tabela.

**Cardinalidade** é o número de tuplas (linhas) de uma tabela.

Exemplo:

A tabela abaixo tem **grau 4** (quatro colunas) e **cardinalidade 3** (três linhas):

| id | nome        | cidade    | ano_ingresso |
|----|-------------|-----------|--------------|
| 1  | Ana Lima    | Goiânia   | 2023         |
| 2  | Bruno Costa | Brasília  | 2024         |
| 3  | Carla Souza | São Paulo | 2022         |

---

## 7. Esquema

O esquema é a definição da estrutura de uma tabela — seus atributos e tipos.

É a "planta" da tabela, não os dados em si.

Exemplo de esquema:

```
alunos(id, nome, cidade, ano_ingresso)
```

Ou em SQL:

```sql
CREATE TABLE alunos (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(100) NOT NULL,
    cidade       VARCHAR(50),
    ano_ingresso INTEGER
);
```

O esquema define a estrutura. As tuplas são os dados que preenchem essa estrutura.

---

## 8. Instância

A instância é o conjunto de dados que a tabela possui em um determinado momento.

O esquema raramente muda. A instância muda com frequência, à medida que dados são inseridos, alterados ou excluídos.

Exemplo:

- o **esquema** de `alunos` define que existem colunas `id`, `nome`, `cidade` e `ano_ingresso`;
- a **instância** de `alunos` são os registros que estão na tabela agora.

---

## 9. Comparação com planilha

Para quem está acostumado com planilhas, a comparação ajuda:

| Planilha (Excel/Sheets) | Banco de Dados Relacional |
|---|---|
| Arquivo `.xlsx` | Banco de dados |
| Aba (sheet) | Tabela |
| Cabeçalho | Atributos (esquema) |
| Linha | Tupla |
| Célula | Valor de um atributo em uma tupla |

A diferença principal é que o banco de dados aplica **regras e restrições**, garante **consistência**, suporta **múltiplos usuários simultâneos** e permite **relacionar tabelas** de forma estruturada.

---

## 10. O que memorizar

- O modelo relacional organiza os dados em tabelas.
- Tabela = relação.
- Linha = tupla = registro.
- Coluna = atributo.
- Domínio = conjunto de valores válidos para um atributo.
- Grau = número de colunas.
- Cardinalidade = número de linhas.
- Esquema = estrutura da tabela (definição).
- Instância = dados atuais da tabela.

---

## 11. Resumo final

O modelo relacional organiza informações em tabelas formadas por linhas e colunas.

Cada linha representa um registro do mundo real. Cada coluna representa uma característica desse registro.

Esse modelo é a base de praticamente todos os SGBDs modernos, como PostgreSQL, MySQL e Oracle.
