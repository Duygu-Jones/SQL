
-------------------------------DATA SSCIENCE SQL LESSONS-------------------------------
-------------------------------PAGE: Orange Page Database: PRACTICE -------------------


												--Date: 25 may 2024 Saturday (2 lessons)
												--Section: 3 ve 4 | Day-4
----------------------------------------------------------------------------------------


--Tablo olusturma:
CREATE TABLE ogrenciler(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(20),
not_ort REAL, --ondalikli sayilar
kayit_tarihi date
);

SELECT * FROM ogrenciler;

--Note:
--SQL de table olusturmanin 2 yolu vardir. 
--Birinci: sifirdan CREATE
--Ikinci: mevcut Table dan belli 'field' lar ile


--Mevcut table dan yeni table olusturma;

CREATE TABLE ogrenci_notlari
AS 
SELECT isim, soyisim, not_ort
FROM ogrenciler;

SELECT * FROM ogrenci_notlari;



-- Value girisi yapalim;

INSERT INTO ogrenciler VALUES ('12345', 'Tom', 'Cruise', 85.5,'2024-05-25');
INSERT INTO ogrenciler VALUES('2345678', 'Ali', 'Can', 90.2, now()); --LOCAL date ekledi

INSERT INTO ogrenciler (isim,soyisim)
VALUES ('Brad','Pitt');
-------------------------------------------
--DBeaver code generate: belli database - schemas - table- Sagtik->generate SQL
-- buradan istedigimiz keyword ile code syntax i alip yapistirabilir ve value lari sonra doldurabilirz

--ORN Generate SQL:
INSERT INTO public.ogrenciler
(ogrenci_no, isim, soyisim, not_ort, kayit_tarihi)
VALUES('', '', '', 0, '');

--Note:
/*-------cok 
 *satirli 
 *yorumu
 ----------*/



-----------DROP TABLE: 

DROP table FROM ogrenciler;



-----------CONSTRAINTS/ KISITLAMALAR/BELİRLEYİCİLER

CREATE TABLE ogrenciler2(
ogrenci_no char(7) UNIQUE, 
isim varchar(20) NOT NULL ,
soyisim varchar(20) NOT NULL ,
not_ort REAL,
kayit_tarihi date
);

SELECT *FROM ogrenciler2;

INSERT INTO ogrenciler2 VALUES ('12456', 'ali','yilmaz',80,now());
INSERT INTO ogrenciler2 VALUES ('12456', 'Veli','yilmaz',90,now()); -- SQL Error [23505]: ogrenco_no UNIQUE fakat ikinci kez girildi
INSERT INTO ogrenciler2 VALUES ('124598', '_','yilmaz',90,now()); -- SPACE de bir karakterdir
INSERT INTO ogrenciler2(isim, soyisim) VALUES ('Ayse','yilmaz');


----------------PRIMARY KEY:

-- Primary Key: Eger bir field "primary key" olarak deklare edilmisse, field datalari "unique", "not null" olmali.
--Bir tabloda sadece 1 tane "primary key" olabilir.


--Primary Key atamasi icin 1.yol:
CREATE TABLE ogrenciler4(
ogrenci_no char(7) PRIMARY KEY , 
isim varchar(20) NOT NULL ,
soyisim varchar(20) NOT NULL ,
not_ort REAL,
kayit_tarihi date
);

SELECT *FROM ogrenciler4;


--Primary Key atamasi icin 2.yol:
CREATE TABLE ogrenciler5(
ogrenci_no char(7), 
isim varchar(20) NOT NULL ,
soyisim varchar(20) NOT NULL ,
not_ort REAL,
kayit_tarihi date,
CONSTRAINT ogr_no_pk PRIMARY KEY (ogrenci_no)
);

SELECT *FROM ogrenciler5;

INSERT INTO ogrenciler5 VALUES ('12456', 'ali','yilmaz',80,now());
INSERT INTO ogrenciler5 VALUES ('12456', 'Veli','yilmaz',90,now());--SQL Error [23505]: ERROR: duplicate key value violates unique constraint "ogr_no_pk"
INSERT INTO ogrenciler5(isim, soyisim) VALUES ('Ayse','yilmaz');
	--SQL Error [23502]: ERROR: null value in column "ogrenci_no" of relation 
	--"ogrenciler5" violates not-null constraint
  	--Ayrıntı: Failing row contains (null, Ayse, yilmaz, null, null).




--------------------FOREING KEY:

-- Foreign Key:Tablolar arasında ilişki oluşturmak içindir.
-- Değer olarak "null" kabul eder
-- Tekrarlanan verileri kabul eder
-- Bir tablo birden çok "Foreign Key" alanına sahip olabilir.


-- Practice:

-- Parent Table;
CREATE TABLE sirketler(
sirket_id INTEGER,
sirket varchar(50)PRIMARY KEY,
personel_sayisi INTEGER
);

SELECT *FROM sirketler;

-- Child Table;
CREATE TABLE personel(
id INTEGER,
isim VARCHAR(50),
sehir VARCHAR(50),
maas REAL,
sirket VARCHAR(50),
FOREIGN key(sirket) REFERENCES sirketler(sirket)
);
--> CONSTRAINT per_fk FOREIGN key(sirket) REFERENCES sirketler(sirket); 
----=> Consraintler isim verilerek tanimlama ile de eklenebilir

SELECT *FROM personel;


-------------------- CHECK Constraints:
-- Condition verir.

--Practice:
--  Age ve Salary için veri giriş şartı oluşturalım.
--Salary 5000 den büyük olmalı, age 0 dan küçük olmamalı

CREATE TABLE person (
id integer, 
name varchar(50),
salary REAL CHECK(salary> 5000),
age integer CHECK (age > 0)
);

SELECT * FROM person;

INSERT INTO person VALUES(11, 'Ali Can' , 6000, 35) ;
INSERT INTO person VALUES(12, 'Ali Can' ,6000, -3); -- ERROR age != -3
INSERT INTO person VALUES(13, 'Ali Can' , 4000, 45); --violates check constraint "person_salary_check"



-------------------- DISTINCT KOMUTU:
-- istenilen sutundaki unique degerleri getirir

-- Practice:
SELECT DISTINCT
	name
FROM person;



--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------
												--Date: 28 may 2024 Tuesday (-Monday was holiday)
												--Section: 5


-- SORU-1
/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”  
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın. 

“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve 
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar(
id SERIAL PRIMARY KEY,
isim varchar(50) UNIQUE,
maas numeric(10,2) NOT NULL ,
ise_baslama DATE 
);



CREATE TABLE adresler(
adres_id SERIAL ,
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

--NOT: Primary key ile foreign Key aynı data tipinde olmalıdır

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); --ERROR (UNIQU isim olmali)
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');

SELECT * FROM calisanlar 
-- INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');-- error verri.çünkü isim UNIQUE olmalıydı

-- INSERT INTO calisanlar VALUES('10006', 'Canan Yaz', NULL, '2019-04-12')--error verir cunku maas field i icin "NOT NULL" constraint atanmistir.


-- PERSON tablosu oluşturalım

CREATE TABLE person (
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES(344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;


--------------- LENGTH:

/*Senaryo 4: 
 *person tablosunda isim ve soyisim değerlerini, soyisim kelime uzunluklarına 
 *göre sıralayarak listeleyiniz. */

SELECT isim, soyisim
FROM person
ORDER BY LENGTH(soyisim) 



--------------- CONCAT:

/*Senaryo 5: 
 *person Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak, 
 *her bir isim ve soyisim değerinin toplam uzunluğuna göre sıralayınız.*/

SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim
FROM person
ORDER BY LENGTH(isim)+LENGTH(soyisim)









--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------
															--Date: 29 may 2024 Wednesday
															--Section: 6


-- developers table create

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','btl@mail.com',4000,'C#','Bursa',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayse Gul','ayse@mail.com',4000,'C#','Ankara',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ali Seker','ali@mail.com',4000,'C#','Ankara',29);

SELECT * FROM developers 

--Senaryo 1: developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.

SELECT *
FROM developers
LIMIT 3;

/*Senaryo 2: developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.*/

SELECT *
FROM developers
OFFSET 2
LIMIT 3;

-- Senaryo 3: developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.*/

SELECT *
FROM developers
ORDER BY salary -- aynı maaş değerlerinin kendi arasında sıralamak için name ekleneiblir
LIMIT 3;


-- Senaryo 4: developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.*/

SELECT *
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

SELECT *
FROM developers AS d 





						

--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------
															--Date: 30 may 2024 Thursday
															--Section: 7





--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------
															--Date: 31 may 2024 Friday
															--Section: 8



















































































