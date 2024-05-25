
-------ÖDEVLER
-------------------------HOMEWORK-DAY-1--------------------------------------------------------------------------------------------
/*
1) Tablo Oluşturma

“tedarikciler” isminde bir tablo olusturun,
“tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres”
ve “ulasim_tarihi”	field’lari olsun. 

2) Var olan tablodan yeni tablo olusturmak 
 “tedarikci_info” isminde bir tabloyu  “tedarikciler” tablosundan olusturun.
Icinde “tedarikci_ismi”, “ulasim_tarihi” field’lari olsun

3) Data ekleme
“ ogretmenler” isminde tablo olusturun.
 Icinde “kimlik_no”, “isim”, “brans” ve “cinsiyet” field’lari olsun.
“ogretmenler” tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.

4) bazı fieldları olan kayıt ekleme
“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Veli Guler
-------------------------------------------------------------------*/

--1) tablo olusturma
create table tedarikciler(
	tedarikci_id char(4),
	tedarikci_isim varchar(20) primary key,
	tedarikci_adres varchar(50),
	ulasim_tarihi varchar(10)
	);
select*from tedarikciler;

--2) var olan tablodan yeni bir tablo olusturmak
CREATE TABLE tedarikci_info AS SELECT tedarikci_isim, ulasim_tarihi FROM tedarikciler;
select*from tedarikci_info;

--3)Data ekleme
create table ogretmenler(
	kimlik_no char(11),
	isim varchar(20),
	brans varchar(50),
	cinsiyet varchar(10)
);
insert into ogretmenler(kimlik_no,isim,brans,cinsiyet) values(234431223,'Ayse Guler','Matematik','Kadin');
insert into ogretmenler(kimlik_no,isim,brans,cinsiyet) values(234431224,'Ali Guler','Fizik','Erkek');
insert into ogretmenler(kimlik_no,isim) values(234431225,'Veli Guler');
select*from ogretmenler;





---------------------------HOMEWORK-2 DAY-2--------------------------------------------------------------------------
/*	 						Queries-1

1-sqlpractice_db isminde database oluşturunuz.
2-sqlpractice_db database içinde musteri isminde tablo oluşturunuz.
      musteri_no(integer)
      isim (string,50 karakter)
      yas (int)
      cinsiyet (string 1:K/E)
      gelir(real)
      meslek(string,20 karakter)
      sehir (string,20 karakter)

constraintler:
musteri_no:primary key, otomatik olarak artırılsın
isim:not null ve not empty,yas:18 den büyük */

create table musteri(
musteri_no serial primary key, --SERIAL==> is a data type here, its numerik and 
isim varchar(50) not null,		--it's used to define an auto-incrementing integer column
yas int,
cinsiyet char(1),
gelir real,
meslek varchar(20),
sehir varchar(20),
CHECK (isim <> '')		--how to ensure that a column has a value other than an empty string.
);


--3-musteri tablosuna kayıt ekleyiniz-----------------------------------------------------------------------------
--isim:ALİ, yas:35,cinsiyet:E,gelir:2500,meslek:MÜHENDİS,sehir:İSTANBUL

INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('ALI',35,'E',2500,'MUHENDIS','ISTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('BURAK',   25, 'E', 3500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('DEMET',   30, 'K', 3000, 'ÖĞRETMEN',    'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('FERHAT',  40, 'E', 2500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('GALİP',   55, 'E', 4000, 'ÖĞRETMEN',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('KÖKSAL',  25, 'E', 2000, 'AVUKAT',      'İZMİR');

--4-musteri tablosunda Tüm kayıtları listeleyiniz.
SELECT*FROM musteri;

--5-Tüm kayıtlardan isim ve meslek bilgilerini görüntüleyiniz
SELECT isim,meslek FROM musteri;

--6-sqlpractice_db databaseinde ;
/*“sehirler” isimli bir Table olusturun. 
Tabloda “alan_kodu”, “isim”, “nufus”  field’lari olsun.
Isim field’i null değer alamasın.
“alan_kodu” field’ini “Primary Key” yapin.*/

CREATE TABLE sehirler(
alan_kodu int,
isim varchar NOT NULL,
nufus int,
CONSTRAINT alan_kodu_PK_yapildi PRIMARY KEY(alan_kodu) 
);


--7a- “tedarikciler3” isimli bir tablo olusturun.
/*Tabloda “tedarikci_id”, “tedarikci_ismi”,  “iletisim_isim” field’lari olsun
“iletisim_isim”  fieldı tekrarsız olsun.
“tedarikci_id” yi Primary Key yapin.
*/
create table tedarikciler3(
tedarikci_id int,
tedarikci_ismi varchar(50),
iletisim_isim varchar(50) UNIQUE,
constraint td_id_PK_yap PRIMARY KEY(tedarikci_id)
);
select*from tedarikciler3;

--7b- “urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun
-------“tedarikci_id” yi Foreign Key yapin.
create table urunler(
tedarikci_id int,
urun_id int,
FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) on delete cascade
);
select*from urunler;

----------------------------------HOMEWORK-DAY-3 YOK--------------------------------------------------------------------
----yok-----

----------------------------------HOMEWORK-3 DAY-4--------------------------------------------------------------------
					---Queries-2 --SELECT-WHERE-DELETE
					
--1-musteri tablosundaki tüm kayıtları listeleyiniz.

--2-Mesleği AVUKAT olanların sadece şehirlerini listeleyiniz.

--3-Kadın müşterilerin tüm bilgilerini listeleyiniz.

--4-Kadın müşterilerin sadece şehir bilgilerini listeleyiniz.

--5-Yaşı 40-50 arasında olan müşterileri listeleyiniz.

--6-Erkek müşterilerin mesleklerini listeleyiniz.

--7-Yaşı 40-50 arasında OLMAYAN müşterileri listeleyiniz.

--8-Yaşı 30-40 arasında olan KADIN müşterilerden ÖĞRETMENLERİ listeleyiniz.

--9-Yaşı 30-40 arasında OLMAYAN ERKEK müşterilerden AVUKAT OLMAYANLARI listeleyiniz.

--10-Geliri 3000-5000 arasında olan müşterileri listeleyiniz.

--musteri tablosundan;
--11-ismi ALİ olan kayıtları siliniz.

--12-yaşı 60 olan kayıtları siliniz.

--13-mesleği 'KUAFÖR' ve cinsiyeti 'K' olan kullanıcıyı siliniz.

--14-geliri 6000 olan veya mesleği 'TESİSATÇI' olan kayıtları siliniz. 

--15-musteri tablosundaki tüm kayıtları siliniz.

--16-tedarikciler3 tablosunu SCHEMADAN kaldırınız.
--
--17-urunler tablosunu SCHEMADAN kaldırınız. 


-----------------------------------HOMEWORK-4 DAY-5--------------------------------------------------------------------
				---Queries-3  --SUBQUERY, UPDATE, IS NULL, ORDER BY

--sqlpractice_db de ==> teachers, courses 
--tablolarını oluşturup, kayıtları ekleyiniz.

CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,    
city varchar(20),
course_name varchar(20),
salary real    
);
CREATE TABLE courses(
course_id int,
course_name varchar(20) UNIQUE,
credit int,
course_fee numeric(5,2),
start_date date,
finish_date date    
);

INSERT INTO teachers VALUES(111,'Ahmet','Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,'Bilal','Fan',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal','San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz','Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'Ekrem','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'Mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'Fatih','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);


INSERT INTO courses VALUES(3001,'SpringMVC',10,100.05,'2023-01-10','2023-02-10');
INSERT INTO courses VALUES(3002,'SpringBOOT',8,120.25,'2023-02-11','2023-02-28');
INSERT INTO courses VALUES(3003,'S.Security',6,200.15,'2023-03-03','2023-03-12');
INSERT INTO courses VALUES(3004,'Java',26,159.99,'2022-11-03','2023-01-12');
INSERT INTO courses VALUES(3005,'SQL',6,175.55,'2023-01-03','2023-03-12');
INSERT INTO courses VALUES(3006,'React',12,255.85,'2023-06-03','2023-07-12');
INSERT INTO courses VALUES(3007,'HTML',6,125.99,'2023-03-03','2023-03-22');
INSERT INTO courses VALUES(3008,'CSS',5,125.99,'2023-04-03','2023-04-22');
INSERT INTO courses VALUES(3009,'JavaScript',10,199.99,'2023-05-03','2023-05-31');

SELECT*FROM teachers;
SELECT*FROM courses;
--------------------------TABLOLAR---------------------------------

1--35 yaşından küçük öğretmenlerin verdikleri derslerin isimlerini ve kredi sayılarını listeleyiniz.


2--Her bir şehirde verilen derslerin isimlerini ve kredisini listeleyiniz. 

3--İstanbulda yaşayan öğretmenlerin verdiği derslerin isimlerini ve başlangıç tarihini listeleyiniz.

4--İstanbulda yaşayan öğretmenlerin isimlerini(firstname), verdiği derslerin isimlerini ve bitiş tarihini listeleyiniz.

5--'03-03-2023' tarihinden önce başlayan dersleri veren öğretmenlerin maaşlarının ortalamasını bulunuz.

6--2023 Şubat ve Mayıs ayları arasında başlayan dersleri veren öğretmenlerin toplam maaşını hesaplayınız.

7--Kurs ücreti 125 ten fazla olan derslerin isimlerini, kredilerini ve bu dersleri veren öğretmenlerin max ve min maaşlarını listeleyiniz

8-- Ahmet Han'ın maaşı ortalama maaştan büyük ise tüm bilgilerini listeleyiniz.

9--Yaşı 37 den büyük olan öğretmenlerin yaşını Java dersi alanların yaşlarının minimumu ile güncelleyiniz.

10--Yaşı 35 den büyük olan öğretmen varsa, bu öğretmenlerin verdiği derslerin isimlerini ve başlangıç tarihlerini listeleyiniz.

11--Hiçbir öğretmen tarafından verilmeyen dersleri isim, başlangıç ve bitiş tarihlerini listeleyiniz.

12--En az bir öğretmen tarafından verilen derslerin ücretlerini 10 artırınız.

13--Ücreti 170 den fazla olan ders varsa bu dersi veren öğretmenlerin tüm bilgilerini
--listeleyiniz.(IN kullanmayınız.)

14--Başlangıç tarihi '03-11-2022' olan kursun ismini ' Core' ekleyiniz.

15--Maaşı ortalama maaştan yüksek olan öğretmenin şehrini Antalya olarak değiştiriniz.

16--Yaşı en küçük olan dersin öğretmeninin maaşını 2 katına çıkarınız.

17--En erken başlayan kursun kredisini 2 artırınız.




------------------------------HOMEWORK-5? DAY-6-----------------------------------------------------------------------
---GROUP BY, HAVING- UNION, UNION ALL, EXCEPT, INTERSECT

--*****ODEV:
--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV
SELECT sehir, MAX(maas) max_maas
FROM personel
GROUP BY sehir
HAVING MAX(maas)<5000;
--**********************************

--ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz. 
 SELECT urun_isim FROM mart
 UNION
 SELECT urun_isim FROM nisan
 
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 SELECT urun_isim FROM mart
 UNION ALL
 SELECT urun_isim FROM nisan
 
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 
 SELECT urun_isim FROM mart
 EXCEPT
 SELECT urun_isim FROM nisan
 
 
 
 
 
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
  verileri geri yükleyecektir.  
  
  
  
Aşağıdaki sorguları dvd_rental veritabanında oluşturunuz.   
 
1-Tüm filmleri film adı ve dili ile birlikte  listeleyiniz.
hint:film ve language tablolarını kullanınız.

2-Ödeme miktarı ve müşteri adıyla birlikte en yüksek ödeme yapan müşteriyi bulunuz.
hint:payment ve customer tablolarını kullanınız.

3-Tüm kategorilerin isimlerini ve kategoriye ait film sayısını birlikte  listeleyiniz.
hint:category,film_category tablolarını kullanınız.

4-customer_id'ye göre en çok film kiralayan müşterilerin ad-soyad ve kiraladığı film sayısını birlikte listeleyiniz.
hint:customer,rental tablolarını kullanınız.  
  
5-Tüm dilleri dil adı ve dildeki film sayısıyla birlikte listeleyiniz.
hint:film ve language tablolarını kullanınız.

6- Tüm personelleri personel adı-soyadı ve personelin yönettiği müşteri sayısıyla birlikte listeleyiniz.
hint:staff ve customer tablolarını kullanınız.

7- En fazla actor oynayan 10 tane filmin ismini ve filmde oynayan actor sayısını bulunuz.
hint:film ve film_actor tablolarını kullanınız.

8-Tüm actorlerin ad-soyadını ve oynadığı filmlerin adını birlikte  listeleyiniz.
hint:actor, film_actor, film tablolarını kullanınız.

9-emaili 'j' ile başlayan ve soyadı 'er' ile biten müşterileri listeleyiniz. 

10-İsmi(title) d harfinden sonra e veya a sonrasında ise m veya n içeren ve y harfi ile biten filmlerin
 isimlerini listeleyiniz.(cevap:Victory Academy,Annie Identity)

11-İsmi c ile başlayan kategorideki filmlerin idlerinden en küçük 5 tanesini listeleyiniz.
hint:category, film_category tablolarını kullanınız.

12-İsmi a ile başlayıp a ile bitmeyen şehir(city) ve bu şehirlerin bulunduğu ismi a ile başlayan
 ülkeleri birlikte listeleyiniz.(örn: Escobar-Argentina)
hint:city, country tablolarını kullanınız.


  
  








