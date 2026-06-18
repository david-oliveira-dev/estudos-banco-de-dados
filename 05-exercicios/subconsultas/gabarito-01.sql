-- ============================================
-- Gabarito — Exercícios de SUBCONSULTAS
-- ============================================

-- 1. Produtos com preço acima da média geral.
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos)
ORDER BY preco DESC;

-- 2. Clientes que já fizeram pelo menos um pedido.
SELECT nome
FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos)
ORDER BY nome;

-- 3. Clientes que nunca fizeram um pedido.
SELECT nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);

-- 4. Produtos que nunca foram vendidos.
SELECT nome
FROM produtos pr
WHERE NOT EXISTS (
    SELECT 1 FROM itens_pedido ip WHERE ip.produto_id = pr.id
);

-- 5. Produto mais caro.
SELECT nome, preco
FROM produtos
WHERE preco = (SELECT MAX(preco) FROM produtos);

-- 6. Pedidos com total acima da média dos pedidos.
SELECT id, total
FROM pedidos
WHERE total > (SELECT AVG(total) FROM pedidos)
ORDER BY total DESC;

-- 7. Quantidade de pedidos por cliente (subconsulta correlacionada).
SELECT
    c.nome,
    (SELECT COUNT(*) FROM pedidos p WHERE p.cliente_id = c.id) AS qtd_pedidos
FROM clientes c
ORDER BY qtd_pedidos DESC, c.nome;

-- 8. Clientes que gastaram mais de 200 (subconsulta no FROM).
SELECT t.nome, t.total_gasto
FROM (
    SELECT c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
) AS t
WHERE t.total_gasto > 200
ORDER BY t.total_gasto DESC;

-- 9. Categorias com pelo menos um produto acima de 1000.
SELECT cat.nome
FROM categorias cat
WHERE EXISTS (
    SELECT 1 FROM produtos p
    WHERE p.categoria_id = cat.id AND p.preco > 1000
);

-- 10. Cliente que mais gastou.
SELECT c.nome, SUM(p.total) AS total_gasto
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome
HAVING SUM(p.total) = (
    SELECT MAX(soma) FROM (
        SELECT SUM(total) AS soma FROM pedidos GROUP BY cliente_id
    )
);
