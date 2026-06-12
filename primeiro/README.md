# Estudos de Banco de Dados

Repositório dedicado ao estudo de banco de dados, desde os conceitos fundamentais até a prática com SQL. Criado como parte da minha jornada de transição para a área de Ciência de Dados.

## Sobre mim

Físico, professor e entusiasta de dados. Estudo banco de dados para complementar minha base em Python e análise de dados, com foco em me tornar Cientista de Dados.

## Estrutura do repositório

```
estudos-banco-de-dados/
│
├── 01-conceitos-fundamentais/
│   ├── introducao.md              ← O que é BD, SGBD, SBD
│   ├── niveis-de-abstracao.md     ← Arquitetura ANSI/SPARC (externo, conceitual, interno)
│   ├── sgbd.md                    ← Propriedades, linguagens DDL/DML/DCL, vantagens
│   └── usuarios.md                ← DBA, projetistas, usuários finais, programadores
│
├── 02-modelo-relacional/
│   ├── conceitos.md               ← Tabela, tupla, atributo, domínio, esquema
│   ├── entidades-atributos-relacionamentos.md  ← ER, cardinalidade 1:1 / 1:N / N:M
│   ├── chaves.md                  ← PK, FK, candidata, composta, alternativa
│   ├── integridade-referencial.md ← CASCADE, RESTRICT, SET NULL, CHECK
│   ├── mapeamento.md              ← Do diagrama ER para tabelas SQL
│   └── modelos-historicos.md      ← Hierárquico, em rede, e por que o relacional venceu
│
├── 03-normalizacao/
│   ├── introducao.md              ← Por que normalizar, anomalias, benefícios
│   ├── dependencia-funcional.md   ← Total, parcial, transitiva
│   ├── 1fn.md                     ← Valores atômicos, sem grupos repetitivos
│   ├── 2fn.md                     ← Eliminar dependências parciais
│   ├── 3fn.md                     ← Eliminar dependências transitivas
│   └── exemplos-praticos.md       ← Normalização completa: nota fiscal e formulário
│
├── 04-sql-basico/
│   ├── select.md                  ← SELECT, WHERE, ORDER BY, LIMIT, DISTINCT
│   ├── joins.md                   ← INNER, LEFT, RIGHT, FULL JOIN
│   ├── group-by.md                ← GROUP BY, HAVING, COUNT/SUM/AVG/MAX/MIN
│   ├── insert-update-delete.md    ← INSERT, UPDATE, DELETE, TRUNCATE, transações
│   └── scripts/
│       └── criacao-tabelas-exemplo.sql  ← Banco de loja para praticar
│
├── 05-exercicios/
│   ├── select/
│   │   ├── exercicio-01.sql
│   │   └── gabarito-01.sql
│   ├── joins/
│   │   ├── exercicio-01.sql
│   │   └── gabarito-01.sql
│   └── group-by/
│       ├── exercicio-01.sql
│       └── gabarito-01.sql
│
└── resumos/
    └── sql-cheatsheet.md          ← Referência rápida de todos os comandos
```

## Tecnologias

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

## Roadmap de estudos

- [x] Conceitos fundamentais de banco de dados
- [x] Modelo relacional (tabelas, tuplas, atributos, domínio)
- [x] Entidades, atributos e relacionamentos (diagrama ER)
- [x] Chaves: primária, estrangeira, candidata, composta
- [x] Integridade referencial
- [x] Mapeamento ER para SQL
- [x] Modelos históricos: hierárquico e em rede
- [x] Normalização: dependência funcional, 1FN, 2FN, 3FN
- [x] SQL: SELECT, WHERE, ORDER BY, LIMIT
- [x] SQL: JOIN (INNER, LEFT, RIGHT, FULL)
- [x] SQL: GROUP BY, HAVING, funções de agregação
- [x] SQL: INSERT, UPDATE, DELETE, transações
- [ ] Subconsultas (subqueries) e CTEs
- [ ] Índices e performance
- [ ] Views e funções

## Como usar este repositório

1. Siga a ordem numérica das pastas (01 a 05).
2. Leia os arquivos `.md` antes de abrir os scripts `.sql`.
3. Tente resolver os exercícios antes de ver o gabarito.
4. Use `resumos/sql-cheatsheet.md` como referência rápida.
5. Para praticar, crie o banco com `04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

## Contato

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/david-oliveira-dev)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/david-oliveira-dev)
