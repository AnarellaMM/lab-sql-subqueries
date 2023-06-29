use sakila; 

-- How many copies of the film "Hunchback Impossible" exist in the inventory system?
SELECT COUNT(*) AS copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

-- List all films whose length is longer than the average of all the films
SELECT *
FROM film
WHERE length > (
  SELECT AVG(length)
  FROM film
);

-- Use subqueries to display all actors who appear in the film "Alone Trip".

SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
  SELECT film_actor.actor_id
  FROM film_actor
  JOIN film ON film_actor.film_id = film.film_id
  WHERE film.title = 'Alone Trip'
);
-- Identify all movies categorized as family films.
SELECT *
FROM film
WHERE film_id IN (
  SELECT film_category.film_id
  FROM film_category
  JOIN category ON film_category.category_id = category.category_id
  WHERE category.name = 'Family'
);
-- get name and email from customers from Canada using subqueries.

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
WHERE customer.address_id IN (
  SELECT address.address_id
  FROM address
  JOIN city ON address.city_id = city.city_id
  JOIN country ON city.country_id = country.country_id
  WHERE country.country = 'Canada'
);

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
  SELECT AVG(total_amount)
  FROM (
    SELECT customer_id, SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
  ) AS subquery
);





