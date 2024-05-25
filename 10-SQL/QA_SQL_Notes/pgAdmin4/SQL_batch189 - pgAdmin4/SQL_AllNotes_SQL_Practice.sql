
--NOTES:
--Yorum satiri --cift tire ile baslar
/* COK SATIRLI YORUMLAR ICIN ayni java ile */

/*
SORU: CHAR ile VARCHAR farkI nedir?
CEVAP:  
	CHAR - Sabit uzunlukta karakter saklar. Yani CHAR(50) ifadesi MAX 50 karakter saklayabilir.
	 	Ancak içerisine atanan veriyi bakılmaksızın bellekte sabit olarak hep 50 karakterlik yer kaplar.
	VARCHAR-  Bellekte değişken uzunlukta yer kaplar.
	 	Varchar(50) ifadesi MAX 50 karakter saklayabilir ancak  30 karakterlik bir atama yapıldığında bellekte 30 karakterlik yer kaplar.

SORU: varchar ile varchar2 arasındaki farklar nelerdir ?
CEVAP: varchar2, varchar ’ın güncellenmiş versiyonudur. 
	   Varchar’a göre 2 kat daha fazla (4000) karakter saklayabilir.*/


------------------------------------------DAY'1 DT----------------------------------------------------------------------------------

--1) Database OLUSTURMA: --DDL (Data Defination Language)-----------------------------------------------------------------

CREATE DATABASE duygu; --SQL komutlarinda kucuk/buyuk harf duyarliligi yoktur
create database duygu;

--create database duygu; kucuk harfler genellikle tercig ediliyormus; isimlendirmelerde bosluk birakmiyoruz
--eger birden fazla kelimeli isim ise sadece bitisik de yazilabilir veya 
-- genellikle alt_tire kullanilarak bitisik yazilir (zorunlu olmamakla birlikte okunurlugu arttirmak icin) NO camelCase


--2) Database nasil SILINIR? --DDL ---------------------------------------------------------------------------------------
	--sol barda olusturulan databaseismi uzerine gel, sag tik, disconnect yaparak ardindan silme islemi gerceklestirilir.
DROP DATABASE duygu;
DROP TABLE student;

--3) TABLE olusturma: --DDL--Datalarin depolandigi alanlardir-----------------------------------------------------------
CREATE TABLE students(
id CHAR(4), 			--4 characterlik sabit buyuklukte bir data alani/field olsturuldu
name VARCHAR(20),		--degisken buyuklukte string/character bir variable icin	
grade REAL,				--, virguller ile variable lar ayrilir, 
register_date DATE		--son variable da (,) XXX kullanilmaz 
);					--(); normal parantez scope dur ve noktali virgul sart degil,--> ; more Readable 
			 ---->(;) birden fazla code calsitirilmak istersek (;) ile son code oldugu gosterilir-bitis demektir 
 


--4) MEVCUT var olan bir TABLE'dan YENI TABLE olusturma: --------------------------------------------------------------
CREATE TABLE grade AS SELECT id, grade 
FROM students; 
SELECT*FROM grade;

DROP TABLE grade;

--------
CREATE TABLE ders_notlari AS SELECT id, grade FROM students;
SELECT*FROM ders_notlari;


------------------------------------------

CREATE TABLE mentoring
(
id int PRIMARY KEY, 
dersler varchar(20) NOT NULL,
kisi_sayisi int	
);

INSERT INTO mentoring VALUES(1,'java',150);
INSERT INTO mentoring(dersler, kisi_sayisi) VALUES('SQL', 100);
SELECT*FROM mentoring;

--5) TABLE'a KAYIT ekleme: --------------------------------------------------------------------------------------------
INSERT INTO students VALUES('1001','Sherlock Holmes',99.5,'2023-10-04');
INSERT INTO students VALUES('1002','Jack Sparrow',88.8,now());


--6) TABLE'daki TUM * datalri GORUNTULEME:----------------------------------------------------------------------------
SELECT * FROM students;		-- yildiz (*) sembolu:  ALL, TUMu demek


--7) TABLE'da belirli  "FIELD / COLUMN / sutun" lara ---> "RECORD / ROW / kayit" ekleme;------------------------------
INSERT INTO students(name,grade) VALUES('Harry Potter',99.9);

--8) tablodaki tum RECORD/ROW' larin sadece belirli COLUMN/FIELD/sutun' larini goruntuleme:----------------------------
SELECT name, grade FROM students



------------------DAY'1 HOMEWORK---------------------------------------------------------------------------------------------------
				   GIRIS- Database Olusturma;
				   
--ÖDEVV:)
--1) Tablo Oluşturma:

--"tedarikciler" isminde bir tablo olusturun,
--"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
--ve "ulasim_tarihi"	field'lari olsun. 
CREATE TABLE tedarikciler(
	tedarikci_id int,
	tedarikci_ismi varchar(30),
	tedarikci_adres varchar(50),
	ulasim_tarihi date
);

--2) Var olan tablodan yeni tablo olusturma:
-- "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
--Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun
CREATE TABLE tedarikci_info1 AS SELECT tedarikci_isim,ulasim_tarihi FROM tedarikciler;
SELECT*FROM tedarikci_info1;

--3) Data ekleme:
--" ogretmenler" isminde tablo olusturun.
-- Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
--"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
--kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
--kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.
CREATE TABLE ogretmenler(
kimlik_no char(11) PRIMARY KEY,
	isim varchar(50) NOT NULL,
	brans varchar(50),
	cinsiyet char(5)
);
INSERT INTO ogretmenler VALUES('634431223', 'Ayse Guler', 'Matematik', 'kadin'),
							  ('834431224', 'Ali Guler', 'Fizik', 'erkek'), 
							  ('367597624', 'Veli Guler');

SELECT*FROM ogretmenler;


----4) bazı fieldları olan kayıt ekleme:
----"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
----kimlik_no: 567597624, isim: Veli Guler 




-----------------------------------------DAY'2 DT--------------------------------------------------------------------------------------

--------TABLE sairler-----------------------------------
CREATE TABLE sairler(
id int,
name varchar(50),
email varchar(50)	
);

INSERT INTO sairler VALUES(1001,'Can Yucel', 'sair@gmail.com');
INSERT INTO sairler VALUES(1001,'Didem MAdak', 'sair@gmail.com');
INSERT INTO sairler VALUES(1002,'sair@gmail.com');
INSERT INTO sairler(name) VALUES('Necip Fazil');

SELECT * FROM sairler; 



--9) tabloya UNIQUE constraint(kisitlama) ekleme---------------------------------------------------------------------
------------TABLE it_persons--------------------------
CREATE TABLE it_persons(
id SERIAL,
name VARCHAR(50),
email VARCHAR(50) UNIQUE,	-- Bu datalar tekrarsiz olmali
salary REAL,
programming_lang VARCHAR(20)	
);

INSERT INTO it_persons(name,email,salary,programming_lang)
VALUES('Betul Hanim','dev1@email.com',5000,'java');

INSERT INTO it_persons(name,email,salary,programming_lang)
VALUES('Ibrahim Bey','dev2@email.com',5000,'java');

INSERT INTO it_persons(name,email,salary)
VALUES('Duygu Hanim','QA@email.com',10000);

SELECT*FROM it_persons; 



--10--tabloya NOT NULL constraint i ekleme---------------------------------------------------------------------------------
-------------TABLE doctors---------------------------
CREATE TABLE doctors(
id SERIAL,
name VARCHAR(50) NOT NULL, 	--null i kabul etmez name sutununda fakat--NOT NULL empty '' i kabul eder
email VARCHAR(50) UNIQUE,
salary REAL
);
INSERT INTO doctors(name,email,salary) VALUES('Dr.Gregory House','dr@mail.com',8000);
INSERT INTO doctors(email,salary) VALUES('doctor@mail.com',8000);		--hata=name -Not Null- yaptik burada ise name yok
INSERT INTO doctors(name,email,salary) VALUES('','doctor@mail.com',8000);
INSERT INTO doctors(name,email,salary) VALUES('','doctor@mail.com',8000);--isim empty-yerini acip bos birakabiliriz calisir
															
SELECT * FROM doctors;


--11) Tabloya PRIMARY KEY Constraint'i ekleme; ---------------------------------------------------------------------------------
		--Bir Sutun, sadece 1 tane (PK) keyword'u ile isaretlenebilir
		
--1.yontem----------------------
CREATE TABLE students2(
id int PRIMARY KEY, --- > [PK]==>1)Null deger alamaz 2)Unique dir 3) baska bir tablo ile iliskilendirmek icin kullanilacak DEMEKTIR
name varchar(50),
grade real,
register_date date
);
SELECT*FROM students2;


--2.yontem;---------------------
CREATE TABLE students3(
id int,
name varchar(50),
grade real,
register_date date,
CONSTRAINT std_pk PRIMARY KEY(id)  ---> son satirda; -->  CONSTRAINT + yeni Const_Name + PRIMARY KEY(sutunIsmi) 
);
SELECT*FROM students3;


--11a-) COMPOSITE KEY; birden fazla PRIMARY KEY yapma; -----------------------------------------------------------------------
		--CONSTRAINT + yeni ConstName + PRIMARY KEY(sutun1, sutun2)--> birden fazla sutun ismi parantez icine yazilabilir
		--Bu durumda 2.yontem zorunlu olarak kullanilmalidir
	
CREATE TABLE students4(
id int,
name varchar(50),
grade real,
register_date date,
CONSTRAINT std4_pk PRIMARY KEY(id,name) --> PK icine 2 tane key girdik
);
SELECT*FROM students4;


--12)Tabloya FOREIGN KEY Ekleme;--------------------------------------------------------------------------------------------
	--->  "Consraint" + "NewFKName"+ "FK(sutunName)" + "REFERENCE" + Ref-aldigi TABLEName (Ref-aldigi SutunName)"
	
CREATE TABLE address3(
address_id int,
street VARCHAR(50),
city VARCHAR(50),
student_id int,	  --FK: 1) Null kabul eder, 2) duplicate(tekrarli) kabul eder 
CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3(id); 
); 
SELECT*FROM address3;


--13) Tabloya CHECK Constraint' i Ekleme; -----------------------------------------------------------------------------------
	--> CHECK(condition)
	
CREATE TABLE staff(
id int,
name varchar(50),
salary real NOT NULL CHECK(salary>5000), --> salary 5000 den fazla olmali 
age int	CHECK(age>0 AND age<50)			---> negatif kabul etmez
);
INSERT INTO staff VALUES(11,'Ali Can',2000,35);--FALSE-salary deki check nedeniyle kabul etmedi-maas2000>5000 false
INSERT INTO staff VALUES(11,'Ali Can',7000,55);--FALSE-yas kriterine uymadi
INSERT INTO staff VALUES(11,'Ali Can',7000,35);--True; CHECK sarrtlariini saglar, tabloya ekler

SELECT*FROM staff;


---------------------------HOMEWORK-2 DAY-2----------------------------------------------------------------------------------------
/*	 						Queries-1

1-) sqlpractice_db isminde database oluşturunuz.
2-) sqlpractice_db database içinde musteri isminde tablo oluşturunuz.
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

--3-) musteri tablosuna kayıt ekleyiniz-
	 --isim:ALİ, yas:35,cinsiyet:E,gelir:2500,meslek:MÜHENDİS,sehir:İSTANBUL

--4-) musteri tablosunda Tüm kayıtları listeleyiniz.

--5-) Tüm kayıtlardan isim ve meslek bilgilerini görüntüleyiniz

--6-) sqlpractice_db databaseinde ;
		--“sehirler” isimli bir Table olusturun. 
		--Tabloda “alan_kodu”, “isim”, “nufus”  field’lari olsun.
		--Isim field’i null değer alamasın.
		--“alan_kodu” field’ini “Primary Key” yapin.

--7a-) “tedarikciler3” isimli bir tablo olusturun.
		--Tabloda “tedarikci_id”, “tedarikci_ismi”,  “iletisim_isim” field’lari olsun
		--“iletisim_isim”  fieldı tekrarsız olsun.
		--“tedarikci_id” yi Primary Key yapin.

--7b-) “urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun
		--“tedarikci_id” yi Foreign Key yapin.





---------------------------------------------Practice DAY'3---------------------------------------------------------------------------------
--Day3 ten sonra tablolar hazir kullaniliyor

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

--14-) WHERE CONDITION(koşulu)-----------------------------------------------------------------------------

--SORULAR
	--1) calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
	--2) calisanlar tablosundan maaşı 5000den fazla olanların tüm bilgilerini listeleyelim
	--3) calisanlar tablosundan maaşı 5000den fazla olanların isim ve maaslarını listeleyelim
	--4) adresler tablosundan sehiri 'Konya' ve adres_id si 10002 olan kaydın tüm verileri getirelim
	--5) sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
	


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


--16-DELETE FROM .. WHERE .. komutu----------------------------------------------------------------------------------

--16a-) Tablodaki tüm kayıtları silme:DELETE FROM .. :
		--id=123 olan kaydı silelim.
		--ismi Kemal Tan olan kaydı silelim
		--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
		
--16b-) Tablodaki tüm kayıtları silme:TRUNCATE TABLE ..:

--17-parent-child ilişkisi olan tablolarda silme işlemi--manuel
		--calisanlar tablosundaki id'si 10002 olan tüm kayıtları silelim (once childi silmek gerek).



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

--18-ON DELETE CASCADE: ------------------------------------------------------------------------------------
		--Parent-Child TABLE larda kademeli silme işlemini OTOMATIKLESTIRir
		--FK ve PK Constraint code'unun sonuna eklenir + ON DELETE CASCADE
--SORULAR
	--1) notlar tablosundan id:123 olan kaydı silelim.
	--2) Variables silme islemleri yapalim
	--3) parent table'da tamamen veya belli fieldlar sil
	--4) child table' da tamamen veya belli fieldlar sil
	
	

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


--20-IN CONDITION:-------------------------------------------------------------------------------------------------
	---aranan table da var ise TRUE verir ve tabloyu gosterir
	---yok ise False donderir.

--SORULAR
	--1) Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
	
	--2) Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.



--21-BETWEEN .. AND .. komutu--------------------------------------------------------------------------------------

--SORULAR
	--1) Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
	--2) Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) dan büyük olan urunlerin tum bilgilerini listeleyiniz




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


--22-AGGREGATE Fonk.:----------- --------------------------------------------------------------------------------
	--AGGREGATE FONKSİYON birden çok değer üzerinde bir hesaplama gerçekleştirir ve tek bir değer döndürür.
	--SQL; avg, count, sum, min, max, vb. fonksiyonlari bircok degerden tek bir sonuc elde eder

--SORULAR
	--1) calisanlar3 tablosunda max maaşı görüntüleyiniz
	--2) calisanlar3 tablosunda min maaşı görüntüleyiniz
	--3) calisanlar3 tablosunda toplam maaşı görüntüleyiniz
	--4) calisanlar3 tablosunda ortalama maaşı görüntüleyiniz
	--5) calisanlar3 tablosundaki kayıt sayısını görüntüleyiniz
	--6) calisanlar3 tablosundaki maaşı 2500 olanların sayısını görüntüleyiniz





--DAY-3 ODEV yok

--------------------------------------- PRACTICE DAY'4 ----------------------------------------------------------------------------------------

------------ TABLE workers ---------------------------
CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50));

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

--------- TABLE Markalar --------------------------------
CREATE TABLE markalar(
marka_id int,
marka_isim VARCHAR(20), ---calisanlar3 isyeri ile ayni sutun
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);



---------TABLE calisanlar3 -------------------------------
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


--23-ALIASES; Gecici isimlendirme yapmak: -----------------------------------------------------------------------
	--Bir sutunu "SELECT sutun1 AS New_sutun_Name FROM table_Name"  seklinde yeni isim olarak goruntuleyebiliriz
	--Sutunlari birlestirme veya AGGRIGATE FONK. lar sonucu yeni bir sutun olusturduktan sonra ortak bir isim ile yeni sutun goruntulenebilir	
	--SUTUN BIRLESTIRME:
		--tablodaki iki sutunu birlestirmek icin || sembolu kullanilir
		--iki sutun birlestirildikten sonra yeni sutunu goruntulerken gecici ortak bir isim atanir
		--isimlendirme yapilmazsa default olarak (fonk ismi) gorunebilir veya bos gelebilir


--ORNEKLER:
--1) workers table'ini gorutuleyiniz

--2) workers table da (calisan_id) sutununu (id ) olarak isimlendirip goruntuleyiniz 

--3 birden fazla sutuna gecici isim verme;
	--workers table dan;
		--(calisan_dogdugu_sehir) sutununu (sehir) olarak; 
		--(calisan_isim) sutununu (isim) olarak isimlendiriniz
		
		

--24-SUBQUERY--NESTED QUERY-------------------------------------------------------------------------------------
--24-a) SUBQUERY: WHERE ile kullanımı: 

--ORNEKLER: 

--1) marka_id si 100 olan markada çalışanları listeleyiniz.

--1.yol:  marka_id'si hem markalar hem calisanlar3 tabolsunda var (acemi isi)
SELECT marka_isim FROM markalar WHERE marka_id=100;
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';

--2.yol; ikisini bir arada yapma islemi: SubQueries; iki islemi bir adimda yapma : (markette bu yol kullanilir)
SELECT *
FROM calisanlar3 
WHERE isyeri=(SELECT marka_isim FROM markalar WHERE marka_id=100);


--2) INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

--3) Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.

--4) calisanlar3 tablosunda ikinci en yüksek maaşı alan kisinin BILGILERI;

--5) calisanlar3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.

--6) Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

--7) marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

--8) Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
	--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.



--24-b-) SUBQUERY: SELECT komutundan sonra kullanımı-------------------------------------------------------------------------------------
	--Ek Bilgi: DISTINCT fonk. tekrarli degerleri 1 kez sayar-gorur

--ORNEKLER:
--1) her markanin kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz

--2) Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

--3) Her markanin ismini, calisan sayisini ve 
	--o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir Sorgu yaziniz.
		--her bir marka icin tek bir max ve min deger yazdiriacak==> aggragete



--Ek Bilgi:
--VIEW olarak tabloyu olusturma-goruntuleme ---> sol barda olan Tablo'lar sekmesinin altinda VIEW olarak table gorulur
CREATE VIEW sehir_sayisi AS
	SELECT marka_id,marka_isim, (SELECT COUNT(DISTINCT(sehir)) FROM calisanlar3 WHERE isyeri=marka_isim) 
	AS sehir_sayisi
	FROM markalar


-----------------------TABLE mart--------------------------
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


-----------------------TABLE nisan --------------------------
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


----25-EXISTS Condition: ----------------------------------------------------------------------------------------------------------

--ORNEKLER:
--1)Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--2) Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.
--3) Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 
	--gecici sutun isimlendirmesi icin m(mart icin) ve n(nisan icin) kullanalim

--4) Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
	--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

--5) Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
	--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.



---------------------------------------------HOMEWORK-3 DAY-4--------------------------------------------------------------------
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





----------------------------------------------DAY'5 PRACTICE---------------------------------------------------------------------------

--26-UPDATE :---------------------------------------------------------------------------------------------------------------------------
	--UPDATE komutu:tablodaki koşulu sağlayan kayıtları günceller:DML
			--UPDATE tablo_adı 
			--SET sütun_adı=yenideğer
			--WHERE koşul  
   					

--ORNEKER;

--1) id'si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.

--2) id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
	--sehirini 'Bursa' olarak güncelleyiniz.

-- 3) markalar tablosundaki marka_id değeri 102 ye eşit veya 
	--büyük olanların marka_id'sini 2 ile çarparak değiştirin.

--4) markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

--5) calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

--6) calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
	--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

--7) calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.




---------------------TABLE people ----------------------------

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


--27---IS NULL:----------------------------------------------------------------------------------------------------------------

--ORNEKLER
--1) people tablosundaki name sütununda NULL olan değerleri listleyiniz.

--2) people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.

--3) people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..



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

--2 person tablosundaki tüm kayıtları soyisim göre (azalan) sıralayarak listeleyiniz.

--3 person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.

--4 person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz

--5 İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.

--6 Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
	--soyisim değerinin toplam uzunluğuna göre sıralayınız.

--7calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
	--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz. 




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




---------------------------------------DAY-6 PRACTICE--------------------------------------------------------------------------

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
--1) Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.

--2) Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
	--toplam ürün miktarına göre AZALAN sıralayınız.

--3) Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.


--NOTE: GROUP BY ile gruplama yapıldığında, SELECT'ten sonra sadece gruplanan sütun yada bir sütunun 
		--AGGREGATE fonk ile sonucu kullanılabilir.


--4) ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.

--5) Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz

--6) Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
	--musteri sayisina göre artan sıralayınız.



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
--1) Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.
--2) Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.

-- NOTE:gruplamadan sonra yapılan işlem sonucu ile ilgili bir koşul belirtmek için HAVING,
		--gruplamadan önce kayıtları filtrelemek(koşul belirtmek) için WHERE kullanılır.


--3) Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.

--4) Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız

--5) Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV


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
		--iki farklı sorgunun sonucunu birleştirerek tek bir sütunda görüntülemeyi sağlar
		--tekrarlı olanları göstermez

--32-UNION ALL:-----------------------------------------------------------------------------------------------------------------------------
		--UNION gibi kullanılır, FAKAT tekrarlı olanları da gösterir

--SORU1:
--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--birlikte tekrarsız gösteren sorguyu yaziniz


--SORU2:
--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--birlikte tekrarlı gösteren sorguyu yaziniz


--NOTe:UNION/UNION ALL birleştirdiğimiz sorgular aynı sayıda sütunu göstermeli ve
		--alt alta gelecek olan sütunun data tipi aynı olmalı


--SORU3:
--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

--SORU4:
--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.

--SORU5:
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz


--32--INTERSECT:----------------------------------------------------------------------------------------------------------------------------
	--iki farklı sorgunun sonuçlarından ortak olanları(kesişimi)
	--tekrarsız olarak gösterir.

--SORU1
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz


--SORU2
--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.


--33--EXCEPT:----------------------------------------------------------------------------------------------------------------------------
	--karsilastirilan iki sorgudan; bir sorgunun sonuçlarından diğer bir sorgunun sonuçlarından 
	--farklı olanları gösterir.

--SORU1
--developers tablosundaki şehirleri
--calisanlar3 tablosunda ortak olan sehirler hariç olarak listeleyiniz

--SORU2
--calisanlar3 tablosundaki şehirleri
--developers tablosunda sehirler hariç olarak listeleyiniz

--SORU3
----developers tablosundaki maaşı 4000 den büyük olanların id'lerinden
--contact_info tablosunda olmayanları listeleyiniz.


 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz. 

 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.

 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 




----------------------------------------------DAY'7 PRACTICE--------------------------------------------------------------------------------

---------------------TABLE sirketler----------------------------
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

---------------------TABLE siparis----------------------------
CREATE TABLE siparis (
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

--ORNEK
--iki tablodaki şirket id'si AYNI olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş id'sini  listeleyiniz.


--34-LEFT JOIN:-----------------------------------------------------------------------------------
			--Sol tablodaki(ilk tablodaki) tüm verileri getirir.

--ORNEK
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.      


--34-RIGHT JOIN:----------------------------------------------------------------------------------
  			--Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.

--ORNEK
--siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    


--****************************
--NOTE: LEFT ve RIGHT JOIN i tablo sırasını değiştirerek birbirinin yerine kullanılabilir.
		--**** bu iki sorgu sonucuda aynidir, tablo yerlerini degistirip, left veya right kullanilarak 
		--tablonun nerede oldugunun bir onemi kalmaz--sonuc olarak iki tabloda birlestirilmis olur 
		--tek bir tabloyla islem yapilir gibi olur
--****************************		

--35-FULL JOIN:----------------------------------------------------------------------------------
			--iki tablodaki baz alınan sütundaki tüm kayıtları getirir.
--ORNEK
--her iki tablodaki tüm kayıtların tüm bilgilerini listeleyiniz.




-----------TABLA personeller-----------------------

CREATE TABLE personeller  (
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
--ORNEK
--herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.



--37--LIKE Conditions:----ALL--------------------------------------------------------------------------------------------------
		
		--	LIKE: Sorgulama yaparken belirli patternleri(kalıp ifadelerle sorgu) kullanabilmezi sağlar
		--	ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
		--	LIKE = ~~
		--	ILIKE = ~~*
		--	NOT LIKE = !~~
		--	NOT ILIKE = !~~*
		
		--  REGEXP_LIKE= ~
		--  REGEXP_LIKE= ~*
		--	NOT REGEXP_LIKE = !~*
		--	NOT REGEXP_LIKE = !~


--NOTES:
--LIKE / ILIKE  Cond. ---------------------------------------------------------------------------------------------------
--WHERE komutundan sonra kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--tablo larda istedigimiz variable aratip bulabilmek icin kullanilir, aramayi daraltir

--Kullanilan SEMBOLLERi: 
		--WILDCARD/joker (%) : joker dedigimiz % isareti==> 0 veya daha fazla karakteri temsil eder.
		--UnderScore     (_) :  'alt_tire' tek bir karakteri temsil eder
	 

--PRACTICES:

------------TABLE developers ---------kullanalim-
--developers tablosundan name degerlerini bastan ve sonda bulunan bosluklarini cikarip guncelleyiniz
UPDATE developers
SET name= TRIM(name)

SELECT * FROM developers;

--ORN: tablodan 'Enes Can' goruntuleyin
SELECT * FROM developers WHERE name='Enes Can'

--LIKE:-----------------------------------------------------------------------------
	--LIKE '%' isareti ile gosterilir
	-- CASE SENSITIVE dir. 


--ORN1: isim 'E' ile basliyan devaminda, 0 veya daha fazla karakter gelen kayitlari goruntuleyin



--ILIKE:----------------------------------------------------------------------------
		--CASE IN-SENSITIVE dir. Buyuk-kucuk harf gozetmez
		--wildcard(joker-%): 0 veya daha fazla karakteri temsil eder.

--ORN2: buyuk/kucuk harf belirsiz ismi 'E/e' harfi ile baslayan kayitlari getir;

--ORN3: a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin

--ORN4: Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin

--ORN5: Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin 

--ORN6: Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin 
		--AND ile

		-- OR ile 

--ORN7: Isminin ikinci harfi u olan devlerin tum bilgilerini yazdiran QUERY yazin

--ORN8: Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin



---******ODEV********
--1-Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin
	--HINT:sadece JavaScript olacak
	
--2-Isminin 2. harfi e, 4. harfi m olan devlerin tum bilgilerini yazdiran QUERY yazin.

--3-ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin



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

--38-REGEXP_LIKE(~): ---------------------------------------------------------------------------------------------------
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
	
--SORU1
--h harfinden sonra a veya i harfini sonra ise t harfini --> '?h a?i ?t'
	--içeren kelimelerin TUM bilgilerini yazdiran QUERY yaziniz.
	
	
--NOTE: (~*) küçük/büyük harf hassasiyeti olmasın demek
--		[ - ] verilen araliktan sadece bir harfi temsil eder



--SORU2
--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
		

--SORU3
-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
		--> [m veya i biri olabilir] demek
		

--- NOTE: ^ :kelimenin başlangıcını gösterir, 
--		  $ :kelimenin bitişini gösterir


--SORU4
--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin --> kelime kesin a ile basliyor
	
	
--SORU5
--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
	
	
--SORU6
--m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
	

-- NOTE: (.*)--> 0 veya daha fazla karakteri temsil eder
--       (.) --> sadece 1 karakteri temsil eder 
  		        --> () parantez icinde de sembol yazilabilir


--SORU7
--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

--SORU8
--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin


--NOT LIKE : verilen karakter desenine benzemeyenleri filtreler -->Case Senst.
--NOT ILIKE: verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.
--  (!~)   : verilen karakter desenine benzemeyenleri filtreler -->Case Sensit.
--  (!~*)  : verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.


--SORU9
-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--1.yol: NOT LIKE-ILIKE ile;

--2.yol: NOT Regex_LIKE ile; (!~*)





--************ ÖDEV *************
--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.


---------------------------HOMEWORK-5 DAY'7--------------------------------------------------------------------------------------
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
  	---------------------------------------------------------------------
  
 --SORULAR
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

--SORULAR
--1) Developers tablosunda name degerlerinin karakter sayisini gosteriniz

--2) developers tablosunda name değerlerindeki başlangıç ve sondaki boşlukları kaldırınız.

--3) developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.



-- UPPER-LOWER-INITCAP Fonks:-------------------------------------------------------------------------------------------

--SORULAR
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

--SORULAR
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

--SORULAR
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

--SORU1:
--Bir bank hesabindan digerine 1000tl gonderilecegi bir senaryo icin;
--Gonderici hesaptan -1000tl eksilir, alici hesapta +1000tl artar
--Senaryoya gore transaction yapan kodu yaziniz
 





  

















