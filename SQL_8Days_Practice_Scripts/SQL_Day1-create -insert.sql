
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

CREATE DATABASE duygu_j; --SQL komutlarinda kucuk/buyuk harf duyarliligi yoktur
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
CREATE TABLE grade AS SELECT id, grade FROM students; 
SELECT*FROM grade;
--------
CREATE TABLE ders_notlari AS SELECT id, grade FROM students;
SELECT*FROM ders_notlari;


--5) TABLE'a KAYIR ekleme: --------------------------------------------------------------------------------------------
INSERT INTO students VALUES('1001','Sherlock Holmes',99.5,'2023-10-04');
INSERT INTO students VALUES('1002','Jack Sparrow',88.8,now());


--6) TABLE'daki TUM * datalri GORUNTULEME:----------------------------------------------------------------------------
SELECT * FROM students;		-- yildiz (*) sembolu:  ALL, TUMu demek


--7) TABLE'da belirli  "FIELD / COLUMN / sutun" lara ---> "RECORD / ROW / kayit" ekleme;------------------------------
INSERT INTO students(name,grade) VALUES('Harry Potter',99.9);

--8) tablodaki tum RECORD/ROW' larin sadece belirli COLUMN/FIELD/sutun' larini goruntuleme:----------------------------
SELECT name, grade FROM students



/*------------------DAY'1 HOMEWORK---------------------------------------------------------------------------------------------------
				   GIRIS- Database Olusturma;
				   
ÖDEVV:)
1) Tablo Oluşturma:

"tedarikciler" isminde bir tablo olusturun,
"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
ve "ulasim_tarihi"	field'lari olsun. 

2) Var olan tablodan yeni tablo olusturma:
 "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun

3) Data ekleme:
" ogretmenler" isminde tablo olusturun.
 Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.

4) bazı fieldları olan kayıt ekleme:
"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Veli Guler
----------------------------------------------------------------------------------*/
--CEVAPLAR

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






