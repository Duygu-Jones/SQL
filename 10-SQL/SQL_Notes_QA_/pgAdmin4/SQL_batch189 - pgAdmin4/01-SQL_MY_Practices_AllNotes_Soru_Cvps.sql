
--------------------------------------------MY PRACTICES---------------------------------------------------------------------------------


---------------------------------------------Practice DAY'3---------------------------------------------------------------------------------

--------------TABLE calisanlar---------------------------------------
CREATE TABLE calisanlar(
id char(5), 
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date,
	CONSTRAINT pk PRIMARY KEY(id)
);
INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--isim:NOT NULL yok+ ilk null olur
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim UNIQUE olmali X
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--maas:NOT NULL x
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas:integer X-> null deger 0 olur int
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--'' NULL değildir +
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--id:PK(unique) X
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--id:10002 zaten var
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--id:PK:NOT NULL
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');


--------------TABLE adresler------------------------------------
CREATE TABLE adresler( 
adres_id char(5),
	sokak varchar(30),
	cadde varchar(20),
	sehir varchar(20),
	FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--FK: duplicate kabul eder
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');
INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');--calisanlarda 10012 yok
INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT*FROM calisanlar;
SELECT*FROM adresler;

--WHERE CONDITION(koşulu)
--calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--calisanlar tablosundan maaşı 5000den fazla olanların tüm bilgilerini listeleyelim
--calisanlar tablosundan maaşı 5000den fazla olanların isim ve maaslarını listeleyelim
--adresler tablosundan sehiri 'Konya' ve adres_id si 10002 olan kaydın tüm verileri getirelim
--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.

SELECT * FROM calisanlar WHERE isim='Donatello';
SELECT * FROM calisanlar WHERE maas>5000;
SELECT isim, maas FROM calisanlar WHERE maas>5000;
SELECT*FROM adresler WHERE sehir='Konya' AND adres_id='10002';
SELECT*FROM adresler WHERE sehir='Konya' OR sehir='Bursa';



------------TABLE ogrenciler1------------------------------

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;


----------------------------------------------------------------------------------------------------------------------------------
--16-DELETE FROM .. WHERE .. komutu


--SORULAR
--16a-Tablodaki tüm kayıtları silme:DELETE FROM .. :
--koşul belitmezsek tablodaki tüm kayıtlar silinir,tablo boş durur
--id=123 olan kaydı silelim.
--ismi Kemal Tan olan kaydı silelim
--ismi Ahmet Ran veya Veli Han olan kayıtları silelim

--CEVAPLAR
DELETE FROM ogrenciler1 WHERE id=123;
DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';
DELETE FROM OGRENCILER1 WHERE isim='Ahmet Ran ' OR isim='Veli Han ';

--16b-Tablodaki tüm kayıtları silme:TRUNCATE TABLE ..:
TRUNCATE TABLE ogrenciler1;
SELECT *FROM ogrenciler1;
DROP TABLE ogrenciler1; --tamamen silindi. yok artik

--17-parent-child ilişkisi olan tablolarda silme işlemi--manuel
SELECT*FROM calisanlar; --parent
SELECT*FROM calisan_adresleri;--child

--calisanlar tablosundaki id'si 10002 olan tüm kayıtları silelim.
--once childi silmk gerek
DELETE FROM calisan_adresleri WHERE id='10002';--child
DELETE FROM calisanlar WHERE id='10002';--parent deki field.


----------TABLE talebeler------------------
CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

----------TABLE notlar------------------
CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) ON DELETE CASCADE	
);--child

INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

-------------------------------------------------------------------------------------------------------------------------------
--18-ON DELETE CASCADE:kademeli silme işlemini OTOMATIKLESTIRME


--SORULAR
--notlar tablosundan id:123 olan kaydı silelim.
--Variables silme islemleri yapalim

--CEVAPLAR
DELETE FROM notlar WHERE talebe_id=123;
DELETE FROM talebeler WHERE id=123;
DELETE FROM talebeler WHERE veli_isim='Fatma';
DELETE FROM notlar WHERE yazili_notu=99;

--2) once parent tabloyu silmeyi dene
--CEVAPLAR
DROP TABLE talebeler; X
TRUNCATE TABLE talebeler; X
DELETE FROM talebeler;

--1) child table ilk olarak tamamen veya belli fieldlar silindi
--CEVAPLAR
DELETE FROM notlar;
TRUNCATE TABLE notlar;
DROP TABLE notlar;


------------TABLE musteriler-----------------------
CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

----------------------------------------------------------------------------------------------------------------------------------
--20-IN CONDITION:liste içinde ise TRUE

--SORULAR
--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.

--CEVAPLAR
SELECT*FROM musteriler WHERE urun_isim IN('Orange','Apple','Apricot');
SELECT*FROM musteriler WHERE urun_isim NOT IN('Orange','Apple','Apricot');

----------------------------------------------------------------------------------------------------------------------------------
--21-BETWEEN .. AND .. komutu

--SORULAR
--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) dan büyük olan urunlerin tum bilgilerini listeleyiniz

--CEVAPLAR
SELECT*FROM musteriler WHERE urun_id>20 AND urun_id<40;
	SELECT *FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

SELECT*FROM musteriler WHERE urun_id<20 OR urun_id>30;
	SELECT*FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 30;


-------------TABLE calisanlar3----------------------
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


------------------ TABLE Markalar ---------------------------
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

SELECT * FROM markalar;
SELECT * FROM calisanlar3;


----------------------------------------------------------------------------------------------------------------------------------
--22-AGGREGATE Fonk.--Teke indirme

--SORULAR
--1calisanlar3 tablosunda max maaşı görüntüleyiniz
--2calisanlar3 tablosunda min maaşı görüntüleyiniz
--3calisanlar3 tablosunda toplam maaşı görüntüleyiniz
--4calisanlar3 tablosunda ortalama maaşı görüntüleyiniz
--5calisanlar3 tablosundaki kayıt sayısını görüntüleyiniz
--6calisanlar3 tablosundaki maaşı 2500 olanların sayısını görüntüleyiniz

--CEVAPLAR
SELECT MAX(maas) FROM calisanlar3;
SELECT MIN(maas) FROM calisanlar3;
SELECT SUM(maas) FROM calisanlar3;
SELECT AVG(maas) FROM calisanlar3;
SELECT COUNT(*) FROM calisanlar3;
	SELECT COUNT(id) FROM calisanlar3;
SELECT COUNT(maas) FROM calisanlar3 WHERE maas=2500;	



-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------DAY'4 PRACTICE----------------------------------------------------------------------------------------


------------ TABLE workers -------------------------
CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50));

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

--------- TABLE Markalar ---------------------------
CREATE TABLE markalar(
marka_id int,
marka_isim VARCHAR(20), ---calisanlar3 isyeri ile ayni sutun
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

---------TABLE calisanlar3 -----------------------
CREATE TABLE calisanlar3 (
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)---marka isimleri ile ayni sutun
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


SELECT * FROM workers;
SELECT * FROM calisanlar3;
SELECT * FROM markalar;
---------------------------------TABLOLAR--------------------------------------------------------------------------------

--23-ALIASES; Gecici isimlendirme yapmak: ------------------------------------------------------------
--"AS nickName"----

--ORNEK:
--1 //normal yazdirma;
SELECT * FROM workers;

--2 //tablolar gecici olarak isimlendirme: "..AS name..FROM tableName"
SELECT calisan_id AS id FROM workers; -- 2-calisan_id'sini, ID olarak workers TABLOsundan GORUNTULE

--3//birden fazla sutuna gecici isim verme;
SELECT calisan_dogdugu_sehir AS sehir, calisan_isim AS isim FROM workers;--3
--4// tablodaki iki deger birlestirmek icin || sembolu kullanilir
SELECT calisan_id || calisan_isim AS id_ve_isim FROM workers;--4
--iki sutun birlestirildigi icin sutun adina gecici ortak bir isim atadik==> "AS id_isim"
SELECT calisan_id ||' - '|| calisan_isim AS id_ve_isim FROM workers;
--araya '- ' isareti ekledik ayrica ==> ||' - '|| seklinde


--24-SUBQUERY--NESTED QUERY-----------------------------------------------------------------------------
--24-a) SUBQUERY: WHERE ile kullanımı: ------------------------------------------------------------------

--ORNEKLER:
--SORU1: marka_id si 100 olan markada çalışanları listeleyiniz.

--1.yol: acemi isi yapma; marka_id'si hem markalar hem calisanlar3 tabolsunda var
SELECT marka_isim FROM markalar WHERE marka_id=100;
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';

--2.yol; ikisini bir arada yapma islemi: SubQueries; iki islemi bir adimda yapma : teknik kullanim budur. 1.yol kullanilmaz
SELECT *
FROM calisanlar3 
WHERE isyeri=(SELECT marka_isim FROM markalar WHERE marka_id=100);


--SORU3: INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 
SELECT*
FROM calisanlar3 
WHERE maas=(SELECT MAX(maas) FROM calisanlar3);

---------------------------------------------------------------------------------------------------------------------
--ÖDEV--SORU4: Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.
SELECT MAX(maas)
FROM calisanlar3
	WHERE maas<(SELECT MAX(maas) 
				FROM calisanlar3);

--ikinci en yüksek maaşı alan kisinin BILGILERI;
SELECT*
FROM calisanlar3
WHERE maas= (SELECT MAX(maas) 
			 FROM calisanlar3 
			 WHERE maas< (SELECT MAX(maas) 
						  FROM calisanlar3));
---------------------------------------------------------------------------------------------------------------------
	

--SORU5: calisanlar3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.
--1.yol:
SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX(maas) FROM calisanlar3) 
OR
maas=(SELECT MIN(maas) FROM calisanlar3);

--2.yol;
SELECT*
FROM calisanlar3
WHERE maas IN((SELECT MAX(maas) FROM calisanlar3),(SELECT MIN(maas) FROM calisanlar3)); 


--SORU6; Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN(SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara');

--SORU7; marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim,maas,sehir
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);

--SORU8: Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.
SELECT isim,maas,isyeri
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);


--24-b-SUBQUERY: SELECT komutundan sonra kullanımı-------------------------------------------------------------------------------------
--ORNEKLER:

--NOTE: DISTINCT tekrarli degerleri teke indirir: 
--SORU1; her markanin kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT DISTINCT(sehir) FROM calisanlar3;

	-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim, (SELECT COUNT(DISTINCT(sehir))FROM calisanlar3 WHERE isyeri=marka_isim) 
  AS sehir_sayisi 
FROM markalar


--VIEW-----------------> sol barda olan Tablo'lar sekmesinin altinda VIEW olarak gorulur
CREATE VIEW sehir_sayisi AS
	SELECT marka_id,marka_isim, (SELECT COUNT(DISTINCT(sehir)) FROM calisanlar3 WHERE isyeri=marka_isim) 
	AS sehir_sayisi
	FROM markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir Sorgu yaziniz.
--her bir marka icin tek bir max ve min deger yazdiriacak==> aggragete
SELECT marka_isim,calisan_sayisi, (SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS min_maas,
								  (SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas
FROM markalar

-----------------------YENI TABLOLAR--------------------------
--TABLO 1:
CREATE TABLE mart(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');


--TABLO 2:
CREATE TABLE nisan(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;


----25-EXISTS Condition----------------------------------------------------------------------------------------------------------
--ORNEKLER:
--1-Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--2 Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--3 Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 

--gecici sutun isimlendirmesi icin m(mart icin) ve n(nisan icin) kullanalim

--4 Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
----NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

--5 Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
-----MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

--1
SELECT * 
FROM nisan 
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota');

--2
SELECT *
FROM nisan
WHERE EXISTS (SELECT urun_isim WHERE urun_isim='Volvo');

--3
SELECT urun_id,musteri_isim
FROM mart
WHERE EXISTS (SELECT urun_isim FROM nisan WHERE nisan.urun_isim=mart.urun_isim);

--4
SELECT urun_isim,musteri_isim
FROM nisan AS n
WHERE EXISTS (SELECT urun_isim FROM mart AS m WHERE n.urun_isim=m.urun_isim)

--5
SELECT urun_isim,musteri_isim
FROM mart AS m
WHERE NOT EXISTS(SELECT urun_isim FROM nisan AS n WHERE m.urun_isim=n.urun_isim)



----------------------------------------------DAY'5 PRACTICE---------------------------------------------------------------------------

--26-UPDATE :---------------------------------------------------------------------------------------------------------------------------
	--UPDATE tablo_adı 
   --SET sütun_adı=yenideğer
   --WHERE koşul  
   					--komutu:tablodaki koşulu sağlayan kayıtları günceller:DML

SELECT * FROM calisanlar3; --eski tablolari kullanalim
SELECT * FROM markalar;

--ORNEKER;

--1) id'si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar3
SET isyeri='Trendyol'
WHERE id=123456789;

--2) id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.
UPDATE calisanlar3
SET isim='Veli Yildirim', sehir='Bursa'
WHERE id=567890123;

-- 3) markalar tablosundaki marka_id değeri 102 ye eşit veya 
-------büyük olanların marka_id'sini 2 ile çarparak değiştirin.
UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102;

--4) markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.
UPDATE markalar
SET calisan_sayisi=calisan_sayisi+marka_id;

--5) calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim = 'Veli Yıldırım')
WHERE isim='Ali Seker'

--6) calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.
UPDATE calisanlar3
SET isyeri=(SELECT marka_isim FROM markalar WHERE calisan_sayisi>2000)
WHERE maas=1500;


--7) calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
UPDATE calisanlar3
SET sehir= sehir||' Subesi'
WHERE isyeri='Vakko'
-----------------
UPDATE calisanlar3
SET sehir= CONCAT(sehir,' Subesi')
WHERE isyeri='Vakko'

---------------------TABLE people --------------------------------------

CREATE TABLE people(
	ssn int,
	name varchar(50),
	adres varchar(50)
);

INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, adres) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

SELECT*FROM people;


--27-IS NULL:----------------------------------------------------------------------------------------------------------------

--ORNEKLER
--1) people tablosundaki name sütununda NULL olan değerleri listleyiniz.
SELECT *
FROM people
WHERE name IS NULL;

--2) people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.
SELECT*
FROM people
WHERE adres IS NOT NULL

--3) people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..
UPDATE people
SET name='MISSING'
WHERE name IS NULL

------------------TABLE person---------------------------------
CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir');

SELECT*FROM person;

--28-ORDER BY: --------------------------------------------------------------------------------------------------------------------
	--kayıtları belirli bir fielda göre varsayılan olarak
	--NATURAL(artan, +(ASC) ASCENDING) sıralı şekilde sıralar./ azalan icin +(DESC) DESCENDING eklenir
	--ORDER yapilmadiginda normalde ekleme sirasina gore siralar. en yeni en altta gelir
	

--ORNEKLER
--1 person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.
SELECT *
FROM person
ORDER BY adres ASC;

--2 person tablosundaki tüm kayıtları soyisim göre (azalan) sıralayarak listeleyiniz.
SELECT *
FROM person
ORDER BY soyisim DESC;

--3 person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.
SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC;

--4 person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz
SELECT *
FROM person
ORDER BY isim ASC, soyisim DESC;

--5 İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.
SELECT isim, soyisim
FROM person
ORDER BY LENGTH(soyisim);
---------
SELECT isim,soyisim, LENGTH(soyisim) AS soyad_char
FROM person
ORDER BY LENGTH(soyisim) ASC;
---------
SELECT isim,soyisim, LENGTH(soyisim) AS soyad_char
FROM person
ORDER BY soyad_char ASC;

--6 Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.
SELECT isim||' '||soyisim AS ad_soyad
FROM person
ORDER BY LENGTH(isim) + LENGTH(soyisim)
--------

SELECT isim||' '||soyisim AS ad_soyad
FROM person
ORDER BY LENGTH(isim||soyisim)
-------

SELECT CONCAT(isim,soyisim) AS ad_soyad
FROM person
ORDER BY LENGTH(isim||soyisim)
-------
SELECT CONCAT(isim,soyisim) AS ad_soyad,LENGTH(isim||soyisim) karacter_sayisi
FROM person
ORDER BY LENGTH(isim||soyisim)


--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz. 
SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas > (SELECT AVG(maas) FROM calisanlar3)
ORDER BY maas ASC;



----------------------------------------------DAY-6 PRACTICE--------------------------------------------------------------------------

-----------------------TABLE manav-------------------
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

--29--GROUP BY clause:-------------------------------------------------------------------------------------------------------------

--ORNEKLER
--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
SELECT isim, SUM(urun_miktar) toplam_urun
FROM manav
GROUP BY isim;

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
--toplam ürün miktarına göre AZALAN sıralayınız.
SELECT isim,SUM(urun_miktar) AS toplam_urun
FROM manav
GROUP BY isim
ORDER BY toplam_urun DESC;

--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.
SELECT isim,SUM(urun_miktar) AS toplam_urun
FROM manav
GROUP BY isim,urun_miktar
ORDER BY isim

--************************
--NOT:GROUP BY ile gruplama yapıldığında SELECTten sonra sadece gruplanan sütun yada bir sütunun 
--AGGREGATE fonk ile sonucu kullanılabilir.
--************************

--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.
SELECT urun_adi, COUNT(DISTINCT isim) AS musteri_sayisi
FROM manav
GROUP BY urun_adi

--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz
SELECT isim, SUM(urun_miktar) toplam_urun, COUNT(DISTINCT urun_adi) AS urun_cesit
FROM manav
GROUP BY isim

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.
SELECT urun_miktar,COUNT(DISTINCT isim) musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY musteri_sayisi ASC;

---------------TABLE personel------------------------------------------
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

--30---HAVING clause:------------------------------------------------------------------------------------------------------------------------
----*** GROUP BY komutundan sonra filtreleme için AGGREGATION fonk ile birlikte kullanılır

--ORNEKLER
--Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.
SELECT sirket, MIN(maas) AS min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas)> 4000;

--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.
SELECT sirket,Min(maas) min_maas
FROM personel
WHERE maas>4000
GROUP by sirket;

---**************
--NOT:gruplamadan sonra yapılan işlem sonucu ile ilgili bir koşul belirtmek için HAVING,
---------gruplamadan önce kayıtları filtrelemek(koşul belirtmek) için WHERE kullanılır.
---**************

--Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.
SELECT isim, SUM(maas) toplam_maas
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000;

--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız
SELECT sehir, COUNT(DISTINCT id) pers_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id)>1;


--****ODEV********
--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV
SELECT sehir,MAX(maas) max_maas
FROM personel
GROUP BY sehir
HAVING MAX(maas)<5000;

----------------------TABLE developers---------------------------------------
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
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','ummu@mail.com',4000,'C#','Bursa',29);


------------------------TABLE contact_info-----------------------------
CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');

SELECT * FROM developers;
SELECT * FROM contact_info;

--31-UNION:----------------------------------------------------------------------------------------------------------------------------
-----iki farklı sorgunun sonucunu birleştirerek tek bir sütunda görüntülemeyi sağlar
--          -tekrarlı olanları göstermez

--32-UNION ALL:-----------------------------------------------------------------------------------------------------------------------------
-----UNION gibi kullanılır, tekrarlı olanları da gösterir

--ORNEKLER

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--birlikte tekrarsız gösteren sorguyu yaziniz
SELECT name FROM developers WHERE age>25
UNION
SELECT prog_lang FROM developers WHERE age<30;


--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--birlikte tekrarlı gösteren sorguyu yaziniz
SELECT name FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age<30;

--******************
--NOT:UNION/UNION ALL birleştirdiğimiz sorgular aynı sayıda sütunu göstermeli ve
--alt alta gelecek olan sütunun data tipi aynı olmalı
--******************

--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz
SELECT salary,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age,prog_lang FROM developers WHERE prog_lang='JavaScript';

--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.
SELECT city,salary AS salary_doorNo FROM developers WHERE id=8
UNION
SELECT city,number AS salary_doorNo FROM contact_info WHERE address_id=8;

--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz
SELECT city FROM developers 
UNION
SELECT sehir FROM calisanlar3;



--32--INTERSECT:----------------------------------------------------------------------------------------------------------------------------
--iki farklı sorgunun sonuçlarından ortak olanları(kesişimi)
--tekrarsız olarak gösterir.

--ORNEKLER
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz
SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3;

--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.
SELECT city FROM developers WHERE prog_lang='Java'
INTERSECT 
SELECT sehir FROM calisanlar3 WHERE maas>1000;



--33--EXCEPT:----------------------------------------------------------------------------------------------------------------------------
--karsilastirilan iki sorgudan; bir sorgunun sonuçlarından diğer bir sorgunun sonuçlarından 
--farklı olanları gösterir.

--ORNEKLER

--developers tablosundaki şehirleri
--calisanlar3 tablosunda ortak olan sehirler hariç olarak listeleyiniz
SELECT city FROM developers 
EXCEPT
SELECT sehir FROM calisanlar3;

--calisanlar3 tablosundaki şehirleri
--developers tablosunda sehirler hariç olarak listeleyiniz
SELECT sehir FROM calisanlar3
EXCEPT
SELECT city FROM developers;

----developers tablosundaki maaşı 4000 den büyük olanların id'lerinden
--contact_info tablosunda olmayanları listeleyiniz.
SELECT id FROM developers WHERE salary>4000
EXCEPT
SELECT address_id FROM contact_info;

 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz. 
 SELECT urun_isim FROM mart 
 UNION
 SELECT urun_isim FROM nisan;
 
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 SELECT urun_isim FROM mart
 INTERSECT
 SELECT urun_isim FROM nisan;
 
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 
SELECT urun_isim FROM mart
EXCEPT
SELECT urun_isim FROM nisan;






---------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------DAY'7 PRACTICE---------------------------------------------------------------------

---------------------TABLE sirketler----------------------------
CREATE TABLE sirketler(
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

---------------------TABLE siparis----------------------------
CREATE TABLE siparis(
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');

SELECT*FROM sirketler;
SELECT*FROM siparis;

--------------------------------------JOINS--BİRLEŞTİRME--------------------------------------------------------------------------
	--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
	--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.

--33-INNER JOIN:---------------------------------------------------------------------------------
			--baz aldığımız sütundaki sadece ortak değerleri gösterir.

--ORNEKLER 
--iki tablodaki şirket id'si aynı olanların; şirket id, şirket ismi,
--sipariş tarihini, sipariş id' sini  listeleyiniz.
SELECT siparis.sirket_id,sirket_isim,siparis_tarihi,siparis_id
FROM sirketler
INNER JOIN siparis
ON siparis.sirket_id = sirketler.sirket_id

--34-LEFT JOIN:-----------------------------------------------------------------------------------
			--Sol tablodaki(ilk tablodaki) tüm verileri getirir.
--SORU1:
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.      
SELECT a.sirket_id,sirket_isim,siparis_tarihi,siparis_id
FROM sirketler AS a LEFT JOIN siparis AS b
ON a.sirket_id= b.sirket_id


--34-RIGHT JOIN:----------------------------------------------------------------------------------
  			--Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.
--SORU1:
--siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    
SELECT b.sirket_id, sirket_isim,siparis_tarihi,siparis_id
FROM sirketler As a RIGHT JOIN siparis AS b
ON a.sirket_id=b.sirket_id

--NOTE: LEFT ve RIGHT JOIN i tablo sırasını değiştirerek birbirinin yerine kullanılabilir.
		--**** bu iki sorgunun sonucu da aynidir, tablo yerlerini degistirip, left veya right kullanilarak 
		--tablonun nerede oldugunun bir onemi kalmaz--sonuc olarak iki tabloda birlestirilmis olur 
		--tek bir tabloyla islem yapilir gibi olur
SELECT b.sirket_id, sirket_isim,siparis_tarihi,siparis_id	
FROM siparis b LEFT JOIN sirketler a
ON a.sirket_id=b.sirket_id


--35-FULL JOIN:----------------------------------------------------------------------------------
			--iki tablodaki baz alınan sütundaki tüm kayıtları getirir.

--Soru1: her iki tablodaki tüm kayıtların tüm bilgilerini listeleyiniz.
SELECT b.sirket_id, sirket_isim,siparis_tarihi,siparis_id	
FROM sirketler a FULL JOIN siparis b
ON a.sirket_id=b.sirket_id

---------------------TABLA personeller-----------------------
CREATE TABLE personeller(
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;

--36-SELF JOIN : -------------------------------------------------------------------------------
			--tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 

-----sadece personlleri gosterelim
SELECT p.id p_id, p.isim p_ismi
FROM personeller AS p
-----sadece yoneticileri gosterelim
SELECT y.id y_id, y.isim y_ismi,y.yonetici_id y_id
FROM personeller AS y

--Soru1: herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.
SELECT p.id p_id, p.isim p_ismi, y.isim y_ismi,p.yonetici_id y_id
FROM personeller AS p
INNER JOIN personeller AS y
ON p.yonetici_id=y.id

-----sadece personlleri gosterelim
SELECT p.id p_id, p.isim p_ismi
FROM personeller AS p
INNER JOIN personeller AS y
ON p.yonetici_id=y.id

--37-LIKE / ILIKE  Cond.:--------------------------------------------------------------------------------------------------------
--WHERE komutu ile kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--tablo larda istedigimiz variable aratip bulabilmek icin kullanilir, aramayi daraltir

--Kullanilan SEMBOLLER: 
		--WILDCARD/joker (%) : joker dedigimiz % isareti==> 0 veya daha fazla karakteri temsil eder.
		--UnderScore     (_) :  'alt_tire' tek bir karakteri temsil eder
						
			 --Yazilisi:
				--   'A%n' == 'A....n' ==> A ile baslayip n ile biten isimleri getir
				--   'A%' ==> 'A....'  
				--   '%A' ==> ... +A 
				--   '%e%' ==> ...+ e + ... 
				--  '%e%a%' => ...+ e +... a 
				--	 veya
				--  '%a%e%' => ... + a ... + e + ...
				--  '%an%'  ==> icinde 'an' hecesini bulunduran kelimeleri getirir
				
				--  '__v_'  ==> 4 harfli bir kelimenin 3.harfi v demek
				--  '__v%'  ==> 3.harfi v olan kelimeler demek
				
	 
----------TABLE developers ----kullanalim----------
--developers tablosundan name degerlerini bastan ve sonda bulunan bosluklarini cikarip guncelleyiniz
UPDATE developers
SET name= TRIM(name)
  
SELECT * FROM developers;

--tablodan 'Enes Can' goruntuleyin
SELECT * FROM developers WHERE name='Enes Can'
-----------------------------------------------

--LIKE:-----------------------------------------------------------------------------
	--LIKE '%' isareti ile gosterilir
	-- CASE SENSITIVE dir. 

--ORN1: isim 'E' ile basliyor devaminda, 0 veya daha fazla karakter gelen kayitlari yazin
SELECT*
FROM developers
WHERE name LIKE 'E%';

--ILIKE:----------------------------------------------------------------------------
		-- CASE IN-SENSITIVE dir. Buyuk-kucuk harf gozetmez
		--wildcard(joker-%): joker dedigimiz % isareti==> 0 veya daha fazla karakteri temsil eder.  

--ORN2: buyuk/kucuk harf belirsiz ismi 'E/e' harfi ile baslayan kayitlari getir;
SELECT*
FROM developers
WHERE name ILIKE 'e%';

--ORN3: a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin
SELECT name,city
FROM developers
WHERE city ILIKE '%a';

--ORN4: Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
SELECT name,salary
FROM developers
WHERE name ILIKE 'T%n';

--ORN5: Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin -- '...an...'
SELECT name,salary
FROM developers
WHERE name ILIKE '%an%';

--ORN6: Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin  --sirasi onemsiz
		--AND ile
SELECT *
FROM developers
WHERE name ILIKE '%e%' AND name ILIKE '%a%';
		-- OR ile 
SELECT*
FROM developers
WHERE name ILIKE '%a%e%' OR name ILIKE '%e%a%';

---- NOTE: underScore: (_) 'alt_tire' tek bir karakteri temsil eder!!!!

--ORN7: Isminin ikinci harfi u olan devlerin tum bilgilerini yazdiran QUERY yazin--> '_u....' gibi
SELECT *
FROM developers 
WHERE name ILIKE '_u%';

--ORN8: Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM developers 
WHERE prog_lang ILIKE '__v_';

---******ODEV********
--1-Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--HINT:sadece JavaScript olacak
SELECT *
FROM developers 
WHERE prog_lang ILIKE 'J____%';

--2-Isminin 2. harfi e, 4. harfi m olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
SELECT *
FROM developers 
WHERE name ILIKE '_e_m%';

--3-ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV
SELECT *
FROM developers 
WHERE name ILIKE '%_%';

SELECT * FROM developers;


--38-REGEXP_LIKE(~): ---------------------------------------------------------------------------------------------------------
	--Belirli bir karakter desenini iceren datalari regex kullanarak filtreleme yapmayi saglar
	-- Kullanilan SEMBOLLER;
		
		-- (~) : Case Sensitive Regex_like icin 
		-- (~*): Case In-Sensitive Regex_like icin demektir 
				--regexP ~ sembolu sonuna * yildiz ekleriz (sorularda aksi belirtilmedigi surece boyle yapilabilir)
		
		-- []  : koseli parantez; icerisinde bulunan sadece 1 harfi temsil eder
				--[abcd] içerisindeki  harflerden sadece birini temsil eder
				-- [a-z] alfabetik olarak iki harf arasindaki - harflerden sadece birini temsil eder
		
		-- (^) : kelimenin başlangıcını gösterir, 
		-- ($) : kelimenin bitişini gösterir
		
		-- (.*): NoktaYildiz: 0 veya daha fazla karakteri temsil eder  -->istenirse () parantez icinde code yazilabilir
	    -- (.) : Nokta: sadece 1 karakteri temsil eder  		-->istenirse () parantez icinde code yazilabilir
		
		--NOT LIKE : verilen karakter desenine benzemeyenleri filtreler -->Case Senst.
		--NOT ILIKE: verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.
		--  (!~)   : verilen karakter desenine benzemeyenleri filtreler -->Case Sensit.
		--  (!~*)  : verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.

-----------------TABLE words---------------------
CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

--SORU1
--h harfinden sonra a veya i harfini sonra ise t harfini --> '?h a?i ?t'
	--içeren kelimelerin TUM bilgilerini yazdiran QUERY yaziniz.
	 -->('h' harfi digerlerine gore basta; devaminda gelecek olan harf a veya i==> biri gelecek; bunlardan sonra da t ile devam edecek)
SELECT*
FROM words
WHERE word ~ 'h[ai]t'; 

--NOTE: (~*) küçük/büyük harf hassasiyeti olmasın demek
--		[ - ] verilen araliktan sadece bir harfi temsil eder
--		[c-f] => d,e harflerinden biri OLABILIR gibi


--SORU2
--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
		---> (a'dan k'ya kadar olan harflerden birisi h'den sonra, t'den once; araya gelecek) demek
SELECT*
FROM words
WHERE word ~* 'h[a-k]t'; 

--SORU3
-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
		--> [m veya i biri olabilir] demek
		--> [m-i] ise m ile i araligindan bir harf olabilir demek
SELECT *
FROM words
WHERE word ~* '[mi]';

--- NOTE: ^ :kelimenin başlangıcını gösterir, 
--		  $ :kelimenin bitişini gösterir


--SORU4
--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin --> kelime kesin a ile basliyor
	--> a ile baslayan degerleri getir dedik
SELECT*
FROM words
WHERE word ~* '^a'; 

--SORU5
--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
	--> [kelime a veya s ile baslayn] kayitlari getirir
SELECT*
FROM words
WHERE word ~* '^[as]'; 

--SORU6
--m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
	-->m' den sonra baska bir karakter yok demek SON
SELECT*
FROM words
WHERE word ~* 'm$'; 

-- NOTE: (.*)--> 0 veya daha fazla karakteri temsil eder
--       (.) --> sadece 1 karakteri temsil eder 
  		        --> () parantez icinde de sembol yazilabilir

--SORU7
--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT*
FROM words
WHERE word ~* '^y.*f$';

--SORU8
--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT*
FROM words
WHERE word ~* '^y.f$';

--NOT LIKE : verilen karakter desenine benzemeyenleri filtreler -->Case Senst.
--NOT ILIKE: verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.
--  (!~)   : verilen karakter desenine benzemeyenleri filtreler -->Case Sensit.
--  (!~*)  : verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.


--SORU9
-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--1.yol: NOT LIKE-ILIKE ile;
SELECT*
FROM words
WHERE word NOT ILIKE 'h%'

--2.yol: NOT Regex_LIKE ile; (!~*)
SELECT*
FROM words
WHERE word !~* '^h'


--************ ÖDEV *************
--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.
SELECT*
FROM words
WHERE word !~* '.[eio]'
----veya
SELECT*
FROM words
WHERE word NOT ILIKE '_e%' and word NOT ILIKE '_i%' and word NOT ILIKE '_o%'

---------------------------HOMEWORK-5 DAY'7----------------------------------------------------------------------
/*
Örnek veritabanı olan dvd_rental veritabanını import ediniz.


1-https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
linkinden dvdrentalı zip olarak indiriniz.
2-İndirdiğiniz "dvdrental.zip" dosyasını çıkarın. Bu, "dvdrental.tar" adlı bir dosya içerecektir.
3-pgAdminde yeni bir veritabanı oluşturarak isim verin.
4-Oluşturduğunuz veritabanının isminin üzerine sağ tıklayınız,açılan menüde
  'restore' seçeneğini tıklayınız.
5-"Dosya" bölümünde, "Filename" (Dosya adı) veya "..." düğmesini tıklayarak "dvdrental.tar" dosyasını seçin. 
6-"Restore Options" (Geri Yükleme Seçenekleri) bölümünde, "Format" (Biçim) seçeneğini "tar" olarak bırakın.
7-"Restore" (Geri Yükle) düğmesine tıklayarak geri yükleme işlemini başlatın.
8-PostgreSQL yönetim aracı, "dvdrental" adında bir veritabanı oluşturacak ve içindeki tabloları ve
  verileri geri yükleyecektir. */
  -------------------------------------------
  
  
--Aşağıdaki sorguları dvd_rental veritabanında oluşturunuz.   
 
--1-Tüm filmleri film adı ve dili ile birlikte  listeleyiniz.
--hint:film ve language tablolarını kullanınız.

--2-Ödeme miktarı ve müşteri adıyla birlikte en yüksek ödeme yapan müşteriyi bulunuz.
--hint:payment ve customer tablolarını kullanınız.

--3-Tüm kategorilerin isimlerini ve kategoriye ait film sayısını birlikte  listeleyiniz.
--hint:category,film_category tablolarını kullanınız.

--4-customer_id'ye göre en çok film kiralayan müşterilerin ad-soyad ve kiraladığı film sayısını birlikte listeleyiniz.
--hint:customer,rental tablolarını kullanınız.  
  
--5-Tüm dilleri dil adı ve dildeki film sayısıyla birlikte listeleyiniz.
--hint:film ve language tablolarını kullanınız.

--6- Tüm personelleri personel adı-soyadı ve personelin yönettiği müşteri sayısıyla birlikte listeleyiniz.
--hint:staff ve customer tablolarını kullanınız.

--7- En fazla actor oynayan 10 tane filmin ismini ve filmde oynayan actor sayısını bulunuz.
--hint:film ve film_actor tablolarını kullanınız.

--8-Tüm actorlerin ad-soyadını ve oynadığı filmlerin adını birlikte  listeleyiniz.
--hint:actor, film_actor, film tablolarını kullanınız.

--9-emaili 'j' ile başlayan ve soyadı 'er' ile biten müşterileri listeleyiniz. 

--10-İsmi(title) d harfinden sonra e veya a sonrasında ise m veya n içeren ve y harfi ile biten filmlerin
--isimlerini listeleyiniz.(cevap:Victory Academy,Annie Identity)

--11-İsmi c ile başlayan kategorideki filmlerin idlerinden en küçük 5 tanesini listeleyiniz.
--hint:category, film_category tablolarını kullanınız.

--12-İsmi a ile başlayıp a ile bitmeyen şehir(city) ve bu şehirlerin bulunduğu ismi a ile başlayan
--ülkeleri birlikte listeleyiniz.(örn: Escobar-Argentina)
	--hint:city, country tablolarını kullanınız.




--------------------------------------- DAY'8- PRACTICE -----------------------------------------------------------------------------------
   
   --STRING FONKSIYONLARI:

/*
1) TRIM(Sütun parametresi) string ifadenin başındaki ve sonundaki boşluk karakterlerini siler
		LTRIM sadece soldan boşluk siler
		RTRIM sadece sağdan boşluk siler
2) REPLACE(sütun,'değişecek ifade','yeni ifade') belirtilen ifadeyi o sütunda bulursa, 
	belirlediğiniz yeni ifade ile değiştirir
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
*/---------------------------------------------------------------------------------------------------------------------------------

---TABLE developers Kullanalim-------
SELECT * FROM developers;

--39-String Fonksiyonlar------------------------------------------------------------------------------------------------

--1) Developers tablosunda name degerlerinin karakter sayisini gosteriniz

--2) developers tablosunda name değerlerindeki başlangıç ve sondaki boşlukları kaldırınız.

--3) developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.



-- UPPER-LOWER-INITCAP Fonks:-------------------------------------------------------------------------------------------

--1) developers tablosundaki tüm kayıtların 
	--name değerlerini kucuk harfe 
	--prog_lang değerlerini buyuk harfe
	--email degerlerini ilk harfi buyuk olacak sekilde çevirerek görüntüleyiniz.

--2) calisanlar3 tablosunda isyeri='Vakko' olan kayıtlarda (_Şubesi) ifadesini siliniz. 

--3) words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.

--4) words tablosunda tüm kelimeleri ve tüm kelimelerin(word) 2.indexten itibaren kalanini görüntüleyiniz.

--5) words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.



----40-FETCH NEXT (sayi) ROW ONLY - OFFSET-----------------------------------------------------------------------------------
-- FETCH NEXT n ROW ONLY  : sadece sıradaki ilk n satırı getirir
--                LIMIT n : sadece sır adaki ilk n satırı getirir-terminate fonk.dur
--                OFFSET n: n satırı atlayıp sonrakileri getirir
					--fetch next = Limit ayni fonks. 

--1) developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.
 
--2) developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

--3) developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.

--4) developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.


--41-ALTER TABLE:tabloyu güncellemek için kullanılır:DDL--------------------------------------------------------------------
		/*
		add column ==> yeni sutun ekler
		drop column ==> mevcut olan sutunu siler
		rename column.. to.. ==> sutunun ismini degistirir      
		rename.. to.. ==> tablonun ismini degistirir*/

--1) calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.

--2) calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
	--varsayılan olarak remote değeri TRUE olsun

--3) calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

--4) calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.

--5) calisanlar3 tablosunun ismini employees olarak güncelleyiniz.

--employees tablosunda id sütunun data tipini varchar olarak güncelleyiniz.

--6) employees tablosunda id sütunun data tipini INT olarak güncelleyiniz.

--7) employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

--NOTE: içinde kayıtlar bulunan bir tabloyu güncellerken bir sütuna 
	--> NOT NULL,PK,FK,UNIQUE vs constraintleri ekleyebilmek için önce
	--bu sütunların değerleri ilgili const. sartlari sağlıyor olmalı. sagalmiyorsa;
	--> Cozum: Constraintler icinde mesela PK yapilacak ise bir Sutun; once UNIQUE ve NOT NULL yapilir ardindan PK eklenir
	--> CONSTRAINT'lerde -->ADD fonk ile ekleme yapilir -DROP ile silinir
			-- ALTER TABLE name
			-- ADD/DROP  CONST_NAME(SutunName);

	--> NOT NULL bir Constraint degildir -SET ile eklenir -DROP ile silinir==>ALTER COLUMN name DROP NOT NULL
	-- eger isim sutununda NULL bir kayir var ise sonradan bu sutuna NOT NULL direk eklenemez
	-- cozum; ilk once bu kayittaki NULL degerler bulunup silinir veya deger atanir, sonra tum sutunu NOT NULL yapabiliriz
			-- ALTER TABLE name
			-- ALTER COLUMN SutunName SET/DROP  NOT NULL;

--8) sirketler tablosunda sirket_id sütununa PRIMARY KEY constrainti ekleyiniz.

--8) sirketler tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.

--9) siparis tablosunda sirket_id sütununa FK constrainti ekleyiniz. 
	-->Siparsi ve Sirketler taplolari sirket_id ortak sutunu sayesinde iliskili idi

--10) siparis tablosundaki FK constrainti kaldırınız.

--11) employees tablosunda isim sütununda NOT NULL constraintini kaldırınız.



--42-TRANSACTION   : databasede en küçük işlem birimi --------------------------------------------------------------------
--       BEGIN     : transactionı başlatır
--       COMMIT    : transactionı onaylar ve sonlandırır
--       SAVEPOINT : kayıt noktası oluşturur
--       ROLLBACK  : değişikleri mevcut duruma geri döndürür,transactionı sonlandırır
--Transaction yonetimini biz kontrol edebilmemiz icin BEGIN-COMMIT-SAVEPOINT-ROLLBACK kullanilir

-----------------TABLE hesaplar-------------------------
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM hesaplar;
----------------------------------------------------------

--ORNEK1:
--Bir bank hesabindan digerine 1000tl gonderilecegi bir senaryo icin;
--Gonderici hesaptan -1000tl eksilir, alici hesapta +1000tl artar
--Senaryoya gore transaction yapan kodu yaziniz
 























