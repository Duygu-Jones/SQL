------------------------: MODIFYING DATA :--------------------------

-- SQL COMMANDS: Veritabanındaki verileri değiştirmek için kullanılan komutlar.

-- INSERT: Yeni veri ekler.
-- Yeni bir satır veya satırlar eklemek için kullanılır. 
-- Her sütun için uygun veri türünde değerler belirtilmelidir.

-- UPDATE: Mevcut veriyi günceller.
-- Mevcut bir tablodaki veriyi değiştirmek için kullanılır. 
-- WHERE koşulu ile belirli satırları güncelleyebiliriz. WHERE olmadan tüm satırlar güncellenir.
-- Örneğin: Bir çalışanın maaşını veya departmanını güncellemek için kullanılır.

-- DELETE: Mevcut veriyi siler.
-- Bir tablodaki veriyi silmek için kullanılır. WHERE koşulu ile belirli satırlar silinebilir.
-- WHERE olmadan kullanılırsa tüm satırlar silinir. 
-- Örneğin: Artık geçerli olmayan bir siparişi veya çalışanın kaydını silmek için kullanılır.

-- TRUNCATE: Tablodaki tüm veriyi siler.
-- Bir tablodaki tüm satırları hızlı bir şekilde siler. Ancak, tablo yapısını ve sütunlarını korur.
-- TRUNCATE, DELETE komutundan daha hızlıdır çünkü her satırın silinmesini kayıt altına almaz.
-- Örneğin: Bir tabloyu hızlı bir şekilde boşaltmak için kullanılır, ancak tablo yapısını korumak istenir.

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
    created_at DATE DEFAULT CURRENT_DATE, -- DEFAULT: Varsayılan değer
    is_active BOOLEAN DEFAULT TRUE -- BOOLEAN ve DEFAULT kısıtlaması
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

-- 1. INSERT: Yeni bir ürün ekle.
INSERT INTO products (product_id, product_name, category_id, price, created_at) 
VALUES (6, 'Product 6', 1, 69.99, '2023-06-01');

-- 2. UPDATE: Product 6'nın fiyatını güncelle.
UPDATE products 
SET price = 74.99 
WHERE product_id = 6;

-- 3. DELETE: Product 6'yı sil.
DELETE FROM products 
WHERE product_id = 6;

-- 4. TRUNCATE: 'products' tablosundaki tüm verileri sil.
TRUNCATE TABLE products;

-- 5. INSERT: 'products' tablosuna yeni veriler ekle.
INSERT INTO products (product_id, product_name, category_id, price, created_at) VALUES
(1, 'Product 1', 1, 19.99, '2023-01-01'),
(2, 'Product 2', 2, 29.99, '2023-02-01'),
(3, 'Product 3', 1, 39.99, '2023-03-01'),
(4, 'Product 4', 3, 49.99, '2023-04-01'),
(5, 'Product 5', 2, 59.99, '2023-05-01');

-- 6. UPDATE: 'products' tablosundaki Product 3'ün ismini ve fiyatını güncelle.
UPDATE products 
SET product_name = 'Updated Product 3', price = 44.99 
WHERE product_id = 3;

-- 7. DELETE: Fiyatı 30'dan büyük olan ürünleri sil.
DELETE FROM products 
WHERE price > 30;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM products WHERE EXISTS (SELECT 1 FROM products);
DELETE FROM categories WHERE EXISTS (SELECT 1 FROM categories);

-- Tabloları silin.
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
