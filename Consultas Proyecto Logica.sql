

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT TITLE, RATING		 
FROM FILM AS F 
WHERE RATING = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
SELECT ACTOR_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS "Nombre_Completo" 
FROM ACTOR AS A 
WHERE ACTOR_ID BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT FILM_ID, TITLE, LANGUAGE_ID 
FROM FILM AS F ;
WHERE LANGUAGE_ID = ORIGINAL_LANGUAGE_ID; 

-- 5. Ordena las películas por duración de forma ascendente.
SELECT FILM_ID, TITLE, LENGTH AS "Duracion"
FROM FILM AS F 
ORDER BY LENGTH ;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS "Nombre_Completo" 
FROM ACTOR AS A 
WHERE LAST_NAME = 'ALLEN';

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS "Nombre_Completo" 
FROM ACTOR AS A 
WHERE LAST_NAME IN ('ALLEN');

-- 7. Encuentra la cantidad total de películas en cada clasificación de 
-- 	  la tabla “film” y muestra la clasificación junto con el recuento.
SELECT RATING AS "Clasificacion", COUNT(FILM_ID) AS "Recuento"
FROM FILM AS F 
GROUP BY "Clasificacion";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
--    duración mayor a 3 horas en la tabla film.
SELECT TITLE, RATING AS "Clasificacion", LENGTH AS "Duracion"
FROM FILM AS F 
WHERE f.RATING IN ('PG-13') OR f.LENGTH > '180';

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE(REPLACEMENT_COST) AS "Variabilidad" 
FROM FILM AS F ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT  MAX(LENGTH) AS "Mayor_Duracion", MIN(LENGTH) AS "Menor_Duracion" 
FROM FILM AS F ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT AMOUNT AS "Precio"
FROM PAYMENT AS P 
ORDER BY PAYMENT_DATE DESC
LIMIT 1 OFFSET 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ 
--     ni ‘G’ en cuanto a su clasificación.
SELECT TITLE, RATING 
FROM FILM AS F 
WHERE RATING NOT IN ('NC-17', 'G')
ORDER BY RATING;

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de 
--     la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT RATING AS "Clasificacion", ROUND(AVG(LENGTH),2)  AS "Promedio_Duracion"
FROM FILM AS F 
GROUP BY "Clasificacion"
ORDER BY "Clasificacion";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT TITLE, LENGTH 
FROM FILM AS F 
WHERE LENGTH > 180
ORDER BY LENGTH ;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(AMOUNT) AS "Total"
FROM PAYMENT AS P ;

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT CUSTOMER_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS "Nombre_Completo"
FROM CUSTOMER AS C 
ORDER BY CUSTOMER_ID DESC 
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película 
--     con título ‘Egg Igby’.
SELECT CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME ) AS "Nombre_Completo", F.TITLE 
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
INNER JOIN FILM AS F 
ON FA.FILM_ID = F.FILM_ID 
WHERE F.TITLE IN ('EGG IGBY')
ORDER BY "Nombre_Completo";

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT TITLE 
FROM FILM AS F ;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración 
--     mayor a 180 minutos en la tabla “film”.
SELECT F.TITLE AS"Titulo", C."name" AS "Categoria", F.LENGTH AS "Duracion" 
FROM FILM AS F 
INNER JOIN FILM_CATEGORY AS FC 
ON F.FILM_ID = FC.FILM_ID 
INNER JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" IN ('Comedy')
ORDER BY F.TITLE;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración 
--     superior a 110 minutos y muestra el nombre de la categoría junto con el 
--     promedio de duración.

SELECT C."name" AS "Nombre_Categoria", AVG(F.LENGTH) AS "Promedio_Duracion" 
FROM CATEGORY AS C
INNER JOIN FILM_CATEGORY AS FC 
ON C.CATEGORY_ID = FC.CATEGORY_ID 
INNER JOIN FILM AS F 
ON FC.FILM_ID = F.FILM_ID 
GROUP BY C."name"
HAVING AVG(F.LENGTH) > 110
ORDER BY "Promedio_Duracion" ;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(F.RENTAL_DURATION) AS "Promedio_duración_alquiler" 
FROM FILM AS F ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y
--	   actrices.
SELECT CONCAT(A.first_name, ' ', A.last_name) AS "Nombre_completo"
FROM ACTOR AS A 
ORDER BY A.first_name;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de
--	   forma descendente. 
SELECT COUNT(R.RENTAL_ID) AS "Cantidad_alquileres", R.RENTAL_DATE AS "Fecha_alquiler"
FROM RENTAL AS R  
GROUP BY "Fecha_alquiler"
ORDER BY "Cantidad_alquileres" DESC ;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT F.TITLE AS "Peliculas", F.LENGTH AS "Duración"
FROM FILM AS F 
WHERE F.LENGTH > (
	SELECT AVG(LENGTH)
	FROM FILM)
ORDER BY F.TITLE ;

-- En la siguiente consulta se muestra la columna del promedio anidando un select dentro del select
SELECT F.TITLE AS Peliculas, F.LENGTH AS Duracion,
  (SELECT AVG(LENGTH) FROM FILM) AS Duracion_Promedio
FROM FILM AS F
WHERE F.LENGTH > (
	SELECT AVG(LENGTH) 
	FROM FILM)
ORDER BY F.TITLE ;

-- 25. Averigua el número de alquileres registrados por mes.
-- Se utiliza EXTRACT() para obtener el número del mes.
SELECT COUNT(R.RENTAL_ID), EXTRACT(MONTH FROM R.RENTAL_DATE) AS "Mes"
FROM RENTAL AS R 
GROUP BY "Mes"
ORDER BY "Mes";

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT AVG(P.AMOUNT) AS "Promedio", STDDEV(P.AMOUNT) AS "Desviación _estandar", VARIANCE(P.AMOUNT) AS "Varianza" 
FROM PAYMENT AS P ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT F.TITLE AS "Título", F.RENTAL_RATE AS "Tarifa_alquiler", 
	(SELECT AVG(F.RENTAL_RATE) -- Para mostrar la columna del precio medio
	FROM FILM AS F) AS "Precio_medio"
FROM FILM AS F 
WHERE RENTAL_RATE > (
	SELECT AVG(F2.RENTAL_RATE)
	FROM FILM AS F2)
GROUP BY "Título", "Tarifa_alquiler" 
ORDER BY "Tarifa_alquiler" ;

-- 28. Muestra el id de los actores que hayan participado en más de 40
--	   películas.
SELECT FA.ACTOR_ID
FROM FILM_ACTOR AS FA 
GROUP BY FA.ACTOR_ID
HAVING COUNT(FA.ACTOR_ID) > 40 
ORDER BY FA.ACTOR_ID ;

-- 29. Obtener todas las películas y, si están disponibles en el inventario,
--     mostrar la cantidad disponible.
SELECT F.TITLE AS "Título", COUNT(I.FILM_ID) AS "Cantidad_Inventario"
FROM FILM AS F
LEFT JOIN INVENTORY AS I -- Utilizamos left join para mostrar todas las películas con o sin inventario
ON F.FILM_ID = I.FILM_ID 
GROUP BY I.FILM_ID, "Título"
ORDER BY "Cantidad_Inventario" DESC ;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
SELECT CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME) AS "Nombre completo", COUNT(f.FILM_ID) AS "Cantidad_peliculas" 
FROM ACTOR AS A 
JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
JOIN FILM AS F 
ON FA.FILM_ID = F.FILM_ID 
GROUP BY CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME)
ORDER BY "Cantidad_peliculas" DESC ;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en
--	   ellas, incluso si algunas películas no tienen actores asociados.
SELECT F.TITLE AS "Título", CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre completo" 
FROM FILM AS F 
LEFT JOIN FILM_ACTOR AS FA 
ON F.FILM_ID = FA.FILM_ID 
LEFT JOIN ACTOR AS A 
ON FA.ACTOR_ID = A.ACTOR_ID 
ORDER BY F.TITLE;
-- GROUP BY F.TITLE, CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME): al no estar usando agregaciones 
-- (como COUNT, MAX, AVG, etc.), no es necesario agrupar.

-- 32. Obtener todos los actores y mostrar las películas en las que han
--	   actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre completo" , F.TITLE AS "Título" 
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
LEFT JOIN FILM AS F 
ON FA.FILM_ID = F.FILM_ID  
ORDER BY "Nombre completo";
-- GROUP BY CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME), F.TITLE: al no estar usando agregaciones 
-- (como COUNT, MAX, AVG, etc.), no es necesario agrupar.

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT F.TITLE AS "Título", R.*
FROM FILM AS F 
LEFT JOIN INVENTORY AS I 
ON F.FILM_ID = I.FILM_ID 
LEFT JOIN RENTAL AS R 
ON I.INVENTORY_ID = R.INVENTORY_ID 
ORDER BY "Título";

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
-- Solo se muestran los nombres:
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_cliente"
FROM CUSTOMER AS C 
JOIN PAYMENT AS P 
ON C.CUSTOMER_ID = P.CUSTOMER_ID 
GROUP BY C.CUSTOMER_ID, CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) 
ORDER BY SUM(P.AMOUNT) DESC 
LIMIT 5; 

-- En esta consulta mostramos también la cantidad:
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_cliente", SUM(P.AMOUNT) AS "Total_gastado"
FROM CUSTOMER AS C 
JOIN PAYMENT AS P 
ON C.CUSTOMER_ID = P.CUSTOMER_ID 
GROUP BY C.CUSTOMER_ID, CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) 
ORDER BY "Total_gastado" DESC 
LIMIT 5; 

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT A.FIRST_NAME, A.LAST_NAME 
FROM ACTOR AS A 
WHERE A.FIRST_NAME = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
SELECT A.FIRST_NAME AS "Nombre", A.LAST_NAME AS "Apellido" 
FROM ACTOR AS A 
WHERE A.FIRST_NAME = 'JOHNNY';

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT MIN(A.ACTOR_ID ) AS "ID_más_bajo", MAX(A.ACTOR_ID ) AS "ID_más_alto"
FROM ACTOR AS A;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
SELECT COUNT(A.ACTOR_ID) AS "Número_actores"
FROM ACTOR AS A ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME) 
FROM ACTOR AS A 
ORDER BY A.LAST_NAME ;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
SELECT F.TITLE AS "Título"
FROM FILM AS F 
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
--	   ¿Cuál es el nombre más repetido?
SELECT A.FIRST_NAME AS "Nombre", COUNT(A.FIRST_NAME) AS "Cantidad_repetida"
FROM ACTOR AS A 
GROUP BY A.FIRST_NAME 
ORDER BY "Cantidad_repetida" DESC 
LIMIT 1; 

-- He buscado cuál sería la consulta para saber cuales son los más repetidos al haber 3 empatados
SELECT
  A.FIRST_NAME AS Nombre,
  COUNT(*)       AS Cantidad_repetida
FROM ACTOR AS A
GROUP BY A.FIRST_NAME
HAVING COUNT(*) = (			-- La subconsulta interna (sub) agrupa por FIRST_NAME y devuelve 
  SELECT MAX(cnt) FROM (    -- un recuento por nombre.
    SELECT COUNT(*) AS cnt  -- El SELECT MAX(cnt) obtiene el valor más alto de esos recuentos.
    FROM ACTOR			   	-- El HAVING COUNT(*) = (valor máximo) filtra solo los nombres con esa 
    GROUP BY FIRST_NAME	    -- frecuencia máxima, incluye los empatados más repetidos
  ) AS sub
)
ORDER BY Nombre;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT *, CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_completo"  
FROM RENTAL AS R 
JOIN CUSTOMER AS C 
ON R.CUSTOMER_ID = C.CUSTOMER_ID ;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_completo", R.* -- Hay que utilizar el alias de Rental
FROM RENTAL AS R 
LEFT JOIN CUSTOMER AS C 
ON R.CUSTOMER_ID = C.CUSTOMER_ID ; 

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT *
FROM FILM AS F 
CROSS JOIN CATEGORY AS C ;
-- ¿Aporta valor esta consulta?¿Por qué?
-- En mi opinión NO. ¿De qué nos sirve crear una tabla para relacionar cada película con todas las categorías?. Lo único que me aporta es saber el número total de combinaciones posibles.
-- Lo importante es realizar una consuta relacionando cada película con sus categorías mediante la tabla film_category.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo", C.name AS "Categoria"
FROM ACTOR AS A 
JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
JOIN FILM AS F 
ON FA.FILM_ID = F.FILM_ID 
JOIN FILM_CATEGORY AS FC 
ON F.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" = 'Action'
GROUP BY A.ACTOR_ID, "Nombre_completo", "Categoria"
ORDER BY "Nombre_completo" ;

-- Podemos saltarnos el JOIN de la tabla Film, porque se pueden relacionar directamente film_actor y film_category.
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo", C.name AS "Categoria"
FROM ACTOR AS A 
JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
JOIN FILM_CATEGORY AS FC 
ON FA.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" = 'Action'
GROUP BY A.ACTOR_ID, "Nombre_completo", "Categoria"
ORDER BY "Nombre_completo" ;

-- 46. Encuentra todos los actores que no han participado en películas.
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo"
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
WHERE A.ACTOR_ID IS NULL ;

-- La resolvemos con una subconsulta NOT EXISTS en el WHERE
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo"
FROM ACTOR AS A 
WHERE NOT EXISTS (
		SELECT 1
		FROM FILM_ACTOR AS FA 
		WHERE FA.ACTOR_ID = A.ACTOR_ID
		);

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado. 
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo", COUNT(FA.FILM_ID) AS "Cantidad_películas" 
FROM ACTOR AS A 
JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
GROUP BY A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME 
ORDER BY "Cantidad_películas" ;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número 
-- 	   de películas en las que han participado.
CREATE VIEW "actor_num_peliculas" AS
	SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo", COUNT(FA.FILM_ID) AS "Cantidad_películas" 
	FROM ACTOR AS A 
	JOIN FILM_ACTOR AS FA 
	ON A.ACTOR_ID = FA.ACTOR_ID 
	GROUP BY A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME 
	ORDER BY "Cantidad_películas" ;

-- Llamamos a la vista para que se ejecute la consulta:
SELECT *
FROM "actor_num_peliculas" AS anp ;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_completo", COUNT(R.RENTAL_ID) AS "Número_alquileres"
FROM CUSTOMER AS C 
LEFT JOIN RENTAL AS R  -- Nos aseguramos de que se incluyan los clientes sin alquileres = 0.
ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME 
ORDER BY "Número_alquileres";

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM(F.LENGTH) AS "Duración_total_categoría_Action"
FROM FILM AS F 
JOIN FILM_CATEGORY AS FC 
ON F.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" = 'Action'
ORDER BY "Duración_total_categoría_Action";

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE cliente_rentas_temporal AS -- Seleccionamos los clientes y el total de alquileres por cliente
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_completo", COUNT(R.RENTAL_ID) AS "Número_alquileres"
FROM CUSTOMER AS C 
LEFT JOIN RENTAL AS R  -- Nos aseguramos de que se incluyan los clientes sin alquileres = 0.
ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME ;

SELECT "Nombre_completo", "Número_alquileres"
FROM cliente_rentas_temporal -- Mostramos a los clientes y su número de alquileres ordenados por nº alquileres de la tabla temporal "ClienteRentasTemporal"
ORDER BY "Número_alquileres";

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido 
--	   alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE PeliculasAlquiladas AS -- Seleccionamos las películas y la cantidad de alquileres agrupados por películas.
			SELECT F.FILM_ID, F.TITLE AS "Título", COUNT(R.RENTAL_ID) AS "Cantidad_alquileres"
			FROM FILM AS F 
			JOIN INVENTORY AS I 
			ON F.FILM_ID = I.FILM_ID
			JOIN RENTAL AS R
			ON I.INVENTORY_ID = R.INVENTORY_ID
			GROUP BY F.FILM_ID, F.TITLE ;

SELECT "Título", "Cantidad_alquileres"
FROM PeliculasAlquiladas
WHERE "Cantidad_alquileres" > 10
ORDER BY "Cantidad_alquileres"; -- Seleccionamos las películas con > 10 veces de alquiler de la tabla temporal "PeliculasAlquiladas"

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ 
--	   y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_completo", F.TITLE AS "Título" , R.RETURN_DATE AS "Fecha_devolución" 
FROM FILM AS F 
JOIN INVENTORY AS I 
ON F.FILM_ID = I.FILM_ID 
JOIN RENTAL AS R 
ON I.INVENTORY_ID = R.RENTAL_ID 
JOIN CUSTOMER AS C 
ON R.CUSTOMER_ID = C.CUSTOMER_ID 
GROUP BY F.TITLE, C.CUSTOMER_ID, R.RETURN_DATE 
HAVING C.FIRST_NAME = 'TAMMY' AND C.LAST_NAME = 'SANDERS' AND R.RETURN_DATE IS NULL
ORDER BY "Título";

-- Consulta mejorada al no utilizarse group by por no haber funciones agregadas (count, max, sum...)
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS Nombre_completo, F.TITLE AS Título
FROM CUSTOMER C
JOIN RENTAL R
ON C.CUSTOMER_ID = R.CUSTOMER_ID
JOIN INVENTORY I
ON R.INVENTORY_ID = I.INVENTORY_ID
JOIN FILM F
ON I.FILM_ID = F.FILM_ID
WHERE C.FIRST_NAME = 'Tammy' AND C.LAST_NAME = 'Sanders' AND R.RETURN_DATE IS NULL
ORDER BY F.TITLE;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría 
--	   ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
SELECT CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) AS "Nombre_completo", C.name AS "Categoria"
FROM ACTOR AS A 
JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID = FA.ACTOR_ID 
JOIN FILM_CATEGORY AS FC 
ON FA.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" = 'Sci-Fi'
GROUP BY A.ACTOR_ID, A.FIRST_NAME , A.LAST_NAME, C.name
ORDER BY  A.LAST_NAME;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después 
--	   de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente 
--	   por apellido.
SELECT DISTINCT A.FIRST_NAME, A.LAST_NAME -- Seleccionamos el nombre y apellido de los actores
FROM ACTOR A		-- No utilizo "Nombre_completo" porque al usar DISTINCT he de añadir A.LAST_NAME
JOIN FILM_ACTOR FA  -- adicionalmente porque ordeno al final de la sentencia por apellido.
ON A.ACTOR_ID = FA.ACTOR_ID
JOIN FILM AS F 
ON FA.FILM_ID = F.FILM_ID
JOIN INVENTORY AS I 
ON F.FILM_ID = I.FILM_ID 
JOIN RENTAL R 
ON I.INVENTORY_ID = R.INVENTORY_ID 
WHERE R.RENTAL_DATE > ( -- Llegamos con los JOIN hasta la tabla rental
    SELECT MIN(R2.RENTAL_DATE)  -- Obtenemos la primera fecha
    FROM RENTAL R2
    JOIN INVENTORY AS I2 
    ON R2.INVENTORY_ID = I2.INVENTORY_ID
    JOIN FILM AS F2 
    ON I2.FILM_ID = F2.FILM_ID
    WHERE F2.TITLE = 'SPARTACUS CHEAPER' -- Se compara el título
	)
ORDER BY A.LAST_NAME;

-- Realizamos la misma consulta con una CTE, (Common Table Expression). Me resulta más legible.
WITH Primera_fecha AS (
  SELECT MIN(R2.RENTAL_DATE) AS "Fecha_minima"
  FROM RENTAL R2
  JOIN INVENTORY I2 
  ON R2.INVENTORY_ID = I2.INVENTORY_ID
  JOIN FILM F2 
  ON I2.FILM_ID = F2.FILM_ID
  WHERE F2.TITLE = 'SPARTACUS CHEAPER'
)
SELECT DISTINCT
  A.FIRST_NAME, A.LAST_NAME
FROM ACTOR A
JOIN FILM_ACTOR FA 
ON A.ACTOR_ID = FA.ACTOR_ID
JOIN FILM F 
ON FA.FILM_ID = F.FILM_ID
JOIN INVENTORY I 
ON F.FILM_ID = I.FILM_ID
JOIN RENTAL R 
ON I.INVENTORY_ID = R.INVENTORY_ID
JOIN Primera_fecha PF 
ON R.RENTAL_DATE > PF."Fecha_minima"
ORDER BY A.LAST_NAME;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película 
--	   de la categoría ‘Music’.
SELECT DISTINCT CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME) AS "Nombre_completo"
FROM ACTOR A
WHERE NOT EXISTS (
  	SELECT 1
  	FROM FILM_ACTOR FA
  	JOIN FILM_CATEGORY FC 
  	ON FA.FILM_ID = FC.FILM_ID
  	JOIN CATEGORY C
  	ON FC.CATEGORY_ID = C.CATEGORY_ID
  	WHERE FA.ACTOR_ID = A.ACTOR_ID AND C.name = 'Music' -- Si en una película de la categoría 'Music' no se encuentra a un actor,													-- lo incluye en 
	)													-- se incluye en el resultado,
ORDER BY "Nombre_completo";

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT F.TITLE AS "Título"
FROM FILM AS F 
WHERE F.RENTAL_DURATION > '8';

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
SELECT F.TITLE AS "Título", C."name" AS "Categoría"
FROM FILM AS F 
JOIN FILM_CATEGORY AS FC 
ON F.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
WHERE C."name" = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título 
--	   ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
SELECT F.TITLE AS "Título", F.LENGTH AS "Duración"
FROM FILM AS F 
WHERE F.LENGTH = (  -- Obtenemos la duración de la película 'DANCING FEVER' y la comparamos con las demás películas.
		SELECT F2.LENGTH
		FROM FILM AS F2
		WHERE F2.TITLE = 'DANCING FEVER')
ORDER BY F.TITLE ;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
--	   Ordena los resultados alfabéticamente por apellido.
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_competo", COUNT(R.CUSTOMER_ID) AS "Alquileres_totales", 
	   COUNT(DISTINCT I.FILM_ID) AS "Películas_alquiladas"
FROM CUSTOMER AS C 
JOIN RENTAL AS R 
ON C.CUSTOMER_ID = R.CUSTOMER_ID 
JOIN INVENTORY AS I 
ON R.INVENTORY_ID = I.INVENTORY_ID 
GROUP BY C.CUSTOMER_ID 
HAVING COUNT(R.CUSTOMER_ID) > 7 AND COUNT(DISTINCT I.FILM_ID) > 7  -- No hace falta introducir COUNT(R.CUSTOMER_ID) > 7 AND,
ORDER BY C.LAST_NAME;  -- porque solamente con COUNT(DISTINCT I.FILM_ID) > 7 es suficiente al ya filtrar 7 alquileres de películas distintas.

-- Utilizamos una CTE para la consulta anterior
WITH cte_clientes AS (
  SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS "Nombre_competo", COUNT(R.CUSTOMER_ID) AS "Alquileres_totales", 
 	 	 COUNT(DISTINCT I.FILM_ID) AS "Películas_alquiladas", C.LAST_NAME AS "Apellido"
  FROM CUSTOMER C
  JOIN RENTAL AS R 
  ON C.CUSTOMER_ID = R.CUSTOMER_ID
  JOIN INVENTORY AS I 
  ON R.INVENTORY_ID = I.INVENTORY_ID
  GROUP BY C.CUSTOMER_ID)
SELECT
  "Nombre_competo", "Alquileres_totales", "Películas_alquiladas"
FROM cte_clientes
WHERE "Películas_alquiladas" > 7
ORDER BY "Apellido";

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría 
--	   junto con el recuento de alquileres.
SELECT C."name" AS "Nombre_categoría", COUNT(R.RENTAL_ID) AS "Número_alquileres"
FROM RENTAL AS R 
JOIN INVENTORY AS I 
ON R.INVENTORY_ID = I.INVENTORY_ID 
JOIN FILM_CATEGORY AS FC 
ON I.FILM_ID = FC.FILM_ID 
JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
GROUP BY C."name" 
ORDER BY C."name" ;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT C."name" AS "Nombre_categoría", COUNT(F.FILM_ID) AS "Número_películas", F.RELEASE_YEAR AS "Estreno"
FROM CATEGORY AS C 
JOIN FILM_CATEGORY AS FC 
ON C.CATEGORY_ID = FC.CATEGORY_ID 
JOIN FILM AS F 
ON FC.FILM_ID = F.FILM_ID 
WHERE F.RELEASE_YEAR = '2006'
GROUP BY C."name", F.RELEASE_YEAR
ORDER BY "Nombre_categoría";

-- Utilizamos una CTE para la consulta anterior
WITH peliculas_2006 AS ( -- Se obtienen las películas estrenadas en 2006
  SELECT FC.category_id, F.film_id, F.release_year AS "Estreno"
  FROM FILM_CATEGORY FC
  JOIN FILM F 
  ON FC.film_id = F.film_id
  WHERE F.release_year = 2006  
)
SELECT C.name AS "Nombre_categoría", COUNT(P.film_id) AS "Número_películas", "Estreno"
FROM peliculas_2006 AS P		
JOIN CATEGORY C 
ON P.category_id = C.category_id
GROUP BY C.name, "Estreno" -- Se agrupan las películas resultantes por nombre de categoría y se asigna el recuento.
ORDER BY C.name;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT CONCAT(S.FIRST_NAME, ' ', S.LAST_NAME), S2.STORE_ID 
FROM STAFF AS S 
CROSS JOIN STORE AS S2 ;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
--	   su nombre y apellido junto con la cantidad de películas alquiladas.
-- En esta consulta calculamos la cantidad total de alquileres que ha hecho cada cliente:
SELECT C.FIRST_NAME AS "Nombre", C.LAST_NAME AS "Apellido", COUNT(R.RENTAL_ID) AS "Cantidad_total_alquileres"
FROM CUSTOMER AS C 
JOIN RENTAL AS R 
ON C.CUSTOMER_ID = R.CUSTOMER_ID 
GROUP BY C.FIRST_NAME, C.LAST_NAME
ORDER BY "Cantidad_total_alquileres";

-- En esta consulta calculamos los alquileres de cada cliente discriminando el alquiler repetido de cada película.
SELECT C.FIRST_NAME AS "Nombre", C.LAST_NAME AS "Apellido", COUNT(DISTINCT I.FILM_ID) AS "Cantidad_alquileres"
FROM CUSTOMER AS C 
JOIN RENTAL AS R 
ON C.CUSTOMER_ID = R.CUSTOMER_ID 
JOIN INVENTORY AS I 
ON R.INVENTORY_ID = I.INVENTORY_ID 
GROUP BY C.FIRST_NAME, C.LAST_NAME
ORDER BY "Cantidad_alquileres";











