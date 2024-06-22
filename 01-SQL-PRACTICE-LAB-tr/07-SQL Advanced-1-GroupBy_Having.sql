------------------------: SQL ADVANCED :--------------------------

-- SQL COMMANDS: Verileri gruplamak ve gruplara koşul uygulamak için kullanılan komutlar.

-- GROUP BY: Verileri belirli bir sütuna veya sütunlara göre gruplar.
-- Bu komut, genellikle toplama (aggregate) fonksiyonları ile birlikte kullanılır.
-- Örneğin: Her bir ürünün toplam satış miktarını veya ortalama satış miktarını hesaplamak için kullanılabilir.

-- HAVING: Gruplara koşul uygulamak için kullanılır.
-- WHERE koşulundan farklı olarak, HAVING gruplama işlemi yapıldıktan sonra gruplar üzerinde koşul uygulamak için kullanılır.
-- Örneğin: Toplam satış miktarı 500'den büyük olan ürünleri bulmak için kullanılabilir.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS sales;

-- CREATE TABLE: Veritabanında yeni bir tablo oluşturur.
-- Bu tablo çeşitli veri türleri ve kısıtlamalar içerir.
CREATE TABLE sales (
    sale_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    product_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    sale_amount DECIMAL(10, 2) CHECK (sale_amount >= 0), -- CHECK: Pozitif olmalı
    sale_date DATE DEFAULT CURRENT_DATE -- DEFAULT: Varsayılan değer
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

-- 1. GROUP BY: Her ürün için toplam satış miktarını hesapla.
-- Bu sorgu, her ürün için toplam satış miktarını hesaplar ve gösterir.
SELECT 
    product_name, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name;

-- 2. GROUP BY: Her ürün için ortalama satış miktarını hesapla.
-- Bu sorgu, her ürün için ortalama satış miktarını hesaplar ve gösterir.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sales 
FROM 
    sales 
GROUP BY 
    product_name;

-- 3. GROUP BY: Her ürün için en yüksek satış miktarını bul.
-- Bu sorgu, her ürün için en yüksek satış miktarını bulur ve gösterir.
SELECT 
    product_name, 
    MAX(sale_amount) AS highest_sale 
FROM 
    sales 
GROUP BY 
    product_name;

-- 4. GROUP BY: Her ürün için en düşük satış miktarını bul.
-- Bu sorgu, her ürün için en düşük satış miktarını bulur ve gösterir.
SELECT 
    product_name, 
    MIN(sale_amount) AS lowest_sale 
FROM 
    sales 
GROUP BY 
    product_name;

-- 5. GROUP BY ve HAVING: Her ürün için toplam satış miktarını hesapla ve toplam satış miktarı 300'den büyük olanları göster.
-- Bu sorgu, her ürün için toplam satış miktarını hesaplar ve toplam satış miktarı 300'den büyük olan ürünleri gösterir.
SELECT 
    product_name, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    SUM(sale_amount) > 300;

-- 6. GROUP BY ve HAVING: Her ürün için ortalama satış miktarını hesapla ve ortalama satış miktarı 150'den büyük olanları göster.
-- Bu sorgu, her ürün için ortalama satış miktarını hesaplar ve ortalama satış miktarı 150'den büyük olan ürünleri gösterir.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sales 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    AVG(sale_amount) > 150;

-- 7. GROUP BY ve HAVING: Her ürün için toplam satış miktarını hesapla ve toplam satış miktarı 500'den küçük olanları göster.
-- Bu sorgu, her ürün için toplam satış miktarını hesaplar ve toplam satış miktarı 500'den küçük olan ürünleri gösterir.
SELECT 
    product_name, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    SUM(sale_amount) < 500;

-- 8. GROUP BY ve HAVING: Her ürün için en yüksek satış miktarını hesapla ve en yüksek satış miktarı 200'den büyük olanları göster.
-- Bu sorgu, her ürün için en yüksek satış miktarını hesaplar ve en yüksek satış miktarı 200'den büyük olan ürünleri gösterir.
SELECT 
    product_name, 
    MAX(sale_amount) AS highest_sale 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    MAX(sale_amount) > 200;

-- 9. GROUP BY ve HAVING: Her ürün için toplam satış miktarını hesapla ve toplam satış miktarı 100 ile 400 arasında olanları göster.
-- Bu sorgu, her ürün için toplam satış miktarını hesaplar ve toplam satış miktarı 100 ile 400 arasında olan ürünleri gösterir.
SELECT 
    product_name, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    SUM(sale_amount) BETWEEN 100 AND 400;

-- 10. GROUP BY ve HAVING: Her ürün için ortalama satış miktarını hesapla ve ortalama satış miktarı 100 ile 200 arasında olanları göster.
-- Bu sorgu, her ürün için ortalama satış miktarını hesaplar ve ortalama satış miktarı 100 ile 200 arasında olan ürünleri gösterir.
SELECT 
    product_name, 
    AVG(sale_amount) AS average_sales 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    AVG(sale_amount) BETWEEN 100 AND 200;

-- 11. GROUP BY ve HAVING: Her ürün için satış sayısını hesapla ve satış sayısı 2'den fazla olanları göster.
-- Bu sorgu, her ürün için satış sayısını hesaplar ve satış sayısı 2'den fazla olan ürünleri gösterir.
SELECT 
    product_name, 
    COUNT(*) AS sale_count 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    COUNT(*) > 2;

-- 12. GROUP BY ve HAVING: Her ürün için en düşük satış miktarını hesapla ve en düşük satış miktarı 100'den büyük olanları göster.
-- Bu sorgu, her ürün için en düşük satış miktarını hesaplar ve en düşük satış miktarı 100'den büyük olan ürünleri gösterir.
SELECT 
    product_name, 
    MIN(sale_amount) AS lowest_sale 
FROM 
    sales 
GROUP BY 
    product_name 
HAVING 
    MIN(sale_amount) > 100;

-- 13. GROUP BY birden fazla sütun: Her ürün ve satış tarihi kombinasyonu için toplam satış miktarını hesapla.
-- Bu sorgu, her ürün ve satış tarihi kombinasyonu için toplam satış miktarını hesaplar ve gösterir.
SELECT 
    product_name, 
    sale_date, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name, 
    sale_date;

-- 14. GROUP BY ve HAVING birden fazla sütun: Her ürün ve satış tarihi kombinasyonu için toplam satış miktarını hesapla ve toplam satış miktarı 150'den büyük olanları göster.
-- Bu sorgu, her ürün ve satış tarihi kombinasyonu için toplam satış miktarını hesaplar ve toplam satış miktarı 150'den büyük olan kombinasyonları gösterir.
SELECT 
    product_name, 
    sale_date, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name, 
    sale_date 
HAVING 
    SUM(sale_amount) > 150;

-- 15. GROUP BY birden fazla sütun: Her ürün ve ay kombinasyonu için toplam satış miktarını hesapla.
-- Bu sorgu, her ürün ve ay kombinasyonu için toplam satış miktarını hesaplar ve gösterir.
SELECT 
    product_name, 
    EXTRACT(MONTH FROM sale_date) AS sale_month, 
    SUM(sale_amount) AS total_sales 
FROM 
    sales 
GROUP BY 
    product_name, 
    EXTRACT(MONTH FROM sale_date);

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM sales WHERE EXISTS (SELECT 1 FROM sales);

-- Tabloyu silin.
DROP TABLE IF EXISTS sales CASCADE;
