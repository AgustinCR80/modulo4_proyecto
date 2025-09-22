
-- Seleccionar nombres y apellidos de las tablas (Customer) y (Employee) que tengan relacion mediante PK y FK 
SELECT CONCAT(e."FirstName", ' ', e."LastName") AS "Nombre_empleado",
	   CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre_cliente"
FROM "Employee" AS e 
INNER JOIN "Customer" AS c
ON	e."EmployeeId" = c."SupportRepId"
ORDER BY "Nombre_empleado";

-- Seleccionar nombres y apellidos de las tablas (Customer) y (Employee) que tengan relacion mediante PK y FK, 
-- solamente seleccionar los de Roberto Almeida y Robert Brown
SELECT CONCAT(e."FirstName", ' ', e."LastName") AS "Nombre_empleado",
	   CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre_cliente"
FROM "Employee" AS e 
INNER JOIN "Customer" AS c
ON	e."EmployeeId" = c."SupportRepId"
WHERE CONCAT(c."FirstName", ' ', c."LastName") IN ('Roberto Almeida', 'Robert Brown')
ORDER BY "Nombre_empleado";

-- Seleccionar todos los empleados aunque no hayan atendido a ningún cliente
SELECT *
FROM "Employee" AS e 
LEFT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId"
ORDER BY e."EmployeeId" ;

-- Contar el número de clientes que ha sido atendido por cada unos de los empleados
SELECT COUNT("CustomerId") AS "Numero_clientes"
FROM "Employee" AS e 
LEFT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId"
GROUP BY e."EmployeeId" 
ORDER BY e."EmployeeId" ;

-- Contar el número de clientes que ha sido atendido por cada unos de los empleados, añadir el nombre del empleado
SELECT COUNT("CustomerId") AS "Numero_clientes",
	   CONCAT(e."FirstName", ' ', e."LastName") AS "Nombre_empleado"
FROM "Employee" AS e 
LEFT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId"
GROUP BY e."EmployeeId" 
ORDER BY e."EmployeeId" ;

-- Mostrar solamente a los empleados que no han atendido a ningún cliente
SELECT COUNT("CustomerId") AS "Numero_clientes",
	   CONCAT(e."FirstName", ' ', e."LastName") AS "Nombre_empleado"
FROM "Employee" AS e 
LEFT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId"
GROUP BY e."EmployeeId" 
HAVING COUNT("CustomerId") = 0
ORDER BY e."EmployeeId" ;

-- Mostrar los empleados que han atendido a clientes
SELECT COUNT("CustomerId") AS "Numero_clientes",
	   CONCAT(e."FirstName", ' ', e."LastName") AS "Nombre_empleado"
FROM "Employee" AS e 
LEFT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId"
GROUP BY e."EmployeeId" 
HAVING COUNT("CustomerId") > 0
ORDER BY e."EmployeeId" ;

-- Mostar a todos los clientes aunque no hayan sido atendidos por ningún empleado
SELECT *
FROM "Employee" AS e 
RIGHT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId" 
ORDER BY c."CustomerId" ;

-- Contar el numero de empleados que han atendido a cada uno de nuestros clientes
SELECT COUNT(e."EmployeeId") AS "Numero_empleados",
		c."CustomerId" 
FROM "Employee" AS e 
RIGHT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId" 
GROUP BY c."CustomerId" 
ORDER BY c."CustomerId" ;

-- Contar el numero de empleados que han atendido a cada uno de nuestros clientes, añadir el nombre del cliente
SELECT COUNT(e."EmployeeId") AS "Numero_empleados",
		CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre_cliente"
FROM "Employee" AS e 
RIGHT JOIN "Customer" AS c 
ON e."EmployeeId" = c."SupportRepId" 
GROUP BY c."CustomerId" 
ORDER BY c."CustomerId" ;

-- Combinar todas las filas de las tablas Empleados y clientes
SELECT *
FROM "Employee" AS e 
CROSS JOIN "Customer" AS c;

-- Obtener una lista entre clientes y facturas independientemente de si no hay relación entre las tablas
SELECT *
FROM "Customer" AS c 
FULL JOIN "Invoice" AS i 
ON C."CustomerId" = i."CustomerId";

-- La misma cunsulta que la anterior pero seleccionando algunas columnas
SELECT i."InvoiceId", 
		i."InvoiceDate", 
		i."Total", 
		CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre_cliente"  
FROM "Customer" AS c 
FULL JOIN "Invoice" AS i 
ON C."CustomerId" = i."CustomerId";

-- Calcular cuanto ha comprado cada cliente
SELECT 	CONCAT(c."FirstName", ' ', c."LastName") AS "nombre_cliente", 
		SUM(i."Total") AS "Total"
FROM "Invoice" AS i 
FULL JOIN "Customer" AS c 
ON i."CustomerId" = c."CustomerId" 
GROUP BY c."CustomerId" 
ORDER BY "nombre_cliente" ;


