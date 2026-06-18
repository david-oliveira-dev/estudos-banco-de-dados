-- ============================================
-- Gabarito — GROUP BY Nível 02
-- ============================================

-- 1. Categorias com preço médio > 200.
SELECT cat.nome AS categoria, ROUND(AVG(p.preco), 2) AS preco_medio
FROM categorias cat
INNER JOIN produtos p ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
HAVING AVG(p.preco) > 200
ORDER BY preco_medio DESC;

-- 2. Clientes com mais de um pedido.
SELECT c.nome, COUNT(p.id) AS qtd_pedidos
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome
HAVING COUNT(p.id) > 1
ORDER BY qtd_pedidos DESC;

-- 3. Receita total por mês.
SELECT
    strftime('%Y-%m', data_pedido) AS mes,
    SUM(total)                     AS receita
FROM pedidos
GROUP BY mes
ORDER BY mes;

-- 4. Produto mais vendido (maior soma de quantidade).
SELECT pr.nome, SUM(ip.quantidade) AS total_vendido
FROM produtos pr
INNER JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY pr.id, pr.nome
ORDER BY total_vendido DESC
LIMIT 1;

-- 5. Ticket médio por cliente.
SELECT c.nome, ROUND(AVG(p.total), 2) AS ticket_medio
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY ticket_medio DESC;

-- 6. Categorias com estoque total > 50.
SELECT cat.nome AS categoria, SUM(p.estoque) AS estoque_total
FROM categorias cat
INNER JOIN produtos p ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
HAVING SUM(p.estoque) > 50
ORDER BY estoque_total DESC;

-- 7. Menor, maior e médio preço por categoria.
SELECT
    cat.nome AS categoria,
    MIN(p.preco)            AS menor_preco,
    MAX(p.preco)            AS maior_preco,
    ROUND(AVG(p.preco), 2)  AS preco_medio
FROM categorias cat
INNER JOIN produtos p ON p.categoria_id = cat.id
GROUP BY cat.id, cat.nome
ORDER BY categoria;

-- 8. Cidades com 2 ou mais clientes.
SELECT cidade, COUNT(*) AS qtd_clientes
FROM clientes
GROUP BY cidade
HAVING COUNT(*) >= 2
ORDER BY qtd_clientes DESC;
