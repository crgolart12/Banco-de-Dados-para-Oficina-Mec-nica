-- 1. Listagem de clientes com veículos cadastrados (SELECT + JOIN)
SELECT 
    c.nome AS Cliente,
    v.placa AS Placa,
    CONCAT(v.marca, ' ', v.modelo) AS Veículo,
    v.ano AS Ano
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente
ORDER BY c.nome;

-- 2. Serviços mais caros que a média (WHERE + Subquery)
SELECT 
    nome AS Serviço,
    preco AS Preço
FROM servicos
WHERE preco > (SELECT AVG(preco) FROM servicos)
ORDER BY preco DESC;

-- 3. Mecânicos e suas especialidades com formatação (Expressão derivada)
SELECT 
    nome AS Mecânico,
    UPPER(especialidade) AS Especialidade,
    CONCAT('Código: ', codigo_identificacao) AS Identificação
FROM mecanicos
ORDER BY especialidade;