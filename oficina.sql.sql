-- Criação do Banco de Dados
DROP DATABASE IF EXISTS oficina;
CREATE DATABASE oficina;
USE oficina;

-- Tabela Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela Veículos
CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa CHAR(7) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano YEAR,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela Mecânicos
CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    codigo_identificacao VARCHAR(10) UNIQUE
);

-- Tabela Serviços
CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    tempo_medio TIME,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela Ordens de Serviço
CREATE TABLE ordens_servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    status ENUM('Aberta', 'Em andamento', 'Concluída') DEFAULT 'Aberta',
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico)
);

-- Tabela de Relacionamento Serviços-Ordens
CREATE TABLE servicos_ordem (
    id_ordem INT,
    id_servico INT,
    PRIMARY KEY (id_ordem, id_servico),
    FOREIGN KEY (id_ordem) REFERENCES ordens_servico(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

-- Tabela Peças
CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela Fornecedores
CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    endereco VARCHAR(255)
);

-- Tabela de Relacionamento Peças-Fornecedores
CREATE TABLE pecas_fornecedor (
    id_peca INT,
    id_fornecedor INT,
    PRIMARY KEY (id_peca, id_fornecedor),
    FOREIGN KEY (id_peca) REFERENCES pecas(id_peca),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);
-- Inserção de dados de teste
INSERT INTO clientes (nome, cpf, telefone, email) VALUES
('João Silva', '12345678901', '(11) 9999-8888', 'joao@email.com'),
('Maria Souza', '98765432109', '(21) 7777-6666', 'maria@email.com');

INSERT INTO veiculos (id_cliente, placa, marca, modelo, ano) VALUES
(1, 'ABC1D23', 'Fiat', 'Palio', 2018),
(2, 'XYZ4E56', 'Volkswagen', 'Gol', 2020);

INSERT INTO mecanicos (nome, especialidade, codigo_identificacao) VALUES
('Carlos Oliveira', 'Motor', 'MEC001'),
('Ana Santos', 'Elétrica', 'MEC002');

INSERT INTO servicos (nome, descricao, preco) VALUES
('Troca de óleo', 'Troca de óleo e filtro', 150.00),
('Revisão elétrica', 'Verificação do sistema elétrico', 300.00);

INSERT INTO pecas (nome, preco, estoque) VALUES
('Filtro de óleo', 25.00, 50),
('Vela de ignição', 45.00, 30);

INSERT INTO ordens_servico (id_veiculo, id_mecanico, status) VALUES
(1, 1, 'Concluída'),
(2, 2, 'Em andamento');