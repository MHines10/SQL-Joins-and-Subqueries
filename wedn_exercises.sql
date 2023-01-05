

------------------------------
--Week 5 - Wednesday Questions
------------------------------


--1. List all customers who live in Texas (use JOINs)

select *
from address a;

select  first_name, last_name, district
from customer c
join address a 
on c.address_id = a.address_id
where district = 'Texas';


---------------------------------------------------------------------------------

--2. List all payments of more than $7.00 with the customer’s first and last name

select *
from customer;

select first_name, last_name, amount 
from payment p 
join customer c 
on c.customer_id = p.customer_id
where amount > '7.00';

---------------------------------------------------------------------------------

--3. Show all customer names who have made over $175 in payments (use
--subqueries)

select *
from payment;

select customer_id, store_id, first_name, last_name
from customer c
where (
	select sum(p.amount)
	from payment p 
	where p.customer_id = c.customer_id
) > 175;

---------------------------------------------------------------------------------

--4. List all customers that live in Argentina (use the city table)

select *
from city;

select first_name, last_name, district, city, country
from customer c
join address a 
on c.address_id = a.address_id
join city ci 
on a.city_id = ci.city_id
join country co 
on ci.country_id = co.country_id
where country = 'Argentina';

---------------------------------------------------------------------------------

--5. Show all the film categories with their count in descending order

select *
from category;

select c.category_id, name, count(c.category_id) as num_movies_in_cat
from category c
left join film_category fc 
on c.category_id = fc.category_id
left join film f 
on fc.film_id = f.film_id
group by c.category_id, name
order by num_movies_in_cat desc;


---------------------------------------------------------------------------------

--6. What film had the most actors in it (show film info)?

select film_id, title, count(actor_id) as num_actors
from film
join film_actor using(film_id)
group by 1
order by count(actor_id) desc
limit 1;

---------------------------------------------------------------------------------

--7. Which actor has been in the least movies?

select actor_id, first_name, last_name, count(film_id) as num_films
from actor
join film_actor using(actor_id)
group by 1
order by count(film_id)
limit 1;

---------------------------------------------------------------------------------

--8. Which country has the most cities?

select country_id, country, count(city_id) as num_cities
from city
join country using(country_id)
group by country.country_id 
order by count(city_id) desc
limit 3;

---------------------------------------------------------------------------------

--9. List the actors who have been in between 20 and 25 films.

--select actor_id, first_name, last_name, count(film_id)
--from actor
--join film_actor using(actor_id)
--group by actor.actor_id
--order by count(film_id) between 20 and 25 desc;


select actor_id, first_name, last_name, count(*)
from film_actor
join actor using(actor_id)
group by actor.actor_id
having COUNT(*) between 20 and 25;

