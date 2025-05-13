--  25 Complex Joins Questions

-- These focus on multi-table queries, JOIN types, subqueries, etc.
-- 	1.	Join employees to itself to display each employee alongside the manager’s name (if they have one).
select e1.first_name, e1.last_name, e1.employee_id , e1.manager_id,
CASE WHEN e1.manager_id IS NULL then False else True END AS 'Has manager'
from employees e1
join employees e2
on e1.employee_id = e2.employee_id;

-- 	2.	List each order_id with the corresponding customer’s first and last name.
Select c.first_name, c.last_name , o.order_id
from orders o
left join customers c
on o.customer_id = c.customer_id;

-- 	3.	Show all product_names that were purchased in orders (use order_items to link).
select p.product_name, oi.order_id
from products p
left join order_items oi
on p.product_id = oi.product_id;

-- 	4.	Find the total quantity of each product (product_name) sold across all orders.
select p.product_name, oi.product_id, count(*) as Items_sold
from products p
left join order_items oi
on p.product_id = oi.product_id
GROUP BY oi.product_id, p.product_name;

-- 	5.	List the customer’s name, order_date, and product_name for all orders in July 2021 (in a single query).

SELECT
    c.first_name,
    c.last_name,
    o.order_date,
    p.product_name
FROM orders        o
JOIN customers     c  ON c.customer_id  = o.customer_id
JOIN order_items   oi ON oi.order_id    = o.order_id          -- if your schema has this table
JOIN products      p  ON p.product_id   = oi.product_id
WHERE o.order_date BETWEEN '2021-07-01' AND '2021-07-31';

-- 	6.	Which employees work in the same department as 'Jane Smith'? (Use a subquery or a join to find Jane’s department, then match employees.)

select first_name, last_name ,department
from employees 
where department = (select department from employees where first_name = 'Jane' and last_name = 'smith' LIMIT 1); 
-- 	7.	Display each order_id and all associated products in one row 
-- (hint: use a string aggregation function if your SQL dialect supports it, or multiple joins).

select oi.order_id , p.product_name, p.category
from order_items oi 
left join products p
on oi.product_id = p.product_id;


-- 	8.	Show the total_amount of each order compared to the sum of (quantity * item_price) 
-- from order_items (check if they match).

select (oi.quantity * oi.item_price) as total_amount , o.total_amount, o.order_id, oi.order_id
from order_items oi
left join orders o 
on o.order_id = oi.order_id
group by o.order_id, oi.order_id;


-- 	9.	Find the top 3 products (by total quantity sold).
select count(oi.quantity) As quantity_sold, p.product_name 
from order_items oi
left join products p
on oi.product_id = p.product_id
GROUP BY p.product_name
LIMIT 3;
-- 	10.	List all orders along with customer email that had a total_amount > 50.
select o.order_id, o.order_date, o.total_amount, c.email
from orders o
left join customers c
on o.customer_id = c.customer_id
where total_amount > 50;

-- 	11.	Identify any employees who do not have direct reports (no one has them as manager_id).
select employee_id, first_name, last_name , department 
from employees 
where manager_id = (select manager_id from employees where manager_id is  NULL);

-- ALTERNATIVE APPROACH
select e1.employee_id, e1.first_name, e1.last_name, e1.department 
from employees e1
join employees e2
on e1.manager_id = e2.manager_id
where e1.manager_id IS NOT NULL;

-- 	12.	Find any customers who have never placed an order (left join or subquery approach).
select c.first_name, c.last_name 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
where o.order_id IS NULL;

-- ALTERNATIVE APPROACH

SELECT first_name, last_name
from customers 
where customer_id = (SELECT customer_id from orders where total_amount IS NULL);

-- 	13.	List all employees and the name of the manager in a single row 
-- (manager’s first_name + last_name as a single column).

select CONCAT(first_name, " ", last_name) as manager_full_name
from employees
where manager_id = (SELECT DISTINCT(manager_id) from employees where manager_id IS NOT NULL LIMIT 1); 
