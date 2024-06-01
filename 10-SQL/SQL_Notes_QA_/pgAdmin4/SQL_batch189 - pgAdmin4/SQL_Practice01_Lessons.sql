-----------------------------------------PRACTICE LESSON Day1----------------------------------------------------------------------------

CREATE TABLE ogrenciler (
	id integer primary key,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer
);

-- veya

CREATE TABLE ogrenciler (
	id integer ,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

-- 2 PK olursa :
CREATE TABLE ogrenciler (
	id integer ,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer,
	CONSTRAINT composite_pk PRIMARY KEY(id,isim)
);

/*
	Neden Composite PK ya ihtiyacim var ???
	
Universite ogrenci numarasi	
2023064120 gibi composite PK dusunelim 
2023 --> ogrencinin kayit oldugu yil
064 --> bolum kodu
120 --> kayit Sirasi

*/


-- Sinav notunun 0-100 arasi olma kontrolu :

CREATE TABLE ogrenciler (
	id integer primary key,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer CHECK(sinav_notu>0 AND sinav_notu<100)
);

-- Tabloma veri ekleme 
INSERT INTO ogrenciler values(1,'Betul Kuyucu','Istanbul',80);

INSERT INTO ogrenciler (id,isim,adres,sinav_notu) values 
		(2,'Zeki Bey','Izmir', 90),
		(3,'Cemal Dogan','Trabzon',65),
		(4,'Mirac','Bursa',45),
		(5,'Yavuz Bal','Antalya',55);
		
INSERT INTO ogrenciler (id,isim,sinav_notu) values
		(6,'Bilal Degirmen',95),
		(7,'Fahri Ersoz',92);
		
SELECT * FROM ogrenciler;

-- SORU1: ogrenciler tablosundaki id ve isim bilgileri ile tum recordlari getirelim :

SELECT id,isim FROM ogrenciler

-- SORU2: Sinav notu 80'den buyuk olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu>80;

-- SORU3: Adresi Ankara olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE adres='Ankara';

-- SORU4: Sinav notu 80 ve adresi Istanbul olan ogrenci ismini listele
SELECT isim FROM ogrenciler WHERE adres='Istanbul' AND sinav_notu=80;

-- SORU5: Sinav notu 55 veya 100 olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu=55 OR sinav_notu=100;
SELECT * FROM ogrenciler WHERE sinav_notu in (55,100);

--SORU6: Sinav notu 65 ve 85 arasinda olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu BETWEEN 65 AND 85;

-- SORU7: id'si 3 ve 5 arasinda olmayan ogrencilerin isim ve sinav notu listele
SELECT isim,sinav_notu FROM ogrenciler WHERE id<3 AND id>5;
SELECT isim,sinav_notu FROM ogrenciler WHERE ID NOT BETWEEN 3 AND 5;

-- SORU8: Sinav notu en yuksek olan puan? 
SELECT max(sinav_notu) FROM ogrenciler; 

-- SORU9: İzmir'de yaşayan ve sınav notu 50'den yuksek olan öğrencilerin listesi:
SELECT * FROM ogrenciler WHERE adres='izmir' AND sinav_notu>50; 

-- SORU10: Ogrenci sayisi ve ortalama sinav ntou:
SELECT COUNT(id),ROUND(AVG(sinav_notu),2) FROM ogrenciler; --*********** virgulden sonra 2 hane olsun dedik

-- SORU11: sinav_notu 55 olan satiri siliniz
DELETE FROM ogrenciler WHERE sinav_notu= 55;

-- SORU12: ismi Derya Soylu veya 'Yavuz Bal' olan satirlari siliniz
DELETE FROM ogrenciler WHERE isim='Derya Soylu' OR isim='Yavuz Bal';
DELETE FROM ogrenciler WHERE isim IN('Derya Soylu','Yavuz Bal');

--Soru13: ogrenciler tablosunun icerigini siliniz
DELETE FROM ogrenciler; --WHERE condition ile secim yapilabilir bundan dolayi yavas ve SOFT DELETE yapar geri getirilebilir
TRUNCATE TABLE ogrenciler; -- no condition!! KALICI SILME yapar kurtarilmaz

--Soru13: ogrenciler tablosunu tamamen siliniz
DROP TABLE ogrenciler;


--------------------------------------------PRACTICE LESSON Day'2------------------------------------------------------------------------------

/******************* ON-DELETE-CASCADE  **********************

CHILD TABLODA "ON DELETE CASCADE" KOMUTU YAZILMAZSA;

1-) Child tablo silinmeden Parent tablo silinmeye calisildiginda 
    PgAdmin Eror verir. Yani Child tablo silinmeden Parent tablo silinemez
		
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye calisildiginda
	Pg Admin Eror verir. yani Child tablodaki veri silinmeden Parent tablodaki veri silinemez


CHILD TABLODA ON DELETE CASCADE KOMUTU YAZILIRSA;

1-) Child tablo silinmeden Parent tablo silinebilir.
    PgAdmin Eror vermez-Tablonun kendisi DROP edilecekse bu islem ikinci kez onaylanmali
	
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye calisildiginda PgAdmin Eror vermez
	Parent tablodaki veriyi siler.	Fakat bu durumda Child tablodaki veri de silinir.
*******************************************************************************************/

------------------------TABLE parent2---------------------------------parent
CREATE TABLE parent2
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO parent2 VALUES (101, 'Sony', 'Kim Lee');
INSERT INTO parent2 VALUES (102, 'Asus', 'George Clooney');
INSERT INTO parent2 VALUES (103, 'Monster', 'Johnny Deep');
INSERT INTO parent2 VALUES (104, 'Apple', 'Mick Jackson') ;

-----------------------TABLE child2-------------------------------------child
CREATE TABLE child2
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY (ted_vergino) REFERENCES parent2(vergi_no) ON DELETE CASCADE   
);
INSERT INTO child2 VALUES(101, 1001,'PC', 'Habip Sanli');
INSERT INTO child2 VALUES(102, 1002,'Kamera', 'Zehra 0z');
INSERT INTO child2 VALUES(102, 1003,'Saat', 'Mesut Kaya');
INSERT INTO child2 VALUES(102, 1004,'PC', 'Vehbi Koc');
INSERT INTO child2 VALUES(103, 1005,'Kamera', 'Cemal Sala');
INSERT INTO child2 VALUES(104, 1006,'Saat', 'Behlil Dana');
INSERT INTO child2 VALUES(104, 1007,'Kamera', 'Eymen Ozden');

SELECT*FROM parent2;
SELECT*FROM child2;


-- SORU-1: parent2 tablosundaki tum verileri siliniz
DELETE FROM parent2;

-- SORU-2 : Parent2 tablosunu silinz
DROP TABLE parent2;
DROP TABLE parent2 CASCADE;

--SORU-3: child2 tablosunu siliniz
DROP TABLE child2;


-----------------------TABLE toptancilar---------------------parent
CREATE TABLE toptancilar
(
vergi_no int PRIMARY KEY,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);
INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen'); 
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203,'Erikson', 'Mehmet Gör'); 
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');


--------------------TABLE malzemeler--------------------------child
CREATE TABLE malzemeler 
(
ted_vergino int,
malzeme_id int,
malzeme_isim VARCHAR(20),
musteri_isim VARCHAR(25),
CONSTRAINT FK FOREIGN KEY (ted_vergino) REFERENCES toptancilar (vergi_no) on delete cascade
);
INSERT INTO malzemeler VALUES (201, 1001, 'Laptop', 'Asli Can'); 
INSERT INTO malzemeler VALUES (202, 1002, 'Telefon', 'Fatih Ak'); 
INSERT INTO malzemeler VALUES (202, 1003, 'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES (202, 1004, 'Laptop', 'Veli Tan');

SELECT*FROM toptancilar;
SELECT*FROM malzemeler;


--SORU-4: Malzemeler tablosundaki musteri_isim'i Asli Can olan kaydin malzeme_isim'ini, 
--toptancılar tablosunda irtibat_ismi 'Adem Coş' olan kaydin sirket_ismi ile güncelleyiniz.
UPDATE malzemeler
SET malzeme_isim = (SELECT sirket_ismi FROM toptancilar WHERE irtibat_ismi='Adem Coş')
WHERE musteri_isim = 'Asli Can';

--SORU-5: malzeme_ismi Laptop olan kaydin musteri_isim 'ini, 
	--sirket_ismi Apple' olan toptancinin irtibat_isim 'i ile güncelleyiniz.
UPDATE malzemeler
SET musteri_isim= (SELECT irtibat_ismi FROM toptancilar WHERE sirket_ismi='Apple')
WHERE malzeme_isim='Laptop';


-----------------TABLE arac----------------------------
create table arac ( 
id int,
marka varchar (30),
model varchar(30), 
fiyat int,
kilometre int, 
vites varchar(20)
);
insert into arac values (100, 'Citroen', 'C3', 500000, 5000, 'Otomatik' );
insert into arac values (101, 'Mercedes', 'C180', 900000, 10000, 'Otomatik' );
insert into arac values (102, 'Honda', 'Civic', 400000, 15000, 'Manuel' );
insert into arac values (103, 'Wolkswagen', 'Golf', 350000, 20000, 'Manuel' );  
insert into arac values (104, 'Ford', 'Mustang', 750000, 5000, 'Otomatik' );
insert into arac values (105, 'Porsche', 'Panamera', 850000, 5000, 'Otomatik' );
insert into arac values (106, 'Bugatti', 'Veyron', 950008, 5000, 'Otomatik' );

SELECT * FROM arac;

--SORU-6: arac tablosundaki en yüksek fiyat'ı listele	
SELECT max(fiyat) FROM arac;	

--Soru-7: arac tablosundaki araçların toplam fiyatını bulunuz
SELECT SUM(fiyat) AS toplam_fiyat FROM arac;

--Soru-8: arac tablosundaki fiyat ortalamalarını bulunuz
SELECT AVG(fiyat) FROM arac;
SELECT Round(avg(fiyat),2) as Ortalama_Fiyat from arac;

--Soru-9:arac tablosunda kaç tane araç olduğunu bulunuz
SELECT count(id) from arac;	
SELECT count(*) from arac;

------------------------TABLE meslekler-------------------------------------
CREATE TABLE meslekler
(
id int PRIMARY KEY, 
isim VARCHAR(50), 
soyisin VARCHAR(50), 
meslek CHAR(9), 
maas int
);
INSERT INTO meslekler VALUES (1, 'Ali', 'Can', 'Doktor', '20000' ); 
INSERT INTO meslekler VALUES (2, 'Veli', 'Cem', 'Mühendis', '18000'); 
INSERT INTO meslekler VALUES (3, 'Mine', 'Bulut', 'Avukat', '17008'); 
INSERT INTO meslekler VALUES (4, 'Mahmut', 'Bulut', 'Ögretmen', '15000'); 
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13008'); 
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000'); 
INSERT INTO meslekler VALUES (7, 'Ali', 'Can', 'Marangoz', '10000' ); 
INSERT INTO meslekler VALUES (8, 'Veli', 'Cem', 'Tekniker', '14000');

SELECT*FROM meslekler;

-- SORU-10: meslekler tablosunu isme gore siralayiniz
SELECT*
FROM meslekler
ORDER BY isim;

--Soru-11: meslekler tablosunda maaşı büyükten küçüğe doğru sıralayınız
SELECT*
FROM meslekler
ORDER BY maas DESC;

--Soru-12: meslekler tablosunda ismi Ali olanların maaşı büyükten küçüğe doğru sıralayınız
SELECT maas
FROM meslekler
WHERE isim='Ali'
ORDER BY maas DESC;

--Soru-13: meslekler tablosunda id değeri 5 ten büyük olan ilk iki veriyi listeleyiniz
SELECT *
FROM meslekler
WHERE id>5
LIMIT 2;

--Soru-14: meslekler tablosunda maaşı en yüksek 3 kişinin bilgilerini getiriniz
SELECT *
FROM meslekler
ORDER BY maas DESC
LIMIT 3;



---------------------------------------------------------JOINs---------------------------------------------------------
create table filmler (
film_id int,
film_name varchar(30), 
category varchar(30) 
);
insert into filmler values (1, 'Eyvah Eyvah', 'Komedi');
insert into filmler values (2, 'Kurtlar Vadisi', 'Aksiyon');
insert into filmler values (3, 'Eltilerin Savasi', 'Komedi');
insert into filmler values (4, 'Aile Arasinda', 'Komedi');
insert into filmler values (5, 'GORA', 'Bilim Kurgu'); 
insert into filmler values (6, 'Organize Isler', 'Komedi');
insert into filmler values (7, 'Babam ve Oglum', 'Dram');


create table aktorler (
id int,
actor_name varchar(30),
film_id int
);

insert into aktorler values (1, 'Ata Demirer', 1); 
insert into aktorler values (2, 'Necati Sasmaz', 2);
insert into aktorler values (3, 'Gupse Ozay', 3);
insert into aktorler values (4, 'Engin Gunaydin', 4);
insert into aktorler values (5, 'Cem Yilmaz', 5);

--Soru-15 Tüm film_name leri, kategorilerini ve filmlerde oynayan aktor_name leri listeleyin
SELECT * FROM filmler as A LEFT JOIN aktorler as B ON A.film_id=B.film_id; 
SELECT * FROM aktorler as B RIGHT JOIN filmler as A ON A.film_id=B.film_id;

--Soru-16 (ODEV): tüm actor_name leri ve oynadigi film name leri listeleyiniz









































