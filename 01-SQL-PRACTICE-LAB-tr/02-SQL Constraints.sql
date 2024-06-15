------------------------: CONSTRAINTS :--------------------------

-- SQL CONSTRAINTS: Kısıtlamalar, tablo sütunlarına uygulanan kurallardır.
-- Bu kurallar, veritabanındaki verilerin doğruluğunu ve bütünlüğünü sağlar.
-- Yaygın SQL kısıtlamaları:
-- PRIMARY KEY: Her satırı benzersiz bir şekilde tanımlar.
-- FOREIGN KEY: Bir tablodaki değerin başka bir tablodaki değere karşılık gelmesini sağlar.
-- UNIQUE: Sütundaki tüm değerlerin benzersiz olmasını sağlar.
-- NOT NULL: Sütundaki değerlerin boş olmasını engeller.
-- CHECK: Belirli bir koşulu sağlayan değerler eklenmesini sağlar.
-- DEFAULT: Bir sütun için varsayılan bir değer belirler.

-- Table daha önce oluşturulmuş mu kontrol et:
SELECT * FROM employees;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
-- Bu tablo çeşitli kısıtlamalar içerir.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    first_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    last_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    email VARCHAR(100) UNIQUE, -- UNIQUE: Benzersiz olmalı
    hire_date DATE,
    salary DECIMAL(10, 2) CHECK (salary > 0), -- CHECK: Pozitif olmalı
    department_id INT
);

-- INSERT DATA: 'employees' tablosuna örnek veriler ekler.
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, salary, department_id) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2021-01-15', 55000.00, 3),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2020-03-22', 60000.00, 2),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '2019-07-10', 70000.00, 1),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '2022-05-30', 52000.00, 4),
(5, 'William', 'Brown', 'william.brown@example.com', '2021-11-19', 65000.00, 3);

--------------------------------------------

-- Table daha önce oluşturulmuş mu kontrol et:
SELECT * FROM departments;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
-- Bu tablo 'employees' tablosuyla ilişkilendirilecektir.
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    budget DECIMAL(10, 2) DEFAULT 0.00 -- DEFAULT: Varsayılan değer
);

-- INSERT DATA: 'departments' tablosuna örnek veriler ekler.
INSERT INTO departments (department_id, department_name, budget) VALUES
(1, 'Human Resources', 100000.00),
(2, 'Finance', 200000.00),
(3, 'IT', 150000.00),
(4, 'Marketing', 120000.00);


----------------: PRACTICE :--------------------

-- Mevcut tüm çalışanları seç ve görüntüle.
SELECT * 
FROM employees;

-- Belirli sütunları seç: Çalışanların sadece adlarını ve maaşlarını seç.
SELECT 
    first_name, 
    salary 
FROM employees;

-- WHERE: Belirli bir koşula göre verileri filtreler.
-- Maaşı 60000'den büyük olan çalışanları seç.
SELECT * 
FROM employees 
WHERE salary > 60000;

-- WHERE ile birden fazla koşul kullanma: Maaşı 60000'den büyük ve departmanı 2 olan çalışanları seç.
SELECT * 
FROM employees 
WHERE 
    salary > 60000 
    AND department_id = 2;
