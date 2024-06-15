------------------------: QUERYING DATA :--------------------------

-- SQL COMMANDS: Veritabanından veri sorgulamak için kullanılan komutlar.

-- SELECT: Veritabanından veri seçer.
-- DISTINCT: Sadece benzersiz (tekrarlanmayan) kayıtları seçer.
-- ORDER BY: Sonuçları belirli bir sütuna göre sıralar.
    -- ASC: Artan sırada (varsayılan).
    -- DESC: Azalan sırada.
-- CONCAT: Metin değerlerini birleştirir.
-- LENGTH: Metin değerinin uzunluğunu döndürür.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
-- Bu tablolar çeşitli veri türleri ve kısıtlamalar içerir.
CREATE TABLE products (
    product_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    product_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    category_id INT, -- Kategori ID'si
    price DECIMAL(10, 2) CHECK (price >= 0), -- CHECK: Pozitif olmalı
    created_at DATE DEFAULT CURRENT_DATE -- DEFAULT: Varsayılan değer
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    category_name VARCHAR(50) NOT NULL -- NOT NULL: Boş olamaz
);

-- INSERT INTO: 'products' ve 'categories' tablolarına örnek veriler ekler.
INSERT INTO products (product_id, product_name, category_id, price, created_at) VALUES
(1, 'Product 1', 1, 19.99, '2023-01-01'),
(2, 'Product 2', 2, 29.99, '2023-02-01'),
(3, 'Product 3', 1, 39.99, '2023-03-01'),
(4, 'Product 4', 3, 49.99, '2023-04-01'),
(5, 'Product 5', 2, 59.99, '2023-05-01');

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Category 1'),
(2, 'Category 2'),
(3, 'Category 3');

------------------------: PRACTICE :--------------------------

-- 1. SELECT: Tüm ürünleri seç ve görüntüle.
SELECT * 
FROM products;

-- 2. DISTINCT: Benzersiz kategori ID'lerine sahip ürünleri seç ve görüntüle.
SELECT DISTINCT category_id 
FROM products;

-- 3. ORDER BY: Ürünleri fiyatlarına göre artan sırada (varsayılan) seç ve görüntüle.
SELECT * 
FROM products 
ORDER BY price;

-- 4. ORDER BY: Ürünleri fiyatlarına göre azalan sırada seç ve görüntüle.
SELECT * 
FROM products 
ORDER BY price DESC;

-- 5. ORDER BY: Ürünleri adlarına göre artan sırada seç ve görüntüle.
SELECT * 
FROM products 
ORDER BY product_name;

-- 6. ORDER BY: Ürünleri oluşturulma tarihlerine göre azalan sırada seç ve görüntüle.
SELECT * 
FROM products 
ORDER BY created_at DESC;

-- 7. ORDER BY ve DISTINCT: Benzersiz kategori ID'lerine sahip ürünleri seç ve kategori ID'sine göre artan sırada görüntüle.
SELECT DISTINCT category_id 
FROM products 
ORDER BY category_id;

-- 8. SELECT ve WHERE: Kategori ID'si 2 olan ürünleri seç ve görüntüle.
SELECT * 
FROM products 
WHERE category_id = 2;

-- 9. SELECT ve WHERE: Fiyatı 30'dan büyük olan ürünleri seç ve fiyatlarına göre azalan sırada görüntüle.
SELECT * 
FROM products 
WHERE price > 30 
ORDER BY price DESC;

-- 10. SELECT, DISTINCT ve ORDER BY: Benzersiz fiyatlara sahip ürünleri seç ve fiyatlarına göre artan sırada görüntüle.
SELECT DISTINCT price 
FROM products 
ORDER BY price;

-- 11. CONCAT: Ürün adı ve kategorisini birleştirerek seç ve görüntüle.
SELECT 
    CONCAT(product_name, ' - ', (SELECT category_name FROM categories WHERE categories.category_id = products.category_id)) AS product_category 
FROM products;

-- 12. LENGTH: Ürün adının uzunluğunu seç ve görüntüle.
SELECT 
    product_name, 
    LENGTH(product_name) AS name_length 
FROM products;

-- 13. CONCAT ve LENGTH: Ürün adını ve uzunluğunu birleştirerek seç ve görüntüle.
SELECT 
    CONCAT(product_name, ' (Length: ', LENGTH(product_name), ')') AS product_name_with_length 
FROM products;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM products WHERE EXISTS (SELECT 1 FROM products);
DELETE FROM categories WHERE EXISTS (SELECT 1 FROM categories);

-- Tabloları silin.
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
