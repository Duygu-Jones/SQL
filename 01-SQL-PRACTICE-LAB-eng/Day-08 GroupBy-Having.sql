-----------------------------Day-8: SQL ADVANCED-1-----------------------------------
-------------------------------GROUP BY - HAVING ------------------------------------

-- GROUP BY: Groups rows that have the same values into summary rows.
-- HAVING: Applies a condition to groups formed by the GROUP BY clause.


-- Create 'Products' table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create 'Sales' table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert data into 'Products' table
INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 800.00),
(2, 'Smartphone', 'Electronics', 600.00),
(3, 'Tablet', 'Electronics', 300.00),
(4, 'Headphones', 'Accessories', 50.00),
(5, 'Charger', 'Accessories', 20.00);

-- Insert data into 'Sales' table
INSERT INTO Sales (SaleID, ProductID, SaleDate, Quantity, Amount) VALUES
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

---- Verification queries
--check or drop the tables before creating.
SELECT * FROM products p 
SELECT * FROM sales s 

-- Practical Questions with GROUP BY and HAVING

-- 1. Group the total sales amount by product.
-- Soru: Ürün bazında toplam satış miktarını gruplandırın.
SELECT
    ProductID,
    SUM(Amount) AS TotalSalesAmount
FROM Sales
GROUP BY ProductID;

-- 2. Group the total quantity sold by product category.
-- Soru: Ürün kategorisi bazında satılan toplam miktarı gruplandırın.
SELECT
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- 3. Find the total sales amount for each product where the total amount is greater than 5000.
-- Soru: Toplam satış miktarı 5000'den fazla olan her ürün için toplam satış miktarını bulun.
SELECT
    ProductID,
    SUM(Amount) AS TotalSalesAmount
FROM Sales
GROUP BY ProductID
HAVING SUM(Amount) > 5000;

-- 4. Group the total sales amount by sale date.
-- Soru: Satış tarihine göre toplam satış miktarını gruplandırın.
SELECT
    SaleDate,
    SUM(Amount) AS TotalSalesAmount
FROM Sales
GROUP BY SaleDate;

-- 5. Find the average sales amount per product.
-- Soru: Ürün başına ortalama satış miktarını bulun.
SELECT
    ProductID,
    AVG(Amount) AS AverageSalesAmount
FROM Sales
GROUP BY ProductID;

-- 6. Group the total quantity sold by product and find those products with a total quantity sold greater than 30.
-- Soru: Ürün bazında satılan toplam miktarı gruplandırın ve toplam satılan miktarı 30'dan fazla olan ürünleri bulun.
SELECT
    ProductID,
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
GROUP BY ProductID
HAVING SUM(Quantity) > 30;

-- 7. Find the total sales amount for each product category where the average sales amount is greater than 1000.
-- Soru: Ortalama satış miktarı 1000'den fazla olan her ürün kategorisi için toplam satış miktarını bulun.
SELECT
    p.Category,
    SUM(s.Amount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category
HAVING AVG(s.Amount) > 1000;

-- 8. Group the total sales amount by product and sale date.
-- Soru: Ürün ve satış tarihine göre toplam satış miktarını gruplandırın.
SELECT
    ProductID,
    SaleDate,
    SUM(Amount) AS TotalSalesAmount
FROM Sales
GROUP BY ProductID, SaleDate;

-- 9. Find the total quantity sold and average sales amount for each product category.
-- Soru: Her ürün kategorisi için satılan toplam miktarı ve ortalama satış miktarını bulun.
SELECT
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold,
    AVG(s.Amount) AS AverageSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- 10. Group the total quantity sold by product and find those products with an average sales amount greater than 1000.
-- Soru: Ürün bazında satılan toplam miktarı gruplandırın ve ortalama satış miktarı 1000'den fazla olan ürünleri bulun.
SELECT
    ProductID,
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
GROUP BY ProductID
HAVING AVG(Amount) > 1000;






-------------------ADDITIONAL PRACTICE AND NOTES FOR GROUP BY - HAVING:-------------------------------

-- Create 'grocer' table
CREATE TABLE grocer (
    name VARCHAR(50),
    product_name VARCHAR(50),
    product_quantity INT
);

-- Insert data into 'grocer' table
INSERT INTO grocer VALUES ('John', 'Apple', 5);
INSERT INTO grocer VALUES ('Jane', 'Pear', 3);
INSERT INTO grocer VALUES ('Mike', 'Apple', 2);  
INSERT INTO grocer VALUES ('James', 'Grapes', 4);  
INSERT INTO grocer VALUES ('John', 'Pear', 2);  
INSERT INTO grocer VALUES ('Jane', 'Apple', 3);  
INSERT INTO grocer VALUES ('Mike', 'Grapes', 5);  
INSERT INTO grocer VALUES ('John', 'Pear', 2);  
INSERT INTO grocer VALUES ('Mike', 'Apple', 3);  
INSERT INTO grocer VALUES ('Jane', 'Grapes', 2);

SELECT * FROM grocer;

-- GROUP BY clause: -----------------------------------------------------------
-- EXAMPLES

-- 1. Display all names in the grocer table and the total product quantity for each name.
SELECT name, SUM(product_quantity)
FROM grocer
GROUP BY name;

-- 2. Display all names in the grocer table and the total product quantity for each name, sorted by total product quantity in descending order.
SELECT name, SUM(product_quantity) AS total_kg
FROM grocer
GROUP BY name
ORDER BY total_kg DESC;

-- 3. Display the total quantity of each product for each name, sorted by name.
SELECT name, product_name, SUM(product_quantity) AS total_kg
FROM grocer
GROUP BY name, product_name
ORDER BY name;

-- NOTE: When grouping with GROUP BY, only "grouped columns" or the result of an aggregate function can be used after SELECT.
-- In other words, after SELECT name, ...... an aggregate function can follow to create a single-column result for each group.
-- If a column that provides multiple results is created, grouping is disrupted.

-- 4. Display the total quantity of each product for each name, sorted by name.
SELECT name, SUM(product_quantity)
FROM grocer
GROUP BY name;

-- 5. This query will result in an error as "product_quantity" must appear in the GROUP BY clause or be used in an aggregate function.
-- SELECT name, product_quantity
-- FROM grocer
-- GROUP BY name;

-- 6. Display the total number of distinct people who have taken each product, grouped by product name.
SELECT product_name, COUNT(DISTINCT name) AS person_count
FROM grocer
GROUP BY product_name;

-- 7. Find the total product quantity and the number of distinct product types taken by each person, grouped by name.
SELECT name, SUM(product_quantity) AS total_kg, COUNT(DISTINCT product_name) AS product_variety
FROM grocer
GROUP BY name;

-- 8. Display the number of customers based on the product quantity taken, sorted in ascending order by the number of customers.
SELECT product_quantity, COUNT(DISTINCT name) AS customer_count
FROM grocer
GROUP BY product_quantity
ORDER BY customer_count ASC;

-- Create 'employees' table
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    city VARCHAR(50), 
    salary INT,  
    company VARCHAR(20)
);

-- Insert data into 'employees' table
INSERT INTO employees VALUES (123456789, 'John Smith', 'New York', 5500, 'Honda'); 
INSERT INTO employees VALUES (234567890, 'Michael Johnson', 'New York', 4500, 'Toyota'); 
INSERT INTO employees VALUES (345678901, 'William Brown', 'Chicago', 3500, 'Honda');
INSERT INTO employees VALUES (456789012, 'James Davis', 'Los Angeles', 6000, 'Ford'); 
INSERT INTO employees VALUES (567890123, 'Robert Miller', 'Chicago', 7000, 'GM');
INSERT INTO employees VALUES (678901245, 'David Wilson', 'Chicago', 4500, 'Ford');  
INSERT INTO employees VALUES (123456710, 'Mary Moore', 'Houston', 4500, 'Honda');

SELECT * FROM employees;



-- HAVING clause: ----------------------------------------------------------------------------------------
-- *** Used with AGGREGATION functions after the GROUP BY command for filtering.
-- If the filtering operation after grouping returns multiple results, the grouping becomes meaningless.
-- Therefore, if you need to filter groups after using GROUP BY, you use the HAVING clause with an aggregate function.

-- EXAMPLES

-- 1. Display the MIN salary of each company, if this value is greater than 4000.
SELECT company, MIN(salary) AS min_salary
FROM employees
GROUP BY company
HAVING MIN(salary) > 4000;

-- 2. Display the MIN salary of each company for employees with a salary greater than 4000.
SELECT company, MIN(salary) AS min_salary
FROM employees
WHERE salary > 4000
GROUP BY company;

-- NOTE: Use HAVING to specify a condition on the result of a grouping operation,
-- and use WHERE to filter records before grouping.

-- 3. Display the name and total salary of each employee if the total income is more than 10000.
SELECT name, SUM(salary) AS total_salary
FROM employees
GROUP BY name
HAVING SUM(salary) > 10000;

-- 4. Display the name of the city and the number of employees working there if the number of employees is more than 1.
SELECT city, COUNT(DISTINCT id) AS employee_count
FROM employees
GROUP BY city
HAVING COUNT(DISTINCT id) > 1;




















