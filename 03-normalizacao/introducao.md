# Introdução à Normalização

## 1. O problema da tabela "bagunçada"

Imagine que uma escola guarda todas as informações dos alunos em uma única planilha:

| matricula | nome_aluno | curso     | coord_curso | tel1         | tel2         | disc1  | nota1 | disc2    | nota2 |
|-----------|------------|-----------|-------------|--------------|--------------|--------|-------|----------|-------|
| 2024001   | Ana Lima   | Informática | Prof. João  | 9999-1111    | 8888-2222    | Banco  | 8.5   | Redes    | 7.0   |
| 2024002   | Bruno Costa| Informática | Prof. João  | 7777-3333    | NULL         | Banco  | 9.0   | Prog.    | 6.5   |
| 2024003   | Carla Souza| Mecânica   | Prof. Maria | 5555-4444    | 4444-5555    | CNC    | 7.5   | Desenho  | 8.0   |

Essa tabela funciona, mas tem vários problemas:

### Problema 1 — Redundância

O nome do coordenador `Prof. João` aparece repetido para cada aluno de Informática.

Se o coordenador mudar, será necessário atualizar cada linha manualmente. Se uma linha for esquecida, o banco ficará com dados inconsistentes.

### Problema 2 — Campos multivalorados

Há colunas `tel1` e `tel2`. E se um aluno tiver três telefones? A estrutura não comporta.

### Problema 3 — Mistura de assuntos diferentes

A mesma tabela guarda informações de aluno, curso, coordenador, disciplina e nota. Isso mistura contextos diferentes e dificulta consultas.

### Problema 4 — Anomalias de atualização, inserção e exclusão

- **Anomalia de atualização:** alterar o coordenador exige atualizar várias linhas.
- **Anomalia de inserção:** não é possível cadastrar um curso sem ter pelo menos um aluno.
- **Anomalia de exclusão:** excluir o único aluno de um curso apaga os dados do curso junto.

---

## 2. O que é normalização?

Normalização é o processo de **reorganizar tabelas** para:

- eliminar redundâncias;
- eliminar dependências problemáticas;
- garantir que cada tabela trate de um único assunto;
- facilitar manutenção e consultas.

O processo foi desenvolvido por Edgar F. Codd junto com o modelo relacional.

---

## 3. Formas normais

A normalização é feita em etapas chamadas **formas normais** (FN):

| Forma Normal | O que elimina |
|---|---|
| 1FN | Grupos repetitivos e valores multivalorados |
| 2FN | Dependências parciais da chave primária |
| 3FN | Dependências transitivas |
| FNBC | Casos residuais da 3FN |
| 4FN e 5FN | Casos especiais mais avançados |

Na prática, chegar até a **3FN é suficiente** para a maioria dos projetos de banco de dados.

---

## 4. Benefícios da normalização

- Reduz duplicação de dados.
- Facilita atualizações — mudar um dado em um só lugar.
- Reduz anomalias de inserção, atualização e exclusão.
- Torna o banco mais consistente e confiável.
- Facilita consultas e manutenção.

---

## 5. Quando não normalizar?

Em alguns contextos — como análise de dados e data warehouses — tabelas **desnormalizadas** (com redundâncias controladas) são usadas intencionalmente para facilitar consultas analíticas e melhorar desempenho.

Esse conceito é chamado de **desnormalização**. Ele existe, mas é uma escolha consciente após dominar a normalização.

---

## 6. Pré-requisito: dependência funcional

Antes de estudar as formas normais, é necessário entender o conceito de **dependência funcional**.

Veja o arquivo [dependencia-funcional.md](dependencia-funcional.md).

---

## 7. O que memorizar

- Normalização organiza tabelas para eliminar redundâncias e inconsistências.
- Um banco mal normalizado sofre anomalias de inserção, atualização e exclusão.
- As formas normais são etapas: 1FN → 2FN → 3FN.
- Chegar à 3FN é suficiente na maioria dos projetos.

---

## 8. Resumo final

A normalização é a técnica que transforma tabelas mal estruturadas em tabelas bem organizadas.

Ela resolve problemas reais como dados duplicados, dificuldade de manutenção e inconsistências que surgem quando um banco cresce.

Entender normalização é uma das habilidades mais valorizadas em projetos de dados.
