-- Create database
create database dash;
use dash;

-- Create tables
create TABLE customers (
    customer_id int AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(30),
    last_name varchar(30),
    address varchar(100),
    postcode varchar(10),
    city varchar(30),
    country varchar(30),
    ascii_safe_email varchar(100),
    date_of_birth datetime
);

create TABLE orders (
    id int PRIMARY KEY,
    order_id int,
    product_id int,
    unitprice float,
    quantity int,
    customer_id int,
    order_date datetime,
    employee_id int,
    deliverydate datetime
);

create TABLE employees (
    employee_id int AUTO_INCREMENT PRIMARY KEY,
    firstname varchar(30),
    lastname varchar(30),
    date_of_birth datetime
);

create TABLE products (
    product_id int AUTO_INCREMENT PRIMARY KEY,
    product_name varchar(30),
    stock int,
    reorder int,
    type varchar(10)
);

-- IMPORT DATA FROM EXCEL TO TABLES HERE --
-- IMPORT DATA FROM EXCEL TO TABLES HERE --
-- IMPORT DATA FROM EXCEL TO TABLES HERE --


-- Product 0 is clearly innocent souls
INSERT INTO products (product_id, product_name, stock, reorder, type) VALUES (0, 'Innocent Souls', 99999, 99998, 'Recycled');
-- Inserting 0 into product_id failed
UPDATE products SET product_id = 0 where product_name = 'Innocent Souls';


-- Create view for sales by employee
CREATE VIEW sales_by_employee as
select concat_ws(' ', firstname, lastname) as employee, sum(quantity) as total_sales, sum(unitprice) as total_revenue from employees e
JOIN orders o ON e.employee_id = o.employee_id
group BY e.employee_id;

-- Create view for sales by product
CREATE VIEW sales_by_product as
select product_name, sum(quantity) as total_sales, sum(unitprice) as total_revenue from products p
JOIN orders o ON p.product_id = o.product_id
group by p.product_id;