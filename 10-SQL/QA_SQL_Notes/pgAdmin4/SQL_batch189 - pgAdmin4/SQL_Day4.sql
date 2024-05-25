--------------DAY'4-------------------

---TABLO1-Workers Tablosu----------------
CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');


------- TABLO2-Markalar Tablosu-----------------------
CREATE TABLE markalar(
marka_id int,
marka_isim VARCHAR(20), ---calisanlar3 isyeri ile ayni sutun
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

-------TABLO3- calisanlar3 TAblosu-------------------
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
---------------------------------TABLOLAR------------------------------------------------------------


--23-ALIASES; Gecici isimlendirme yapmak: ---------------------------------------------------------------------------------------

--ORNEK:
--1 //normal yazdirma;
SELECT* FROM workers;

--2 //tablolar gecici olarak isimlendirme: "..AS name..FROM tableName"
SELECT calisan_id AS id FROM workers; --goruntulenen raporda calisan_id sutunu "id" olarak gecici isimlendirildi

--3//birden fazla sutuna gecici isim verme;
SELECT calisan_id AS id, calisan_isim AS isim FROM workers;

--4// tablodaki iki deger birlestirmek icin || sembolu kullanilir
SELECT calisan_id ||' - '|| calisan_isim AS id_isim FROM workers; 
--iki sutun birlestirildigi icin sutun adina gecici ortak bir isim atadik==>
--calisan_id + calisan_isim ==>  AS "id_isim"
--araya '- ' isareti ekledik ==> ||' - '|| ->esittir ==> + '-' +  

SELECT * FROM workers AS calisanlar;--w

--24-SUBQUERY--NESTED QUERY-----------------------------------------------------------------------------------------------
--24-a-SUBQUERY: WHERE ile kullanımı

--ORNEKLER:
--SORU: marka_id'si 100 olan markada çalışanları listeleyiniz.
SELECT marka_isim FROM markalar WHERE marka_id=100;	--Vakko --parent tablodan bulundu --unique deger
SELECT*FROM calisanlar3 WHERE isyeri='Vakko';		--child tablodan vakkoda calisanlar geitirldi-tekrarli deger

--2.yol; ikisini bir arada yapma islemi: SubQueries; ==> "CORALETED/bagimli SUBQUERIES" denir ayrica
--iki islemi bir adimda yapma : teknik kullanim budur. 1.yol kullanilmaz
--1:OutQuery	2:SubQuery     	kismlari
SELECT*
FROM calisanlar3
WHERE isyeri=(SELECT marka_isim 
			  FROM markalar 
			  WHERE marka_id=100)

--SORU: INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX(maas) FROM calisanlar3);



--ÖDEV
--SORU: Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.
---------------------------------------------------------------------------------------------------------------------
--CEVAP;
SELECT MAX(maas)
FROM calismalar3
WHERE maas < (SELECT MAX(maas)
			  FROM calisanlar3);
			  
----------------------------------------------------------------------------------------------------------------------
--ikinci en yüksek maaşı alan kisinin tum bilgileri;

SELECT *
FROM calisanlar3
WHERE maas= (SELECT MAX(maas)
			FROM calismalar3
			WHERE maas < (SELECT MAX(maas)
						FROM calisanlar3);

---------------------------------------------------------------------------------------------------------------------


--SORU: calisanlar3 tablosunda max VEYA min maaşı alan çalışanların tüm fieldlarını gösteriniz.
--1.yol:
SELECT*
FROM calisanlar3 
WHERE maas=(SELECT min(maas) 
			FROM calisanlar3) OR maas=(SELECT max(maas) 
									   FROM calisanlar3);
--2.yol;
SELECT *
FROM calisanlar3
WHERE maas IN ((SELECT MAX(maas) 
				FROM calisanlar3),(SELECT MIN(maas) 
								   FROM calisanlar3));



--SORU; 
--Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN('Pierre Cardin','Adidas', 'Vakko');

--subQuery ile dinamik cozum:
SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN(SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara');


--SORU;
--marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT marka_isim, maas, sehir
FROM calisanlar3
WHERE isyeri (SELECT marka_isim FROM markalar WHERE marka_id>101);


--SORU;
-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.
SELECT marka_isim, maas,isyeri
FROM calisanlar3
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);



--24-b-SUBQUERY: SELECT komutundan sonra kullanımı----------------------------------------------------------------------------
--ORNEKLER:

-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT (sehir)) 
							FROM calisanlar3 
							WHERE isyeri=marka_isim) AS sehir_sayisi
							FROM markalar;

--NOTE: DISTINCT tekrarli degerleri teke indirir
SELECT DISTINCT(sehir) FROM calisanlar3;-- tekrarli sehirleri 1 ke sayar

--VIEW----------------------
CREATE VIEW sehir_sayisi AS
SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT(sehir)) 
							FROM calisanlar3 
							WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir Sorgu yaziniz.
--her bir marka icin tek bir max ve min deger yazdiriacak==> aggragete
SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas,
								  (SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS min_maas								  
FROM markalar; 






---------------------------------YENI TABLOLAR--------------------------------------------------------------------
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


--25-EXISTS Condition-----------------------------------------------------------------------------------------------

--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur-true dondurur
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır -false dondurur

--ORNEKLER:
--Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--EXISTS
SELECT *
FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota')

--Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--EXISTS
SELECT *
FROM nisan
WHERE EXISTS (SELECT urun_isim 
			  FROM mart 
			  WHERE urun_isim='Volvo')

--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 
--EXISTS 
SELECT urun_id,musteri_isim
FROM mart
WHERE EXISTS (SELECT urun_isim 
			  FROM nisan 
			  WHERE nisan.urun_isim=mart.urun_isim)

--gecici sutun isinlendirmesi icin m(mart icin) ve n(nisan icin) kullanalim
SELECT urun_id,musteri_isim
FROM mart AS m
WHERE EXISTS (SELECT urun_isim 
			  FROM nisan AS n 
			  WHERE n.urun_isim=m.urun_isim)


---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız
			
			 --EXISTS
SELECT urun_isim,musteri_isim
FROM nisan n
WHERE EXISTS (SELECT urun_isim 
			 FROM mart m 
			WHERE m.urun_isim=n.urun_isim);


--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

			 -- NOT EXISTS 
SELECT urun_isim, musteri_isim
FROM mart
WHERE NOT EXISTS (SELECT urun_isim
			 	   FROM nisan AS n 
				  WHERE n.urun_isim=m.urun_isim)  
--burada (n.urun_isim <> m.urun_isim) seklinde <> esit degildir kullanilmamali, esit olamayan fakat Exist TRUE dondurur hatali yazdirir
			 
			 										



