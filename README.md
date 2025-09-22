Realización de las consultas a través de mis apuntes de las lecciones y la ayuda en ocasiones de ChatGPT, tanto para la realización como optimización y ampliación de éstas, adjunto los apuntes.
Consulta 24, se realiza también otra consulta con una ampliación de la misma, mostrando una columna más con el tiempo promedio.
Consulta 25, se utiliza EXTRACT() para obtener el número del mes.
Consulta 29, utilizo left join para mostrar todas las películas con o sin inventario
Consulta 31, no es necesario usar GROUP BY F.TITLE, CONCAT(A.FIRST_NAME , ' ', A.LAST_NAME) al no estar usando agregaciones(como COUNT, MAX, AVG, etc.), no es necesario agrupar.
Consulta 32, lo mismo que en la 31.
Consulta 34, se realiza también otra consulta que muestra la cantidad.
Consulta 41, he buscado como sería la consulta para saber cuales son los más repetidos, ya que hay 3 actores más repetidos empatados.
Consulta 43, he tenido que utilizar el alias de rental para realizar la consulta, R*
Consulta 44, dejo las respuestas de las preguntas comentadas.
Consulta 45, podemos saltarnos el JOIN de la tabla Film, porque se pueden relacionar directamente film_actor y film_category.
Consulta 46, la resuelvo también con una subconsulta NOT EXISTS en el WHERE.
Consulta 49, utilizo un left join para que se incluyan los clientes sin alquileres = 0.
Consulta 51, anotaciones que explican la consulta.
Consulta 53, se añade otra consulta mejorada al no utilizarse group by por no haber funciones agregadas (count, max, sum...)
Consulta 55, anotaciones que explican la consulta. Se realiza la misma consulta con una CTE, (Common Table Expression). Me resulta más legible.
Consulta 59, anotaciones que explican la consulta.
Consulta 60, se realiza la misma consulta con una CTE.
Consulta 62, se realiza la misma consulta con una CTE.
Consulta 64, se realiza la consulta calculando la cantidad total de alquileres por cliente, realizo otra consulta discriminando si hay alquileres repetidos de la misma película.




