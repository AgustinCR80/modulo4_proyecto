
-------- SUBCONSULTAS CON WHERE ---------

-- Artistas que tengan más de un álbum
SELECT a."ArtistId" ,a."Name" 
FROM "Artist" AS a 
WHERE "ArtistId" IN (
		SELECT "ArtistId" 
		FROM "Album" 
		GROUP BY "ArtistId" 
		HAVING COUNT("AlbumId") >1);

-- Obtener las canciones que tengan un precio mayor a la media
SELECT "TrackId" , t."Name", "UnitPrice" 
FROM "Track" AS t 
WHERE "UnitPrice" > (
		SELECT AVG("UnitPrice")
		FROM "Track" AS t2);

-- Obtener los clientes los cuales realizaron compras por un valor mayor al
-- promedio de compras de todos los clientes
SELECT c."CustomerId", CONCAT(c."FirstName",' ', c."LastName" ) AS "Nombre_completo"
FROM "Customer" AS c 
WHERE "CustomerId" IN (
		SELECT  "CustomerId" 
		FROM "Invoice" AS i 
		GROUP BY "CustomerId" 
		HAVING SUM("Total") > (
		
			SELECT AVG("Total")	
			FROM "Invoice" AS i 
			)); 
	
			
-------- SUBCONSULTAS CON WHERE (Exist y Not Exist) ---------
			
-- Ver si existe algún album que contenga al menos una pista de tipo Rock
SELECT "AlbumId" , "Album"."Title" 
FROM "Album"
WHERE EXISTS (
		SELECT 1
		FROM "Track"  
		JOIN "Genre" 
		ON "Track"."GenreId" = "Genre"."GenreId"
		WHERE "Track"."AlbumId" = "Album"."AlbumId" AND 
		"Genre"."Name" = 'Rock');
		
-- Obtener los artistas que no tengan album asociado
SELECT "ArtistId" , "Artist"."Name" 
FROM "Artist" 
WHERE NOT EXISTS (
		SELECT 1
		FROM "Album"
		WHERE "Album"."ArtistId" = "Artist"."ArtistId" 
		);

-- Que clientes han realizado alguna compra
SELECT "CustomerId" , CONCAT("Customer"."FirstName", ' ', "Customer"."LastName") AS "Nombre"
FROM "Customer" 
WHERE EXISTS (
		SELECT 1
		FROM "Invoice"
		WHERE "Invoice"."CustomerId" = "Customer"."CustomerId" 
		);

-- Que clientes que no han realizado ninguna compra
SELECT "CustomerId" , CONCAT("Customer"."FirstName", ' ', "Customer"."LastName") AS "Nombre"
FROM "Customer" 
WHERE NOT EXISTS (
		SELECT 1
		FROM "Invoice"
		WHERE "Invoice"."CustomerId" = "Customer"."CustomerId" 
		);


-------- SUBCONSULTAS EN EL SELECT ---------

-- Obtener el número total de álbumes de cada artista
SELECT a."ArtistId" , a."Name" AS Nombre,
		(SELECT COUNT(al."AlbumId") 
		FROM "Album" AS al 
		WHERE al."ArtistId" = a."ArtistId"
		) AS "Total_Albumes"
FROM "Artist" AS a ;

-- Obtener el precio total de todas las pistas de cada album
SELECT a."AlbumId" , a."Title",
		(SELECT SUM(t."UnitPrice") 
		FROM "Track" AS t 
		WHERE t."AlbumId" = a."AlbumId"
		) AS "Precio_Total"
FROM "Album" AS a ;

-- Obtener el nombre del género de cada pista, ordenamos por Album
SELECT t."TrackId" , t."Name" AS "Nombre_pista", a."Title" AS "Título_album",
		(SELECT g."Name" 
		FROM "Genre" AS g 
		WHERE g."GenreId" = t."GenreId"	
		) AS "Nombre_género"
FROM "Track" AS t  
INNER JOIN "Album" AS a 
on t."AlbumId" = a."AlbumId"
ORDER BY a."Title";


-------- SUBCONSULTAS CON FROM ---------

-- Obtener el total de facturas por país
SELECT "BillingCountry" AS País, Total_Facturas
FROM (SELECT i."BillingCountry", COUNT(i."InvoiceId") AS Total_Facturas
	 FROM "Invoice" AS i 
	 GROUP BY I."BillingCountry") ;

SELECT i."BillingCountry" AS País, COUNT(i."InvoiceId") AS Total_Facturas
FROM "Invoice" AS i 
GROUP BY I."BillingCountry" ;

-- Obtener la suma de facturación por cliente
SELECT "CustomerId" , CONCAT("FirstName" ,' ', "LastName") AS Nombre, Total_facturacion
FROM (SELECT "Customer"."CustomerId",  "Customer"."FirstName", "Customer"."LastName", sum("Invoice"."Total") AS Total_facturacion 
	FROM "Customer"  
	JOIN "Invoice" 
	ON "Customer"."CustomerId" = "Invoice"."CustomerId" 
	GROUP BY "Customer"."CustomerId",  CONCAT("FirstName" , "LastName")
	) 
ORDER BY "CustomerId";

SELECT c."CustomerId" , CONCAT(c."FirstName", ' ', c."LastName") AS Nombre, SUM(i."Total") AS Total_facturacion  
FROM "Customer" AS c 
JOIN "Invoice" AS i 
ON c."CustomerId" = i."CustomerId" 
GROUP BY c."CustomerId" , CONCAT("FirstName", ' ', "LastName")
ORDER BY "CustomerId";
		
-- Obtener el total de pistas por álbum
SELECT "AlbumId", "Title", Numero_pistas
FROM 
	(SELECT "Album"."AlbumId", "Album"."Title", COUNT("Track"."TrackId") AS Numero_pistas
	FROM "Album"
	JOIN "Track" 
	ON "Album"."AlbumId" = "Track"."AlbumId" 
	GROUP BY "Album"."AlbumId", "Album"."Title")
ORDER BY "AlbumId";

SELECT a."AlbumId" , a."Title", COUNT(t."TrackId") AS Numero_pistas
FROM "Album" AS a 
JOIN "Track" AS t 
ON a."AlbumId" = t."AlbumId" 
GROUP BY a."AlbumId", a."Title" 
ORDER BY a."AlbumId" ;


		