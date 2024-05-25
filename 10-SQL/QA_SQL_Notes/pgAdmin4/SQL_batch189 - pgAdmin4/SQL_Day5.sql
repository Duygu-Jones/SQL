------------------DAY5---------------------------------------------------------------------------------------------------------
--DBMS --> CRUD fonsiyonlarini  ve komutlarini hatirlayalim
--****************
--CREATE: INSERT
--READ: SELECT
--UPDATE: ?       --> bugun bunu gorecegiz
--DELETE: DELETE
--*****************


SELECT * FROM calisanlar3; --eski tablolari kullanalim
SELECT * FROM markalar;

--26-UPDATE :-------------------------------------------------------------------------------------------------------------
	--UPDATE tablo_adı 
   --SET sütun_adı=yenideğer
   --WHERE koşul  
   					--komutu:tablodaki koşulu sağlayan kayıtları günceller:DML


--ORNEKER;

--1) id'si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar3 			--tabloyu sec
SET isyeri='Trendyol'		--updste edilecek sutunu sec ve yeni degerini ata
WHERE id=123456789;			--sutunds hangi kayida uptade edeceksek id ile esitle. 


--2) id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.
UPDATE calisanlar3 							--tablo
SET isim='Veli Yildirim', sehir='Bursa'		--sutun
WHERE id= 567890123							--satir
											---sonuc olarak; 1 hucreyi guncelledik

-- 3) markalar tablosundaki marka_id değeri 102 ye eşit veya 
-------büyük olanların marka_id'sini 2 ile çarparak değiştirin.
UPDATE markalar
SET marka_id= marka_id*2
WHERE marka_id>=102;

--4) markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.
UPDATE markalar
SET calisan_sayisi= calisan_sayisi+marka_id

--5) calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
UPDATE calisanlar3
SET isyeri= (SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker'

--6) calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.
UPDATE calisanlar3
SET isyeri= (SELECT marka_ismi FROM markalar WHERE calisan_sayisi > 20000)
WHERE maas=1500

--7) calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
UPDATE calisanlar3
SET sehir= sehir || ' Subesi' 		--SQL de concationation sembolu ==> || idi.
WHERE isyeri= 'Vakko'				
----------------------
UPDATE calisanlar3
SET sehir= CONCAT(sehir, ' Subesi') --veya CONCAT(string) seklinde de yapilabilir
WHERE isyeri= 'Vakko'

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
SELECT*
FROM people
WHERE name IS NULL


--2) people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.
SELECT*
FROM people
WHERE adres IS NOT NULL

--3) people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..
UPDATE people
SET name = 'MISSING'
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


--28-ORDER BY: ------------------------------------------------------------------------------------------------------------
--kayıtları belirli bir fielda göre varsayılan olarak
--NATURAL(artan,ASCENDING) sıralı şekilde sıralar.


--ORNEKLER
--1 person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.
SELECT *
FROM person
ORDER BY adres ASC;--defaultta : ASCENDING(artan) kisaltimi yazilabilir==> zaten deault dur

--2 person tablosundaki tüm kayıtları soyisim göre (azalan) sıralayarak listeleyiniz.
SELECT *
FROM person
ORDER BY soyisim DESC; --DESCENDING (azalan)

--3 person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.
SELECT *
FROM person
WHERE soyisim='Bulut'	--filtrele sonra
ORDER BY isim DESC;		--sirala
--------------
SELECT *
FROM person
WHERE soyisim='Bulut'	
ORDER BY 2 DESC; --sutun numarasi (sutun indexleri 1 den baslr ) ONERILMEZ- okunur degil


--4 person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz
SELECT*
FROM person
ORDER BY isim ASC, soyisim DESC; --	isimleri artan, (ayni isimlerin soyisimlerini de azalan siralar)


--5 İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.
SELECT isim,soyisim
FROM person
ORDER BY LENGTH(soyisim) --karakter sayisina gore k--> buyuge siralar; piramit gibi gorunur bu ornekte
-----------
SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayisi 	--yeni gecici sutunda goster dedik
FROM person
ORDER BY LENGTH(soyisim) 
---------
----> aynisi; karakter_sayisi tanimlanmis oldu artik kullanilabilir
SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayisi 
FROM person
ORDER BY karakter_sayisi 


--6 Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim ||' '||soyisim AS ad_soyad, LENGTH(isim||soyisim) karakter_sayisi
FROM person
ORDER BY LENGTH(isim ||soyisim)
-------------
SELECT isim ||' '||soyisim AS ad_soyad
FROM person
ORDER BY LENGTH(isim) + LENGTH(soyisim)


--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas > (SELECT avg(maas) FROM calisanlar3)
ORDER BY maas ASC;










