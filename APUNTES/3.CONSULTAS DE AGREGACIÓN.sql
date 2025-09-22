
-- Seleccionar todo de la tabla "Invoice"
SELECT *
FROM "Invoice" AS i;

-- Seleccionar la columna "Total" la tabla "Invoice"
SELECT "Total" AS "Total_Facturas"
FROM "Invoice" AS i;

-- Seleccionar el valor mínimo de todos los registros de la columna "Total" la tabla "Invoice", solo muestra un valor mínimo aunque hayan repetidos
SELECT  MIN("Total") AS "Total_mínimo"
FROM "Invoice" AS i;

-- Con esta consulta muestra los repetidos
SELECT "Total" AS "Total_mínimo"
FROM "Invoice"
WHERE "Total" = (SELECT MIN("Total") FROM "Invoice");

-- Seleccionar el valor máximo de la columna "Total" la tabla "Invoice"
SELECT  MAX("Total") AS "Total_máximo"
FROM "Invoice" AS i;

-- Seleccionar el valor mínimo y máximo de la columna "Total" la tabla "Invoice"
SELECT MIN("Total") AS "Total_mínimo", MAX("Total") AS "Total_máximo"
FROM "Invoice" AS i;

-- Seleccionar los valores mínimos de la columna "Total" y su fecha de la tabla "Invoice"
SELECT "Total", "InvoiceDate" 
FROM "Invoice"
WHERE "Total" = (SELECT MIN("Total") FROM "Invoice");

-- Para obtener solo un único valor mínimo
SELECT "Total", "InvoiceDate"
FROM "Invoice"
WHERE "Total" = (SELECT MIN("Total") FROM "Invoice")
ORDER BY "InvoiceDate"
LIMIT 1;

-- Obtener el valor mínimo de cada fecha
SELECT  MIN("Total"), "InvoiceDate" 
FROM "Invoice" AS i
GROUP by "InvoiceDate";

-- Seleccionar la fecha más reciente
SELECT MAX("InvoiceDate") AS "Fecha_más_reciente"
FROM "Invoice" AS i;

-- Seleccionar la fecha más antigua
SELECT MIN("InvoiceDate") AS "Fecha_más_antigua"
FROM "Invoice" AS i;

-- Selecciona el primer país por orden alfabético
SELECT MIN("BillingCountry") AS "País"
FROM "Invoice" AS i;

-- Selecciona el último país por orden alfabético
SELECT MAX("BillingCountry") AS "País"
FROM "Invoice" AS i;

-- Contar el número de filas de la tabla (Invoice) que tienen valor, como por ejemplo "InvoiceId", count no cuenta los valores null
SELECT COUNT("InvoiceId") AS "Numero_facturas"
FROM "Invoice" AS i; 

-- Contar el número de filas que al menos tienen un valor, el resultado es el mismp que la consulta anterior
SELECT COUNT(*)
FROM "Invoice" AS i;

-- Contar el número de estados, devuelve menos cantidad que la consulta anterior porque tiene valores null
SELECT COUNT("BillingState") AS "Numero_estados" 
FROM "Invoice" AS i;

-- Mostrar los valores de una columna pero discriminando los repetidos, es decir, solo los cuenta una vez, también muestra null
SELECT DISTINCT "BillingState" AS "Estados"
FROM "Invoice" AS i; 

-- Mostrar los valores de una columna pero discriminando los repetidos, sin mostrar el null
SELECT DISTINCT "BillingState" AS "Estados"
FROM "Invoice" AS i 
WHERE "BillingState" IS NOT NULL ;
 
-- Contar los distintos estados de la tabla (Invoice), sin contar los repetidos, pero si cuenta el null
SELECT COUNT(DISTINCT "BillingState") AS "Numero_estados" 
FROM "Invoice" AS i; 

-- Contar los distintos estados de la tabla (Invoice), sin contar los repetidos y sin contar el null
SELECT COUNT(DISTINCT "BillingState") AS "Numero_estados" 
FROM "Invoice" AS i
WHERE "BillingState" IS NOT NULL ; 

-- Sumar todas las cantidades de la columna "Total"
SELECT SUM("Total") AS "Facturacion_total" 
FROM "Invoice" AS i;

-- Calcular la media de la columna "Total", no contabiliza los null
SELECT AVG("Total") AS "Media_Total" 
FROM "Invoice" AS i ;

-- Calcular la media de la columna "Total" y Redondear el resultado 
SELECT ROUND(AVG("Total")) AS "Media_total"
FROM "Invoice" AS i ;

-- Calcular la media de la columna "Total" y mostrar el resultado con dos decimales redondeando el último
SELECT ROUND(AVG("Total"),2) AS "Media_total"
FROM "Invoice" AS i ;

-- Calcular la desviación estandar de la columna "Total" y mostrar el resultado con dos decimales redondeando el último
SELECT ROUND(STDDEV("Total"),2) AS "Desviacion_estandar"
FROM "Invoice" AS i ;

-- Calcular la varianza de la columna "Total" y mostrar el resultado con dos decimales redondeando el último
SELECT ROUND(VARIANCE("Total"),2) AS "Varianza"
FROM "Invoice" AS i ;

-- Concatenar en una sola columna las columnas "FirstName" y "Lastname", utilizamos ' ' para generar un espacio 
SELECT CONCAT("FirstName", ' ', "LastName") AS "Nombre_cliente"
FROM "Customer" AS c ;

-- Concatenar en una sola columna las columnas "FirstName" y "Lastname", también se muestra la columna "CustomerId"
SELECT CONCAT("FirstName", ' ', "LastName") AS "Nombre_cliente", "CustomerId" AS "Identificador_cliente"
FROM "Customer" AS c ;

-- Podemos concatener columnas de tipo texto "Country" con columnas de tipo numérico "SupportRepId"
SELECT CONCAT("Country", ' ', "SupportRepId") 
FROM "Customer" AS c ;










