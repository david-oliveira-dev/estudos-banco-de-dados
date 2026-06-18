# Módulo 05 — Exercícios

Pratique com exercícios organizados por tema. Sempre tente resolver antes de ver o gabarito.

## Estrutura

```
05-exercicios/
├── select/          ← SELECT, WHERE, ORDER BY (módulo 04)
├── joins/           ← INNER/LEFT JOIN (módulo 04)
├── group-by/        ← GROUP BY, HAVING, agregação (módulo 04)
├── subconsultas/    ← subqueries: IN, EXISTS, correlacionada (módulo 06)
└── avancado/        ← CTE, views, window functions, CASE (módulo 06)

Cada pasta tem:
  exercicio-01.sql   ← enunciados
  gabarito-01.sql    ← respostas
```

## Como usar

1. Crie o banco com `../04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.
2. Abra o arquivo de exercício do tema que quer praticar.
3. Tente escrever cada query antes de ver o gabarito.
4. Compare sua resposta com o gabarito — podem existir várias soluções corretas.
5. Para conferir que todos os gabaritos funcionam, rode na raiz do repositório:
   `python3 scripts/testar_sql.py`.

## Banco de dados dos exercícios

Todos os exercícios usam o banco de loja com as tabelas:

```
clientes → pedidos → itens_pedido ← produtos ← categorias
```
