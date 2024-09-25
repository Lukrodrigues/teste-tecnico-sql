--1) Escreva uma query para listar todos os funcionários ativos, mostrando as colunas 
--id, nome, salario. Ordene o resultado pelo nome em ordem ascendente.


SELECT id_vendedor, nome, salario
FROM vendedores
WHERE inativo = 'false'
ORDER BY nome ASC;

--2)Escreva uma query para listar os funcionários que possuem um salário acima da 
--média salarial de todos os funcionários. A consulta deve mostrar as colunas id, nome, 
--e salario, ordenadas pelo salario em ordem descendente.

SELECT id_vendedor, nome, salario
FROM vendedores
WHERE salario > (SELECT AVG(salario) FROM vendedores)
ORDER BY salario DESC;

--3) Escreva uma query para listar todos os clientes e o valor total de pedidos já 
--transmitidos. A consulta deve retornar as colunas id, razao_social, total, ordenadas
-- pelo total em ordem descendente.

SELECT t.id_cliente AS id, t.razao_social, COALESCE(CAST(SUM(p.valor_total) AS INT), 0) AS total
FROM clientes t
LEFT JOIN pedido p ON t.id_cliente = p.id_cliente
GROUP BY t.id_cliente, t.razao_social
ORDER BY total DESC;

--4)Escreva uma query que retorne a situação atual de cada pedido da base. A consulta deve retornar as colunas id, valor, data e situacao. A situacao deve obedecer a seguinte regra:
--Se possui data de cancelamento preenchido: CANCELADO
--Se possui data de faturamento preenchido: FATURADO
--Caso não possua data de cancelamento e nem faturamento: PENDENTE

SELECT 
    s.id_pedido AS id,
    s.valor_total AS valor,
    s.data_emissao AS data,
    CASE 
        WHEN s.data_cancelamento IS NOT NULL THEN 'CANCELADO'
        WHEN s.data_faturamento IS NOT NULL THEN 'FATURADO'
        ELSE 'PENDENTE'
    END AS situacao
FROM pedido s;

--5-Escreva uma query que retorne o produto mais vendido ( em quantidade ), incluindo 
--o valor total vendido deste produto, quantidade de pedidos em que ele apareceu e 
--para quantos clientes diferentes ele foi vendido. A consulta deve retornar as 
--colunas id_produto, quantidade_vendida, total_vendido, clientes, pedidos. 
--Caso haja empate em quantidade de vendas, utilizar o total vendido como critério de 
--desempate.


SELECT 
    p.id_produto,
    CAST(SUM(pv.quantidade) AS INT) AS quantidade_vendida,
    CAST(SUM(pv.preco_praticado * pv.quantidade) AS INT) AS total_vendido,
    COUNT(DISTINCT pv.id_pedido) AS pedidos,
    COUNT(DISTINCT ped.id_cliente) AS clientes
FROM itens_pedido pv
JOIN pedido ped ON pv.id_pedido = ped.id_pedido
JOIN produtos p ON pv.id_produto = p.id_produto
GROUP BY p.id_produto
ORDER BY quantidade_vendida DESC, total_vendido DESC
LIMIT 1;


--Dúvidas:
--clientes: Contagem de clientes distintos que compraram o produto (COUNT(DISTINCT ped.id_cliente)).
--pedidos: Contagem de pedidos distintos nos quais o produto apareceu (COUNT(DISTINCT pv.id_pedido)).
--ordenação é feita pela quantidade total vendida (quantidade_vendida DESC).
--empate, o critério de desempate é o valor total vendido (total_vendido DESC).

