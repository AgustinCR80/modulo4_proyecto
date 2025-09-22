
-- Ordenar por orden alfabético de "LastName" (lo hace por defecto) 
-- las columnas "LastName" y "FirstName" de la tabla (Employee) y las concatenamos
SELECT CONCAT("LastName", ' ', "FirstName") AS "Nombre_completo", "Title" 
FROM "Employee" AS e 
ORDER BY "LastName";

-- Ordenar las columnas por "EmployeeId" descendente aunque no la mostremos 
-- en la consulta
SELECT CONCAT("LastName", ' ', "FirstName") AS "Nombre_completo", "Title" 
FROM "Employee" AS e 
ORDER BY "EmployeeId" DESC;

-- Ordenar por el alias de "Nombre_completo"
SELECT CONCAT("LastName", ' ', "FirstName") AS "Nombre_completo", "Title"
FROM "Employee" AS e 
ORDER BY "Nombre_completo" ;

-- Ordenar por "Titulo" de manera ascendente y por "fecha" en descendente
SELECT CONCAT("LastName", ' ', "FirstName") AS "Nombre_completo",
		"Title" AS "posicion",
		"BirthDate" AS "fecha_nacimiento"
FROM "Employee" AS e 
ORDER BY "Title", "BirthDate" DESC ;

-- Ordenar por "Titulo" de manera ascendente y por "fecha" en descendente 
-- donde el título sea 'Sales Support Agent' 
-- No se utilizan alias en el WHERE porque en el orden de ejecución de SQL 
-- el WHERE se llama antes que el SELECT
SELECT CONCAT("LastName", ' ', "FirstName") AS "Nombre_completo",
		"Title" AS "posicion",
		"BirthDate" AS "fecha_nacimiento"
FROM "Employee" AS e 
WHERE "Title" = 'Sales Support Agent'
ORDER BY "Title", "BirthDate" DESC ;

-- Seleccionar las 6 primeras canciones 
SELECT *
FROM "Track" AS t 
LIMIT 6;

-- Seleccionar las 6 primeras canciones ordenadas por milisegundos en orden descendente
SELECT *
FROM "Track" AS t 
ORDER BY "Milliseconds" DESC 
LIMIT 6;

-- Seleccionar las 6 primeras canciones ordenadas por milisegundos en orden 
-- ascendente mayores a 5000 ms
SELECT "Name" , "Milliseconds" , "UnitPrice" 
FROM "Track" AS t 
WHERE "Milliseconds" > 5000
ORDER BY "Milliseconds" 
LIMIT 6;

-- Seleccionar las 6 primeras canciones pero discrimina las dos primeras
SELECT *
FROM "Track" AS t 
LIMIT 6
OFFSET 2;

-- Seleccionar las canciones de la 5 a la 10
SELECT *
FROM "Track" AS t 
LIMIT 6
OFFSET 4;

-- Seleccionar por país cuantos clientes hay
SELECT "Country" AS "Pais", COUNT("CustomerId") AS "Numero_clientes"
FROM "Customer" AS c
GROUP BY "Country"
ORDER BY "Numero_clientes" DESC ;

-- Seleccionar por país cuantos clientes hay, solo los 5 primeros
SELECT "Country" AS "Pais", COUNT("CustomerId") AS "Numero_clientes"
FROM "Customer" AS c
GROUP BY "Country"
ORDER BY "Numero_clientes" DESC 
limit 5;

-- Seleccionar por país cuantos clientes hay, pero solo los que tengan más de 3 
SELECT "Country" AS "Pais", COUNT("CustomerId") AS "Numero_clientes"
FROM "Customer" AS c
GROUP BY "Country"
HAVING COUNT("CustomerId") > 3 
ORDER BY "Numero_clientes" DESC ;

-- Seleccionar por país cuantos clientes hay, pero solo los que tengan más de 3 
-- y no sean USA
SELECT "Country" AS "Pais", COUNT("CustomerId") AS "Numero_clientes"
FROM "Customer" AS c
WHERE "Country" NOT IN ('USA')
GROUP BY "Country"
HAVING COUNT("CustomerId") > 3 
ORDER BY "Numero_clientes" DESC ;

-- Mostrar las compras de cada cliente
SELECT c."CustomerId" , CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre", COUNT(i."CustomerId") AS "Compras" 
FROM "Customer" AS c 
INNER JOIN "Invoice" AS i 
ON c."CustomerId" = i."CustomerId" 
GROUP BY c."CustomerId", "Nombre" 
ORDER BY "Nombre";















