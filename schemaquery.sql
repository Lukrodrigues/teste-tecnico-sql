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

