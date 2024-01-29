use sakila;
#1) Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select FILM_ID, TITLE FROM FILM;
#439
select film_id, inventory_id from inventory;
#amount = 6

SELECT film.title AS FilmTitle,
    (SELECT COUNT(*)
        FROM inventory
        WHERE inventory.film_id = film.film_id) 
AS NumberOfCopies FROM film
WHERE film.title = 'Hunchback Impossible';

#2) List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, length from film;
select avg(length) from film;

SELECT 
    film_id, title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);

#3) Use a subquery to display all actors who appear in the film "Alone Trip"
select film_id, actor_id from film_actor;
select actor_id, first_name, last_name from actor;
select film_id, title from film;
# alone trip film_Id = 7
# 8 actors

SELECT 
    actor_id,
    first_name,
    last_name
FROM 
    actor
WHERE 
    actor_id IN (
        SELECT 
            actor_id
        FROM 
            film_actor
        WHERE 
            film_id IN (
                SELECT 
                    film_id
                FROM 
                    film
                WHERE 
                    title = 'Alone Trip'
            )
    );

#4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select * from category; #film films = catagery 8
select * from film_category;
select * from film;
SELECT 
    film_id,
    title
FROM 
    film
WHERE 
    film_id IN (
        SELECT 
            film_id
        FROM 
            film_category
        WHERE 
            category_id IN (
                SELECT 
                    category_id
                FROM 
                    category
                WHERE 
                    name = 'Family'
            )
    );

#5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select country_id, country from country; #Canada country id = 20
select customer_id,address_id, email, first_name, last_name from customer;
select city_id, country_id from city;
select * from address;
# primary key will be address_id 
# foreign keys will be city_id 
SELECT 
    first_name,
    last_name,
    email
FROM 
    customer
WHERE 
    address_id IN (
        SELECT 
            address_id
        FROM 
            address
        WHERE 
            city_id IN (
                SELECT 
                    city_id
                FROM 
                    city
                WHERE 
                    country_id IN (
                        SELECT 
                            country_id
                        FROM 
                            country
                        WHERE 
                            country = 'Canada'
                    )
            )
    );

