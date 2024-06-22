--------------------------: ALIASES (Takma İsimler) :--------------------------

-- ALIASES: SQL sorgularında sütunlara veya tablolara geçici isimler vermemizi sağlar.
-- Bu, sorguların okunabilirliğini ve anlaşılabilirliğini artırır.



------------------------: TABLE CREATION :--------------------------

-- Mevcut 'workers' tablosunu kontrol et ve sil.
DROP TABLE IF EXISTS workers;


-- CREATE TABLE: 'workers' tablosunu oluşturur.
CREATE TABLE workers (
    worker_id CHAR(9),
    worker_name VARCHAR(50),
    worker_birth_city VARCHAR(50)
);

-- INSERT INTO: 'workers' tablosuna örnek veriler ekler.
INSERT INTO workers VALUES ('123456789', 'John Doe', 'New York'); 
INSERT INTO workers VALUES ('234567890', 'Jane Smith', 'Los Angeles');  
INSERT INTO workers VALUES ('345678901', 'Michael Johnson', 'Chicago');


------------------------: PRACTICE :--------------------------

-- 1. 'workers' tablosunu herhangi bir takma isim kullanmadan görüntüleyin.
SELECT * 
FROM workers;

-- 2. 'worker_id' sütununa geçici bir takma isim verin.
SELECT worker_id AS id 
FROM workers;

-- 3. 'worker_id' ve 'worker_name' sütunlarına geçici takma isimler verin.
SELECT 
    worker_id AS id, 
    worker_name AS name 
FROM workers;

-- 4. 'worker_id' ve 'worker_name' sütunlarını birleştirip 'id_name' takma ismini verin.
SELECT 
    worker_id || ' - ' || worker_name AS id_name 
FROM workers;

-- 5. Tüm 'workers' tablosuna geçici bir takma isim verin ve 'worker_birth_city' sütununu 'birth_city' olarak adlandırın.
SELECT 
    worker_id AS id, 
    worker_name AS name, 
    worker_birth_city AS birth_city 
FROM workers AS employees;


------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM workers WHERE EXISTS (SELECT 1 FROM workers);

-- Tabloları silin.
DROP TABLE IF EXISTS workers;
