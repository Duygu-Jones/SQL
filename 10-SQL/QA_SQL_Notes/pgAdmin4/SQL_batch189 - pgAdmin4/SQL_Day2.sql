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



--10--tabloya NOT NULL constraint i ekleme--------------------------------------------------------------------------
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


--3-) musteri tablosuna kayıt ekleyiniz-
	 --isim:ALİ, yas:35,cinsiyet:E,gelir:2500,meslek:MÜHENDİS,sehir:İSTANBUL

INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('ALI',35,'E',2500,'MUHENDIS','ISTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('BURAK',   25, 'E', 3500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('DEMET',   30, 'K', 3000, 'ÖĞRETMEN',    'ANKARA');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('FERHAT',  40, 'E', 2500, 'MİMAR',       'İZMİR');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('GALİP',   55, 'E', 4000, 'ÖĞRETMEN',    'İSTANBUL');
INSERT INTO musteri(isim,yas,cinsiyet,gelir,meslek,sehir) VALUES('KÖKSAL',  25, 'E', 2000, 'AVUKAT',      'İZMİR');

--4-) musteri tablosunda Tüm kayıtları listeleyiniz.
SELECT*FROM musteri;

--5-) Tüm kayıtlardan isim ve meslek bilgilerini görüntüleyiniz
SELECT isim,meslek FROM musteri;

--6-) sqlpractice_db databaseinde ;
		--“sehirler” isimli bir Table olusturun. 
		--Tabloda “alan_kodu”, “isim”, “nufus”  field’lari olsun.
		--Isim field’i null değer alamasın.
		--“alan_kodu” field’ini “Primary Key” yapin.

CREATE TABLE sehirler(
alan_kodu int,
isim varchar NOT NULL,
nufus int,
CONSTRAINT alan_kodu_PK_yapildi PRIMARY KEY(alan_kodu) 
);


--7a-) “tedarikciler3” isimli bir tablo olusturun.
		--Tabloda “tedarikci_id”, “tedarikci_ismi”,  “iletisim_isim” field’lari olsun
		--“iletisim_isim”  fieldı tekrarsız olsun.
		--“tedarikci_id” yi Primary Key yapin.

create table tedarikciler3(
tedarikci_id int,
tedarikci_ismi varchar(50),
iletisim_isim varchar(50) UNIQUE,
constraint td_id_PK_yap PRIMARY KEY(tedarikci_id)
);
select*from tedarikciler3;


--7b-) “urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun
		--“tedarikci_id” yi Foreign Key yapin.
		
create table urunler(
tedarikci_id int,
urun_id int,
FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) on delete cascade
);
select*from urunler;






