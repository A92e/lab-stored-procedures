use sakila;

 
  
select concat(first_name,' ',last_name) AS full_name, email, ca.name from customer c
right join rental r
on c.customer_id=r.customer_id
join inventory i
on r.inventory_id=i.inventory_id
join film_category fc
on i.film_id=fc.film_id
join category ca
on fc.category_id=ca.category_id
where ca.name = 'Action'
group by full_name;

  
 -- 1-   
  
  
  
  drop procedure if exists rented_action;
delimiter //
create procedure rented_action ()
begin

select concat(first_name,' ',last_name) AS full_name, email, ca.name from customer c
right join rental r
on c.customer_id=r.customer_id
join inventory i
on r.inventory_id=i.inventory_id
join film_category fc
on i.film_id=fc.film_id
join category ca
on fc.category_id=ca.category_id
where ca.name = 'Action'
group by full_name;
 
end;
//
delimiter ;

call rented_action();

  
   
 -- 2-  
  
drop procedure if exists rented_action;
delimiter //
create procedure rented_action (in param varchar(20))
begin

select concat(first_name,' ',last_name) AS full_name, email, ca.name from customer c
right join rental r
on c.customer_id=r.customer_id
join inventory i
on r.inventory_id=i.inventory_id
join film_category fc
on i.film_id=fc.film_id
join category ca
on fc.category_id=ca.category_id
where ca.name COLLATE utf8mb4_general_ci = param
group by full_name;
 
end;
//
delimiter ;

call rented_action("Action");
call rented_action("Animation");



-- 3- 

-- check the number of movies released in each movie category

select c.name as categories, count(fc.film_id) as num_films from category c
join film_category fc
on c.category_id=fc.category_id
group by c.name;

-- filter only those categories that have movies released greater than a certain number. 

select c.name as categories, count(fc.film_id) as num_films from category c
join film_category fc
on c.category_id=fc.category_id
group by c.name
having num_films > 60 ;

-- Pass that number as an argument in the stored procedure.

drop procedure if exists num_films_cat;
delimiter //
create procedure num_films_cat (in param int)
begin

select c.name as categories, count(fc.film_id) as num_films from category c
join film_category fc
on c.category_id=fc.category_id
group by c.name
having num_films > param ;
 
end;
//
delimiter ;

call num_films_cat(60);
