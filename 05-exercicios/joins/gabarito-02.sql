-- ============================================
-- Gabarito — JOIN Nível 02
-- ============================================

-- 1. Pedidos com os nomes dos produtos.
SELECT p.id AS pedido, pr.nome AS produto, ip.quantidade
FROM pedidos p
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
INNER JOIN produtos pr     ON pr.id = ip.produto_id
ORDER BY p.id, pr.nome;

-- 2. Quantidade total de itens por pedido.
SELECT p.id AS pedido, SUM(ip.quantidade) AS total_itens
FROM pedidos p
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY p.id
ORDER BY p.id;

-- 3. Receita por categoria.
SELECT cat.nome AS categoria, SUM(ip.quantidade * ip.preco_unit) AS receita
FROM itens_pedido ip
INNER JOIN produtos pr   ON pr.id = ip.produto_id
INNER JOIN categorias cat ON cat.id = pr.categoria_id
GROUP BY cat.id, cat.nome
ORDER BY receita DESC;

-- 4. Produtos distintos comprados por cliente.
SELECT c.nome, COUNT(DISTINCT ip.produto_id) AS produtos_distintos
FROM clientes c
INNER JOIN pedidos p       ON p.cliente_id = c.id
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY produtos_distintos DESC;

-- 5. Produtos nunca vendidos.
SELECT pr.nome
FROM produtos pr
LEFT JOIN itens_pedido ip ON ip.produto_id = pr.id
WHERE ip.id IS NULL;

-- 6. Cidade que mais gastou.
SELECT c.cidade, SUM(p.total) AS total_gasto
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.cidade
ORDER BY total_gasto DESC
LIMIT 1;

-- 7. Pedidos distintos por categoria.
SELECT cat.nome AS categoria, COUNT(DISTINCT ip.pedido_id) AS pedidos
FROM categorias cat
INNER JOIN produtos pr    ON pr.categoria_id = cat.id
INNER JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY cat.id, cat.nome
ORDER BY pedidos DESC;

-- 8. Produto mais caro (preco_unit) comprado por cada cliente.
SELECT c.nome AS cliente, MAX(ip.preco_unit) AS maior_preco_unit
FROM clientes c
INNER JOIN pedidos p       ON p.cliente_id = c.id
INNER JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY maior_preco_unit DESC;
