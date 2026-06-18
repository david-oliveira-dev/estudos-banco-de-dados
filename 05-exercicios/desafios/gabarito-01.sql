-- ============================================
-- Gabarito — DESAFIOS (nível avançado)
-- ============================================

-- 1. Produto mais vendido de cada categoria.
WITH vendas AS (
    SELECT
        cat.id   AS cat_id,
        cat.nome AS categoria,
        pr.nome  AS produto,
        SUM(ip.quantidade) AS total_vendido
    FROM itens_pedido ip
    INNER JOIN produtos pr    ON pr.id = ip.produto_id
    INNER JOIN categorias cat ON cat.id = pr.categoria_id
    GROUP BY cat.id, cat.nome, pr.id, pr.nome
),
ranqueado AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY cat_id ORDER BY total_vendido DESC) AS pos
    FROM vendas
)
SELECT categoria, produto, total_vendido
FROM ranqueado
WHERE pos = 1
ORDER BY total_vendido DESC;

-- 2. Percentual de cada cliente na receita total.
WITH gastos AS (
    SELECT c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
)
SELECT
    nome,
    total_gasto,
    ROUND(100.0 * total_gasto / SUM(total_gasto) OVER (), 2) AS pct_receita
FROM gastos
ORDER BY total_gasto DESC;

-- 3. Receita por mês e crescimento vs mês anterior.
WITH por_mes AS (
    SELECT strftime('%Y-%m', data_pedido) AS mes, SUM(total) AS receita
    FROM pedidos
    GROUP BY mes
)
SELECT
    mes,
    receita,
    LAG(receita) OVER (ORDER BY mes)              AS receita_mes_anterior,
    receita - LAG(receita) OVER (ORDER BY mes)    AS crescimento
FROM por_mes
ORDER BY mes;

-- 4. Primeiro/último pedido, quantidade e ticket médio por cliente.
SELECT
    c.nome,
    MIN(p.data_pedido)     AS primeiro_pedido,
    MAX(p.data_pedido)     AS ultimo_pedido,
    COUNT(p.id)            AS qtd_pedidos,
    ROUND(AVG(p.total), 2) AS ticket_medio
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY qtd_pedidos DESC;

-- 5. Ranking de categorias por receita + receita acumulada.
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
    RANK() OVER (ORDER BY receita DESC)                 AS posicao,
    SUM(receita) OVER (ORDER BY receita DESC)           AS receita_acumulada
FROM receita_cat
ORDER BY receita DESC;

-- 6. Clientes que compraram em mais de uma categoria.
SELECT c.nome, COUNT(DISTINCT pr.categoria_id) AS categorias_distintas
FROM clientes c
INNER JOIN pedidos p       ON p.cliente_id = c.id
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
INNER JOIN produtos pr     ON pr.id = ip.produto_id
GROUP BY c.id, c.nome
HAVING COUNT(DISTINCT pr.categoria_id) > 1
ORDER BY categorias_distintas DESC;

-- 7. Curva ABC dos produtos por receita.
WITH receita_prod AS (
    SELECT pr.nome, SUM(ip.quantidade * ip.preco_unit) AS receita
    FROM itens_pedido ip
    INNER JOIN produtos pr ON pr.id = ip.produto_id
    GROUP BY pr.id, pr.nome
),
acumulado AS (
    SELECT
        nome,
        receita,
        SUM(receita) OVER (ORDER BY receita DESC) AS receita_acum,
        SUM(receita) OVER ()                      AS receita_total
    FROM receita_prod
)
SELECT
    nome,
    receita,
    ROUND(100.0 * receita_acum / receita_total, 1) AS pct_acumulado,
    CASE
        WHEN 100.0 * receita_acum / receita_total <= 80 THEN 'A'
        WHEN 100.0 * receita_acum / receita_total <= 95 THEN 'B'
        ELSE 'C'
    END AS classe
FROM acumulado
ORDER BY receita DESC;

-- 8. Quanto cada produto está acima/abaixo da média da categoria (%).
SELECT
    cat.nome AS categoria,
    pr.nome  AS produto,
    pr.preco,
    ROUND(
        100.0 * (pr.preco - AVG(pr.preco) OVER (PARTITION BY pr.categoria_id))
        / AVG(pr.preco) OVER (PARTITION BY pr.categoria_id),
        1
    ) AS pct_vs_media_categoria
FROM produtos pr
INNER JOIN categorias cat ON cat.id = pr.categoria_id
ORDER BY categoria, pct_vs_media_categoria DESC;
