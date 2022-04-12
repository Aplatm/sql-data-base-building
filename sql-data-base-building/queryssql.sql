SELECT * FROM actor
LEFT JOIN film_info ON actor.actor_id = film_info.film_id;

SELECT * FROM actor
INNER JOIN film_info ON actor.actor_id = film_info.film_id;

SELECT actor.first_name, actor.last_name, film.title, film.description
FROM actor
INNER JOIN film_info ON actor.actor_id = film_info.actor_id
INNER JOIN film ON film_info.film_id = film.film_id.film_id ;

-- todas las pelis que han hecho todos los actores
SELECT actor.first_name, actor.last_name, film.title, film.description
FROM actor
INNER JOIN actor_info ON actor.actor_id = actor_info.actor_id
INNER JOIN film ON actor_info.film_id = film.film_id

-- todas las pelis de "JOE SWANK"

SELECT actor.first_name, actor.last_name, film.title, film.description
FROM actor
INNER JOIN actor_info ON actor.actor_id = actor_info.actor_id
INNER JOIN film ON actor_info.film_id = film.film_id
WHERE actor.first_name = "JOE" AND actor.last_name = "SWANK"

-- todas peliculas alquiladas por un mismo cliente

SELECT * FROM rental
WHERE customer_id = 1

-- quien es el cliente que alquila la pelicula
SELECT * FROM customer
WHERE customer_id = 1

-- su direccion
SELECT * FROM address
WHERE address_id = 1

-- su store
SELECT * FROM store
WHERE store_id = 1

-- la persona que lo atendió
SELECT * FROM staff
WHERE staff_id = 1

-- la pelicula que alquilo
SELECT * FROM inventory
WHERE inventory_id = 1

-- la pelicula que alquilo
SELECT * FROM film
WHERE film_id = 1

SELECT * FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN staff ON rental.staff_id = staff.staff_id
-- WHERE film.title= "ACADEMY DINOSAUR"