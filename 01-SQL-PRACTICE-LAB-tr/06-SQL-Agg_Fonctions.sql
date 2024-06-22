------------------------------------: SQL FUNCTIONS-01:-------------------------------------------

------------------------: AGGREGATE FUNCTIONS WITH GROUP BY AND HAVING :--------------------------

-- SQL COMMANDS: Veritabanı tablolarındaki verileri özetlemek ve gruplamak için kullanılan komutlar.

-- COUNT: Satırların sayısını döndürür.
-- SUM: Belirtilen sütundaki değerlerin toplamını döndürür.
-- AVG: Belirtilen sütundaki değerlerin ortalamasını döndürür.
-- MAX: Belirtilen sütundaki en yüksek değeri döndürür.
-- MIN: Belirtilen sütundaki en düşük değeri döndürür.
-- GROUP BY: Verileri belirli bir sütuna göre gruplar.
-- HAVING: Gruplara koşul uygulamak için kullanılır.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS sales;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    sale_amount DECIMAL(10, 2) CHECK (sale_amount >= 0),
    sale_date DATE DEFAULT CURRENT_DATE
);

-- INSERT INTO: 'sales' tablosuna örnek veriler ekler.
INSERT INTO sales (sale_id, product_name, sale_amount, sale_date) VALUES
(1, 'Product A', 100.00, '2023-01-01'),
(2, 'Product B', 150.00, '2023-01-02'),
(3, 'Product A', 200.00, '2023-01-03'),
(4, 'Product C', 250.00, '2023-01-04'),
(5, 'Product B', 300.00, '2023-01-05'),
(6, 'Product A', 50.00, '2023-01-06'),
(7, 'Product C', 100.00, '2023-01-07'),
(8, 'Product B', 200.00, '2023-01-08'),
(9, 'Product A', 150.00, '2023-01-09'),
(10, 'Product C', 50.00, '2023-01-10');

------------------------: PRACTICE :--------------------------

-- 1. COUNT: Tablodaki toplam satış sayısını hesapla.
SELECT 
    COUNT(*) AS total_sales 
FROM 
    sales;

-- 2. COUNT: Her ürün için satış sayısını hesapla.
SELECT 
    product_name, 
    COUNT(*) AS sale_count 
FROM 
    sales 
GROUP BY 
    product_name;

-- 3. SUM: Tablodaki toplam satış miktarını hesapla.
SELECT 
    SUM(sale_amount) AS total_sale_amount 
FROM 
    sales;

-- 4. SUM: Her ürün için toplam satış miktarını hesapla.
SELECT 
    product_name, 
    SUM(sale_amount) AS total_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 5. AVG: Tablodaki ortalama satış miktarını hesapla.
SELECT 
    AVG(sale_amount) AS average_sale_amount 
FROM 
    sales;

-- 6. AVG: Her ürün için ortalama satış miktarını hesapla.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 7. MAX: Tablodaki en yüksek satış miktarını bul.
SELECT 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales;

-- 8. MAX: Her ürün için en yüksek satış miktarını bul.
SELECT 
    product_name, 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 9. MIN: Tablodaki en düşük satış miktarını bul.
SELECT 
    MIN(sale_amount) AS lowest_sale_amount 
FROM 
    sales;

-- 10. MIN: Her ürün için en düşük satış miktarını bul.
SELECT 
    product_name, 
    MIN(sale_amount) AS lowest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 11. COUNT ve SUM: Her ürün için satış sayısını ve toplam satış miktarını hesapla.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 12. AVG ve MAX: Her ürün için ortalama ve en yüksek satış miktarını hesapla.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sale_amount, 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 13. MIN ve SUM: Her ürün için en düşük ve toplam satış miktarını hesapla.
SELECT 
    product_name, 
    MIN(sale_amount) AS lowest_sale_amount, 
    SUM(sale_amount) AS total_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 14. COUNT, SUM ve AVG: Her ürün için satış sayısını, toplam satış miktarını ve 
-- ortalama satış miktarını hesapla.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount, 
    AVG(sale_amount) AS average_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 15. COUNT, SUM, AVG ve MAX: Her ürün için satış sayısını, toplam satış miktarını,
-- ortalama satış miktarını ve en yüksek satış miktarını hesapla.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount, 
    AVG(sale_amount) AS average_sale_amount, 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name;

-- 16. COUNT, SUM ve HAVING: Her ürün için satış sayısını ve toplam satış miktarını hesapla,
-- toplam satış miktarı 500'den büyük olanları göster.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    SUM(sale_amount) > 500;

-- 17. AVG, MAX ve HAVING: Her ürün için ortalama ve en yüksek satış miktarını hesapla,
-- ortalama satış miktarı 150'den büyük olanları göster.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sale_amount, 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    AVG(sale_amount) > 150;

-- 18. COUNT, SUM, AVG ve HAVING: Her ürün için satış sayısını, toplam satış miktarını ve
-- ortalama satış miktarını hesapla, ortalama satış miktarı 100'den büyük olanları göster.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount, 
    AVG(sale_amount) AS average_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    AVG(sale_amount) > 100;

-- 19. COUNT, SUM ve AVG ile HAVING: Her ürün için satış sayısını, toplam satış miktarını
-- ve ortalama satış miktarını hesapla, satış sayısı 3'ten fazla olanları ve
-- toplam satış miktarı 500'den büyük olanları göster.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount, 
    AVG(sale_amount) AS average_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    COUNT(*) > 3 
    AND SUM(sale_amount) > 500;

-- 20. GROUP BY ve HAVING ile birleştirilen daha karmaşık bir sorgu:
-- Her ürün için satış sayısını, toplam satış miktarını, ortalama satış miktarını
-- ve en yüksek satış miktarını hesapla, ortalama satış miktarı 100 ile 200
-- arasında olanları göster.
SELECT 
    product_name, 
    COUNT(*) AS sale_count, 
    SUM(sale_amount) AS total_sale_amount, 
    AVG(sale_amount) AS average_sale_amount, 
    MAX(sale_amount) AS highest_sale_amount 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    AVG(sale_amount) BETWEEN 100 AND 200;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM sales WHERE EXISTS (SELECT 1 FROM sales);

-- Tabloyu silin.
DROP TABLE IF EXISTS sales CASCADE;
