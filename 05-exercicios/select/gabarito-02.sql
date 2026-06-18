-- ============================================
-- Gabarito — SELECT Nível 02
-- ============================================

-- 1. Cidades distintas.
SELECT DISTINCT cidade FROM clientes ORDER BY cidade;

-- 2. Produtos cujo nome contém "o".
SELECT nome FROM produtos WHERE nome LIKE '%o%';

-- 3. Produtos com preço entre 100 e 500.
SELECT nome, preco FROM produtos
WHERE preco BETWEEN 100 AND 500
ORDER BY preco;

-- 4. Clientes sem e-mail.
SELECT nome FROM clientes WHERE email IS NULL;

-- 5. Produtos das categorias 1 ou 3.
SELECT nome, categoria_id FROM produtos
WHERE categoria_id IN (1, 3)
ORDER BY categoria_id;

-- 6. Preço com 10% de aumento.
SELECT nome, preco, ROUND(preco * 1.10, 2) AS preco_reajustado
FROM produtos;

-- 7. Três produtos mais caros.
SELECT nome, preco FROM produtos
ORDER BY preco DESC
LIMIT 3;

-- 8. Ordenado por categoria e, dentro, por preço desc.
SELECT categoria_id, nome, preco FROM produtos
ORDER BY categoria_id ASC, preco DESC;

-- 9. Valor total em estoque por produto.
SELECT nome, preco * estoque AS valor_estoque
FROM produtos
ORDER BY valor_estoque DESC;

-- 10. Segundo produto mais caro.
SELECT nome, preco FROM produtos
ORDER BY preco DESC
LIMIT 1 OFFSET 1;
