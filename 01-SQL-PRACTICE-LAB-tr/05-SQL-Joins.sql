------------------------: JOIN DATA :--------------------------

-- SQL COMMANDS: Veritabanı tablolarını birleştirmek ve veritabanı sorgularını birleştirmek için kullanılan komutlar.

-- JOIN: İki veya daha fazla tabloyu belirli bir koşula göre birleştirir.
-- JOIN komutu, iki veya daha fazla tabloyu birleştirir ve birleştirilen sütunlardaki eşleşen değerler üzerinden çalışır.

-- INNER JOIN: Her iki tablodaki eşleşen kayıtları döndürür.
-- INNER JOIN, sadece her iki tabloda da bulunan değerlerin sonuç kümesine dahil edilmesini sağlar.

-- LEFT JOIN: Sol tablodaki tüm kayıtları ve sağ tablodaki eşleşen kayıtları döndürür.
-- Eşleşen bir kayıt yoksa, sağ tablodaki sütunlar için NULL değerler döndürülür. 
-- Bu, sol tablodaki tüm kayıtların sonuç kümesine dahil edilmesini sağlar.

-- RIGHT JOIN: Sağ tablodaki tüm kayıtları ve sol tablodaki eşleşen kayıtları döndürür.
-- Eşleşen bir kayıt yoksa, sol tablodaki sütunlar için NULL değerler döndürülür. 
-- Bu, sağ tablodaki tüm kayıtların sonuç kümesine dahil edilmesini sağlar.

-- FULL JOIN: Her iki tablodaki tüm kayıtları döndürür, eşleşenler NULL olarak gösterilir.
-- Eşleşmeyen kayıtlar için NULL değerler döndürülür. 
-- Bu, her iki tablodaki tüm kayıtların sonuç kümesine dahil edilmesini sağlar.

-- UNION: İki sorgunun sonuçlarını birleştirir, yinelenen kayıtları kaldırır.
-- Bu komut, iki veya daha fazla SELECT sorgusunun sonuçlarını birleştirir ve yinelenen kayıtları otomatik olarak kaldırır.

-- UNION ALL: İki sorgunun sonuçlarını birleştirir, yinelenen kayıtları kaldırmaz.
-- UNION ALL, iki veya daha fazla SELECT sorgusunun sonuçlarını birleştirir ve yinelenen kayıtları kaldırmaz.


------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employee_projects;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
-- Bu tablolar çeşitli veri türleri ve kısıtlamalar içerir.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- INSERT INTO: Tablolara örnek veriler ekler.
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

INSERT INTO employees (employee_id, employee_name, department_id, hire_date) VALUES
(1, 'Alice', 1, '2023-01-01'),
(2, 'Bob', 1, '2023-02-01'),
(3, 'Charlie', 2, '2023-03-01'),
(4, 'David', 3, '2023-04-01'),
(5, 'Eve', 2, '2023-05-01');

INSERT INTO projects (project_id, project_name, start_date) VALUES
(1, 'Project A', '2023-01-01'),
(2, 'Project B', '2023-02-01'),
(3, 'Project C', '2023-03-01');

INSERT INTO employee_projects (employee_id, project_id, role) VALUES
(1, 1, 'Manager'),
(2, 2, 'Developer'),
(3, 1, 'Tester'),
(4, 3, 'Developer'),
(5, 2, 'Manager');

------------------------: INNER JOIN :--------------------------

-- INNER JOIN: Her iki tablodaki eşleşen kayıtları döndürür.

-- 1. INNER JOIN: Çalışanları ve departman adlarını birleştir.
SELECT 
    employees.employee_name, 
    departments.department_name 
FROM 
    employees 
INNER JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- 2. INNER JOIN: Çalışanları ve projelerini birleştir.
SELECT 
    employees.employee_name, 
    projects.project_name 
FROM 
    employees 
INNER JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
INNER JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 3. INNER JOIN: Departmanlardaki çalışanları ve rollerini birleştir.
SELECT 
    departments.department_name, 
    employees.employee_name, 
    employee_projects.role 
FROM 
    employees 
INNER JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
INNER JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id;

-- 4. INNER JOIN: Çalışanların isimlerini ve çalıştıkları projeleri ve rolleri göster.
SELECT 
    employees.employee_name, 
    projects.project_name, 
    employee_projects.role 
FROM 
    employees 
INNER JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
INNER JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 5. INNER JOIN: Çalışanların isimlerini, departmanlarını ve projelerini birleştir.
SELECT 
    employees.employee_name, 
    departments.department_name, 
    projects.project_name 
FROM 
    employees 
INNER JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
INNER JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
INNER JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

------------------------: LEFT JOIN :--------------------------

-- LEFT JOIN: Sol tablodaki tüm kayıtları ve sağ tablodaki eşleşen kayıtları döndürür.

-- 1. LEFT JOIN: Çalışanları ve departman adlarını birleştir,
-- departmanı olmayan çalışanları da göster.
SELECT 
    employees.employee_name, 
    departments.department_name 
FROM 
    employees 
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- 2. LEFT JOIN: Çalışanları ve projelerini birleştir,
-- projede yer almayan çalışanları da göster.
SELECT 
    employees.employee_name, 
    projects.project_name 
FROM 
    employees 
LEFT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
LEFT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 3. LEFT JOIN: Departmanlardaki çalışanları ve rollerini birleştir,
-- rolü olmayan çalışanları da göster.
SELECT 
    departments.department_name, 
    employees.employee_name, 
    employee_projects.role 
FROM 
    employees 
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
LEFT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id;

-- 4. LEFT JOIN: Çalışanların isimlerini ve çalıştıkları projeleri
-- ve rolleri göster, projede yer almayan çalışanları da göster.
SELECT 
    employees.employee_name, 
    projects.project_name, 
    employee_projects.role 
FROM 
    employees 
LEFT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
LEFT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 5. LEFT JOIN: Çalışanların isimlerini, departmanlarını ve projelerini birleştir,
-- projede yer almayan çalışanları da göster.
SELECT 
    employees.employee_name, 
    departments.department_name, 
    projects.project_name 
FROM 
    employees 
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
LEFT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
LEFT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

------------------------: RIGHT JOIN :--------------------------

-- RIGHT JOIN: Sağ tablodaki tüm kayıtları ve sol tablodaki eşleşen kayıtları döndürür.

-- 1. RIGHT JOIN: Çalışanları ve departman adlarını birleştir,
-- çalışanı olmayan departmanları da göster.
SELECT 
    employees.employee_name, 
    departments.department_name 
FROM 
    employees 
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- 2. RIGHT JOIN: Çalışanları ve projelerini birleştir,
-- çalışanı olmayan projeleri de göster.
SELECT 
    employees.employee_name, 
    projects.project_name 
FROM 
    employees 
RIGHT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
RIGHT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 3. RIGHT JOIN: Departmanlardaki çalışanları ve rollerini birleştir,
-- çalışanı olmayan departmanları da göster.
SELECT 
    departments.department_name, 
    employees.employee_name, 
    employee_projects.role 
FROM 
    employees 
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
RIGHT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id;

-- 4. RIGHT JOIN: Çalışanların isimlerini ve çalıştıkları projeleri
-- ve rolleri göster, çalışanı olmayan projeleri de göster.
SELECT 
    employees.employee_name, 
    projects.project_name, 
    employee_projects.role 
FROM 
    employees 
RIGHT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
RIGHT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 5. RIGHT JOIN: Çalışanların isimlerini, departmanlarını ve projelerini birleştir,
-- çalışanı olmayan projeleri de göster.
SELECT 
    employees.employee_name, 
    departments.department_name, 
    projects.project_name 
FROM 
    employees 
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
RIGHT JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
RIGHT JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

------------------------: FULL JOIN :--------------------------

-- FULL JOIN: Her iki tablodaki tüm kayıtları döndürür,
-- eşleşenler NULL olarak gösterilir.

-- 1. FULL JOIN: Çalışanları ve departman adlarını birleştir,
-- eşleşmeyenleri de göster.
SELECT 
    employees.employee_name, 
    departments.department_name 
FROM 
    employees 
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- 2. FULL JOIN: Çalışanları ve projelerini birleştir,
-- eşleşmeyenleri de göster.
SELECT 
    employees.employee_name, 
    projects.project_name 
FROM 
    employees 
FULL JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
FULL JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 3. FULL JOIN: Departmanlardaki çalışanları ve rollerini birleştir,
-- eşleşmeyenleri de göster.
SELECT 
    departments.department_name, 
    employees.employee_name, 
    employee_projects.role 
FROM 
    employees 
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
FULL JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id;

-- 4. FULL JOIN: Çalışanların isimlerini ve çalıştıkları projeleri
-- ve rolleri göster, eşleşmeyenleri de göster.
SELECT 
    employees.employee_name, 
    projects.project_name, 
    employee_projects.role 
FROM 
    employees 
FULL JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
FULL JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

-- 5. FULL JOIN: Çalışanların isimlerini, departmanlarını ve projelerini birleştir,
-- eşleşmeyenleri de göster.
SELECT 
    employees.employee_name, 
    departments.department_name, 
    projects.project_name 
FROM 
    employees 
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id 
FULL JOIN 
    employee_projects 
ON 
    employees.employee_id = employee_projects.employee_id 
FULL JOIN 
    projects 
ON 
    employee_projects.project_id = projects.project_id;

------------------------: UNION ve UNION ALL :--------------------------

-- UNION: İki sorgunun sonuçlarını birleştirir, yinelenen kayıtları kaldırır.
-- UNION ALL: İki sorgunun sonuçlarını birleştirir, yinelenen kayıtları kaldırmaz.

-- 1. UNION: Tüm departman adlarını ve proje adlarını birleştir.
SELECT 
    department_name AS name 
FROM 
    departments 
UNION 
SELECT 
    project_name AS name 
FROM 
    projects;

-- 2. UNION ALL: Tüm departman adlarını ve proje adlarını birleştir.
SELECT 
    department_name AS name 
FROM 
    departments 
UNION ALL 
SELECT 
    project_name AS name 
FROM 
    projects;

-- 3. UNION: Tüm çalışan adlarını ve proje adlarını birleştir.
SELECT 
    employee_name AS name 
FROM 
    employees 
UNION 
SELECT 
    project_name AS name 
FROM 
    projects;

-- 4. UNION ALL: Tüm çalışan adlarını ve proje adlarını birleştir.
SELECT 
    employee_name AS name 
FROM 
    employees 
UNION ALL 
SELECT 
    project_name AS name 
FROM 
    projects;

-- 5. UNION: Tüm çalışan adlarını ve departman adlarını birleştir.
SELECT 
    employee_name AS name 
FROM 
    employees 
UNION 
SELECT 
    department_name AS name 
FROM 
    departments;

-- 6. UNION ALL: Tüm çalışan adlarını ve departman adlarını birleştir.
SELECT 
    employee_name AS name 
FROM 
    employees 
UNION ALL 
SELECT 
    department_name AS name 
FROM 
    departments;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM employee_projects WHERE EXISTS (SELECT 1 FROM employee_projects);
DELETE FROM projects WHERE EXISTS (SELECT 1 FROM projects);
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);
DELETE FROM departments WHERE EXISTS (SELECT 1 FROM departments);

-- Tabloları silin.
DROP TABLE IF EXISTS employee_projects CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
