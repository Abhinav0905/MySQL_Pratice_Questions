use Amazon_Interview;

-- 1. Create the EMPLOYEES table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2),
    manager_id INT  -- Self-reference to employee_id if someone has a manager
);

-- 2. Create the PRODUCTS table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    created_at DATE
);

-- 3. Create the CUSTOMERS table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    created_at DATE
);

-- 4. Create the ORDERS table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Create the ORDER_ITEMS table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert into EMPLOYEES
INSERT INTO employees 
    (employee_id, first_name, last_name, department, hire_date, salary, manager_id)
VALUES
    (1, 'John', 'Doe', 'Sales',    '2019-01-15', 60000, NULL),
    (2, 'Jane', 'Smith', 'Sales', '2020-03-10', 50000, 1),
    (3, 'Mark', 'Taylor', 'HR',   '2018-05-21', 55000, NULL),
    (4, 'Emily','Clark', 'IT',    '2021-07-09', 65000, NULL),
    (5, 'Michael','Brown', 'IT',  '2022-02-14', 45000, 4);

-- Insert into PRODUCTS
INSERT INTO products 
    (product_id, product_name, category, price, created_at)
VALUES
    (101, 'Wireless Mouse',   'Electronics',  25.99, '2021-01-01'),
    (102, 'Mechanical Keyboard', 'Electronics',  59.99, '2021-02-15'),
    (103, 'Office Chair',     'Furniture',    129.50, '2021-03-10'),
    (104, 'USB-C Cable',      'Electronics',  10.00, '2021-04-20'),
    (105, 'Notebook',         'Stationery',    3.50, '2021-05-05');

-- Insert into CUSTOMERS
INSERT INTO customers 
    (customer_id, first_name, last_name, email, phone, created_at)
VALUES
    (1001, 'Alice', 'Johnson',  'alice@example.com', '555-1234', '2021-01-10'),
    (1002, 'Bob',   'Williams', 'bob@example.com',   '555-2345', '2021-02-11'),
    (1003, 'Carol', 'Davis',    'carol@example.com', '555-3456', '2021-03-12'),
    (1004, 'David', 'Miller',   'david@example.com', '555-4567', '2021-04-13'),
    (1005, 'Eve',   'Wilson',   'eve@example.com',   '555-5678', '2021-05-14');

-- Insert into ORDERS
INSERT INTO orders
    (order_id, customer_id, order_date, total_amount)
VALUES
    (5001, 1001, '2021-06-01', 35.99),
    (5002, 1002, '2021-06-02', 59.99),
    (5003, 1001, '2021-06-05', 10.00),
    (5004, 1003, '2021-06-10', 139.50),
    (5005, 1004, '2021-06-15', 25.99),
    (5006, 1005, '2021-07-01', 3.50),
    (5007, 1003, '2021-07-08', 59.99),
    (5008, 1002, '2021-07-15', 35.99);

-- Insert into ORDER_ITEMS
INSERT INTO order_items
    (order_item_id, order_id, product_id, quantity, item_price)
VALUES
    (1, 5001, 101, 1, 25.99),
    (2, 5001, 104, 1, 10.00),
    (3, 5002, 102, 1, 59.99),
    (4, 5003, 104, 1, 10.00),
    (5, 5004, 103, 1, 129.50),
    (6, 5004, 101, 1, 10.00),  -- Maybe a discount or partial item?
    (7, 5005, 101, 1, 25.99),
    (8, 5006, 105, 1, 3.50),
    (9, 5007, 102, 1, 59.99),
    (10, 5008, 101, 1, 25.99),
    (11, 5008, 104, 1, 10.00);
    
    