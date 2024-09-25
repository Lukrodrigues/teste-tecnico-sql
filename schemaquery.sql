--1) Escreva uma query para listar todos os funcionários ativos, mostrando as colunas 
--id, nome, salario. Ordene o resultado pelo nome em ordem ascendente.


SELECT id_vendedor, nome, salario
FROM vendedores
WHERE inativo = 'false'
ORDER BY nome ASC;
