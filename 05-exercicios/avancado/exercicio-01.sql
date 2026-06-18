-- ============================================
-- Exercícios de SQL AVANÇADO (CTE, views, window functions, CASE)
-- Use o banco criado em: 04-sql-basico/scripts/criacao-tabelas-exemplo.sql
-- Teoria em: 06-sql-avancado/
-- Tente resolver antes de ver o gabarito!
-- ============================================

-- 1. (CTE) Usando WITH, calcule o total gasto por cliente e liste apenas os
--    clientes que gastaram acima da média de gasto dos clientes.

-- 2. (Window) Para cada produto, mostre o nome, o preço e o preço médio da sua
--    categoria (use AVG ... OVER (PARTITION BY ...)).

-- 3. (Window) Ranqueie os produtos por preço DENTRO de cada categoria, do mais
--    caro para o mais barato (use ROW_NUMBER).

-- 4. (Window) Mostre a receita acumulada dos pedidos ao longo do tempo
--    (ordenado por data).

-- 5. (CASE) Classifique cada produto em 'caro' (>= 1000), 'médio' (>= 100) ou
--    'barato' (< 100).

-- 6. (View) Crie uma view chamada vw_gastos_clientes com o total gasto por
--    cliente e depois liste os 3 que mais gastaram.

-- 7. (Window) Para cada pedido (ordenado por data), mostre o total do pedido
--    anterior usando LAG.

-- 8. (CTE recursiva) Gere uma sequência de números de 1 a 10.
