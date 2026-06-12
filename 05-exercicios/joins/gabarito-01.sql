-- ============================================
-- Gabarito — Exercícios de JOIN
-- ============================================

-- 1. Liste todos os pedidos com o nome do cliente.
SELECT c.nome AS cliente, p.id AS pedido, p.total, p.data_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.data_pedido;

-- 2. Liste todos os clientes e seus pedidos (incluindo quem nunca comprou).
SELECT c.nome AS cliente, p.id AS pedido, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
ORDER BY c.nome;

-- 3. Clientes que nunca fizeram um pedido.
SELECT c.nome
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- 4. Produtos com o nome da categoria.
SELECT p.nome AS produto, cat.nome AS categoria, p.preco
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
ORDER BY cat.nome, p.nome;

-- 5. Itens de cada pedido com detalhes.
SELECT
    c.nome          AS cliente,
    p.id            AS pedido,
    pr.nome         AS produto,
    ip.quantidade,
    ip.preco_unit
FROM pedidos p
INNER JOIN clientes c       ON p.cliente_id  = c.id
INNER JOIN itens_pedido ip  ON ip.pedido_id  = p.id
INNER JOIN produtos pr      ON ip.produto_id = pr.id
ORDER BY p.id, pr.nome;

-- 6. Produto mais caro de cada categoria.
SELECT cat.nome AS categoria, MAX(p.preco) AS preco_maximo
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY preco_maximo DESC;

-- 7. Pedidos de janeiro de 2024 com nome do cliente.
SELECT c.nome, p.id AS pedido, p.total, p.data_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE p.data_pedido BETWEEN '2024-01-01' AND '2024-01-31'
ORDER BY p.data_pedido;

-- 8. Quantidade de produtos por categoria.
SELECT cat.nome AS categoria, COUNT(p.id) AS total_produtos
FROM categorias cat
LEFT JOIN produtos p ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY total_produtos DESC;

-- 9. Cliente que gastou mais.
SELECT c.nome, SUM(p.total) AS total_gasto
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC
LIMIT 1;

-- 10. Produtos que nunca foram pedidos.
SELECT pr.nome
FROM produtos pr
LEFT JOIN itens_pedido ip ON ip.produto_id = pr.id
WHERE ip.id IS NULL;
