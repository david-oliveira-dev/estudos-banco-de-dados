-- ============================================
-- Gabarito — SUBCONSULTAS Nível 02
-- ============================================

-- 1. Produtos acima da média da própria categoria.
SELECT p.nome, p.preco
FROM produtos p
WHERE p.preco > (
    SELECT AVG(p2.preco) FROM produtos p2
    WHERE p2.categoria_id = p.categoria_id
)
ORDER BY p.preco DESC;

-- 2. Cliente(s) do pedido de maior valor.
SELECT c.nome, p.total
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
WHERE p.total = (SELECT MAX(total) FROM pedidos);

-- 3. Produtos mais caros que o mais caro de 'Acessórios'.
SELECT nome, preco
FROM produtos
WHERE preco > (
    SELECT MAX(preco) FROM produtos
    WHERE categoria_id = (SELECT id FROM categorias WHERE nome = 'Acessórios')
)
ORDER BY preco DESC;

-- 4. Clientes que gastaram acima da média.
SELECT t.nome, t.total_gasto
FROM (
    SELECT c.id, c.nome, SUM(p.total) AS total_gasto
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
) AS t
WHERE t.total_gasto > (
    SELECT AVG(soma) FROM (
        SELECT SUM(total) AS soma FROM pedidos GROUP BY cliente_id
    )
)
ORDER BY t.total_gasto DESC;

-- 5. Categorias sem nenhum produto vendido.
SELECT cat.nome
FROM categorias cat
WHERE NOT EXISTS (
    SELECT 1
    FROM produtos p
    INNER JOIN itens_pedido ip ON ip.produto_id = p.id
    WHERE p.categoria_id = cat.id
);

-- 6. Produtos com o segundo maior preço da loja.
SELECT nome, preco
FROM produtos
WHERE preco = (
    SELECT MAX(preco) FROM produtos
    WHERE preco < (SELECT MAX(preco) FROM produtos)
);

-- 7. Quantidade de produtos por categoria (correlacionada).
SELECT
    cat.nome,
    (SELECT COUNT(*) FROM produtos p WHERE p.categoria_id = cat.id) AS qtd_produtos
FROM categorias cat
ORDER BY qtd_produtos DESC;

-- 8. Produtos que aparecem em mais de um pedido distinto.
SELECT nome
FROM produtos
WHERE id IN (
    SELECT produto_id
    FROM itens_pedido
    GROUP BY produto_id
    HAVING COUNT(DISTINCT pedido_id) > 1
);
