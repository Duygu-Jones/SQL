------------------------: SQL INTRODUCTION :--------------------------

-- SQL: Structured Query Language (Yapılandırılmış Sorgu Dili), 
-- veritabanları ile iletişim kurmak ve veri yönetimi işlemlerini gerçekleştirmek için kullanılır.

-- Veritabanı: Verilerin düzenli bir şekilde saklandığı ve yönetildiği sistemdir.
-- Bir veritabanı, bir veya daha fazla tablodan oluşur.

-- Tablo: Verilerin satırlar ve sütunlar halinde düzenlendiği yapı.
-- Her tablo, belirli bir veri türünü temsil eden bir veya daha fazla sütuna sahiptir.

-- Veri Türleri: SQL'de her sütun için belirli bir veri türü belirlenir.
-- Veri türleri, sütunda saklanabilecek veri türünü ve boyutunu tanımlar.

-- Yaygın SQL Veri Türleri:

-- 1. INT:
--    - Tam sayı verilerini saklar.
--    - Örnek: `Age INT`

-- 2. SMALLINT:
--    - Daha küçük tam sayı verilerini saklar.
--    - Örnek: `SmallNumber SMALLINT`

-- 3. BIGINT:
--    - Daha büyük tam sayı verilerini saklar.
--    - Örnek: `LargeNumber BIGINT`

-- 4. CHAR(n):
--    - Sabit uzunlukta karakter dizilerini saklar, `n` karakter sayısını belirtir.
--    - Örnek: `Code CHAR(10)`

-- 5. VARCHAR(n):
--    - Değişken uzunlukta karakter dizilerini saklar, `n` maksimum karakter sayısını belirtir.
--    - Örnek: `Name VARCHAR(50)`

-- 6. TEXT:
--    - Uzun metin verilerini saklar.
--    - Örnek: `Description TEXT`

-- 7. DATE:
--    - Tarih verilerini saklar (yıl, ay, gün).
--    - Örnek: `BirthDate DATE`

-- 8. TIME:
--    - Zaman verilerini saklar (saat, dakika, saniye).
--    - Örnek: `StartTime TIME`

-- 9. TIMESTAMP:
--    - Tarih ve zaman verilerini saklar.
--    - Örnek: `LastUpdated TIMESTAMP`

-- 10. DECIMAL(p, s):
--     - Kesirli sayıları saklar, `p` hassasiyeti ve `s` ölçeği belirtir.
--     - Örnek: `Price DECIMAL(10, 2)`

-- 11. NUMERIC(p, s):
--     - Kesirli sayıları saklar, DECIMAL ile aynıdır, `p` hassasiyeti ve `s` ölçeği belirtir.
--     - Örnek: `Amount NUMERIC(10, 2)`

-- 12. FLOAT:
--     - Kayan nokta sayıları saklar.
--     - Örnek: `Score FLOAT`

-- 13. REAL:
--     - Tek hassasiyetli kayan nokta sayıları saklar.
--     - Örnek: `Measurement REAL`

-- 14. DOUBLE PRECISION:
--     - Çift hassasiyetli kayan nokta sayıları saklar.
--     - Örnek: `HighPrecisionValue DOUBLE PRECISION`

-- 15. BOOLEAN:
--     - TRUE veya FALSE değerlerini saklar.
--     - Örnek: `IsActive BOOLEAN`

------------------------: DATABASE AND TABLE CREATION :--------------------------

-- CREATE DATABASE: Yeni bir veritabanı oluşturur.
CREATE DATABASE example_db;

-- USE DATABASE: Oluşturulan veritabanını kullanmaya başlar.
USE example_db;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
-- Bu tablo çeşitli veri türleri içerir.
CREATE TABLE example_table (
    id INT PRIMARY KEY, -- INT veri türü, birincil anahtar
    name VARCHAR(50) NOT NULL, -- VARCHAR veri türü, NOT NULL kısıtlaması ile
    description TEXT, -- TEXT veri türü
    created_at DATE, -- DATE veri türü
    price DECIMAL(10, 2), -- DECIMAL veri türü
    is_active BOOLEAN -- BOOLEAN veri türü
);

-- INSERT INTO: 'example_table' tablosuna örnek veriler ekler.
INSERT INTO example_table (id, name, description, created_at, price, is_active) VALUES
(1, 'Example Item 1', 'This is a description for item 1.', '2023-01-01', 19.99, TRUE),
(2, 'Example Item 2', 'This is a description for item 2.', '2023-02-01', 29.99, FALSE),
(3, 'Example Item 3', 'This is a description for item 3.', '2023-03-01', 39.99, TRUE);

------------------------: CREATE NEW TABLE FROM EXISTING TABLE :--------------------------


-- CREATE TABLE: Mevcut bir tablodan yeni bir tablo oluşturur.
-- Bu örnekte, sadece belirli sütunlar ve veriler yeni tabloya eklenir.
CREATE TABLE new_example_table AS
SELECT 
    id, 
    name, 
    price 
FROM example_table;

-- Tabloyu görüntüle:
SELECT * FROM new_example_table;



------------------------: SELECT EXAMPLES :--------------------------

-- Mevcut tüm öğeleri seç ve görüntüle.
SELECT * 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece adlarını ve fiyatlarını seç.
SELECT 
    name, 
    price 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece adlarını, açıklamalarını ve aktif olup olmadıklarını seç.
SELECT 
    name, 
    description, 
    is_active 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece kimlik numaralarını ve oluşturulma tarihlerini seç.
SELECT 
    id, 
    created_at 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece kimlik numaralarını, adlarını ve fiyatlarını seç.
SELECT 
    id, 
    name, 
    price 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece adlarını ve oluşturulma tarihlerini seç.
SELECT 
    name, 
    created_at 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece açıklamalarını ve aktif olup olmadıklarını seç.
SELECT 
    description, 
    is_active 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece fiyatlarını ve aktif olup olmadıklarını seç.
SELECT 
    price, 
    is_active 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece adlarını, açıklamalarını ve fiyatlarını seç.
SELECT 
    name, 
    description, 
    price 
FROM example_table;

-- Belirli sütunları seç: Öğelerin sadece kimlik numaralarını ve adlarını seç.
SELECT 
    id, 
    name 
FROM example_table;


-- Table tamamen silme: DROP TABLE
DROP TABLE new_example_table;

