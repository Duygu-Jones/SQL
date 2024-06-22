------------------------------------: SQL FUNCTIONS-01:-------------------------------------------

------------------------: STRING FUNCTIONS :--------------------------

-- SQL STRING FUNCTIONS: Metin (string) verileri üzerinde işlem yapmak için kullanılan fonksiyonlar.

-- CONCAT: İki veya daha fazla stringi birleştirir.
-- LOWER: Bir stringi küçük harfe dönüştürür.
-- UPPER: Bir stringi büyük harfe dönüştürür.
-- TRIM: Bir stringin başındaki ve sonundaki boşlukları kaldırır.
-- LENGTH: Bir stringin uzunluğunu döndürür.
-- SUBSTRING: Bir stringin belirli bir kısmını döndürür.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS employees;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- INSERT INTO: 'employees' tablosuna örnek veriler ekler.
INSERT INTO employees (employee_id, first_name, last_name, email) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com'),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com'),
(4, 'David', 'Wilson', 'david.wilson@example.com'),
(5, 'Eve', 'Davis', 'eve.davis@example.com');

------------------------: PRACTICE :--------------------------

-- 1. CONCAT: Çalışanların tam adını (first_name ve last_name) birleştir ve görüntüle.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name 
FROM 
    employees;

-- 2. LOWER: Çalışanların email adreslerini küçük harfe dönüştür ve görüntüle.
SELECT 
    LOWER(email) AS email_lower 
FROM 
    employees;

-- 3. UPPER: Çalışanların email adreslerini büyük harfe dönüştür ve görüntüle.
SELECT 
    UPPER(email) AS email_upper 
FROM 
    employees;

-- 4. TRIM: Çalışanların first_name sütunundaki boşlukları kaldır ve görüntüle.
-- Bu örnekte, TRIM fonksiyonunu göstermek için first_name sütununda başında veya sonunda boşluk olan bir değer ekleyeceğiz.
INSERT INTO employees (employee_id, first_name, last_name, email) VALUES (6, '  Frank', 'Miller', 'frank.miller@example.com');

SELECT 
    TRIM(first_name) AS trimmed_first_name 
FROM 
    employees 
WHERE 
    employee_id = 6;

-- 5. LENGTH: Çalışanların email adreslerinin uzunluğunu hesapla ve görüntüle.
SELECT 
    email, 
    LENGTH(email) AS email_length 
FROM 
    employees;

-- 6. SUBSTRING: Çalışanların email adreslerinden '@' işaretinden önceki kısmı al ve görüntüle.
SELECT 
    email, 
    SUBSTRING(email, 1, POSITION('@' IN email) - 1) AS email_prefix 
FROM 
    employees;

-- 7. CONCAT ve UPPER: Çalışanların tam adını (first_name ve last_name) birleştir ve büyük harfe dönüştür.
SELECT 
    UPPER(CONCAT(first_name, ' ', last_name)) AS full_name_upper 
FROM 
    employees;

-- 8. LENGTH ve SUBSTRING: Email adresinin uzunluğunu kullanarak '@' işaretinden sonraki kısmı al ve görüntüle.
SELECT 
    email, 
    SUBSTRING(email, POSITION('@' IN email) + 1, LENGTH(email)) AS email_domain 
FROM 
    employees;

-- 9. LOWER ve TRIM: Çalışanların first_name sütunundaki boşlukları kaldır ve küçük harfe dönüştür.
SELECT 
    LOWER(TRIM(first_name)) AS trimmed_lower_first_name 
FROM 
    employees;

-- 10. UPPER ve SUBSTRING: Çalışanların email adreslerinin domain kısmını büyük harfe dönüştür ve görüntüle.
SELECT 
    email, 
    UPPER(SUBSTRING(email, POSITION('@' IN email) + 1, LENGTH(email))) AS email_domain_upper 
FROM 
    employees;

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);

-- Tabloyu silin.
DROP TABLE IF EXISTS employees CASCADE;





-----------------ADDITIONAL STRING FUNCTIONS: --And PRACTICES---------------
------------------------: STRING FUNCTIONS :--------------------------------

-- SQL STRING FUNCTIONS: Metin (string) verileri üzerinde işlem yapmak için kullanılan fonksiyonlar.

-- 1) TRIM(column): String değerinin başındaki ve sonundaki boşlukları kaldırır.
--    LTRIM: Sadece baştaki boşlukları kaldırır.
--    RTRIM: Sadece sondaki boşlukları kaldırır.

-- 2) REPLACE(column, 'eski değer', 'yeni değer'): Kolondaki belirtilen değeri bulur ve yeni belirtilen değerle değiştirir.
--    Değişiklik yapmak için UPDATE ile kullanılır.

-- 3) CONCAT(column name, 'string'): İki veya daha fazla stringi birleştirmek için kullanılır.

-- 4) SUBSTRING(column name, start index, end index): Kolondaki string değerinin belirtilen indeks aralığındaki kısmını döndürür.
--    Tek indeksle de çalışır ve belirtilen kısımdan sonuna kadar alır.

-- 5) UPPER(column name): Kolondaki string değerlerini büyük harfe dönüştürür.

-- 6) LOWER(column name): Kolondaki string değerlerini küçük harfe dönüştürür.

-- 7) INITCAP(column name): Kolondaki her kelimenin ilk harfini büyük yapar.

-- 8) LENGTH(column name): Belirtilen kolondaki stringlerin uzunluğunu döndürür.

-- 9) REVERSE(column name): Kolondaki string değerini tersine çevirir.

-- 10) LEFT(column, n) / RIGHT(column, n): Stringin başından veya sonundan belirtilen karakter sayısını alır.
--     LEFT(column, 3) ilk 3 karakteri alır; RIGHT(column, 3) son 3 karakteri alır.

-- 11) FETCH NEXT n ROW ONLY: Sadece sonraki n satırı alır.
--     LIMIT n: Sadece sonraki n satırı alır - bitirme fonksiyonu.
--     OFFSET n: n satırı atlar ve sonraki satırları alır.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS employees;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2)
);

-- INSERT INTO: 'employees' tablosuna örnek veriler ekler.
INSERT INTO employees (employee_id, first_name, last_name, email, salary) VALUES
(1, ' Alice ', 'Smith ', 'alice.smith@example.com', 70000),
(2, '  Bob', '  Johnson  ', 'bob.johnson@example.com', 60000),
(3, 'Charlie  ', '  Brown', 'charlie.brown@example.com', 75000),
(4, ' David', 'Wilson', 'david.wilson@example.com', 80000),
(5, 'Eve', 'Davis', 'eve.davis@example.com', 90000);

------------------------: PRACTICE :--------------------------

-- 1. TRIM: Çalışanların first_name ve last_name sütunlarındaki boşlukları kaldır ve görüntüle.
SELECT 
    TRIM(first_name) AS trimmed_first_name, 
    TRIM(last_name) AS trimmed_last_name 
FROM 
    employees;

-- 2. LTRIM ve RTRIM: Çalışanların first_name sütunundaki baştaki ve sondaki boşlukları kaldır ve görüntüle.
SELECT 
    LTRIM(first_name) AS ltrim_first_name, 
    RTRIM(last_name) AS rtrim_last_name 
FROM 
    employees;

-- 3. REPLACE: Çalışanların email adreslerindeki 'example.com' ifadesini 'company.com' ile değiştir ve görüntüle.
UPDATE employees
SET email = REPLACE(email, 'example.com', 'company.com');
SELECT * FROM employees;

-- 4. CONCAT: Çalışanların tam adını (first_name ve last_name) birleştir ve görüntüle.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name 
FROM 
    employees;

-- 5. SUBSTRING: Çalışanların email adreslerinden '@' işaretinden önceki kısmı al ve görüntüle.
SELECT 
    email, 
    SUBSTRING(email, 1, POSITION('@' IN email) - 1) AS email_prefix 
FROM 
    employees;

-- 6. UPPER ve LOWER: Çalışanların email adreslerini büyük harfe ve küçük harfe dönüştür ve görüntüle.
SELECT 
    UPPER(email) AS email_upper, 
    LOWER(email) AS email_lower 
FROM 
    employees;

-- 7. INITCAP: Çalışanların first_name ve last_name sütunlarındaki her kelimenin ilk harfini büyük yap ve görüntüle.
SELECT 
    INITCAP(first_name) AS initcap_first_name, 
    INITCAP(last_name) AS initcap_last_name 
FROM 
    employees;

-- 8. LENGTH: Çalışanların first_name ve last_name sütunlarındaki stringlerin uzunluğunu hesapla ve görüntüle.
SELECT 
    first_name, 
    LENGTH(first_name) AS first_name_length, 
    last_name, 
    LENGTH(last_name) AS last_name_length 
FROM 
    employees;

-- 9. REVERSE: Çalışanların email adreslerini ters çevir ve görüntüle.
SELECT 
    email, 
    REVERSE(email) AS reversed_email 
FROM 
    employees;

-- 10. LEFT ve RIGHT: Çalışanların email adreslerinin ilk 5 ve son 5 karakterini al ve görüntüle.
SELECT 
    email, 
    LEFT(email, 5) AS left_email, 
    RIGHT(email, 5) AS right_email 
FROM 
    employees;

------------------------: OFFSET, FETCH NEXT, LIMIT :--------------------------

-- 11. FETCH NEXT 3 ROW ONLY: 'employees' tablosundan ilk 3 kaydı getir.
SELECT * 
FROM employees
FETCH NEXT 3 ROW ONLY;

-- 12. OFFSET ve FETCH NEXT: 'employees' tablosundan ilk 2 kaydı atla ve sonraki 3 kaydı getir.
SELECT * 
FROM employees
OFFSET 2 ROWS 
FETCH NEXT 3 ROW ONLY;

-- 13. LIMIT: 'employees' tablosundan ilk 3 kaydı getir.
SELECT * 
FROM employees
LIMIT 3;

-- 14. OFFSET ve LIMIT: 'employees' tablosundan ilk 2 kaydı atla ve sonraki 3 kaydı getir.
SELECT * 
FROM employees
OFFSET 2 ROWS 
LIMIT 3;

-- 15. LIMIT ve ORDER BY: 'employees' tablosundan en düşük maaşa sahip ilk 3 kaydı getir.
SELECT * 
FROM employees
ORDER BY salary ASC
LIMIT 3;

-- 16. OFFSET ve LIMIT: 'employees' tablosundan en yüksek maaşa sahip ikinci kaydı getir.
SELECT *
FROM employees
ORDER BY salary DESC
OFFSET 1 
LIMIT 1;

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM employees WHERE EXISTS (SELECT 1 FROM employees);

-- Tabloyu silin.
DROP TABLE IF EXISTS employees CASCADE;







