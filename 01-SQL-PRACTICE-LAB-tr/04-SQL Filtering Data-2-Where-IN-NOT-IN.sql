------------------------: IN, NOT IN, BETWEEN ve NOT BETWEEN :--------------------------

-- SQL IN, NOT IN, BETWEEN ve NOT BETWEEN: Belirli bir değerin alt sorgu veya liste içinde olup olmadığını ve bir aralıkta olup olmadığını kontrol eder.
-- IN: Belirli bir değerin alt sorgu veya liste içinde olup olmadığını kontrol eder.
-- NOT IN: Belirli bir değerin alt sorgu veya liste içinde olmadığını kontrol eder.
-- BETWEEN: Belirli bir değerin belirli bir aralıkta olup olmadığını kontrol eder.
-- NOT BETWEEN: Belirli bir değerin belirli bir aralıkta olmadığını kontrol eder.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloları kontrol et ve sil.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2),
    city VARCHAR(50)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    amount DECIMAL(10, 2),
    sale_date DATE
);

-- INSERT INTO: 'employees', 'departments', 'products' ve 'sales' tablolarına örnek veriler ekler.
INSERT INTO employees (employee_id, first_name, last_name, email, department_id, salary, city) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', 1, 70000, 'Chicago'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', 1, 60000, 'New York'),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com', 2, 75000, 'San Francisco'),
(4, 'David', 'Wilson', 'david.wilson@example.com', 3, 80000, 'Los Angeles'),
(5, 'Eve', 'Davis', 'eve.davis@example.com', 2, 90000, 'Chicago');

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Product A', 'Electronics', 100.00),
(2, 'Product B', 'Electronics', 150.00),
(3, 'Product C', 'Clothing', 50.00),
(4, 'Product D', 'Clothing', 80.00),
(5, 'Product E', 'Electronics', 200.00);

INSERT INTO sales (sale_id, product_id, quantity, amount, sale_date) VALUES
(1, 1, 5, 500.00, '2024-01-01'),
(2, 2, 10, 1500.00, '2024-01-02'),
(3, 3, 20, 1000.00, '2024-01-03'),
(4, 4, 15, 1200.00, '2024-01-04'),
(5, 5, 8, 1600.00, '2024-01-05');



------------------------: PRACTICE :--------------------------

-- 1. IN: 'HR' ve 'Finance' departmanlarında çalışanların isimlerini ve departmanlarını bulun.
SELECT 
    first_name, 
    last_name, 
    department_id 
FROM 
    employees 
WHERE 
    department_id IN (1, 2);

-- 2. NOT IN: 'Electronics' kategorisindeki ürünler dışında kalan ürünlerin isimlerini bulun.
SELECT 
    product_name 
FROM 
    products 
WHERE 
    category NOT IN ('Electronics');

-- 3. IN: '2024-01-01' ve '2024-01-03' tarihlerinde satılan ürünlerin isimlerini bulun.
SELECT 
    product_name 
FROM 
    products 
WHERE 
    product_id IN (SELECT product_id FROM sales WHERE sale_date IN ('2024-01-01', '2024-01-03'));

-- 4. NOT IN: Maaşı 80000'den az olan ve 'Chicago' şehrinde çalışmayan çalışanların isimlerini bulun.
SELECT 
    first_name, 
    last_name, 
    city 
FROM 
    employees 
WHERE 
    salary < 80000 
    AND city NOT IN ('Chicago');

-- 5. BETWEEN: '2024-01-01' ile '2024-01-04' tarihleri arasında satılan ürünlerin isimlerini bulun.
SELECT 
    product_name 
FROM 
    products 
WHERE 
    product_id IN (SELECT product_id FROM sales WHERE sale_date BETWEEN '2024-01-01' AND '2024-01-04');

-- 6. NOT BETWEEN: Fiyatı 100 ile 200 arasında olmayan ürünlerin isimlerini bulun.
SELECT 
    product_name, 
    price 
FROM 
    products 
WHERE 
    price NOT BETWEEN 100 AND 200;

-- 7. BETWEEN: Maaşı 60000 ile 80000 arasında olan çalışanların isimlerini ve maaşlarını bulun.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    salary BETWEEN 60000 AND 80000;

-- 8. NOT BETWEEN: 'Electronics' kategorisinde olup fiyatı 150 ile 200 arasında olmayan ürünlerin isimlerini bulun.
SELECT 
    product_name, 
    price 
FROM 
    products 
WHERE 
    category = 'Electronics' 
    AND price NOT BETWEEN 150 AND 200;

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);
DELETE FROM departments WHERE EXISTS (SELECT 1 FROM departments);
DELETE FROM products WHERE EXISTS (SELECT 1 FROM products);
DELETE FROM sales WHERE EXISTS (SELECT 1 FROM sales);

-- Tabloları silin.
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
