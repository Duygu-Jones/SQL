
--Tablo olusturma:
CREATE TABLE ogrenciler(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(20),
not_ort REAL, --ondalikli sayilar
kayit_tarihi date
);

SELECT * FROM ogrenciler;

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

-----------------------
/*cok 
 * 
 *satirli 
 *yorum
 */
------------------------

--Table silme
DROP table FROM ogrenciler;

--CONSTRAINTS/ KISITLAMALAR/BELİRLEYİCİLER

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


--PRIMARY KEY: -----------------------------------------------
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

--FOREING KEY:------------------------------------------
-- Foreign Key:Tablolar arasında ilişki oluşturmak içindir.
-- Değer olarak "null" kabul eder
-- Tekrarlanan verileri kabul eder
-- Bir tablo birden çok "Foreign Key" alanına sahip olabilir.

--Parent Table;
CREATE TABLE sirketler(
sirket_id INTEGER,
sirket varchar(50)PRIMARY KEY,
personel_sayisi INTEGER
);

SELECT *FROM sirketler;

--Child Table;
CREATE TABLE personel(
id INTEGER,
isim VARCHAR(50),
sehir VARCHAR(50),
maas REAL,
sirket VARCHAR(50),
FOREIGN key(sirket) REFERENCES sirketler(sirket)
);

-- CONSTRAINT per_fk FOREIGN key(sirket) REFERENCES sirketler(sirket); => basina tanimlama ile de eklenebilir
SELECT *FROM personel;


-- CHECK Constraints: -------------------------------

--ORN:
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

-- DISTINCT KOMUTU;------------------------------
-- istenilen sutundaki unique degerleri getirir
SELECT DISTINCT
	name
	FROM person;



