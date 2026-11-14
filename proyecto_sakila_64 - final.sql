-- PROYECTO SAKILA

-- 02. Nombres de películas clasificadas R.
SELECT title FROM film WHERE rating = 'R' ORDER BY title;

-- 03. Actores con actor_id entre 30 y 40 (incluidos).
SELECT first_name, last_name FROM actor WHERE actor_id BETWEEN 30 AND 40 ORDER BY actor_id;

-- 04. Películas cuyo idioma coincide con el idioma original.
SELECT title, language_id, original_language_id
FROM film WHERE language_id = original_language_id ORDER BY title;

-- 05. Películas ordenadas por duración ascendente.
SELECT title, length FROM film ORDER BY length ASC NULLS LAST, title;

-- 06. Actores con «Allen» en el apellido.
SELECT first_name, last_name FROM actor WHERE last_name ILIKE '%Allen%' ORDER BY last_name, first_name;

-- 07. Número de películas por clasificación.
SELECT rating, COUNT(*) AS total_peliculas FROM film GROUP BY rating ORDER BY rating;

-- 08. Películas PG-13 O de más de 180 minutos.
SELECT title, rating, length FROM film WHERE rating = 'PG-13' OR length > 180 ORDER BY title;

-- 09. Variabilidad del coste de reemplazo (varianza y desviación estándar).
SELECT VAR_SAMP(replacement_cost) AS varianza_coste_reemplazo,
       STDDEV_SAMP(replacement_cost) AS desviacion_coste_reemplazo,
       MIN(replacement_cost) AS minimo, MAX(replacement_cost) AS maximo
FROM film;

-- 10. Duración máxima y mínima.
SELECT MAX(length) AS mayor_duracion, MIN(length) AS menor_duracion FROM film;

-- 11. Coste del antepenúltimo alquiler por fecha.
SELECT r.rental_id, r.rental_date, COALESCE(SUM(p.amount), 0) AS coste_alquiler
FROM rental r LEFT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY r.rental_id, r.rental_date
ORDER BY r.rental_date DESC, r.rental_id DESC OFFSET 2 LIMIT 1;

-- 12. Películas que no son NC-17 ni G.
SELECT title, rating FROM film WHERE rating NOT IN ('NC-17', 'G') ORDER BY title;

-- 13. Duración media por clasificación.
SELECT rating, ROUND(AVG(length)::numeric, 2) AS duracion_media
FROM film GROUP BY rating ORDER BY rating;

-- 14. Películas de más de 180 minutos.
SELECT title, length FROM film WHERE length > 180 ORDER BY length DESC, title;

-- 15. Total de ingresos registrados.
SELECT SUM(amount) AS ingresos_totales FROM payment;

-- 16. Diez clientes con id más alto.
SELECT customer_id, first_name, last_name FROM customer ORDER BY customer_id DESC LIMIT 10;

-- 17. Actores de Egg Igby.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'EGG IGBY' ORDER BY a.last_name, a.first_name;

-- 18. Títulos únicos.
SELECT DISTINCT title FROM film ORDER BY title;

-- 19. Comedias con duración mayor de 180 minutos.
SELECT DISTINCT f.title, f.length
FROM film f JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Comedy' AND f.length > 180 ORDER BY f.title;

-- 20. Categorías con duración media superior a 110 minutos.
SELECT c.name AS categoria, ROUND(AVG(f.length)::numeric, 2) AS duracion_media
FROM category c JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.category_id, c.name HAVING AVG(f.length) > 110
ORDER BY duracion_media DESC, categoria;

-- 21. Media de duración real del alquiler en días.
SELECT ROUND(AVG(EXTRACT(EPOCH FROM (return_date - rental_date)) / 86400)::numeric, 2)
       AS media_dias_alquiler
FROM rental WHERE return_date IS NOT NULL;

-- 22. Nombre completo de cada actor.
SELECT actor_id, CONCAT_WS(' ', first_name, last_name) AS nombre_completo FROM actor ORDER BY actor_id;

-- 23. Alquileres por día, de mayor a menor cantidad.
SELECT rental_date::date AS dia, COUNT(*) AS numero_alquileres
FROM rental GROUP BY rental_date::date ORDER BY numero_alquileres DESC, dia;

-- 24. Películas de duración superior al promedio.
SELECT title, length FROM film WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, title;

-- 25. Alquileres por mes 
SELECT DATE_TRUNC('month', rental_date)::date AS mes, COUNT(*) AS alquileres
FROM rental GROUP BY DATE_TRUNC('month', rental_date)::date ORDER BY mes;

-- 26. Promedio, desviación estándar y varianza de pagos individuales.
SELECT ROUND(AVG(amount)::numeric, 2) AS media_pago,
       ROUND(STDDEV_SAMP(amount)::numeric, 2) AS desviacion_estandar,
       ROUND(VAR_SAMP(amount)::numeric, 2) AS varianza_pago
FROM payment;

-- 27. Películas con precio de alquiler superior al precio medio.
SELECT title, rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) ORDER BY rental_rate DESC, title;

-- 28. Actores con más de 40 películas.
SELECT actor_id, COUNT(*) AS total_peliculas FROM film_actor
GROUP BY actor_id HAVING COUNT(*) > 40 ORDER BY total_peliculas DESC, actor_id;

-- 29. Todas las películas y número de copias en inventario.
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS copias_en_inventario
FROM film f LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.film_id, f.title ORDER BY f.title;

-- 30. Actores y número de películas, incluso con cero.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS numero_peliculas
FROM actor a LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name ORDER BY numero_peliculas DESC, a.actor_id;

-- 31. Todas las películas con sus actores.
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f LEFT JOIN film_actor fa ON fa.film_id = f.film_id
LEFT JOIN actor a ON a.actor_id = fa.actor_id ORDER BY f.title, a.last_name, a.first_name;

-- 32. Todos los actores con sus películas.
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id ORDER BY a.last_name, a.first_name, f.title;

-- 33. Todas las películas y todos los registros de alquiler, relacionados vía inventario.
SELECT f.film_id, f.title, r.rental_id, r.rental_date
FROM film f FULL OUTER JOIN inventory i ON i.film_id = f.film_id
FULL OUTER JOIN rental r ON r.inventory_id = i.inventory_id
ORDER BY f.film_id NULLS LAST, r.rental_id;

-- 34. Cinco clientes que más han gastado.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS gasto_total
FROM customer c JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY gasto_total DESC, c.customer_id LIMIT 5;

-- 35. Actores llamados Johnny.
SELECT * FROM actor WHERE first_name ILIKE 'Johnny' ORDER BY actor_id;

-- 36. Renombrar columnas en el resultado (sin alterar tabla).
SELECT first_name AS "Nombre", last_name AS "Apellido" FROM actor ORDER BY actor_id;

-- 37. Id mínimo y máximo de actor.
SELECT MIN(actor_id) AS id_minimo, MAX(actor_id) AS id_maximo FROM actor;

-- 38. Número de actores.
SELECT COUNT(*) AS numero_actores FROM actor;

-- 39. Actores ordenados por apellido ascendente.
SELECT * FROM actor ORDER BY last_name ASC, first_name ASC, actor_id;

-- 40. Primeras cinco películas.
SELECT * FROM film ORDER BY film_id ASC LIMIT 5;

-- 41. Recuento por nombre, más repetido primero.
SELECT first_name, COUNT(*) AS repeticiones FROM actor
GROUP BY first_name ORDER BY repeticiones DESC, first_name;
-- La primera fila es uno de los nombres más repetidos; puede haber empates.

-- 42. Alquileres y clientes que los realizaron.
SELECT r.rental_id, r.rental_date, c.customer_id, c.first_name, c.last_name
FROM rental r JOIN customer c ON c.customer_id = r.customer_id ORDER BY r.rental_id;

-- 43. Todos los clientes y sus alquileres, aunque no tengan.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c LEFT JOIN rental r ON r.customer_id = c.customer_id
ORDER BY c.customer_id, r.rental_id;

-- 44. CROSS JOIN entre film y category.
SELECT f.film_id, f.title, c.category_id, c.name AS categoria
FROM film f CROSS JOIN category c ORDER BY f.film_id, c.category_id;

-- 45. Actores que han participado en películas Action.
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action' ORDER BY a.last_name, a.first_name;

-- 46. Actores sin películas.
SELECT a.actor_id, a.first_name, a.last_name FROM actor a
WHERE NOT EXISTS (SELECT 1 FROM film_actor fa WHERE fa.actor_id = a.actor_id)
ORDER BY a.actor_id;

-- 47. Actores y cantidad de películas.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC, a.last_name, a.first_name;

-- 48. Vista actor_num_peliculas.
CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS numero_peliculas
FROM actor a LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;
SELECT * FROM actor_num_peliculas ORDER BY numero_peliculas DESC, actor_id;

-- 49. Alquileres por cliente.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY c.customer_id;

-- 50. Duración total del catálogo Action, en minutos.
SELECT c.name AS categoria, SUM(f.length) AS minutos_totales
FROM category c JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE c.name = 'Action' GROUP BY c.name;

-- 51. Tabla temporal de alquileres por cliente.
DROP TABLE IF EXISTS pg_temp.cliente_rentas_temporal;
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
SELECT * FROM cliente_rentas_temporal ORDER BY total_alquileres DESC, customer_id;

-- 52. Tabla temporal con películas alquiladas al menos diez veces.
DROP TABLE IF EXISTS pg_temp.peliculas_alquiladas;
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS veces_alquilada
FROM film f JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title HAVING COUNT(r.rental_id) >= 10;
SELECT * FROM peliculas_alquiladas ORDER BY veces_alquilada DESC, title;

-- 53. Películas alquiladas por Tammy Sanders todavía sin devolver.
SELECT DISTINCT f.title FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE c.first_name = 'TAMMY' AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL ORDER BY f.title;

-- 54. Actores de Sci-Fi, ordenados por apellido.
SELECT DISTINCT a.actor_id, a.first_name, a.last_name FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi' ORDER BY a.last_name, a.first_name, a.actor_id;

-- 55. Actores de películas alquiladas DESPUÉS del primer alquiler de Spartacus Cheaper.
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN inventory i ON i.film_id = fa.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
  SELECT MIN(r2.rental_date) FROM rental r2
  JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
  JOIN film f2 ON f2.film_id = i2.film_id
  WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name, a.first_name, a.actor_id;

-- 56. Actores que NO han actuado en ninguna película Music.
SELECT a.actor_id, a.first_name, a.last_name FROM actor a
WHERE NOT EXISTS (
  SELECT 1 FROM film_actor fa
  JOIN film_category fc ON fc.film_id = fa.film_id
  JOIN category c ON c.category_id = fc.category_id
  WHERE fa.actor_id = a.actor_id AND c.name = 'Music'
) ORDER BY a.last_name, a.first_name, a.actor_id;

-- 57. Títulos alquilados durante más de 8 días reales (solo devueltos).
SELECT DISTINCT f.title FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY f.title;

-- 58. Películas de la categoría Animation.
SELECT DISTINCT f.title FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Animation' ORDER BY f.title;

-- 59. Películas de igual duración que Dancing Fever.
SELECT title, length FROM film
WHERE length IN (SELECT length FROM film WHERE title = 'DANCING FEVER') ORDER BY title;

-- 60. Clientes con al menos siete películas distintas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(DISTINCT i.film_id) AS peliculas_distintas
FROM customer c JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name, c.first_name, c.customer_id;

-- 61. Número total de alquileres por categoría.
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM category c LEFT JOIN film_category fc ON fc.category_id = c.category_id
LEFT JOIN inventory i ON i.film_id = fc.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.category_id, c.name ORDER BY total_alquileres DESC, categoria;

-- 62. Número de películas estrenadas en 2006 por categoría.
SELECT c.name AS categoria, COUNT(f.film_id) AS peliculas_2006
FROM category c LEFT JOIN film_category fc ON fc.category_id = c.category_id
LEFT JOIN film f ON f.film_id = fc.film_id AND f.release_year = 2006
GROUP BY c.category_id, c.name ORDER BY categoria;

-- 63. Todas las combinaciones posibles de trabajadores y tiendas.
SELECT s.staff_id, s.first_name, s.last_name, st.store_id
FROM staff s CROSS JOIN store st ORDER BY s.staff_id, st.store_id;

-- 64. Alquileres por cliente (id, nombre, apellido, cantidad).
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS peliculas_alquiladas
FROM customer c LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY c.customer_id;
