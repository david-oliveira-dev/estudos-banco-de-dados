-- ============================================
-- Exercícios de SQL AVANÇADO — Nível 02 (CTE, window, CASE)
-- Use o banco: 04-sql-basico/scripts/criacao-tabelas-exemplo.sql
-- Teoria em: 06-sql-avancado/
-- ============================================

-- 1. (Window) Ranqueie os clientes por total gasto, do maior para o menor,
--    usando RANK.

-- 2. (Window) Para cada produto, mostre quanto ele representa (%) do estoque
--    total da loja (use SUM(estoque) OVER ()).

-- 3. (Window) Mostre cada produto, seu preço e a diferença para o preço médio
--    geral.

-- 4. (CTE + Window) Liste o produto mais caro de CADA categoria
--    (dica: ROW_NUMBER por categoria dentro de uma CTE e filtre posição = 1).

-- 5. (CASE) Classifique cada produto pelo estoque: 'sem estoque' (0),
--    'baixo' (1 a 10), 'ok' (acima de 10).

-- 6. (Window) Mostre os pedidos com uma contagem acumulada de pedidos ao longo
--    do tempo (1, 2, 3...).

-- 7. (CTE) Calcule a receita por categoria e mostre cada categoria com seu
--    percentual sobre a receita total.

-- 8. (CTE recursiva) Gere a tabuada do 3 (3, 6, 9, ... até 30).
