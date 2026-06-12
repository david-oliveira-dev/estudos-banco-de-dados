-- ============================================
-- Gabarito — Exercícios de SELECT
-- ============================================

-- 1. Liste todos os clientes cadastrados.
SELECT * FROM clientes;

-- 2. Liste apenas o nome e a cidade dos clientes.
SELECT nome, cidade FROM clientes;

-- 3. Liste todos os produtos com preço acima de R$ 100,00.
SELECT * FROM produtos WHERE preco > 100;

-- 4. Liste os produtos em ordem de preço, do mais barato ao mais caro.
SELECT * FROM produtos ORDER BY preco ASC;

-- 5. Liste os 3 produtos mais caros.
SELECT * FROM produtos ORDER BY preco DESC LIMIT 3;

-- 6. Liste os clientes que moram em Goiânia.
SELECT * FROM clientes WHERE cidade = 'Goiânia';

-- 7. Liste os produtos cujo nome contenha a letra 'o'.
SELECT * FROM produtos WHERE nome LIKE '%o%';

-- 8. Liste os clientes que não têm e-mail cadastrado.
SELECT * FROM clientes WHERE email IS NULL;

-- 9. Quantos clientes existem no total?
SELECT COUNT(*) AS total_clientes FROM clientes;

-- 10. Qual é o preço médio dos produtos?
SELECT ROUND(AVG(preco), 2) AS preco_medio FROM produtos;
