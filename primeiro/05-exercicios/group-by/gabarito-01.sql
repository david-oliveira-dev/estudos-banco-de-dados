-- ============================================
-- Gabarito — Exercícios de GROUP BY e Agregação
-- ============================================

-- 1. Clientes por cidade.
SELECT cidade, COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade
ORDER BY total_clientes DESC;

-- 2. Valor total e ticket médio dos pedidos.
SELECT
    COUNT(*)              AS total_pedidos,
    SUM(total)            AS receita_total,
    ROUND(AVG(total), 2)  AS ticket_medio
FROM pedidos;

-- 3. Pedidos por cliente.
SELECT c.nome, COUNT(p.id) AS qtd_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY qtd_pedidos DESC;

-- 4. Preço médio por categoria.
SELECT cat.nome AS categoria, ROUND(AVG(p.preco), 2) AS preco_medio
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY preco_medio DESC;

-- 5. Categorias com mais de 1 produto.
SELECT cat.nome AS categoria, COUNT(p.id) AS qtd_produtos
FROM categorias cat
INNER JOIN produtos p ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
HAVING COUNT(p.id) > 1
ORDER BY qtd_produtos DESC;

-- 6. Cliente com mais pedidos.
SELECT c.nome, COUNT(p.id) AS qtd_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY qtd_pedidos DESC
LIMIT 1;

-- 7. Total arrecadado por mês (PostgreSQL).
SELECT
    EXTRACT(YEAR  FROM data_pedido) AS ano,
    EXTRACT(MONTH FROM data_pedido) AS mes,
    COUNT(*)                        AS pedidos,
    SUM(total)                      AS receita
FROM pedidos
GROUP BY ano, mes
ORDER BY ano, mes;

-- 7. Total arrecadado por mês (SQLite).
-- SELECT strftime('%Y', data_pedido) AS ano,
--        strftime('%m', data_pedido) AS mes,
--        COUNT(*) AS pedidos, SUM(total) AS receita
-- FROM pedidos
-- GROUP BY ano, mes
-- ORDER BY ano, mes;

-- 8. Produtos pedidos mais de uma vez.
SELECT pr.nome, SUM(ip.quantidade) AS total_pedido
FROM itens_pedido ip
INNER JOIN produtos pr ON ip.produto_id = pr.id
GROUP BY pr.id, pr.nome
HAVING SUM(ip.quantidade) > 1
ORDER BY total_pedido DESC;

-- 9. Valor total de estoque por categoria.
SELECT cat.nome AS categoria, SUM(p.preco * p.estoque) AS valor_estoque
FROM produtos p
INNER JOIN categorias cat ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY valor_estoque DESC;

-- 10. Cidades com clientes com e-mail.
SELECT cidade, COUNT(*) AS com_email
FROM clientes
WHERE email IS NOT NULL
GROUP BY cidade
ORDER BY com_email DESC;
