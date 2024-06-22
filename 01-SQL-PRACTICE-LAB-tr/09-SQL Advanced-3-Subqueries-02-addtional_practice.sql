-----------------------------: SQL ADVANCED :-------------------------------

------------------------: SUBQUERIES -EXISTS - IN:--------------------------
-- SQL ADVANCED: Alt sorgular ve EXISTS & IN komutlarını kullanarak gelişmiş SQL sorguları yazma.

-- SUBQUERIES: Bir sorgunun içinde başka bir sorgu yazılması.
-- EXISTS: Belirli bir koşulun sağlanıp sağlanmadığını kontrol eder, eğer alt sorgu bir sonuç dönerse TRUE, aksi takdirde FALSE döner.
-- IN: Belirli bir değerin alt sorgu veya liste içinde olup olmadığını kontrol eder.

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

------------------------: ADDITIONAL PRACTICE :--------------------------

-- 1. Satılmış ürünlerin isimlerini bulun.
SELECT product_name
FROM products
WHERE product_id IN (SELECT DISTINCT product_id FROM sales);

-- 2. Toplamda 15 birimden fazla satılan ürünlerin isimlerini bulun.
SELECT product_name
FROM products
WHERE product_id IN (SELECT product_id 
					FROM sales 
					GROUP BY product_id 
					HAVING SUM(quantity) > 15);

-- 3. Her ürün kategorisinin toplam satış miktarını bulun.
SELECT category, SUM(amount) AS total_sales_amount
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY category;

-- 4. Tüm ürünlerin ortalama fiyatından daha yüksek fiyata sahip ürünleri bulun.
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 5. '2024-01-03' tarihinde satılan ürünleri bulun.
SELECT product_name
FROM products
WHERE product_id IN (SELECT product_id FROM sales WHERE sale_date = '2024-01-03');

-- 6. Her ürün için satılan maksimum miktarı bulun.
SELECT product_name,   (SELECT MAX(quantity) 
						FROM sales 
						WHERE product_id = p.product_id) AS max_quantity
FROM products p;

-- 7. 'Electronics' kategorisinde satılan ürünlerin toplam satış miktarını bulun.
SELECT SUM(amount) AS total_sales_amount
FROM sales
WHERE product_id IN (SELECT product_id FROM products WHERE category = 'Electronics');

-- 8. Hiç satılmamış ürünlerin isimlerini bulun.
SELECT product_name
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM sales);

-- 9. Her ürün için satılan toplam miktarı ve toplam tutarı bulun.
SELECT product_name,
       (SELECT SUM(quantity) FROM sales WHERE product_id = p.product_id) AS total_quantity,
       (SELECT SUM(amount) FROM sales WHERE product_id = p.product_id) AS total_amount
FROM products p;

-- 10. En az iki kez satılmış ürünlerin isimlerini bulun.
SELECT product_name
FROM products
WHERE product_id IN (SELECT product_id FROM sales GROUP BY product_id HAVING COUNT(sale_id) >= 2);

-- 11. 100 brand_id'sine sahip markada çalışan çalışanları göster.
SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id 
    FROM departments 
    WHERE department_id = 100
);

-- 12. Maksimum maaş alan çalışanı göster.
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary) 
    FROM employees
);

-- 13. İkinci en yüksek maaşı göster.
SELECT MAX(salary)
FROM employees
WHERE salary < (
    SELECT MAX(salary) 
    FROM employees
);

-- 14. İkinci en yüksek maaşı alan çalışanı göster.
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

-- 15. Maksimum veya minimum maaş alan çalışanları göster.
SELECT *
FROM employees
WHERE salary IN (
    (SELECT MAX(salary) 
     FROM employees), 
    (SELECT MIN(salary) 
     FROM employees)
);

-- 16. 'Chicago'da çalışan çalışanların çalıştığı markaların brand_id'lerini ve çalışan sayısını göster.
SELECT department_id, department_name
FROM departments
WHERE department_name IN (
						    SELECT DISTINCT department_name 
						    FROM employees 
						    WHERE city = 'Chicago'
);

-- 17. brand_id'si 101'den büyük olan markalarda çalışan çalışanların isimlerini, maaşlarını ve şehirlerini göster.
SELECT first_name, salary, city
FROM employees
WHERE department_id IN (
					    SELECT department_id 
					    FROM departments 
					    WHERE department_id > 101
);

-- 18. Çalışan sayısı 15000'den büyük olan markaların isimlerini ve bu markalarda çalışan çalışanların isimlerini ve maaşlarını göster.
SELECT first_name, salary, department_id
FROM employees
WHERE department_id IN (
					    SELECT department_id 
					    FROM departments 
					    WHERE department_name IN (
											        SELECT department_name 
											        FROM employees 
											        WHERE salary > 15000)
						);

-- 19. Her markanın brand_id'sini, markanın adını ve bulunduğu toplam şehir sayısını göster.
SELECT department_id, department_name, 
       (SELECT COUNT(DISTINCT city) 
        FROM employees 
        WHERE department_id = d.department_id) AS city_count
FROM departments d;

-- 20. Her markanın adını, çalışan sayısını ve maksimum ve minimum maaşlarını göster.
SELECT department_name, 
       (SELECT COUNT(*) 
        FROM employees 
        WHERE department_id = d.department_id) AS employee_count,
       (SELECT MAX(salary) 
        FROM employees 
        WHERE department_id = d.department_id) AS max_salary,
       (SELECT MIN(salary) 
        FROM employees 
        WHERE department_id = d.department_id) AS min_salary
FROM departments d;

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
