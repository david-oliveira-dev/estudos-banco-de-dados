-- ============================================
-- Gabarito — Exercícios de SQL AVANÇADO
-- ============================================

-- 1. (CTE) Clientes que gastaram acima da média de gasto.
WITH gastos AS (
    SELECT c.id, c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
)
SELECT nome, total_gasto
FROM gastos
WHERE total_gasto > (SELECT AVG(total_gasto) FROM gastos)
ORDER BY total_gasto DESC;

-- 2. (Window) Preço do produto x média da categoria.
SELECT
    cat.nome AS categoria,
    pr.nome  AS produto,
    pr.preco,
    ROUND(AVG(pr.preco) OVER (PARTITION BY pr.categoria_id), 2) AS media_categoria
FROM produtos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.id
ORDER BY categoria, pr.preco DESC;

-- 3. (Window) Ranque dos produtos por preço dentro da categoria.
SELECT
    cat.nome AS categoria,
    pr.nome  AS produto,
    pr.preco,
    ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS posicao
FROM produtos pr
INNER JOIN categorias cat ON pr.categoria_id = cat.id
ORDER BY categoria, posicao;

-- 4. (Window) Receita acumulada dos pedidos.
SELECT
    id AS pedido,
    data_pedido,
    total,
    SUM(total) OVER (ORDER BY data_pedido, id) AS receita_acumulada
FROM pedidos;

-- 5. (CASE) Faixa de preço de cada produto.
SELECT
    nome,
    preco,
    CASE
        WHEN preco >= 1000 THEN 'caro'
        WHEN preco >= 100  THEN 'médio'
        ELSE 'barato'
    END AS faixa
FROM produtos
ORDER BY preco DESC;

-- 6. (View) View de gastos por cliente + os 3 maiores.
DROP VIEW IF EXISTS vw_gastos_clientes;
CREATE VIEW vw_gastos_clientes AS
SELECT
    c.id,
    c.nome,
    COALESCE(SUM(p.total), 0) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;

SELECT nome, total_gasto
FROM vw_gastos_clientes
ORDER BY total_gasto DESC
LIMIT 3;

-- 7. (Window) Total do pedido anterior com LAG.
SELECT
    id AS pedido,
    data_pedido,
    total,
    LAG(total) OVER (ORDER BY data_pedido, id) AS total_anterior
FROM pedidos;

-- 8. (CTE recursiva) Sequência de 1 a 10.
WITH RECURSIVE numeros(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numeros WHERE n < 10
)
SELECT n FROM numeros;
