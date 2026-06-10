-- ============================================
-- Banco de Dados de Exemplo: Loja
-- Use para praticar os exercícios do repositório
-- Compatível com SQLite, MySQL e PostgreSQL
-- ============================================

-- Clientes
CREATE TABLE clientes (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    nome      VARCHAR(100) NOT NULL,
    email     VARCHAR(100) UNIQUE,
    cidade    VARCHAR(50),
    criado_em DATE DEFAULT CURRENT_DATE
);

-- Categorias
CREATE TABLE categorias (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL
);

-- Produtos
CREATE TABLE produtos (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    nome         VARCHAR(100) NOT NULL,
    preco        DECIMAL(10,2) NOT NULL,
    estoque      INTEGER DEFAULT 0,
    categoria_id INTEGER,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Pedidos
CREATE TABLE pedidos (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id  INTEGER NOT NULL,
    data_pedido DATE DEFAULT CURRENT_DATE,
    total       DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Itens do Pedido
CREATE TABLE itens_pedido (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id  INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unit DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id)  REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- ============================================
-- Dados de Exemplo
-- ============================================

INSERT INTO categorias (nome) VALUES
('Eletrônicos'), ('Informática'), ('Acessórios');

INSERT INTO clientes (nome, email, cidade) VALUES
('Ana Lima',     'ana@email.com',    'Goiânia'),
('Bruno Costa',  'bruno@email.com',  'Brasília'),
('Carla Souza',  'carla@email.com',  'São Paulo'),
('Diego Mendes', 'diego@email.com',  'Goiânia'),
('Eva Rocha',     NULL,              'Cuiabá');

INSERT INTO produtos (nome, preco, estoque, categoria_id) VALUES
('Notebook',      3500.00, 10, 2),
('Mouse',           89.90, 50, 3),
('Teclado',        149.90, 30, 3),
('Monitor',       1200.00,  8, 1),
('Headset',        299.90, 20, 1),
('Cabo USB',        19.90, 100, 3);

INSERT INTO pedidos (cliente_id, data_pedido, total) VALUES
(1, '2024-01-10', 3589.90),
(2, '2024-01-15',  149.90),
(1, '2024-02-01',  299.90),
(3, '2024-02-10', 1289.90),
(4, '2024-03-05',   89.90);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unit) VALUES
(1, 1, 1, 3500.00),
(1, 2, 1,   89.90),
(2, 3, 1,  149.90),
(3, 5, 1,  299.90),
(4, 4, 1, 1200.00),
(4, 2, 1,   89.90),
(5, 2, 1,   89.90);
