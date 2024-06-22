--------------------------: VIEW (Görünümler) :--------------------------

-- VIEW: SQL sorgularının sonuçlarını saklamak için kullanılan sanal tablolar oluşturur.
-- Görünümler, gerçek veri depolamaz; sorgunun sonuçlarını dinamik olarak döndürür.

------------------------: TABLE CREATION :--------------------------

-- Mevcut 'employees' ve 'departments' tablolarını kontrol et ve sil.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- CREATE TABLE: 'employees' tablosunu oluşturur.
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    department_id INT,
    salary DECIMAL(10, 2)
);

-- CREATE TABLE: 'departments' tablosunu oluşturur.
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255)
);

-- INSERT INTO: 'employees' ve 'departments' tablolarına örnek veriler ekler.
INSERT INTO employees (first_name, last_name, department_id, salary) VALUES
('Alice', 'Smith', 1, 70000),
('Bob', 'Johnson', 1, 60000),
('Charlie', 'Brown', 2, 75000),
('David', 'Wilson', 2, 80000),
('Eve', 'Davis', 3, 90000);

INSERT INTO departments (department_name) VALUES
('HR'),
('Finance'),
('IT');

------------------------: PRACTICE :--------------------------

-- 1. 'high_salary_employees' adında bir görünüm oluşturun. Bu görünüm, maaşı 75000'den fazla olan çalışanların bilgilerini içermelidir.
CREATE VIEW high_salary_employees AS
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 75000;

-- 2. 'high_salary_employees' görünümünden tüm çalışan bilgilerini listeleyin.
SELECT *
FROM high_salary_employees;

-- 3. 'department_employees' adında bir görünüm oluşturun. Bu görünüm, her departmandaki çalışanların adlarını ve departman adlarını içermelidir.
CREATE VIEW department_employees AS
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 4. 'department_employees' görünümünden tüm bilgileri listeleyin.
SELECT *
FROM department_employees;

-- 5. 'department_salaries' adında bir görünüm oluşturun. Bu görünüm, her departmandaki toplam maaşları ve departman adlarını içermelidir.
CREATE VIEW department_salaries AS
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 'department_salaries' görünümünden tüm bilgileri listeleyin.
SELECT *
FROM department_salaries;

------------------------: CLEANUP :--------------------------

-- Görünümleri silin.
DROP VIEW IF EXISTS high_salary_employees;
DROP VIEW IF EXISTS department_employees;
DROP VIEW IF EXISTS department_salaries;

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);
DELETE FROM departments WHERE EXISTS (SELECT 1 FROM departments);

-- Tabloları silin.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
