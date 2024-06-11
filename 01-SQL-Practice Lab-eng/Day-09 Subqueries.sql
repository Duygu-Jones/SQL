-----------------------------Day-9: SQL ADVANCED-2-----------------------------------
---------------------------------SUBQUERIES----- ------------------------------------

-- Subqueries: A query nested inside another query.
-- Subqueries can be used with SELECT, INSERT, UPDATE, and DELETE statements.
-- Subqueries must be enclosed within parentheses.


---- Verification queries
--check or drop the tables before creating.
SELECT * FROM products p 
SELECT * FROM sales s 

-- Create 'brands' table
CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50),
    employee_count INT
);

-- Create 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10, 2),
    workplace VARCHAR(50)
);

-- Insert data into 'brands' table
INSERT INTO brands VALUES (100, 'Nike', 20000);
INSERT INTO brands VALUES (101, 'Adidas', 15000);
INSERT INTO brands VALUES (102, 'Puma', 12000);
INSERT INTO brands VALUES (103, 'Reebok', 8000);
INSERT INTO brands VALUES (104, 'Under Armour', 5000);

-- Insert data into 'employees' table
INSERT INTO employees VALUES (1, 'John Doe', 'New York', 5000, 'Nike');
INSERT INTO employees VALUES (2, 'Jane Smith', 'Los Angeles', 6000, 'Adidas');
INSERT INTO employees VALUES (3, 'Emily Davis', 'Chicago', 4000, 'Puma');
INSERT INTO employees VALUES (4, 'Michael Brown', 'Houston', 4500, 'Reebok');
INSERT INTO employees VALUES (5, 'Sarah Wilson', 'Phoenix', 7000, 'Under Armour');
INSERT INTO employees VALUES (6, 'David Miller', 'New York', 5500, 'Nike');
INSERT INTO employees VALUES (7, 'Laura Moore', 'Chicago', 3000, 'Puma');
INSERT INTO employees VALUES (8, 'Daniel Taylor', 'Houston', 3500, 'Reebok');

SELECT * FROM brands;
SELECT * FROM employees;

-- SUBQUERY -- NESTED QUERY -----------------------------------------------------------------------------------------------

-- Subqueries: Using subqueries with WHERE clause

-- Example:
-- 1. Display the employees who work at the brand with brand_id 100.
-- First, find the brand name with brand_id 100.
SELECT brand_name 
FROM brands 
WHERE brand_id = 100; -- Nike -- found from parent table -- unique value

-- Next, find the employees who work at 'Nike'.
SELECT * 
FROM employees 
WHERE workplace = 'Nike'; -- retrieved employees working at 'Nike' from child table

-- Alternative way: Subqueries; also known as "CORRELATED SUBQUERIES"
-- Combining both steps into one: this is the technical usage. The first method is not used.
-- 1: Outer Query 2: Subquery
SELECT *
FROM employees
WHERE workplace = (
    SELECT brand_name 
    FROM brands 
    WHERE brand_id = 100
);

-- 2. Display all fields of the employee who earns the maximum salary.
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary) 
    FROM employees
);

-- 3. Display the second highest salary in the employees table.
SELECT MAX(salary)
FROM employees
WHERE salary < (
    SELECT MAX(salary) 
    FROM employees
);

-- 4. Display all fields of the employee who earns the second highest salary.
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);

-- 5. Display all fields of the employees who earn the maximum or minimum salary.
-- Method 1:
SELECT *
FROM employees 
WHERE salary = (
    SELECT MIN(salary) 
    FROM employees
) 
OR salary = (
    SELECT MAX(salary) 
    FROM employees
);

-- Method 2:
SELECT *
FROM employees
WHERE salary IN (
    (SELECT MAX(salary) 
     FROM employees), 
    (SELECT MIN(salary) 
     FROM employees)
);

-- 6. Display the brand_ids and employee counts of brands that have employees working in 'Chicago'.
-- Static solution:
SELECT brand_id, employee_count
FROM brands
WHERE brand_name IN ('Nike', 'Adidas', 'Puma');

-- Dynamic solution using subquery:
SELECT brand_id, employee_count
FROM brands
WHERE brand_name IN (
    SELECT workplace 
    FROM employees 
    WHERE city = 'Chicago'
);

-- 7. Display the names, salaries, and cities of employees who work at brands with brand_id greater than 101.
SELECT name, salary, city
FROM employees
WHERE workplace IN (
    SELECT brand_name 
    FROM brands 
    WHERE brand_id > 101
);

-- 8. Display the names of brands with employee count greater than 15000 and the names and salaries of employees working at these brands.
SELECT name, salary, workplace
FROM employees
WHERE workplace IN (
    SELECT brand_name 
    FROM brands 
    WHERE employee_count > 15000
);

-- Subqueries: Using subqueries after SELECT command ---------------------------------------------------------------------------
-- Examples:

-- 9. Display the brand_id, brand_name, and the total number of distinct cities each brand is located in.
SELECT brand_id, brand_name, 
       (SELECT COUNT(DISTINCT city) 
        FROM employees 
        WHERE workplace = brand_name) AS city_count
FROM brands;

-- NOTE: DISTINCT removes duplicate values.
SELECT DISTINCT(city) 
FROM employees; -- counts each city only once

-- 10. Display the brand_name, employee_count, and the maximum and minimum salaries of employees for each brand.
-- Only one max and min value per brand -- aggregate
SELECT brand_name, employee_count, 
       (SELECT MAX(salary) 
        FROM employees 
        WHERE workplace = brand_name) AS max_salary,
       (SELECT MIN(salary) 
        FROM employees 
        WHERE workplace = brand_name) AS min_salary
FROM brands;





------------------------------------------ADDITIONAL PRACTICE AND NOTES FOR SUBQUERIES:---------


---- Verification queries
--check or drop the tables before creating.
SELECT * FROM products p 
SELECT * FROM sales s 


-- Create 'products' table
CREATE TABLE products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create 'sales' table
CREATE TABLE sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

-- Insert data into 'products' table
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 800.00),
(2, 'Smartphone', 'Electronics', 600.00),
(3, 'Tablet', 'Electronics', 300.00),
(4, 'Headphones', 'Accessories', 50.00),
(5, 'Charger', 'Accessories', 20.00);

-- Insert data into 'sales' table
INSERT INTO sales VALUES
(1, 1, '2024-01-01', 5, 4000.00),
(2, 2, '2024-01-01', 10, 6000.00),
(3, 3, '2024-01-02', 15, 4500.00),
(4, 4, '2024-01-02', 20, 1000.00),
(5, 5, '2024-01-03', 25, 500.00),
(6, 1, '2024-01-03', 3, 2400.00),
(7, 2, '2024-01-04', 8, 4800.00),
(8, 3, '2024-01-04', 12, 3600.00),
(9, 4, '2024-01-05', 18, 900.00),
(10, 5, '2024-01-05', 22, 440.00);

----------------- Practical Questions with Subqueries----------------------------

-- 1. Find the product names of the products that have been sold.
-- Query: Display the names of products that have been sold.
SELECT ProductName
FROM products
WHERE ProductID IN (SELECT DISTINCT ProductID FROM sales);

-- 2. Find the names of products sold more than 15 units in total.
-- Query: Display the names of products that have been sold more than 15 units in total.
SELECT ProductName
FROM products
WHERE ProductID IN (SELECT ProductID FROM sales GROUP BY ProductID HAVING SUM(Quantity) > 15);

-- 3. Find the total sales amount of each product category.
-- Query: Display the total sales amount for each product category.
SELECT Category, SUM(Amount) AS TotalSalesAmount
FROM products p
JOIN sales s ON p.ProductID = s.ProductID
GROUP BY Category;

-- 4. Find the products with a price higher than the average price of all products.
-- Query: Display the names and prices of products that have a price higher than the average price of all products.
SELECT ProductName, Price
FROM products
WHERE Price > (SELECT AVG(Price) FROM products);

-- 5. Find the products sold on '2024-01-03'.
-- Query: Display the names of products sold on '2024-01-03'.
SELECT ProductName
FROM products
WHERE ProductID IN (SELECT ProductID FROM sales WHERE SaleDate = '2024-01-03');

-- 6. Find the maximum quantity sold for each product.
-- Query: Display the product names and the maximum quantity sold for each product.
SELECT ProductName, (SELECT MAX(Quantity) FROM sales WHERE ProductID = p.ProductID) AS MaxQuantity
FROM products p;

-- 7. Find the total sales amount for products sold in the 'Electronics' category.
-- Query: Display the total sales amount for products sold in the 'Electronics' category.
SELECT SUM(Amount) AS TotalSalesAmount
FROM sales
WHERE ProductID IN (SELECT ProductID FROM products WHERE Category = 'Electronics');

-- 8. Find the names of products that have never been sold.
-- Query: Display the names of products that have never been sold.
SELECT ProductName
FROM products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM sales);

-- 9. Find the total quantity sold and total amount for each product.
-- Query: Display the product names, total quantity sold, and total amount for each product.
SELECT ProductName,
       (SELECT SUM(Quantity) FROM sales WHERE ProductID = p.ProductID) AS TotalQuantity,
       (SELECT SUM(Amount) FROM sales WHERE ProductID = p.ProductID) AS TotalAmount
FROM products p;

-- 10. Find the products that have been sold at least twice.
-- Query: Display the names of products that have been sold at least twice.
SELECT ProductName
FROM products
WHERE ProductID IN (SELECT ProductID FROM sales GROUP BY ProductID HAVING COUNT(SaleID) >= 2);














