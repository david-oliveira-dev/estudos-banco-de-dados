-- ============================================
-- Views e Índices de exemplo (Módulo 06)
-- Pré-requisito: criar o banco com
--   04-sql-basico/scripts/criacao-tabelas-exemplo.sql
-- Compatível com SQLite (e, com pequenos ajustes, MySQL/PostgreSQL)
-- ============================================

-- --------------------------------------------
-- VIEWS
-- --------------------------------------------

-- Pedidos com o nome do cliente já resolvido
DROP VIEW IF EXISTS vw_pedidos_detalhados;
CREATE VIEW vw_pedidos_detalhados AS
SELECT
    p.id          AS pedido,
    c.nome        AS cliente,
    p.data_pedido,
    p.total
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- Resumo por cliente: quantos pedidos e quanto gastou
DROP VIEW IF EXISTS vw_resumo_clientes;
CREATE VIEW vw_resumo_clientes AS
SELECT
    c.id,
    c.nome,
    COUNT(p.id)               AS qtd_pedidos,
    COALESCE(SUM(p.total), 0) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;

-- Usando as views:
SELECT * FROM vw_pedidos_detalhados ORDER BY total DESC;
SELECT nome, total_gasto FROM vw_resumo_clientes ORDER BY total_gasto DESC;

-- --------------------------------------------
-- ÍNDICES
-- --------------------------------------------

-- Acelera buscas por email
CREATE INDEX IF NOT EXISTS idx_clientes_email ON clientes(email);

-- Acelera JOINs e filtros por cliente nos pedidos
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente ON pedidos(cliente_id);

-- Índice composto para a tabela de itens
CREATE INDEX IF NOT EXISTS idx_itens_pedido ON itens_pedido(pedido_id, produto_id);

-- Conferindo se um filtro usa o índice (SQLite):
EXPLAIN QUERY PLAN
SELECT * FROM pedidos WHERE cliente_id = 1;
