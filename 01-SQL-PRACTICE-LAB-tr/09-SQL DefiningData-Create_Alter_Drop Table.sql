------------------------: DEFINING DATA :--------------------------

-- SQL COMMANDS: Veritabanında veri yapılarını tanımlamak için kullanılan komutlar.

-- CREATE TABLE: Yeni bir tablo oluşturur.
-- Yeni bir tablo oluştururken, sütun adları, veri türleri ve kısıtlamalar belirtilir.
-- Örneğin: Bir 'employees' tablosu oluştururken, 'employee_id' sütunu birincil anahtar (PRIMARY KEY) olarak belirlenebilir.

-- ALTER TABLE: Mevcut bir tabloyu değiştirir.
-- Mevcut bir tabloya yeni sütun eklemek, sütun adını değiştirmek, sütun veri türünü değiştirmek veya mevcut bir sütunu silmek için kullanılır.
-- Örneğin: Bir tabloya yeni bir 'phone_number' sütunu eklemek veya bir sütunun adını 'first_name'den 'given_name' olarak değiştirmek.

-- DROP TABLE: Bir tabloyu siler.
-- Bir tabloyu ve tablodaki tüm verileri kalıcı olarak silmek için kullanılır.
-- Bu komut dikkatli kullanılmalıdır çünkü silinen tablo ve veriler geri alınamaz.
-- Örneğin: Artık gerekli olmayan bir 'old_records' tablosunu silmek için kullanılabilir.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
-- Bu tablolar çeşitli veri türleri ve kısıtlamalar içerir.
CREATE TABLE departments (
    department_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    department_name VARCHAR(50) NOT NULL -- NOT NULL: Boş olamaz
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    employee_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    department_id INT,
    hire_date DATE DEFAULT CURRENT_DATE, -- DEFAULT: Varsayılan değer
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE -- FOREIGN KEY: 'departments' tablosundaki 'department_id'ye referans, CASCADE ile
);

-- INSERT INTO: 'departments' ve 'employees' tablolarına örnek veriler ekler.
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

INSERT INTO employees (employee_id, employee_name, department_id, hire_date) VALUES
(1, 'Alice', 1, '2023-01-01'),
(2, 'Bob', 1, '2023-02-01'),
(3, 'Charlie', 2, '2023-03-01'),
(4, 'David', 3, '2023-04-01');

------------------------: PRACTICE :--------------------------

-- 1. CREATE TABLE: Yeni bir tablo oluştur.
-- 'projects' adında yeni bir tablo oluşturulur.
-- Bu tablo 'project_id', 'project_name' ve 'start_date' sütunlarını içerir.
CREATE TABLE projects (
    project_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    project_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    start_date DATE DEFAULT CURRENT_DATE -- DEFAULT: Varsayılan değer
);

-- 2. ALTER TABLE: 'projects' tablosuna yeni bir sütun ekle.
-- 'projects' tablosuna 'end_date' adında yeni bir tarih sütunu eklenir.
ALTER TABLE projects 
ADD COLUMN end_date DATE;

-- 3. ALTER TABLE: 'employees' tablosunda bir sütunun adını değiştir.
-- 'employees' tablosundaki 'employee_name' sütununun adı 'full_name' olarak değiştirilir.
ALTER TABLE employees 
RENAME COLUMN employee_name TO full_name;

-- 4. ALTER TABLE: 'departments' tablosunda bir sütunun veri türünü değiştir.
-- 'departments' tablosundaki 'department_name' sütununun veri türü VARCHAR(50)'den TEXT'e değiştirilir.
ALTER TABLE departments 
ALTER COLUMN department_name TYPE TEXT;

-- 5. ALTER TABLE: 'projects' tablosundaki 'end_date' sütununu varsayılan değer ile güncelle.
-- 'projects' tablosundaki 'end_date' sütununa varsayılan değer olarak '2023-12-31' atanır.
ALTER TABLE projects 
ALTER COLUMN end_date SET DEFAULT '2023-12-31';

-- 6. DROP TABLE: 'projects' tablosunu sil.
-- 'projects' tablosu ve içindeki tüm veriler kalıcı olarak silinir.
DROP TABLE IF EXISTS projects;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);
DELETE FROM departments WHERE EXISTS (SELECT 1 FROM departments);

-- Tabloları silin.
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
