
-------------------------------DATA SSCIENCE SQL LESSONS-------------------------------
-------------------------------PAGE: Green Page :LEARNING------------------------------


												--Date: 25 may 2024 Saturday (2 lessons)
												--Section: 3 ve 4 | Day-4
---------------------------------------------------------------------------------------

----------CREATE:

--Create the table: Customers();

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  country     VARCHAR(50),
  score       INTEGER
);

INSERT INTO customers (customer_id, first_name, last_name, country, score) VALUES
(1,'Maria', 'Cramer', 'Germany',350),
(2,'John','Steel','USA', 900),
(3,'Georg','Pipps', 'UK', 750),
(4,'Martin','Müller','Germany', 500),
(5,'Peter','Franken','USA', NULL);


SELECT *
FROM customers


----------SELECT:

SELECT 
	first_name,
	country
FROM customers;


-- create table orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id    SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  DATE,
  quantity    INTEGER
);



---------INSERT:

-- Insert orders data
INSERT INTO orders (order_id, customer_id, order_date, quantity) VALUES
(1001,1,'2021-01-11',250),
(1002,2,'2021-04-05',1150),
(1003,3,'2021-06-18',500),
(1004,6,'2021-08-31',750);


SELECT * FROM orders;

SELECT order_id FROM orders;


-- create table employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id      SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  emp_country VARCHAR(50),
  salary      INTEGER
);


-- Insert employees data
INSERT INTO employees (emp_id, first_name, last_name, emp_country, salary) VALUES
(1,'John', 'Steel', 'USA', 55000),
(2,'Ann', 'Labrune', 'France', 75000),
(3,'Marie', 'Bertrand', 'Brazil', 75000),
(4,'Georg', 'Afonso', 'UK', 75000),
(5,'Marie', 'Steel', 'UK', 75000);

SELECT * FROM employees;


------- DISTINCT: 
-- Secilen sutundaki unique degerleri getirir

--Practice:
SELECT DISTINCT
	country
FROM customers




-------------------------PAGE: Green Page :LEARNING--------------------------------------------
												--Date: 28 may 2024 Tuesday (-Monday holiday)
												--Section: 5 | Day-5


------- ORDER BY:

--Practice:
-- Customer tablosunu score değerlerine göre küçükten büyüğe sıralayarak getir

SELECT * FROM customers
ORDER BY score ASC   -- ASC, DEFAULT olarak ORDER BY tarafından getirilir


--NOTE:
-- PostgreSQL; default olarak NULL hücreyi en sona götürür, MySQL de ise tam tersi şekilde getirir
-- PostgreSQL; Büyükten küçüğe sıralamada NULL hücteyi öncelikli getirir
-- Eğer NULL değerler en üstte gelsin isterseniz: ASC order ile getirebilirisiniz

--Practice:

SELECT * FROM customers
ORDER BY score ASC NULLS FIRST 


--Practice:
--Customer tablosunu score değerlerine göre büyükten küçüğe sıralayarak getir

SELECT * FROM customers
ORDER BY score DESC 


--Practice:
--NULL değerler en altta görünmesini isterseniz;

SELECT * FROM customers
ORDER BY score DESC NULLS LAST


--Practice:
--Country'e göre alfabetik olarak ve score göre büyükten küçüğe sırala;

SELECT *
FROM customers 
ORDER BY country ASC, score DESC 
--> önce country ye göre suraladık, sonra ülkeleri kendi içerisinde score a göre tekrar sıraladık

-- NOTE:
-- Alttaki kullanım çok tavsiye edilmez ama kullanılailbir
-- Field adı yerine sıralamadaki numarasını yazaiblirsiniz..
SELECT * FROM customers
ORDER BY 4 ASC, 5 DESC 



---------LIMIT:
-- Seçilen rakam kadar satır döndürür

--Practice:
SELECT * 
FROM customers
LIMIT 2



----------OFFSET ve LIMIT:
-- OFFSET: yazılan rakam kadar satırı atlayıp sonrakileri getirmenizi sağlar

--Practice:
SELECT * 
FROM customers
OFFSET 2
LIMIT 2
--> ilk 2 satırı atlayıp sonraki 2 satırı döndürür












-------------------------PAGE: Green Page :LEARNING----------------------------------
														--Date: 29 may 2024 Wednesday
														--Section: 6






						

-------------------------PAGE: Green Page :LEARNING-----------------------------------
														--Date: 30 may 2024 Thursday
														--Section: 7





-------------------------PAGE: Orange Page Database: Practices-------------------------
														--Date: 31 may 2024 Friday
														--Section: 8








































