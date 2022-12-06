-- How many copies of the film Hunchback Impossible exist in the inventory system?
use sakila;
select title, count(inventory_id) as total_inventory
from film join inventory
on film.film_id = inventory.film_id
where title='Hunchback Impossible';

-- List all films whose length is longer than the average of all the films.

select title, avg(length)
from film 
group by title
having avg(length) > (select avg(length) from film)
order by avg(length) desc;

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title, category
FROM film_list
WHERE category = 'Family';

-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

SELECT cu.last_name, cu.first_name,cu.email
FROM customer cu
WHERE customer_id =
	(SELECT country_id
    FROM country co
	WHERE country = "Canada") ;

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred
SELECT count(film_actor.actor_id), actor.first_name, actor.last_name 
FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id ;


-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT
	film.film_id as "Film ID",
    film.title as "Film Title",
    SUM(payment.amount) as "Total Sales",
FROM
    payment

GROUP BY
    film.film_id
ORDER BY
    SUM(payment.amount)
DESC

-- Customers who spent more than the average payments.
select customer_id, avg(amount)
from payment
group by customer_id
having avg(amount) > (select avg(amount) from payment)
order by avg(amount) desc;
