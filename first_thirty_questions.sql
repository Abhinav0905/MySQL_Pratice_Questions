--- 25 Query Basics Questions

-- Below are 25 questions that help you practice basic SQL operations. Use SELECT, FROM, WHERE, GROUP BY, ORDER BY, LIMIT, etc.
-- 1.	List all employees with their full names (first and last) and department.
select first_name, last_name , department 
from 
employees;
-- 2.	Find all products whose price is greater than 20.
select product_id, product_name, price
from products
where price > 20;
-- 3.	Select all orders placed in June 2021 (i.e., order_date between 2021-06-01 and 2021-06-30).
select * from orders
where order_date between '2021-06-01' and '2021-06-30';
-- 4.	Show only distinct product categories from the products table.
select distinct(category) from products;
-- 5.	List all customers who joined (created_at) after April 1, 2021.
select * from customers 
where created_at > '2021-04-01';
-- 6.	Calculate the count of employees in each department (group by department).
select department, count(*) from employees 
group by department;
-- 7.	Which orders have a total_amount below 20?
select order_id, order_date, total_amount from 
orders
where total_amount < 20;
-- 8.	Find the average salary of employees in the HR department.
select avg(salary) from employees where 
department = 'HR';
-- 9.	Show the total number of orders for each customer (group by customer_id).
select count(order_id) ,  customer_id 
from orders 
group by customer_id;
-- 10.	Retrieve employees whose last_name starts with 'C'.
select last_name from employees
where last_name LIKE 'c%';
-- 11.	List products in ascending order of product_name.
select product_id, product_name 
from products
order by product_name ;
-- 12.	Find the maximum and minimum product price in the products table.

select MAX(price), product_id, product_name
from products
group by product_name;

-- 13.	Display the sum of all order_items.quantity sold across all orders.

select sum(item_price * quantity) as sum_of_all_orders , order_id, product_id
from order_items
group by product_id, order_id;
-- 14.	List the employees hired in 2021.
select * from employees 
where hire_date between  '2021-01-01' and '2021-12-31'; 
-- 15.	Count how many employees do not have a manager (manager_id IS NULL).
select count(*) from employees where manager_id IS NULL;
-- 16.	Find the total amount spent by customer_id = 1001 (sum of orders.total_amount).
select total_amount from orders
where customer_id = 1001;
-- 17.	Which employees have a salary between 45,000 and 60,000?
select * from employees 
where salary between '45000' and '60000';
-- 18.	Retrieve products where product_name contains the word 'Mouse' (case-insensitive search).
select * from products 
where product_name LIKE '%Mouse%';
-- 19.	Show the order dates and total_amount for all orders sorted by order_date descending.
select order_date, total_amount from orders 
order by order_date DESC;
-- 20.	Find the number of orders placed each day in June 2021 (group by day).
select DAY(order_date), count(order_id) from orders
where order_date BETWEEN '2021-06-01' and '2021-06-31'

order by order_date DESC;

-- 21.	List the first 3 employees with the highest salaries.
select * from employees 
order by salary DESC
LIMIT 3;
-- 22.	Show all order_items where quantity is greater than 1 (if any).
select * from order_items
where quantity > '1' ; 
-- 23.	Get the average price of products in the 'Electronics' category.
select avg(price) from products where category = 'Electronics';
-- 24.	Which employees have department = 'IT' OR department = 'Sales'?
select * from employees where department = 'IT' or department ='Sales';
-- 25.	Display the total of order_items.item_price * order_items.quantity for each order_id (i.e., the sum of line items).
select sum(quantity*item_price) as 'total_order_amount', order_id 
from order_items
group by order_id;

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
-- 	5.	List the customer’s name, order_date, and product_name for all orders in July 2021 (in a single query).
-- 	6.	Which employees work in the same department as 'Jane Smith'? (Use a subquery or a join to find Jane’s department, then match employees.)
-- 	7.	Display each order_id and all associated products in one row (hint: use a string aggregation function if your SQL dialect supports it, or multiple joins).
-- 	8.	Show the total_amount of each order compared to the sum of (quantity * item_price) from order_items (check if they match).
-- 	9.	Find the top 3 products (by total quantity sold).
-- 	10.	List all orders along with customer email that had a total_amount > 50.
-- 	11.	Identify any employees who do not have direct reports (no one has them as manager_id).
-- 	12.	Find any customers who have never placed an order (left join or subquery approach).
-- 	13.	List all employees and the name of the manager in a single row (manager’s first_name + last_name as a single column).
-- 	14.	Join products and order_items to show the total revenue generated per product (price * total quantity sold).
-- 	15.	Which customers have purchased both 'Wireless Mouse' and 'USB-C Cable'? (Set intersection logic.)
-- 	16.	Find the most expensive order based on the sum of order_items. (Check if it matches orders.total_amount.)
-- 	17.	Show the employee name and department for employees who manage at least one other employee.
-- 	18.	Which product is the least popular by total quantity sold?
-- 	19.	Display each order and the corresponding product categories included in that order.
-- 	20.	List all customers who ordered a 'Mechanical Keyboard' after '2021-06-01'.
-- 	21.	For each department, list the average salary of employees. Only include departments that have more than 1 employee.
-- 	22.	Show the orders placed by 'Alice Johnson' (customer_id 1001) along with each product_name.
-- 	23.	Identify the customer(s) who placed the largest single order (by total_amount).
-- 	24.	List the product names that have never been ordered.
-- 	25.	Show the customer’s name, order_date, and the number of items in each order (sum of quantity).