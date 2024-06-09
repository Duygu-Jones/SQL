
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



--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------------
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









--------------------------------------PAGE: Orange Page Database: PRACTICE --------------------------------
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


/*Senaryo 2: 
 *developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.*/

SELECT *
FROM developers
OFFSET 2
LIMIT 3;


-- Senaryo 3: 
-- developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.*/

SELECT *
FROM developers
ORDER BY salary -- aynı maaş değerlerinin kendi arasında sıralamak için name ekleneiblir
LIMIT 3;



-- Senaryo 4: 
-- developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.*/

SELECT *
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

SELECT *
FROM developers AS



--------------------ALIAS: AS name
--------------------ALIAS ile yapılan işlemler sadece RAPORLAMADA görülür


CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');
SELECT * FROM workers;


/* Practice: 
1-calisan_id sutun ismini id olarak degistirelim
2-calisan_isim sutun ismini isim olarak degistirelim
3-workers olan tablo ismini w olarak degistirelim*/

SELECT calisan_id AS id FROM workers 
SELECT calisan_isim isim FROM workers;  --as kullanmadan da calisir
SELECT calisan_isim isim FROM workers AS w;  --tablo ismide degistirilebilir. 




--------------------- WHERE:


CREATE TABLE calisanlar1(
id char(5),
isim varchar(50),
maas int,
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Donatello' ,12000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10003', null, 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10004', 'Donatello', 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10005', 'Michelangelo', 5000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10006', 'Leonardo', null, '2019-04-12');
INSERT INTO calisanlar1 VALUES('10007', 'Raphael',null , '2018-04-14');
INSERT INTO calisanlar1 VALUES('', 'April', 2000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('', 'Ms.April', 2000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10002', 'Splinter' ,12000, '2018-04-14');
INSERT INTO calisanlar1 VALUES( null, 'Fred' ,12000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10010', 'Betty' ,12000, '2018-04-14');


CREATE TABLE adresler1(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(20)
);

INSERT INTO adresler1 VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler1 VALUES('10003','Kaya Sok', '50.Cad.','Ankara');
INSERT INTO adresler1 VALUES('10002','Taş Sok', '30.Cad.','Konya');
INSERT INTO adresler1 VALUES('10012','Taş Sok', '30.Cad.','Konya');
INSERT INTO adresler1 VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler1 VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT * FROM calisanlar1;
SELECT * FROM adresler1;


--Practice:
--calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
SELECT *
FROM calisanlar1
WHERE isim = 'Donatello'


--calisanlar tablosundan maaşı 5000den fazla olanların tüm bilgilerini listeleyelim
SELECT *
FROM calisanlar1
WHERE maas > 5000;

--calisanlar tablosundan maaşı 5000den fazla olanların isim ve maaşlarını listeleyelim
SELECT isim,maas
FROM calisanlar1
WHERE maas > 5000

--adresler tablosundan sehiri 'Konya' ve adres_id si 10002 olan kaydın tüm verileri getirelim
SELECT *
FROM adresler1
WHERE sehir = 'Konya'
AND adres_id = '10002'

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim
SELECT cadde, sehir
FROM adresler1
WHERE sehir = 'Konya'
OR sehir = 'Bursa'



						

--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------------
																			--Date: 30 may 2024 Thursday
																			--Section: 7
--Empty--

--------------------------------------PAGE: Orange Page Database: PRACTICE -------------------------------
																			--Date: 31 may 2024 Friday
																			--Section: 8

/*Senaryo: “markalar” ve “calisanlar3” adinda iki tablo oluşturun.*/

CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

CREATE TABLE calisanlar3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosunda max maaş değerini bulunuz.
SELECT MAX(maas) AS max_maas
FROM calisanlar3

--calisanlar3 tablosunda min maaş değerini bulunuz.
SELECT MIN(maas) AS min_maas
FROM calisanlar3

--calisanlar3 tablosunda toplam maaş değerini bulunuz.
SELECT SUM(maas) AS top_maas
FROM calisanlar3

--calisanlar3 tablosunda ortalama maaş değerini bulunuz.
SELECT ROUND(AVG(maas),2) AS ort_maas
FROM calisanlar3

--calisanlar3 tablosundaki kayıt sayısını bulunuz.
SELECT COUNT(*) AS kayit_sayi
FROM calisanlar3

--calisanlar3 tablosunda maaşı 2500 olanların kayıt sayısını bulunuz.
SELECT COUNT(*) AS kayit_sayi_2500
FROM calisanlar3
WHERE maas = 2500



----------------STRING FUNCTIONS:


-- TEACHERS tablosu oluşturalım;

CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,	
city varchar(20),
course_name varchar(20),
salary real	
);

INSERT INTO teachers VALUES(111,'AhmeT  ','  Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran ',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,' Bilal','Fan ',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal',' San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz',' Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'ekreM','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'fatiH','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);

SELECT * FROM teachers;

--SORU-1:
--teachers tablosundaki tüm kayıtların;
----firstname değerlerini büyük harfe, 
----lastname değerlerini küçük harfe çevirerek, 
----uzunlukları ile birlikte listeleyiniz.

SELECT 
upper(firstname) AS upper_firstname,
length(firstname) AS len_firstname,
LOWER(lastname) AS lower_lastname,
length(lastname) AS len_lastname
FROM teachers t 

--Soru-2:
--teachers tablosunda firstname ve lastname değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırarak raporlayınız.

SELECT 
	TRIM(firstname) AS clean_firstname, 
	TRIM(lastname)AS clean_lastname
FROM teachers t 

--SOrU 3:
--teachers tablosunda tüm kayıtların firstname değerlerini
--ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

-------------INITCAP: (initial capital)
SELECT 
	firstname,
	initcap(firstname) AS init_firstname 
FROM teachers t 



-----------------------------------PAGE: Orange Page Database: PRACTICE ---------------------------------
																			--Date: 01 June 2024 Saturday
																			--Section: 9


-----------TABLE manav-------
CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav;

--Senaryo 1:
--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
SELECT isim,SUM(urun_miktar) AS toplam_urun
FROM manav
GROUP BY isim;

--Senaryo 2:
--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
--toplam ürün miktarına göre AZALAN sıralayınız.

SELECT isim, SUM(urun_miktar) AS top_kg
FROM manav m 
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC; 

--Senaryo 3:Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.
SELECT isim,urun_adi,SUM(urun_miktar) AS toplam_kg 
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim

--Senaryo 4: ürün adina göre, her bir ürünü alan toplam kişi sayısını gösteriniz
SELECT urun_adi,
count(DISTINCT isim) AS alan_kisi_sayisi --elmayi birden fazla alan bir kisiyi 1 kez saydik
FROM manav m 
GROUP BY urun_adi; 


--Senaryo 5: Isme göre, alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz
SELECT isim, sum(urun_miktar) AS top_urun_miktar,
count(DISTINCT urun_adi) AS urun_cesit_sayisi  
FROM manav m 
GROUP BY isim;


---------------HAVING clause:
--*** GROUP BY komutundan sonra filtreleme için AGGREGATION fonk ile birlikte kullanılır
--gruplamadan sonra yapmak istedigimiz filtreleme islemi birden fazla sonuc dondururse gruplama anlamsiz kalir
--bu yuzden GROUP BY dan sonra gruplari da filtrelemek gerekirse Aggrigate fonk kullanilarak HAVING ile filtreleme yapilir 

---------------TABLE personel:
DROP TABLE IF EXISTS personel;

CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;

--Senario 1: Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.
SELECT sirket,
min(maas) AS min_maas 
FROM personel 
GROUP BY sirket 
HAVING min(maas)>4000; 


--Senaryo 2: Maaşı 4000 den fazla olan çalışanlarin sirketlerini bulduktan sonra, 
-- bu sinirin ustunde olan MIN maas bilgisini her sirket icin görüntüleyiniz.

SELECT sirket,
min(maas) AS min_maas 
FROM personel 
WHERE maas >4000
GROUP BY sirket; 


--Senario 3: Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız
SELECT sehir,COUNT(id) personel_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(id)>1;


------------------ UPDATE - SET -WHERE:

CREATE TABLE calisanlar4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO calisanlar4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM calisanlar4;

-- SORU:
-- Senaryo 1: calisanlar4 adli bir tablo olusturunuz. id’si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/

UPDATE calisanlar4  
SET isyeri = 'Trendyol'
WHERE id = 123456789;

-- Senaryo 2: id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/

UPDATE calisanlar4  
SET isim = 'Veli Yıldırım', sehir ='Bursa'
WHERE id = 567890123

SELECT * FROM markalar m ;

--Senaryo 3: markalar tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.*/

UPDATE  markalar 
SET marka_id = marka_id *2
WHERE marka_id >= 102;

--Senaryo 4: markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/

UPDATE markalar 
SET calisan_sayisi = calisan_sayisi +marka_id 
--> WHERE E İHTİYAÇ YOK, ÇÜnk TÜM CALIŞAN SAYISI DEĞİsECEK  



















































