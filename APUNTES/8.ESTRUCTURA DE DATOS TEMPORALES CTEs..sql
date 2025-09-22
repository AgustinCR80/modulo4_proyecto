
-------- CTEs intro ---------

-- CTEs (Common Table Expressions), también conocidas como expresiones de tabla común

-- Calcular el total de facturación por cliente usando una CTE, y luego seleccionar a los 
-- clientes que han gastado más de 40

WITH CustomerTotals AS (
		SELECT "CustomerId", SUM("Total") AS "Total_gastado"
		FROM "Invoice"
		GROUP BY "CustomerId")
		
SELECT "CustomerId", "Total_gastado"
FROM CustomerTotals
WHERE "Total_gastado" > 40
ORDER BY "CustomerId";

-- Obtengamos el total de pistas por álbum usando una CTE, y seleccionar los álbumes que tienen más de 10 pistas

WITH AlbumTrackCounts AS (
			select "AlbumId", COUNT("TrackId") AS "Numero_pistas" 
			FROM "Track" AS t 
			GROUP BY "AlbumId"
			)
SELECT "AlbumId", "Numero_pistas"  
FROM AlbumTrackCounts 
WHERE "Numero_pistas" > 10
ORDER BY "AlbumId";

-- Artistas con más de un álbum, la CTE ArtistAlbumCounts cuenta cuántos álbumes tiene cada artista. Luego, 
-- la consulta principal selecciona a los artistas que tienen más de un álbum.

 WITH ArtistAlbumCounts AS (
 			SELECT "Artist"."ArtistId", "Artist"."Name", COUNT("Album"."AlbumId") AS "Cantidad_albumes"
 			FROM "Artist"  
 			JOIN "Album" 
 			ON "Artist"."ArtistId" = "Album"."ArtistId"
 			GROUP BY "Artist"."ArtistId", "Artist"."Name"
 			)
 SELECT "ArtistId", "Name", "Cantidad_albumes"  -- No se pone "Artist"."ArtistId", "Artist"."Name"
 FROM ArtistAlbumCounts
 WHERE "Cantidad_albumes" > 1
 ORDER BY "ArtistId";
 
 
 -------- CTEs antes del SELECT ---------
 
 -- Obtengamos los clientes que se hayan gastado más de 30$
WITH ClientesGastadores AS (
 			SELECT i."CustomerId", SUM(i."Total") AS "Total_gastado"
 			FROM "Invoice" AS i
 			GROUP BY i."CustomerId"
 			),
ElegirClientes AS (		
 			SELECT "CustomerId", "Total_gastado"
 			FROM ClientesGastadores
 			WHERE "Total_gastado" > 30)
 
 SELECT c2."CustomerId", c2."FirstName", c."Total_gastado"
 from "Customer" AS c2 
 JOIN ElegirClientes AS c  -- No se pone entre comillas la CTE
 ON c2."CustomerId" = c."CustomerId";
 
 -- Otra forma de hacer la consulta con una CTE menos
 WITH ClientesGastadores AS (
 			SELECT i."CustomerId", SUM(i."Total") AS "Total_gastado"
 			FROM "Invoice" AS i
 			GROUP BY i."CustomerId"
 			HAVING SUM(i."Total") > 30
 			)
 
 SELECT c2."CustomerId", c2."FirstName", ClientesGastadores."Total_gastado"
 FROM "Customer" AS c2 
 JOIN ClientesGastadores -- No se pone entre comillas la CTE
 ON c2."CustomerId" = ClientesGastadores."CustomerId";
	
-- Obtengamos los álbumes con más de 5 canciones
WITH Albumes AS (
 		SELECT t."AlbumId", COUNT(t."TrackId") AS "Numero_canciones"
 		FROM "Track" AS t 
 		GROUP BY t."AlbumId"
 		),
 AlbumesElegidos AS ( 
 		SELECT "AlbumId", "Numero_canciones"
 		FROM Albumes
 		WHERE "Numero_canciones" > 5
 		)
SELECT a."AlbumId", a."Title", AlbumesElegidos."Numero_canciones"
FROM "Album" AS a 
JOIN AlbumesElegidos
ON a."AlbumId" = AlbumesElegidos."AlbumId";

-- Otra forma de hacer la consulta  
WITH AlbumesElegidos AS (
 		SELECT t."AlbumId", COUNT(t."TrackId") AS "Numero_canciones"
 		FROM "Track" AS t 
 		GROUP BY t."AlbumId"
 		HAVING COUNT(t."TrackId") > 5
 		)
SELECT a."AlbumId", a."Title", AlbumesElegidos."Numero_canciones"
FROM "Album" AS a 
JOIN AlbumesElegidos
ON a."AlbumId" = AlbumesElegidos."AlbumId"; 

-- Obtengamos los nombres de los artistas que tienen más de tres álbumes.
WITH Albumes AS (
		SELECT  "ArtistId", COUNT("AlbumId") AS "Numero_albumes"
		FROM "Album" AS a 
		GROUP BY "ArtistId"
		),
AlbumesElegidos AS (
		SELECT "ArtistId", "Numero_albumes"
		FROM Albumes
		WHERE "Numero_albumes" > 3
		)
SELECT a2."ArtistId", a2."Name", AlbumesElegidos."Numero_albumes"
FROM "Artist" AS a2 
JOIN AlbumesElegidos
ON a2."ArtistId" = AlbumesElegidos."ArtistId";

-- Otra forma de hacer la consulta 
WITH AlbumesElegidos AS (
		SELECT  "ArtistId", COUNT("AlbumId") AS "Numero_albumes"
		FROM "Album" AS a 
		GROUP BY "ArtistId"
		HAVING COUNT("AlbumId") > 3
		)
SELECT a2."ArtistId", a2."Name", AlbumesElegidos."Numero_albumes"
FROM "Artist" AS a2 
JOIN AlbumesElegidos
ON a2."ArtistId" = AlbumesElegidos."ArtistId";

-- Otra forma de hacer la consulta 
WITH Albumes AS (
		SELECT  "ArtistId", COUNT("AlbumId") AS "Numero_albumes"
		FROM "Album" 
		GROUP BY "ArtistId"
		),
InformacionArtistas AS (
		SELECT "ArtistId", "Name"
		FROM "Artist" 
		)
SELECT InformacionArtistas."Name", Albumes."Numero_albumes"
FROM Albumes
INNER JOIN InformacionArtistas
ON Albumes."ArtistId" = InformacionArtistas."ArtistId"
WHERE Albumes."Numero_albumes" > 3;


-------- CTEs al comienzo de una subconsulta ---------

-- Obtengamos los países cuyo total de ventas sea mayor de 100$
SELECT "BillingCountry", "Total_Ventas"
FROM (
	WITH VentasPaises AS (	
		SELECT "BillingCountry", SUM("Total") AS "Total_Ventas"
		FROM "Invoice" 
		GROUP BY "BillingCountry"
	)
	SELECT VentasPaises."BillingCountry", VentasPaises."Total_Ventas"
	FROM VentasPaises
	WHERE "Total_Ventas" > 100
) AS VentasAltasPaises;

-- Contar pistas de álbumes en una subconsulta para obtener aquellos con más de 3 pistas
SELECT a."AlbumId", "Title", "Cantidad_Pistas"
FROM (
	WITH AgruparAlbumes AS (
		SELECT "AlbumId", COUNT("TrackId") AS "Cantidad_Pistas" 
		FROM "Track" AS t
		GROUP BY "AlbumId"
	)
	SELECT "AlbumId", "Cantidad_Pistas" 
	FROM AgruparAlbumes
	WHERE "Cantidad_Pistas" > 3
) AS AlbumesSeleccionados
INNER JOIN "Album" AS a 
ON AlbumesSeleccionados."AlbumId" = a."AlbumId";
		
-- Obtengamos los clientes que gastaron más del promedio de facturación		
SELECT c."CustomerId", CONCAT("FirstName", ' ', "LastName") AS "Nombre_Completo"
FROM (
	WITH SeleccionarClientes AS (
	SELECT "CustomerId", SUM("Total") AS "Gasto_Cliente"
	FROM "Invoice" AS i 
	GROUP BY "CustomerId"
	) 
	SELECT "CustomerId"
	FROM  SeleccionarClientes
	WHERE "Gasto_Cliente" > (
		SELECT AVG("Total") AS "Promedio_Gasto"
		FROM "Invoice" AS i2 
	)			 
) AS ClientesMasGastadores
INNER JOIN "Customer" AS c 
ON ClientesMasGastadores."CustomerId" = c."CustomerId";

--La consulta anterior que además muestra el "Gasto_Cliente" y el "Promedio_Gasto"
WITH 
  GastoPorCliente AS (
    SELECT "CustomerId",
           SUM("Total") AS "Gasto_Cliente"
      FROM "Invoice"
     GROUP BY "CustomerId"
  ),
  PromedioGlobal AS (
    SELECT AVG("Gasto_Cliente") AS "Promedio_Gasto"
      FROM GastoPorCliente
  )
SELECT 
  c."CustomerId",
  CONCAT(c."FirstName", ' ', c."LastName") AS "Nombre_Completo",
  g."Gasto_Cliente",
  p."Promedio_Gasto"
FROM GastoPorCliente g
CROSS JOIN PromedioGlobal p
JOIN "Customer" c
  ON g."CustomerId" = c."CustomerId"
WHERE g."Gasto_Cliente" > p."Promedio_Gasto";


 -------- CTEs entre dos SELECT ---------

-- Calcular las ventas por país que superan un umbral de 100
WITH VentasPais AS (
		SELECT "BillingCountry", SUM("Total") AS "TotalVentas" 
		FROM "Invoice"
		GROUP BY "BillingCountry"
)
SELECT "BillingCountry", "TotalVentas"
FROM VentasPais
WHERE "TotalVentas" > 100
ORDER BY "TotalVentas";

-- Obtener los álbumes con más de 10 pistas
WITH AlbumesPistas AS (
		SELECT "AlbumId", COUNT("TrackId") AS "CantidadPistas"
		FROM "Track" AS t 
		GROUP BY "AlbumId"
) 	
SELECT "AlbumId", "CantidadPistas"
FROM AlbumesPistas
WHERE "CantidadPistas" > 10
ORDER BY "CantidadPistas";

-- La misma que la anterior
SELECT "AlbumId", COUNT("TrackId") AS "CantidadPistas"
FROM "Track" AS t 
GROUP BY "AlbumId"
HAVING COUNT("TrackId")  > 10
ORDER BY "CantidadPistas";

-- Obtener los clientes con más de una factura
WITH ClientesFacturas AS (
		SELECT "CustomerId", COUNT("InvoiceId") AS "CantidadFacturas"
		FROM "Invoice" AS i 
		GROUP BY "CustomerId"
)
SELECT "CustomerId", "CantidadFacturas"
FROM ClientesFacturas
WHERE "CantidadFacturas" > 1
ORDER BY "CantidadFacturas";


-------- Tablas temporales ---------

-- Almacenar y consultar las ventas totales por cliente
CREATE TEMPORARY TABLE TempVentasClientes AS
SELECT "CustomerId", SUM("Total") AS "TotalGastado"
FROM "Invoice" AS i 
GROUP BY "CustomerId";
 
-- Clientes con más de 20$ gastados
SELECT "CustomerId", "TotalGastado"
FROM TempVentasClientes
WHERE "TotalGastado" > 20;


-- Almacenar pistas de los álbumes de un artista y consultemos las pistas largas
CREATE TEMPORARY TABLE PistasAlbumesArtista AS 
SELECT t."TrackId", t."Name", t."Milliseconds" 
FROM "Track" AS t
JOIN "Album" AS a ON t."AlbumId" = a."AlbumId" 
JOIN "Artist" AS a2 ON a."ArtistId" = a2."ArtistId" 
WHERE a2."Name" = 'AC/DC';

-- Obtener las pistas con más de 300000 milisegundos 
SELECT "TrackId", "Name", "Milliseconds"
FROM PistasAlbumesArtista
WHERE "Milliseconds" > 300000;


-- Almacenamos los álbumes con más de 10 pistas y consultamos los álbumes más populares
CREATE TEMPORARY TABLE AlbumesConMuchasPistas AS 
SELECT a."AlbumId", a."Title", COUNT("Track"."TrackId") AS "NumeroPistas"
FROM "Album" AS a 
JOIN "Track" ON a."AlbumId" = "Track"."AlbumId"
GROUP BY a."AlbumId"
HAVING COUNT("Track"."TrackId") > 10;

-- Álbumes más populares
SELECT "AlbumId", "Title", "NumeroPistas"
FROM AlbumesConMuchasPistas
ORDER BY "AlbumId";