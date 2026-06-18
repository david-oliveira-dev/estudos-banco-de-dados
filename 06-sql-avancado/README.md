# Módulo 06 — SQL Avançado

Continuação do módulo 04 (SQL básico). Aqui estão os recursos que separam uma
consulta simples de uma análise de dados de verdade.

## Conteúdo

| Arquivo | Tema |
|---------|------|
| [subconsultas.md](subconsultas.md) | subqueries: escalar, `IN`, `EXISTS`, correlacionada, no `FROM` |
| [ctes.md](ctes.md) | `WITH`, CTEs encadeadas e recursivas |
| [views.md](views.md) | `CREATE VIEW`, views com agregação, quando usar |
| [indices-e-performance.md](indices-e-performance.md) | índices, índice composto/único, `EXPLAIN` |
| [funcoes-e-case.md](funcoes-e-case.md) | funções de texto/número/data, `COALESCE`, `CASE` |
| [window-functions.md](window-functions.md) | `OVER`, `PARTITION BY`, ranqueamento, total acumulado, `LAG/LEAD` |

## Pré-requisitos

- ter feito o módulo **04-sql-basico** (SELECT, JOIN, GROUP BY);
- ter o banco de exemplo criado a partir de
  `../04-sql-basico/scripts/criacao-tabelas-exemplo.sql`.

## Scripts prontos

A pasta [`scripts/`](scripts/) traz exemplos executáveis:

- `views-e-indices.sql` — cria views e índices úteis sobre o banco de loja.

## Praticando

Os exercícios deste módulo estão em
[`../05-exercicios/`](../05-exercicios/) nas pastas `subconsultas/` e `avancado/`.

Para conferir que todo o SQL do repositório funciona, rode (na raiz):

```bash
python3 scripts/testar_sql.py
```
