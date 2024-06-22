-----------------------------: SQL ADVANCED :-------------------------------

------------------------: SUBQUERIES -EXISTS - IN:--------------------------

-- SQL ADVANCED: Alt sorgular ve EXISTS & IN komutlarını kullanarak gelişmiş SQL sorguları yazma.

-- SUBQUERIES: Bir sorgunun içinde başka bir sorgu yazılması.
-- EXISTS: Belirli bir koşulun sağlanıp sağlanmadığını kontrol eder, eğer alt sorgu bir sonuç dönerse TRUE, aksi takdirde FALSE döner.
-- IN: Belirli bir değerin alt sorgu veya liste içinde olup olmadığını kontrol eder.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- INSERT INTO: 'employees' ve 'departments' tablolarına örnek veriler ekler.
INSERT INTO employees (employee_id, first_name, last_name, email, department_id, salary) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', 1, 70000),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', 1, 60000),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com', 2, 75000),
(4, 'David', 'Wilson', 'david.wilson@example.com', 3, 80000),
(5, 'Eve', 'Davis', 'eve.davis@example.com', 2, 90000);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

------------------------: PRACTICE :--------------------------

-- 1. SUBQUERY: Çalışanların maaşlarının ortalamasını hesapla.
SELECT 
    AVG(salary) AS avg_salary 
FROM 
    employees;

-- 2. SUBQUERY: Maaşı ortalama maaştan yüksek olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    salary > (SELECT AVG(salary) FROM employees);

-- 3. EXISTS: 'HR' departmanında çalışan olup olmadığını kontrol et.
SELECT 
    EXISTS (SELECT 1 FROM employees WHERE department_id = 1) AS hr_exists;

-- 4. IN: 'HR' ve 'Finance' departmanlarında çalışanların isimlerini ve departmanlarını seç.
SELECT 
    first_name, 
    last_name, 
    department_id 
FROM 
    employees 
WHERE 
    department_id IN (1, 2);

-- 5. SUBQUERY: 'Finance' departmanında çalışanların sayısını hesapla.
SELECT 
    COUNT(*) AS finance_count 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance');

-- 6. COMPLEX SUBQUERY: 'Finance' departmanında çalışan ve maaşı ortalama maaştan yüksek olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance') 
    AND salary > (SELECT AVG(salary) FROM employees);

-- 7. EXISTS: 'IT' departmanında çalışanların bilgilerini göster, eğer 'IT' departmanı varsa.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    email 
FROM 
    employees 
WHERE 
    EXISTS (SELECT 1 FROM departments WHERE department_id = employees.department_id AND department_name = 'IT');

-- 8. IN: Maaşı 70000 ve 80000 olan çalışanların isimlerini ve maaşlarını seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    salary IN (70000, 80000);

-- 9. SUBQUERY: Her departmandaki en yüksek maaşı alan çalışanları seç.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    department_id, 
    salary 
FROM 
    employees e 
WHERE 
    salary = (SELECT MAX(salary) FROM employees WHERE department_id = e.department_id);

-- 10. SUBQUERY: Her departmandaki çalışan sayısını göster.
SELECT 
    department_name, 
    (SELECT COUNT(*) FROM employees WHERE department_id = d.department_id) AS employee_count 
FROM 
    departments d;

-- 11. EXISTS: 'Finance' departmanında çalışanların bilgilerini göster, eğer 'Finance' departmanı varsa.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    email 
FROM 
    employees 
WHERE 
    EXISTS (SELECT 1 FROM departments WHERE department_id = employees.department_id AND department_name = 'Finance');

-- 12. COMPLEX SUBQUERY: 'HR' ve 'IT' departmanlarında çalışan ve maaşı 75000'den yüksek olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id IN (SELECT department_id FROM departments WHERE department_name IN ('HR', 'IT')) 
    AND salary > 75000;

-- 13. IN: 'HR' ve 'Finance' departmanlarında çalışanların isimlerini ve maaşlarını seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id IN (SELECT department_id FROM departments WHERE department_name IN ('HR', 'Finance'));

-- 14. SUBQUERY: En yüksek maaşı alan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    salary = (SELECT MAX(salary) FROM employees);

-- 15. EXISTS: 'Finance' departmanında çalışan ve maaşı ortalama maaştan yüksek olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance') 
    AND EXISTS (SELECT 1 FROM employees e WHERE e.salary > (SELECT AVG(salary) FROM employees));

-- 16. COMPLEX SUBQUERY: 'HR' departmanında çalışan ve maaşı en yüksek 3 çalışanı seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'HR') 
ORDER BY 
    salary DESC 
LIMIT 3;

-- 17. SUBQUERY: Her departmandaki en düşük maaşı alan çalışanları seç.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    department_id, 
    salary 
FROM 
    employees e 
WHERE 
    salary = (SELECT MIN(salary) FROM employees WHERE department_id = e.department_id);

-- 18. EXISTS: 'IT' departmanında çalışan ve maaşı 75000'den yüksek olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'IT') 
    AND EXISTS (SELECT 1 FROM employees e WHERE e.salary > 75000);

-- 19. SUBQUERY: 'HR' departmanında çalışanların isimlerini ve ortalama maaşlarını göster.
SELECT 
    first_name, 
    last_name, 
    (SELECT AVG(salary) FROM employees WHERE department_id = 1) AS avg_salary 
FROM 
    employees 
WHERE 
    department_id = 1;

-- 20. COMPLEX SUBQUERY: 'Finance' departmanında çalışan ve maaşı 80000'den düşük olan çalışanları seç.
SELECT 
    first_name, 
    last_name, 
    salary 
FROM 
    employees 
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance') 
    AND salary < 80000;

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);
DELETE FROM departments WHERE EXISTS (SELECT 1 FROM departments);

-- Tabloları silin.
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
