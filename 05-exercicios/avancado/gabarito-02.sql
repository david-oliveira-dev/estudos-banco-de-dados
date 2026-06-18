-- ============================================
-- Gabarito — SQL AVANÇADO Nível 02
-- ============================================

-- 1. (Window) RANK de clientes por total gasto.
SELECT
    c.nome,
    SUM(p.total) AS total_gasto,
    RANK() OVER (ORDER BY SUM(p.total) DESC) AS posicao
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;

-- 2. (Window) Percentual de cada produto no estoque total.
SELECT
    nome,
    estoque,
    ROUND(100.0 * estoque / SUM(estoque) OVER (), 2) AS pct_estoque
FROM produtos
ORDER BY pct_estoque DESC;

-- 3. (Window) Preço x média geral.
SELECT
    nome,
    preco,
    ROUND(preco - AVG(preco) OVER (), 2) AS diferenca_media
FROM produtos
ORDER BY preco DESC;

-- 4. (CTE + Window) Produto mais caro de cada categoria.
WITH ranqueado AS (
    SELECT
        cat.nome AS categoria,
        pr.nome  AS produto,
        pr.preco,
        ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS pos
    FROM produtos pr
    INNER JOIN categorias cat ON cat.id = pr.categoria_id
)
SELECT categoria, produto, preco
FROM ranqueado
WHERE pos = 1
ORDER BY preco DESC;

-- 5. (CASE) Faixa de estoque.
SELECT
    nome,
    estoque,
    CASE
        WHEN estoque = 0           THEN 'sem estoque'
        WHEN estoque BETWEEN 1 AND 10 THEN 'baixo'
        ELSE 'ok'
    END AS situacao_estoque
FROM produtos
ORDER BY estoque;

-- 6. (Window) Contagem acumulada de pedidos no tempo.
SELECT
    id AS pedido,
    data_pedido,
    COUNT(*) OVER (ORDER BY data_pedido, id) AS pedidos_ate_aqui
FROM pedidos;

-- 7. (CTE) Receita por categoria e percentual sobre o total.
WITH receita_cat AS (
    SELECT cat.nome AS categoria, SUM(ip.quantidade * ip.preco_unit) AS receita
    FROM itens_pedido ip
    INNER JOIN produtos pr    ON pr.id = ip.produto_id
    INNER JOIN categorias cat ON cat.id = pr.categoria_id
    GROUP BY cat.id, cat.nome
)
SELECT
    categoria,
    receita,
    ROUND(100.0 * receita / (SELECT SUM(receita) FROM receita_cat), 2) AS pct_total
FROM receita_cat
ORDER BY receita DESC;

-- 8. (CTE recursiva) Tabuada do 3.
WITH RECURSIVE tabuada(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM tabuada WHERE n < 10
)
SELECT n, n * 3 AS resultado FROM tabuada;
