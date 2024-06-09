
-------------------------------DATA SSCIENCE SQL LESSONS-------------------------------
-------------------------------PAGE: Green Page :LEARNING------------------------------


												--Date: 25 may 2024 Saturday (2 lessons)
												--Section: 3 ve 4 | Day-4
---------------------------------------------------------------------------------------

----------CREATE:

--Create the table: Customers();

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  country     VARCHAR(50),
  score       INTEGER
);

INSERT INTO customers (customer_id, first_name, last_name, country, score) VALUES
(1,'Maria', 'Cramer', 'Germany',350),
(2,'John','Steel','USA', 900),
(3,'Georg','Pipps', 'UK', 750),
(4,'Martin','Müller','Germany', 500),
(5,'Peter','Franken','USA', NULL);


SELECT *
FROM customers


----------SELECT:

SELECT 
	first_name,
	country
FROM customers;


-- create table orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id    SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  DATE,
  quantity    INTEGER
);



---------INSERT:

-- Insert orders data
INSERT INTO orders (order_id, customer_id, order_date, quantity) VALUES
(1001,1,'2021-01-11',250),
(1002,2,'2021-04-05',1150),
(1003,3,'2021-06-18',500),
(1004,6,'2021-08-31',750);


SELECT * FROM orders;

SELECT order_id FROM orders;


-- create table employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id      SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  emp_country VARCHAR(50),
  salary      INTEGER
);


-- Insert employees data
INSERT INTO employees (emp_id, first_name, last_name, emp_country, salary) VALUES
(1,'John', 'Steel', 'USA', 55000),
(2,'Ann', 'Labrune', 'France', 75000),
(3,'Marie', 'Bertrand', 'Brazil', 75000),
(4,'Georg', 'Afonso', 'UK', 75000),
(5,'Marie', 'Steel', 'UK', 75000);

SELECT * FROM employees;


------- DISTINCT: 
-- Secilen sutundaki unique degerleri getirir

--Practice:
SELECT DISTINCT
	country
FROM customers




----------------------------------PAGE: Green Page :LEARNING-----------------------------------------
														--Date: 28 may 2024 Tuesday (-Monday holiday)
														--Section: 5 | Day-5


------- ORDER BY:

--Practice:
-- Customer tablosunu score değerlerine göre küçükten büyüğe sıralayarak getir

SELECT * FROM customers
ORDER BY score ASC   -- ASC, DEFAULT olarak ORDER BY tarafından getirilir


--NOTE:
-- PostgreSQL; default olarak NULL hücreyi en sona götürür, MySQL de ise tam tersi şekilde getirir
-- PostgreSQL; Büyükten küçüğe sıralamada NULL hücteyi öncelikli getirir
-- Eğer NULL değerler en üstte gelsin isterseniz: ASC order ile getirebilirisiniz

--Practice:

SELECT * FROM customers
ORDER BY score ASC NULLS FIRST 


--Practice:
--Customer tablosunu score değerlerine göre büyükten küçüğe sıralayarak getir

SELECT * FROM customers
ORDER BY score DESC 


--Practice:
--NULL değerler en altta görünmesini isterseniz;

SELECT * FROM customers
ORDER BY score DESC NULLS LAST


--Practice:
--Country'e göre alfabetik olarak ve score göre büyükten küçüğe sırala;

SELECT *
FROM customers 
ORDER BY country ASC, score DESC 
--> önce country ye göre suraladık, sonra ülkeleri kendi içerisinde score a göre tekrar sıraladık

-- NOTE:
-- Alttaki kullanım çok tavsiye edilmez ama kullanılailbir
-- Field adı yerine sıralamadaki numarasını yazaiblirsiniz..
SELECT * FROM customers
ORDER BY 4 ASC, 5 DESC 



---------LIMIT:
-- Seçilen rakam kadar satır döndürür

--Practice:
SELECT * 
FROM customers
LIMIT 2



----------OFFSET ve LIMIT:
-- OFFSET: yazılan rakam kadar satırı atlayıp sonrakileri getirmenizi sağlar

--Practice:
SELECT * 
FROM customers
OFFSET 2
LIMIT 2
--> ilk 2 satırı atlayıp sonraki 2 satırı döndürür












-----------------------------------------PAGE: Green Page :LEARNING----------------------------------
																		--Date: 29 may 2024 Wednesday
																		--Section: 6

--------------------ALIAS:


SELECT *
FROM employees e 

SELECT salary, salary*0.1 AS bonus
FROM employees e 

SELECT salary
FROM employees e 


---------------------WHERE:


--Practice:
---sadece German olanları getir
SELECT *
FROM customers c
WHERE country = 'Germany'

--score değeri 500 den büyük olanları getir
SELECT *
FROM customers c
WHERE score > 500

--score değeri 500 den küçük olanları getir
SELECT *
FROM customers c
WHERE score < 500

-- German olmayanları getir
SELECT *
FROM customers c
WHERE country != 'Germany'

--2.versiyon
SELECT *
FROM customers c
WHERE country <> 'Germany'



---------------------AND Operatörü:


-- TASK: Puanı 400 den az ve Germany olan tüm customerları bul.
SELECT *
FROM customers
WHERE country = 'Germany' 
AND score < 400


					




---------------------------------------PAGE: Green Page :LEARNING-----------------------------------
																		--Date: 30 may 2024 Thursday
																		--Section: 7

---------------WHERE Komutu (Devam)


SELECT * FROM customers c 

--Practice:
--ALMANYA "OR" SCORE'u  500 DEN KÜÇÜK OLANLARI GETİR
SELECT * 
FROM customers
WHERE country = 'Germany'
OR
score < 500


--Practice:
--Score değeri 400 den küçük olmayanları getir (NOT örneği)
SELECT *
FROM customers c 
WHERE NOT 
score < 400

-------------------- BETWEEN:

--Practice:
-- score değeri 100 ve 500 arasında olanları getir
--Betweeen de sınırlar dahildir
SELECT *
FROM customers c 
WHERE score 
BETWEEN 100 AND 500

--Alternatif
SELECT *
FROM customers c 
WHERE 
score >= 100 AND score <=500



-----------------------IN:


--Practice:
--id değeri 1,2 veya 5 olan customer ları getir
SELECT *
FROM customers c 
WHERE customer_id IN(1,2,5)


--IN kullanilmamis hali;
SELECT *
FROM customers
WHERE customer_id =1
OR customer_id =2
OR customer_id=5


------------------------LIKE:
--Case Sensitivedir

--Practice:
-- n harfi ile biten adların hepsini getir
SELECT *
FROM customers c
WHERE first_name LIKE '%n'

--Practice:
-- 3.sıradaki harfi r olan isimleri getir
SELECT *
FROM customers c
WHERE first_name LIKE '__r%'

--Practice: 
-- M harfi ile başlayan isimleri getir
SELECT *
FROM customers c
WHERE first_name LIKE 'M%'

--Practice:
-- İçinde r harfi geçen isimleri getir
SELECT *
FROM customers c
WHERE first_name LIKE '%r%'



------------------- GROUP BY:


SELECT *
FROM customers c 

--Practice:
-- herbir ülke için total customer sayılarını getir
SELECT 
COUNT(*) AS total_customers,
country
FROM customers c 
GROUP BY country 
ORDER BY COUNT(*) ASC


-------------------- AGGREGATE FUNCTIONS:
-------------------- COUNT:

SELECT * FROM customers

-- Count örneği
SELECT count(*) AS total_customers 
FROM customers

-- Count örneği: 
SELECT count(customer_id) AS total_cus
FROM customers 


--Note: Count(*): count of all rows (ignores NULLs)
--------Count(column): count of all values in the column, (ignores NULLs)
--------Count(Distinct Column): count of all unique values in the column (ignores NULLs)
--------Count(T.*): count of all rows with onlty non-null values


SELECT * 
FROM orders

-- SUM örneği
-- toplam quantity ne kadardır?
SELECT sum(quantity) AS sum_quantity
FROM orders






-------------------------------------PAGE: Green Page :LEARNING ---------------------------------------
																			--Date: 31 may 2024 Friday
																			--Section: 8


----------------- AVERAGE:

SELECT * FROM customers c 

SELECT AVG(score) AS avg_score
FROM customers c


----------------COALESCE():

-- eğer NULL hücreye belli bir değer verip ortalamaya katmak istersek;
SELECT AVG(COALESCE(score,0)) AS avg_score
FROM customers c


---------------- MIN and MAX:

-- en yüksek score değeri nedir ?
SELECT max(score) AS max_score 
FROM customers c 

-- en düşük  score değeri nedir ?
SELECT MIN(score) AS min_score 
FROM customers c 

SELECT * FROM orders o  

-- Tarihlerle alakalı ilk ve son siparişin tarihini de Min-Max ile bulabiliriz

SELECT MIN(order_date) AS first_order 
FROM orders o 

SELECT MAX(order_date) AS last_order 
FROM orders o 

--2.Alternatif yol:
SELECT order_date
FROM orders
ORDER BY order_date  DESC
LIMIT 1
   


/*-----------------STRING FONKSIYONLARI---------------------------
1) TRIM(Sütun parametresi) string ifadenin başındaki ve sonundaki boşluk karakterlerini siler
		LTRIM sadece soldan boşluk siler
		RTRIM sadece sağdan boşluk siler
		
2) REPLACE(sütun,'değişecek ifade','yeni ifade') belirtilen ifadeyi o sütunda bulursa,belirlediğiniz yeni ifade ile değiştirir
	bir değişiklik yaptığı için UPDATE ile kullanılır
	
3) CONCAT(sütunadı, 'string') iki veya daha fazla dizeyi birleştirme işlemi için kullanılır

4) SUBSTRING(sütun adı,başlangıç index,bitiş index) o sütunda belirtilen index aralığındaki string değerini verir
	istediğimiz bir sütunda stringlerin istediğimiz kısımlarını değiştirebiliriz. 
	Tek index ilede çalışır belirtilen kısımdan en sona kadar alır
	
5) UPPER (sütun adı) o sütundaki strng değerleri büyük harfle getirir 
6) LOWER (sütun adı) o sütundaki strn değerleri küçük harfle getirir 
7) INITCAP(sütun adı) o sütundaki her bir satırdaki stringlerin baş harfini büyük harf yapar
8) LENGTH(sütun adı) belirtilen sütundaki her satır içinde bulunan stringlerin uzunluklarını alır 
9) REVERSE(sütun adı) sütunu ters çevirir
10) LEFT() / RIGHT() (Başlangıç ve Son Karakterler): Bir dizinin başlangıç veya sonundaki belirli karakterleri alır.
11) LEFT(sütun, 3) ilk 3 karakteri alır RIGHT olsa son 3 karakteri alırdı
12) FETCH NEXT n ROW ONLY  : sadece sıradaki ilk n satırı getirir
                  LIMIT n  : sadece sıradaki ilk n satırı getirir - terminate fonk
                  OFFSET n : n satırı atlayıp sonrakileri getirir
----------------------------------------------------------------------*/

--------------- STRING FUNCTIONS:
-------------1) CONCAT():

-- isim ve soyisimi araya tire koyarak birlşeitirinz
SELECT * FROM customers c 

SELECT CONCAT(first_name,'-',last_name) AS cust_name_surname
FROM customers c 

--------------2)UPPER-LOWER():

-- FIRST name i büyük harflere, last name i küçük harflere dönüştürelim
SELECT 
UPPER(first_name) AS upper_first_name,
LOWER(last_name) AS lower_lasname
FROM customers c 

---------------3)LENGTH():

SELECT last_name,
length(last_name) AS len_lastname
FROM customers c 

----------------4)TRIM():

--TRIM ÖNCESİ VE SONRASI  UZUNLUKLARI GOSTER VE KARŞILAŞTIR

SELECT last_name,
length(last_name) AS len_lastname,   -- Trim öncesi uzunluklar
TRIM(last_name) AS clean_lastname,  -- Trim işlemi
LENGTH(TRIM(last_name))AS clean_len_lastname --Trim sonrası uzunluklar
FROM customers c 

-----------------5)SUBSTRING:
-- Kelimenin  belli bir bölümünü almak için

SELECT 
last_name,
substring(last_name,2,3) 
FROM customers c 

------------------ GROUP BY - HAVING:

SELECT * FROM customers c 

SELECT 
COUNT(*) AS total_customers,
country 
FROM customers c 
GROUP BY country 
ORDER BY COUNT(*)


-- herbir ülke için en yüksek score getir
SELECT 
MAX(score) AS max_score,
country
FROM customers c 
GROUP BY country 

--------------------- HAVING:
--Group by ile yapilan islemlerde filtrreleme yapar.

--soru: her ülke için toplam müşteri sayısını bulup sadece 1 den fazla olan sonuçları getir
SELECT 
country,
count(*) AS total_customers
FROM customers c 
GROUP BY country
HAVING count(*) > 1






-------------------------------------PAGE: Green Page :LEARNING ------------------------------------------
																			--Date: 01 June 2024 Saturday
																			--Section: 9

------------INSERT:

SELECT * FROM customers c 

INSERT INTO customers VALUES(DEFAULT, 'Anna', 'Nixon', 'UK',NULL);

--Default olark tabloda en son kaldigi satir numarasini id icin atar (eger bir constraint yok ise)


UPDATE customers
SET country ='USA', score ='100'
WHERE customer_id = 4;



INSERT INTO customers 
	(customer_id, first_name,last_name)
VALUES (7, 'Max', 'Lang')


--------------- UPDATE:

-- NOT: UPDATE-SET-WHERE 3lü yapıyı kullancağız
--SORU: Customer_id si 6 olan kiişnin Country değerini Germany yap

UPDATE customers 
SET country = 'Germany'
WHERE customer_id = 6

SELECT * FROM customers c 

--SORU: Max Lang ın country değerini USA yapıp score değerini 100 olarak güncelleyiniz

UPDATE customers  
SET 
	country = 'USA',
	score = 100
WHERE customer_id = 7;

SELECT * FROM customers c 


--------------------- DELETE & TRUNCATE:
----------------------DELETE-FROM-WHERE-----

--DELETE ile TRUNCATE ve DROP sorgusu arasındaki fark nedir?
--DELETE komutu veritabanındaki tablodan bir veya daha fazla mevcut kaydı siler.
--DROP Komutu tablonun tamamını veritabanından çıkarır.
--TRUNCATE Komutu mevcut tablodaki tüm satırları siler ve  sütunları adlarıyla bırakır.


--SORU: yeni eklenen Anna ve Max i tablodan siliniz
-- NOT: DELETE-FROM-WHERE 3lü yapıyı kullancağız
DELETE 
FROM customers 
WHERE customer_id IN(6,7) -- silme ve UPDATE işlemelrinde ID üzerindne koşul konulması önerilir

SELECT * FROM customers c 


--------------------- TRUNCATE TABLE:

--SORU: Tablodak tüm customers lrı siliniz

TRUNCATE TABLE customers  -- TÜM SATIRLARI SİLDİ -FAKAT FİELD'LAR KALDI

INSERT INTO customers (customer_id, first_name, last_name, country, score) VALUES
(1,'Maria', 'Cramer', 'Germany',350),
(2,'John','Steel','USA', 900),
(3,'Georg','Pipps', 'UK', 750),
(4,'Martin','Müller','Germany', 500),
(5,'Peter','Franken','USA', NULL);




























