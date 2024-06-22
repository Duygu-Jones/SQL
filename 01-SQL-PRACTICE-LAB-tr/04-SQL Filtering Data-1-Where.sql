------------------------: FILTERING DATA :--------------------------

-- SQL COMMANDS: Verileri filtrelemek için kullanılan komutlar.

-- WHERE: Belirli bir koşula göre verileri filtreler.
    -- AND, OR, NOT: Birden fazla koşulu birleştirir.
        -- AND: Tüm koşulların sağlanmasını gerektirir.
        -- OR: Herhangi bir koşulun sağlanmasını yeterli kılar.
        -- NOT: Koşulun sağlanmamasını gerektirir.
    -- BETWEEN: Başlangıç ve bitiş değerleri dahil olmak üzere, belirli bir aralıktaki değerleri seçer.
    -- IN: Belirli bir dizi değerden herhangi birine eşleşen satırları seçer.
    -- LIKE: Belirli bir deseni karşılayan satırları seçmek için kullanılır. 
-- Kombine kullanımlar: Birden fazla filtreleme komutunu birlikte kullanma.
    -- Birden fazla komutun birlikte kullanımı, verileri daha hassas bir şekilde filtrelemeyi sağlar.
-- DELETE: Belirli bir koşula göre verileri siler.
-- DROP: Tabloyu tamamen siler-tabloyu SCHEMA'dan kaldırir
-- CASCADE: İlişkili verilerin otomatik olarak silinmesini veya güncellenmesini sağlar.
-- IF EXISTS: Bir tablo veya veri var ise silinmesini sağlar.

------------------------: TABLE CREATION :--------------------------

-- Mevcut tabloyu kontrol et ve sil.
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS product_categories;

-- CREATE TABLE: Veritabanında yeni tablolar oluşturur.
-- Bu tablolar çeşitli veri türleri ve kısıtlamalar içerir.
CREATE TABLE products (
    product_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    product_name VARCHAR(50) NOT NULL, -- NOT NULL: Boş olamaz
    description TEXT, -- TEXT veri türü
    price DECIMAL(10, 2) CHECK (price >= 0), -- CHECK: Pozitif olmalı
    created_at DATE DEFAULT CURRENT_DATE, -- DEFAULT: Varsayılan değer
    is_active BOOLEAN DEFAULT TRUE -- BOOLEAN ve DEFAULT kısıtlaması
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY, -- PRIMARY KEY: Benzersiz ve NULL olamaz
    category_name VARCHAR(50) NOT NULL -- NOT NULL: Boş olamaz
);

CREATE TABLE product_categories (
    product_id INT, 
    category_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE, -- FOREIGN KEY: 'products' tablosundaki 'product_id'ye referans, CASCADE ile
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE -- FOREIGN KEY: 'categories' tablosundaki 'category_id'ye referans, CASCADE ile
);

-- INSERT INTO: 'products' ve 'categories' tablolarına örnek veriler ekler.
INSERT INTO products (product_id, product_name, description, price, created_at, is_active) VALUES
(1, 'Product 1', 'Description for product 1.', 19.99, '2023-01-01', TRUE),
(2, 'Product 2', 'Description for product 2.', 29.99, '2023-02-01', FALSE),
(3, 'Product 3', 'Description for product 3.', 39.99, '2023-03-01', TRUE);

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Category 1'),
(2, 'Category 2'),
(3, 'Category 3');

INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);

------------------------: PRACTICE :--------------------------

-- 1. WHERE: Fiyatı 30'dan büyük olan ürünleri seç.
SELECT * 
FROM products 
WHERE price > 30;

-- 2. WHERE: Ürün adı 'Product 2' olan ürünleri seç.
SELECT * 
FROM products 
WHERE product_name = 'Product 2';

-- 3. AND: Fiyatı 20 ile 40 arasında olan ve aktif olan ürünleri seç.
SELECT * 
FROM products 
WHERE price BETWEEN 20 AND 40 
    AND is_active = TRUE;

-- 4. OR: Ürün adı 'Product 1' veya 'Product 3' olan ürünleri seç.
SELECT * 
FROM products 
WHERE product_name = 'Product 1' 
    OR product_name = 'Product 3';

-- 5. NOT: Ürün adı 'Product 2' olmayan ürünleri seç.
SELECT * 
FROM products 
WHERE NOT product_name = 'Product 2';

-- 6. BETWEEN: Fiyatı 20 ile 40 arasında olan ürünleri seç.
SELECT * 
FROM products 
WHERE price BETWEEN 20 AND 40;

-- 7. IN: Ürün adı 'Product 1', 'Product 2' veya 'Product 3' olan ürünleri seç.
SELECT * 
FROM products 
WHERE product_name IN ('Product 1', 'Product 2', 'Product 3');

-- 8. LIKE: Ürün adı 'Product%' ile başlayan ürünleri seç.
SELECT * 
FROM products 
WHERE product_name LIKE 'Product%';

-- 9. LIKE: Açıklamasında 'description' kelimesini içeren ürünleri seç.
SELECT * 
FROM products 
WHERE description LIKE '%description%';

-- 10. Kombine: Fiyatı 20 ile 40 arasında olan ve ürün adı 'Product%' ile başlayan ürünleri seç.
SELECT * 
FROM products 
WHERE price BETWEEN 20 AND 40 
    AND product_name LIKE 'Product%';

-- 11. Kombine: Aktif olan ve açıklamasında 'product' kelimesini içeren ürünleri seç.
SELECT * 
FROM products 
WHERE is_active = TRUE 
    AND description LIKE '%product%';

-- 12. DELETE: Fiyatı 30'dan büyük olan ürünleri sil.
DELETE FROM products 
WHERE price > 30;

-- 13. DELETE CASCADE: Kategori ID'si 1 olan tüm kategorileri ve bu kategorilere bağlı ürün kategorilerini sil.
-- CASCADE kullanımı, ilişkili tüm verilerin otomatik olarak silinmesini sağlar.
DELETE FROM categories 
WHERE category_id = 1;

-- 14. DELETE WHERE: Ürün adı 'Product 3' olan ürünleri sil.
DELETE FROM products 
WHERE product_name = 'Product 3';

-- 15. DELETE WHERE: Ürün adı 'Product 1' veya 'Product 2' olan ürünleri sil.
DELETE FROM products 
WHERE product_name IN ('Product 1', 'Product 2');

-- 16. DELETE WHERE: Fiyatı 25'ten küçük olan ürünleri sil.
DELETE FROM products 
WHERE price < 25;

------------------------: CLEANUP :--------------------------

-- Tabloları silmeden önce verileri temizleyin.
DELETE FROM product_categories WHERE EXISTS (SELECT 1 FROM product_categories);
DELETE FROM categories WHERE EXISTS (SELECT 1 FROM categories);
DELETE FROM products WHERE EXISTS (SELECT 1 FROM products);

-- Tabloları silin.
DROP TABLE IF EXISTS product_categories CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS products CASCADE;
