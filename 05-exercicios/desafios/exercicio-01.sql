-- ============================================
-- DESAFIOS — Nível avançado (problemas integrativos)
-- Combinam JOIN + GROUP BY + subconsultas + CTE + window functions.
-- Use o banco: 04-sql-basico/scripts/criacao-tabelas-exemplo.sql
-- São o tipo de pergunta que aparece em análise de dados e entrevistas.
-- ============================================

-- 1. Para cada categoria, qual o produto MAIS VENDIDO (maior soma de quantidade)?
--    Mostre categoria, produto e total vendido.

-- 2. Quanto cada cliente representa (%) da receita total da loja (com base no
--    total dos pedidos)? Ordene do maior para o menor.

-- 3. Receita por mês e o crescimento em relação ao mês anterior (use LAG).

-- 4. Para cada cliente: data do primeiro pedido, data do último pedido,
--    quantidade de pedidos e ticket médio.

-- 5. Ranking das categorias por receita (use RANK) e a receita acumulada
--    conforme se desce no ranking.

-- 6. Liste os clientes que compraram produtos de mais de uma categoria distinta.

-- 7. Curva ABC dos produtos por receita: classifique como 'A' (até 80% da
--    receita acumulada), 'B' (até 95%) ou 'C' (o resto). Mostre o percentual
--    acumulado de cada produto.

-- 8. Para cada produto, mostre o preço e quantos % ele está acima ou abaixo da
--    média de preço da sua categoria.
