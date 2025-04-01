--1. CREA EL ESQUEMA DE LA BBDD


--2.Muestra los nombres de todas las películas con una clasificación por edades de R

SELECT "title" AS "Película",
		"rating"
FROM "film"AS f
WHERE "rating"= 'R';

--3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

SELECT "actor_id" AS "Identificador",
		concat("first_name",' ',"last_name") AS "Nombre"
FROM "actor" AS a 
WHERE "actor_id" BETWEEN 30 AND 40;

--4.Obtén las películas cuyo idioma coincide con el idioma original.

SELECT f."title"
FROM "film"AS f
WHERE f."language_id"= f."original_language_id";

--Todos los datos de la columna original_language_id son NULL


--5.Ordena las películas por duración de forma ascendente.

SELECT "title"AS "Película",
		"length"AS "Duración"
FROM "film" AS f
ORDER BY "length" ASC;

--6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

SELECT concat ("first_name",' ',"last_name")
FROM "actor"AS a
WHERE "last_name" ILIKE 'Allen';

--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

SELECT "rating"AS "clasificación",
		COUNT("film_id")AS "Número_films"
FROM "film"AS f
GROUP BY "rating";


--8. Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una duración mayor a 3 horas en la tabla film.

SELECT "title" AS "Film",
		"rating",
		"length"AS "Duración"
FROM "film"AS f
WHERE "rating" = 'PG-13' OR "length">180;

--9.Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT ROUND(AVG("replacement_cost"),2) AS "Variabilidad_reemplazo"
FROM "film"AS f;

--10.Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT	MAX("length") AS "Máximo" ,
		MIN("length") AS "Mínimo"
FROM "film"AS f;

--11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT "payment_date"AS "Fecha_pago",
		"amount"AS "Costo"
FROM "payment"AS p
ORDER BY "payment_date" DESC
LIMIT 3;

--12.Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC17ʼ ni ‘Gʼ en cuanto a su clasificación.

SELECT "title" AS "Film",
		"rating"
FROM "film"AS f
WHERE f.rating NOT IN ('NC-17','G');


/*13.Encuentra el promedio de duración de las películas para cada clasificación 
de la tabla film y muestra la clasificación junto con el promedio de duración de la 
tabla film y muestra la clasificación junto con el promedio de duración.*/

SELECT "rating",
		ROUND(AVG(f.length),2) AS "promedio"
FROM "film"AS f
GROUP BY "rating";

/*14.Encuentra el título de todas las películas que tengan una duración mayor 
180 minutos.*/

SELECT "title"AS "Film",
		"length"AS "Duración"
FROM "film"AS f
WHERE "length">180
ORDER BY "length" ASC;

--15.¿Cuánto dinero ha generado en total la empresa?

SELECT SUM("amount")
FROM "payment";

--16.Muestra los 10 clientes con mayor valor de id

SELECT "customer_id",
		concat("first_name",' ',"last_name")
FROM "customer"AS c
ORDER BY "customer_id" DESC
LIMIT 10;

/*17.Encuentra el nombre y apellido de los actores que aparecen 
en la película con título ‘Egg Igbyʼ*/

SELECT concat("first_name",' ' ,"last_name")
FROM "actor"AS a
WHERE "actor_id" IN  (
	SELECT "actor_id" AS "actor"
	FROM "film" AS f
	INNER JOIN "film_actor" AS fa 
	ON f."film_id" = fa."film_id"
	WHERE "title" ILIKE 'Egg Igby');

--18.Selecciona todos los nombres de las películas únicos.


/*19. Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla “filmˮ.*/

SELECT "title" AS "Nombre_películas",
		"film_id" AS "Identificador"
FROM "film"AS f
WHERE "film_id" IN (
	SELECT "film_id"
	FROM "film_category"AS fi
	INNER JOIN "category" AS c
	ON fi."category_id" = c."category_id"
	WHERE "name" ILIKE 'Comedy');


/*20.Encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración.*/

SELECT "title"AS "Película",
		"length"
FROM "film"AS f
INNER JOIN "film_category"AS fi
ON f.


--21.¿Cuál es la media de duración del alquiler de las películas?

SELECT round(avg("rental_duration"),2) AS "Media_alquiler"
FROM "film"AS f;

/*22.Crea una columna con el nombre y apellidos de todos los actores y 
actrices.*/

SELECT concat("first_name",' ',"last_name") AS "Nombre_Apellidos"
FROM "actor" AS a

/*23.Números de alquiler por día, ordenados por cantidad de alquiler de 
forma descendente.*/

SELECT "rental_date",
		count("rental_id")
FROM "rental"AS r
GROUP BY "rental_id";


--24.Encuentra las películas con una duración superior al promedio.

SELECT "title"AS "Película"
FROM "film" AS "Película"
WHERE "length">(
	SELECT ROUND(AVG("length"),2) AS "Promedio_Duración"
	FROM "film")
ORDER BY "length";

--25.Averigua el número de alquileres registrados por mes.




/*26.Encuentra el promedio, la desviación estándar y varianza del total 
pagado*//

SELECT ROUND(AVG("amount"),2) AS "Promedio",
		ROUND(STDDEV("amount"),2) AS "Desviación_Estandar",
		ROUND(VARIANCE("amount"),2) AS "Varianza"
FROM "payment"AS p

--27.¿Qué películas se alquilan por encima del precio medio?

SELECT f.title,
		p.amount 
FROM "film"AS f
INNER JOIN "inventory"AS i
ON f.film_id =i.film_id
	INNER JOIN "rental" AS r
	ON i.inventory_id =r.inventory_id
		INNER JOIN "payment"AS p
		ON r.rental_id =p.rental_id
		WHERE "amount">(
			SELECT round(avg("amount"),2)
			FROM "payment"AS p);

/*28.Muestra el id de los actores que hayan participado en más de 40 
películas.*/

--TERMINAAAAAARRRRRRRRRRRRRRRRRRR

SELECT a."actor_id" AS "Id",
		concat(a.first_name,' ',a.last_name)AS "Actor",
		count (f."film_id") AS "Número_películas"
FROM "actor" AS a
INNER JOIN "film_actor"AS f
ON a.actor_id = f.actor_id
GROUP BY "Id"
ORDER BY "Id" DESC


/*29.Obtener todas las películas y, si están disponibles en el inventario, 
mostrar la cantidad disponible.*/

--TERMINAAAAARRRRRRR

SELECT "title"AS "Película"
FROM "film"AS fi
INNER JOIN "inventory" AS i
ON fi."film_id"= i."film_id"
WHERE 

--30.Obtener los actores y el número de películas en las que ha actuado.

SELECT  CONCAT(a."first_name",' ',a."last_name") AS "Actor",
		COUNT(fi."film_id") AS "Número_películas"
FROM "actor" AS a
INNER JOIN "film_actor" AS fi
ON a."actor_id" = fi."actor_id"
GROUP BY "Actor";

 /*31.Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.*/

SELECT f.title,
		i.actor_id	
FROM "film_actor"AS i
LEFT JOIN "film"AS f
ON f.film_id = i.film_id
WHERE i."actor_id" IS NULL


 /*32.Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.*/

SELECT f.actor_id ,
		concat (a.first_name,' ',a.last_name)AS "actor",
		f.film_id
FROM "actor"AS a
LEFT JOIN "film_actor"AS f
ON a.actor_id = f.actor_id
 
 /*33.Obtener todas las películas que tenemos y todos los registros de 
alquiler.*/

SELECT f."title",
		r.*
FROM "film"AS f
	--Unión con tabla inventario	
	INNER JOIN "inventory"AS i
	ON f."film_id" = i."film_id"
	--Unión con tabla alquiler
	INNER JOIN "rental" AS r
	ON r."inventory_id" = i."inventory_id"
 
 --34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 
SELECT concat(c."first_name",' ',c."last_name")AS "Cliente",
		sum("amount")AS "Gasto"
FROM "payment"AS p
	INNER JOIN "rental" AS r
	ON p."rental_id"=  r."rental_id"
	INNER JOIN "customer"AS c
	ON r."customer_id" = c."customer_id"
GROUP BY "Cliente"
ORDER BY "Gasto" DESC
LIMIT 5;

--35.Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT "first_name"AS "Nombre",
		"last_name"AS "Apellido"
FROM "actor" AS a
WHERE "first_name" ILIKE 'Johnny';

 /*36.Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como 
Apellido.*/

SELECT "first_name"AS "Nombre",
		"last_name"AS "Apellido"
FROM "actor" AS a

--37.Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MAX("actor_id"),
		MIN("actor_id")
FROM "actor"AS a

--38.Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT count("actor_id") AS "Número_actores"
FROM "actor"AS a

 /*39.Selecciona todos los actores y ordénalos por apellido en orden 
ascendente.*/

SELECT "last_name",
		"first_name"
FROM "actor"AS a
ORDER BY "last_name" DESC;

 --40.Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT "title"AS "Película",
		"film_id"AS "Id"
FROM "film"AS f
ORDER BY "film_id" ASC;

 /*41.Agrupa los actores por su nombre y cuenta cuántos actores tienen el 
mismo nombre. ¿Cuál es el nombre más repetido?*/

SELECT "first_name"
FROM "actor"AS a

/*42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron*/

SELECT c."first_name",
		c."last_name",
		c."customer_id",
		count("rental_id")AS"número_alquileres"
FROM "rental"AS r
INNER JOIN "customer"AS c
ON r."customer_id"= c."customer_id"
GROUP BY c."customer_id"
ORDER BY c."customer_id";

/*43.Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/

SELECT c."customer_id",
		r."rental_id"
FROM "customer"AS c
LEFT JOIN "rental"AS r
ON c."customer_id"=r."customer_id"
ORDER BY c."customer_id";

/*44.Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/

SELECT *
FROM "film"AS f
CROSS JOIN "category"AS c

/*45.Encuentra los actores que han participado en películas de la categoría
'Action'*/

SELECT c."name",
		concat (a."first_name",' ',a."last_name")
FROM "category" AS c
INNER JOIN "film_category"AS fi	
ON c."category_id"=fi."category_id"
	INNER JOIN "film"AS fil
	ON fi."film_id"=fil."film_id"
		INNER JOIN "film_actor"AS filma
		ON fil."film_id"= filma."film_id"
			INNER JOIN "actor" AS a
			ON filma."actor_id"=a."actor_id"
			WHERE "name" ILIKE 'action';
		
/*46.Encuentra todos los actores que no han participado en películas. */
SELECT "actor_id"
FROM "film_actor"AS f
WHERE "film_id" = 'null'
 
/*47.Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/

SELECT 	concat(a.first_name,' ',a.last_name)AS "Actor",
		count (f.film_id)AS "Número_films"
FROM "actor"AS a
INNER JOIN "film_actor"AS f
ON a.actor_id = f."actor_id"
GROUP BY a.actor_id 

/*48.Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres
de los actores y el número de películas en las que han participado.*/

CREATE VIEW "actor_num_películas"AS 
SELECT a."actor_id" AS "Identificador",
		concat (a."first_name",' ',a."last_name")AS "actor",
		count(f."film_id")AS "número_películas"
FROM "actor"AS a
INNER JOIN "film_actor"AS f
ON a."actor_id"=f."actor_id"
GROUP BY a."actor_id"
ORDER BY "número_películas" DESC;

/*49.Calcula el número total de alquileres realizados por cada cliente.*/

SELECT c.customer_id AS "Identificador",
		concat (c."first_name",' ',c."last_name")AS "cliente",
		count(r."rental_id")AS "número_alquileres"
FROM "rental"AS r
INNER JOIN "customer"AS c
ON r."customer_id"=c."customer_id" 
GROUP BY c.customer_id
ORDER BY "número_alquileres" DESC;

/*50. Calcula la duración total de las películas en la categoría 'Action'.*/

SELECT sum(fil."length")
FROM "category" AS c
INNER JOIN "film_category"AS fi	
ON c."category_id"=fi."category_id"
	INNER JOIN "film" AS fil
	ON fi."film_id"=fil."film_id"
		WHERE "name" = 'Action';

/*51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para
almacenar el total de alquileres por cliente.*/

CREATE TEMP TABLE "Cliente_rentas_temporal" AS 
SELECT c.customer_id AS "Identificador",
		concat (c."first_name",' ',c."last_name")AS "cliente",
		count(r."rental_id")AS "número_alquileres"
FROM "rental"AS r
INNER JOIN "customer"AS c
ON r."customer_id"=c."customer_id" 
GROUP BY c.customer_id
ORDER BY "número_alquileres" DESC;

SELECT *
FROM "Cliente_rentas_temporal"
WHERE "número_alquileres">40;

/*52.Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las
películas que han sido alquiladas al menos 10 veces.*/

CREATE TEMP TABLE "Películas_alquiladas" AS
SELECT f."title" AS "Película",
		count(r."rental_id") AS "número_alquileres"
FROM "rental" AS r
INNER JOIN "inventory"AS i
ON r.inventory_id =i.inventory_id
	INNER JOIN "film"AS f
	ON i.film_id = f.film_id
GROUP BY "Película"
ORDER BY "Película";

SELECT *
FROM "Películas_alquiladas" AS p
WHERE "número_alquileres">=10;
	
/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/

--TERMINAAAAAAAAAAAAAARRRRRRRRRRRRRRRRRRR

SELECT "title" AS "Película",
		"return_date" AS "Fecha_devolución"
FROM "customer"AS c
INNER JOIN "rental"AS r
ON c.customer_id = r.customer_id
	INNER JOIN "inventory"AS i
	ON r.inventory_id =i.inventory_id
		INNER JOIN "film" AS f
		ON i.film_id =f.film_id
WHERE "first_name" ILIKE 'Tammy'AND r.return_date IN 'NULL'; 

/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados
alfabéticamente por apellido.*/

SELECT concat (a.first_name,' ',a.last_name )
FROM "actor"AS a
INNER JOIN "film_actor"AS f
ON a.actor_id =f.actor_id
	INNER JOIN "film"AS fi
	ON f.film_id =fi.film_id
		INNER JOIN "film_category" AS fil
		ON fil.film_id =fi.film_id
			INNER JOIN "category"AS c
			ON fil.category_id =c.category_id
			WHERE c."name" = 'Sci-fi'

SELECT f.film_id,
		c.name,
		f.category_id
FROM "film_category"AS f
INNER JOIN "category"AS c
ON c.category_id = f.category_id
WHERE c."name" LIKE 'Sci-fi'


FROM "category"AS c


/*55.Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaperʼ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/



/*56.Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Musicʼ.*/



/*57.Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/


/*58.Encuentra el título de todas las películas que son de la misma categoría
que ‘Animationʼ*/

SELECT f."title"AS "Película",
		c."name"
FROM "film"AS f
INNER JOIN "film_category"AS fil
ON f.film_id = fil.film_id
	INNER JOIN "category" AS c
	ON fil.category_id = c.category_id
	WHERE c."name" = 'Animation';
	
/*59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Feverʼ. Ordena los resultados
alfabéticamente por título de película.*/

SELECT f."title",
		f."length" 
FROM "film" AS f
WHERE f."length"= (
	SELECT "length"
	FROM "film" AS f
	WHERE "title" ILIKE 'Dancing Fever');

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/


/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT "name" AS "Categoría",
		count(r.rental_id) AS "Número_alquileres"
FROM "category" AS c
INNER JOIN "film_category"AS f
ON c.category_id = f.category_id 
	INNER JOIN "film" AS fi
	ON f.film_id = fi.film_id 
	INNER JOIN "inventory"AS i
	ON fi.film_id = i.film_id
		INNER JOIN "rental" AS r
		ON i.inventory_id = r.inventory_id
		GROUP BY c."name" ;
		
/*62.Encuentra el número de películas por categoría estrenadas en 2006.*/

SELECT "name"AS "Categoría",
		count(i."film_id") AS "Número_películas"
FROM "category"AS c
INNER JOIN "film_category"AS i
ON i.category_id  = c.category_id
INNER JOIN "film"AS f
ON i.film_id = f.film_id
WHERE f.release_year >= 2006
GROUP BY "name";

/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/

SELECT concat (s."first_name",' ',s."last_name")AS "Personal",
		st."store_id" AS "Tienda"
FROM "staff"AS s
		CROSS JOIN "store" AS st;
 
/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas*/

SELECT c."customer_id" AS "Id",
		concat(c."first_name",' ',c."last_name")AS "Cliente",
		count(r."rental_id") AS "Número_alquileres"
FROM "customer" AS c
INNER JOIN "rental"AS r
ON r.customer_id = c.customer_id
GROUP BY c."customer_id";
