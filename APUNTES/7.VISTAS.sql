-- Obtener el nombre de la canción y el artista
SELECT t."Name" AS Nombre_cancion, a2."Name" AS Nombre_artista
FROM "Track" AS t 
INNER JOIN "Album" AS a 
ON t."AlbumId" = a."AlbumId" 
INNER JOIN "Artist" AS a2 
ON a."ArtistId" = a2."ArtistId" ;

-- Crear una vista de la Query anterior
CREATE view tabla_canciones_artistas AS
	SELECT t."Name" AS Nombre_cancion, a2."Name" AS Nombre_artista
	FROM "Track" AS t 
	INNER JOIN "Album" AS a 
	ON t."AlbumId" = a."AlbumId" 
	INNER JOIN "Artist" AS a2 
	ON a."ArtistId" = a2."ArtistId" ;  

-- LLamar a la vista tabla_canciones_artistas
SELECT *
FROM TABLA_CANCIONES_ARTISTAS AS TCA ;