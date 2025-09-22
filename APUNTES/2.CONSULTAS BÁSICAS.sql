-- Seleccionar todas las colunmas de Album
SELECT *
FROM "Album";

-- Seleccionar los géneros Id de las distintas canciones
SELECT "GenreId" 
FROM "Track"; 

-- Seleccionar los tipos de géneros y el Id de las canciones
SELECT *
FROM "Genre";

-- Seleccionar empleado con id = 3
SELECT *
FROM "Employee" 
WHERE "EmployeeId" = 3;

-- Seleccionar empleados cuya id sea mayor a 5
SELECT *
FROM "Employee" 
WHERE "EmployeeId" > 5;

-- Seleccionar empleados cuya id sea menor e igual a 5
SELECT *
FROM "Employee" 
WHERE "EmployeeId" <= 5;

-- Seleccionar empleados cuya id sea destinto de 5
SELECT *
FROM "Employee" 
WHERE "EmployeeId" <> 5;

-- Seleccionar empleados cuya fecha de nacimiento sea menor de 1970
SELECT "EmployeeId" , "FirstName" , "BirthDate" 
FROM "Employee" 
WHERE "BirthDate" < '1970-01-01';

-- Seleccionar empleados cuya ciudad se Calgary
SELECT *
FROM "Employee" 
WHERE "City" = 'Calgary';

-- Seleccionar empleados que sean de Calgary y Edmonton (No hay empleados en esta query)
SELECT "EmployeeId" , "FirstName" , "LastName", "City" 
FROM "Employee" 
WHERE "City" = 'Calgary' 
AND "City" = 'Edmonton';

-- Seleccionar empleados que sean de Calgary o de Edmonton 
SELECT "EmployeeId" , "FirstName" , "LastName", "City" 
FROM "Employee" 
WHERE "City" = 'Calgary' 
OR "City" = 'Edmonton';

-- Seleccionar empleados que sean de Calgary y reporten en 2
SELECT "EmployeeId" , "FirstName" , "LastName", "City","ReportsTo" 
FROM "Employee"
WHERE "City" = 'Calgary'
AND "ReportsTo" = 2;

-- Seleccionar empleados que se llamen Andrew o Steve o Nancy 
SELECT "EmployeeId" , "FirstName" , "LastName"
FROM "Employee" 
WHERE "FirstName" = 'Andrew' OR "FirstName" = 'Steve' OR "FirstName" = 'Nancy';

SELECT "EmployeeId" , "FirstName" , "LastName"
FROM "Employee" 
WHERE "FirstName" IN ('Andrew', 'Steve', 'Nancy');

-- Seleccionar empleados cuyo "EmployeeId" sea 3 o 5 o 7
SELECT "EmployeeId" , "FirstName" , "LastName"
FROM "Employee" 
WHERE "EmployeeId" IN (3, 5, 7);

-- Seleccionar empleados que no sean llamen Andrew o Steve o Nancy
SELECT "EmployeeId" , "FirstName" , "LastName"
FROM "Employee" 
WHERE "FirstName" NOT IN ('Andrew', 'Steve', 'Nancy');

-- Seleccionar empleados que tienen un "EmployeeId" entre el 3 y el 7
SELECT *
FROM "Employee" 
WHERE "EmployeeId" >= 3 AND "EmployeeId" <= 7;

SELECT *
FROM "Employee" 
WHERE "EmployeeId" BETWEEN 3 AND 7; -- between incluye los extremos

-- Seleccionar empleados cuyo "Firstname" empiece entre la A y la P
SELECT *
FROM "Employee" 
WHERE "FirstName" BETWEEN 'A' AND 'P';

-- Seleccionar empleados que sean de Calgary o de Edmonton UTILIZAMOS ALIAS
SELECT "EmployeeId" AS "IDENTIFICADOR" , "FirstName" AS "NOMBRE" , "LastName" AS "APELLIDO", "City" AS "CIUDAD" 
FROM "Employee" 
WHERE "City" = 'Calgary' 
OR "City" = 'Edmonton';










