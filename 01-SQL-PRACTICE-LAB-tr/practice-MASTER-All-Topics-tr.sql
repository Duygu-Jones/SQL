-- PRACTICE DErs

/* TABLO OLUŞTURMA  (CRUD - Create)                  
============================================================*/
CREATE TABLE student
(
    std_id VARCHAR(4),
    std_name VARCHAR(20),
    std_age INTEGER
);

/* VERİ GİRİŞİ 
===========================================================*/
INSERT INTO student VALUES('1001', 'MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYŞE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);

/* PARÇALI VERİ GİRİŞİ 
===========================================================*/
-- NOT: Veri girişi yapılmayan değişkenlere NULL atanır.

INSERT INTO student(std_id, std_name) VALUES('1005', 'MUSTAFA KARAR');

select * from student 

/*                        CRUD ÖRNEK  
 ===========================================================
             
 Veritabanımızda urunler adında bir Tablo oluşturalım.
 urun_id  => NUMBER
 urun_adı => VARCHAR2(50)
 fiyat => NUMBER(5,2)
 tett => DATE,      
 stok_adedi => NUMBER(10)  
 
 Tabloya, Ürün girişi yapalım.Örneğin CİPS, KOLA, AYRAN, BİSKÜVİ,  
 (100, ‘CİPS’, 5.50, ‘01-05-2022’, 500)
 Verilerimizi çekelim.
 ===========================================================*/
CREATE TABLE urunler
(
    urun_id SERIAL PRIMARY KEY,
    urun_adi VARCHAR(50),
    fiyat NUMERIC(5,2),
    tett DATE,
    stok_adedi INTEGER
);

INSERT INTO urunler (urun_adi, fiyat, tett, stok_adedi) VALUES('CİPS', 5.50, '2022-05-01', 500);
INSERT INTO urunler (urun_adi, fiyat, tett, stok_adedi) VALUES('BİSKÜVİ', 2.50, '2024-07-01', 300);
INSERT INTO urunler (urun_adi, fiyat, tett, stok_adedi) VALUES('GOFRET', 1.50, '2023-09-05', 120);
INSERT INTO urunler (urun_adi, fiyat, tett, stok_adedi) VALUES('KOLA', 4.50, '2025-09-21', 50);
INSERT INTO urunler (urun_adi, fiyat, tett, stok_adedi) VALUES('AYRAN', 2.50, '2021-05-01', 5);

SELECT * FROM urunler;

/*======================= CONSTRAINTS - KISITLAMALAR ======================================
               
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder. 

    UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

    FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 

    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir şartı sağlamasını garanti eder. 

    DEFAULT - Herhangi bir değer atanamadığında Başlangıç değerinin atanmasını sağlar.
 ========================================================================================*/

----------------------------------------------------------------
-- KISITLAMALAR (ORNEK1 - PRIMARY KEY)
----------------------------------------------------------------
CREATE TABLE calisanlar
(
    id CHAR(5) PRIMARY KEY,
    isim VARCHAR(50) UNIQUE,
    maas NUMERIC(5) NOT NULL,
    ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan', 7000, '2018-04-13');
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10003', '', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
-- Alttaki  satır PostgreSQL'de hata verecektir çünkü 'maas' sütunu NOT NULL kısıtlamasına sahiptir.
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');

SELECT * FROM calisanlar;

 DROP TABLE calisanlar; -- Tabloyu silmek isterseniz bu satırı uncomment yapın.

-- 10001 id'li çalışanı silme
DELETE FROM calisanlar WHERE id='10001';

----------------------------------------------------------------
-- KISITLAMALAR (ORNEK2 - PRIMARY KEY ALTERNATİF YÖNTEM)
----------------------------------------------------------------
-- Bu yöntemde Kısıtlamaya istediğimiz ismi atayabiliriz 
-- ve DISABLE komutuyla istediğimizde pasif hale getirebiliriz. 

CREATE TABLE calisanlar
(
    id CHAR(5),
    isim VARCHAR(50) UNIQUE,
    maas NUMERIC(5) NOT NULL,
    ise_baslama DATE,
    CONSTRAINT id_pk PRIMARY KEY(id)
);

INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan', 7000, '2018-04-13');
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');

----------------------------------------------------------------
-- KISITLAMALAR (ORNEK3 - FOREIGN KEY)
----------------------------------------------------------------
-- Bu örneği çalıştırmadan önce 'calisanlar' tablosunun oluşturulmuş olması gerekmektedir.
CREATE TABLE adresler
(
    adres_id CHAR(5),
    sokak VARCHAR(50),
    cadde VARCHAR(30),
    sehir VARCHAR(15),
    CONSTRAINT id_fk FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10001', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES('10001', 'Can Sok', '50.Cad.', 'Ankara');
INSERT INTO adresler VALUES('10002', 'Ağa Sok', '30.Cad.', 'Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL, 'Ağa Sok', '30.Cad.', 'Antep');
-- Parent tabloda olmayan bir id ile ekleme yapılamaz. Alttaki satır hata verecektir.
-- INSERT INTO adresler VALUES('10004', 'Gel Sok', '60.Cad.', 'Van');

SELECT * FROM adresler;
SELECT * FROM calisanlar;

-- Child tablo silinmeden parent tablo silinemez.
-- DROP TABLE calisanlar; -- Önce child tablo (adresler) silinmelidir.
-- DROP TABLE adresler;

-- FK ile birleştirilen tablolardaki tüm verileri çekmek için JOIN İşlemi yapmak gerekir.
-- Bu konuyu sonra göreceğiz.
-- SELECT * FROM calisanlar JOIN adresler ON calisanlar.id = adresler.adres_id;

-------------------------------------------------------------------------------------------------------
-- Personel tablosunu oluştur
CREATE TABLE personel
(
    id CHAR(5),
    isim VARCHAR(50), 
    maas INTEGER 
);

-- Öğrenciler tablosunu oluştur
CREATE TABLE ogrenciler
(
    id INTEGER, 
    isim VARCHAR(50), 
    adres VARCHAR(100), 
    sinav_notu INTEGER 
);

-- Öğrenciler tablosuna örnek veriler ekle
INSERT INTO ogrenciler VALUES (123, 'Ali Can', 'Ankara', 75);
INSERT INTO ogrenciler VALUES (124, 'Merve Gul', 'Ankara', 85);
INSERT INTO ogrenciler VALUES (125, 'Kemal Yasa', 'Istanbul', 85);

-- Tüm öğrencileri listele
SELECT * FROM ogrenciler;

Örnek-1: /* Sınav notu 80'den büyük olan öğrencilerin bilgilerini listele */
SELECT * FROM ogrenciler WHERE sinav_notu > 80;

-- notu 80 den büyük olanların sadece isim ve not bilgilerini listeleme
    SELECT isim,sinav_notu
    FROM ogrenciler 
    WHERE sinav_notu>80;

Örnek-2: /* Adresi Ankara olan öğrencilerin isim ve adres bilgilerini listele */
SELECT isim, adres FROM ogrenciler WHERE adres = 'Ankara';

Örnek-3: /* id'si 124 olan öğrencinin bilgilerini listele */
SELECT * FROM ogrenciler WHERE id = 124;

-- Personel tablosunu oluştur
CREATE TABLE personel
(
    id CHAR(5), 
    isim VARCHAR(50), 
    maas INTEGER 
);

-- Personel tablosuna örnek veriler ekle
INSERT INTO personel VALUES ('10001', 'Ahmet Aslan', 7000);
INSERT INTO personel VALUES ('10002', 'Mehmet Yılmaz', 12000);
INSERT INTO personel VALUES ('10003', 'Meryem', 7215);
INSERT INTO personel VALUES ('10004', 'Veli Han', 5000);
INSERT INTO personel VALUES ('10005', 'Mustafa Ali', 5500);
INSERT INTO personel VALUES ('10005', 'Ayşe Can', 4000);
-- Dikkat: Aynı id ile iki kayıt eklenmiş, bu bir hata olabilir.
-- PostgreSQL'de id genellikle UNIQUE veya PRIMARY KEY olarak kullanılır.
-- Eğer '10005' id'si ile iki farklı kayıt kasıtlıysa ve id benzersiz olmak zorunda değilse bu şekilde bırakılabilir.
-- Aksi takdirde, id değerlerinin benzersiz olması sağlanmalıdır.
INSERT INTO personel VALUES ('10006', 'Ayşe Can', 4000); -- '10005' id'si tekrarlanmış, '10006' olarak değiştirildi

-- Tüm personel bilgilerini listele
SELECT * FROM personel;


Örnek-4: /* id'si 10002 ile 10005 arasında olan personelin bilgilerini listele */
--1.Yöntem (AND ile aralık sorgusu)
SELECT * FROM personel
WHERE id >= '10002' AND id <= '10005';

--2.Yöntem (BETWEEN ile aralık sorgusu)
SELECT id, isim, maas 
FROM personel
WHERE id BETWEEN '10002' AND '10005'; -- Hem '10002' hem de '10005' dahil

--Örnek-5: ismi Mehmet Yılmaz ile Veli Han arasındaki olan personel bilgilerini 
  listeleyiniz. personelin bilgilerini listele
SELECT * FROM  personel
    WHERE isim BETWEEN 'Mehmet Yılmaz' AND 'Veli Han';

-- ORNEK6: id’si 10002 - 10004 arasında olmayan personelin bilgilerini listele
 SELECT * FROM personel
    WHERE id NOT BETWEEN '10002' AND '10004';

/* ======================= SELECT - IN ======================================
    IN birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları 
    tek komutla yazabilme imkânı verir
    */

--ORNEK7: id’si 10001,10002 ve 10004 olan personelin bilgilerini listele
--1.YOL: OR operatörü kullanımı
SELECT id, isim, maas
FROM personel
WHERE id = '10001' OR id = '10002' OR id = '10004';

--2.YOL: IN operatörü kullanımı
SELECT id, isim, maas
FROM personel
WHERE id IN ('10001', '10002', '10004');

--ORNEK8: Maaşı sadece 7000  ve 12000 olan personelin bilgilerini listele
 SELECT * FROM personel
WHERE maas IN (7000, 12000);

--======================= SELECT - LIKE ======================================
-- DIKKAT: LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri  kullanabilmemize olanak sağlar.
   

--ORNEK9:  ismi A harfi ile başlayanları listeleyiniz
 -----------------------------------------------------------------------------*/   
SELECT * FROM personel
WHERE isim ILIKE 'A%';
-----------------------------------------------------------------------------
-- ORNEK10:  ismi n harfi ile bitenleri listeleyiniz
-----------------------------------------------------------------------------
SELECT * FROM personel
WHERE isim ILIKE '%n';
 ----------------------------------------------------------------------------
--ORNEK11:  isminin 2. harfi e olanları listeleyiniz
----------------------------------------------------------------------------
SELECT * FROM personel
WHERE isim LIKE '_e%';
-----------------------------------------------------------------------------
--ORNEK12:  isminin 2. harfi e olup diğer harflerinde y olanları listeleyiniz
 -----------------------------------------------------------------------------
SELECT * FROM personel
WHERE isim LIKE '_e%y%';

--ORNEK13:  ismi A ile başlamayanları listeleyiniz

SELECT * FROM personel
WHERE isim NOT LIKE 'A%';

-----------------------------------------------------------------------------
--ORNEK14:  ismi n ile bitmeyenleri listeleyiniz
 -----------------------------------------------------------------------------
SELECT * FROM personel
WHERE isim NOT LIKE '%n';

-----------------------------------------------------------------------------
--ORNEK15:  isminde a harfi olmayanları listeleyiniz
 -----------------------------------------------------------------------------
SELECT * FROM personel
WHERE isim NOT LIKE '%a%';

 -----------------------------------------------------------------------------
--ORNEK16:  maaşının son 2 hanesi 00 olmayanları listeleyiniz
 -----------------------------------------------------------------------------  
SELECT * FROM personel
WHERE maas::TEXT NOT LIKE '%00';

--NOT: maas::TEXT: maas sütununu metin türüne (TEXT) dönüştürür. 
--Bu dönüşüm, maaş değerlerinin metinsel işlemlere tabi tutulabilmesi için yapılır.

-----------------------------------------------------------------------------
--ORNEK17:  maaşının 4000 olmayanları listeleyiniz
 ----------------------------------------------------------------------------- 
SELECT * FROM personel
WHERE maas != 4000;
    
 -----------------------------------------------------------------------------
--ORNEK18: maaşı 5 haneli olanları listeleyiniz
 -----------------------------------------------------------------------------    
SELECT * FROM personel
WHERE LENGTH(maas::TEXT) = 5;
/* NOT: HERE LENGTH(maas::TEXT) = 5: Bu koşul, maas sütunundaki değerlerin metin 
 * (TEXT) türüne dönüştürüldükten sonra uzunluğunun (yani karakter sayısının) beş 
 * olup olmadığını kontrol eder. LENGTH fonksiyonu, verilen metin değerinin 
 * uzunluğunu döndürür. Bu durumda, maaş değeri tam olarak beş haneli olan kayıtlar seçilir.
  */

 -----------------------------------------------------------------------------
 --ORNEK19: maaşının  5 haneli olmayanları listeleyiniz
 -----------------------------------------------------------------------------  
SELECT * FROM personel
WHERE LENGTH(maas::TEXT) != 5;
      
-----------------------------------------------------------------------------
--ORNEK20: 1. harfi A ve 7.harfi A olan perspneli listeleyiniz.
 ----------------------------------------------------------------------------- 

SELECT * FROM personel
WHERE isim LIKE 'A_____a%';
-----------------------------

CREATE TABLE kelimeler
(
    id INTEGER UNIQUE,
    kelime VARCHAR(50) NOT NULL,
    harf_sayisi INTEGER
);

INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1001, 'hot', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1002, 'hat', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1003, 'hit', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1005, 'hct', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1006, 'adem', 4);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1007, 'selim', 5);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1008, 'yusuf', 5);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1009, 'hip', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1010, 'HOT', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1011, 'hOt', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1012, 'h9t', 3);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1013, 'hoot', 4);
INSERT INTO kelimeler (id, kelime, harf_sayisi) VALUES (1014, 'haaat', 5);

select * from kelimeler

-- Eğer tabloyu hemen silmek istemiyorsanız, aşağıdaki DROP TABLE komutunu kullanmayın.
-- DROP TABLE kelimeler;

-----------------------------------------------------------------------------
--ORNEK21: İçerisinde 'hi' bulunan kelimeleri listeleyeniz
 -----------------------------------------------------------------------------
SELECT * FROM kelimeler
WHERE kelime ~ 'hi';
    
--Eğer büyük/küçük harfe duyarlı olmayan bir arama yapmak istiyorsanız, ~* operatörünü kullanabilirsiniz:
SELECT * FROM kelimeler
WHERE kelime ~* 'hi';

-----------------------------------------------------------------------------
--ORNEK22: İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyeniz
-----------------------------------------------------------------------------
 -- VEYA işlemi için | karakteri kullanılır.
    
SELECT * FROM kelimeler
WHERE kelime ~ 'at|ot';

--Bu sorgu, "kelime" sütununda "at" veya "ot" desenini içeren tüm kelimeleri döndürecektir. 
--Eğer büyük/küçük harfe duyarlı olmayan bir arama yapmak istiyorsanız, ~* operatörünü kullanabilirsiniz:

SELECT * FROM kelimeler
WHERE kelime ~* 'at|ot';

-----------------------------------------------------------------------------------------------------
--ORNEK23: İçerisinde 'ot' veya 'at' bulunan kelimeleri büyük-küçük harfe dikkat etmeksizin listeleyeniz
 ---------------------------------------------------------------------------------------------------
 -- 'c' => case-sentisitive demektir ve default case-sensitive aktiftir.
 -- 'i' => incase-sentisitive demektir.
--PostgreSQL'de, büyük/küçük harf duyarlılığını göz ardı eden düzenli ifade aramaları için ~* operatörü kullanılır. 
   
SELECT * FROM kelimeler
WHERE kelime ~* 'at|ot';
   
-----------------------------------------------------------------------------
--ORNEK24: 'ho' veya 'hi' ile başlayan kelimeleri büyük-küçük harfe dikkat etmeksizin listeleyeniz
-----------------------------------------------------------------------------  
-- Başlangıcı göstermek için ^ karakteri kullanılır.
    
SELECT * FROM kelimeler
WHERE kelime ~* '^hi|^ho';
    
-----------------------------------------------------------------------------
--ORNEK25: Sonu 't' veya 'm' ile bitenleri büyük-küçük harfe dikkat etmeksizin listeleyeniz
 -----------------------------------------------------------------------------  
-- Bitişi göstermek için $ karakteri kullanılır.

SELECT * FROM kelimeler
WHERE kelime ~* 't$|m$';

-----------------------------------------------------------------------------
--ORNEK26: h ile başlayıp t ile biten 3 harfli kelimeleri büyük-küçük harfe dikkat etmeksizin listeleyeniz
 -----------------------------------------------------------------------------
SELECT * FROM kelimeler
WHERE kelime ~ 'h[a-zA-Z0-9]t';

-----------------------------------------------------------------------------
--ORNEK27: İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
 ---------------------------------------------------------------------------- 
SELECT * FROM kelimeler
WHERE kelime ~ 'h[ai]t';

----------------------------------------------------------------------------
--ORNEK28: İçinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
 -----------------------------------------------------------------------------    
SELECT * FROM kelimeler
WHERE kelime ~ '[mie]';
 
-----------------------------------------------------------------------------
--ORNEK29: a veya s ile başlayan kelimelerin tüm bilgilerini listeleyiniz.
----------------------------------------------------------------------------- 
SELECT * FROM kelimeler
WHERE kelime ~ '^[as]';

/* ============================== UPDATE SET ===================================    
    
   Aşağıdaki gibi tedarikciler adında bir tablo oluşturunuz ve vergi_no  sutununu primary key yapınız.
 Sonrasında aşağıdaki gibi urunler adında bir başka tablo oluşturunuz ve bu  tablonun ted_vergino sutunu ile 
 tedarikciler tablosunun vergi_no sutunu  ilişkilendiriniz. */

CREATE TABLE tedarikciler
(
    vergi_no INTEGER,
    firma_ismi VARCHAR(50),
    irtibat_ismi VARCHAR(50),
    PRIMARY KEY (vergi_no)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

DROP TABLE IF EXISTS urunler;
CREATE TABLE urunler
(
    ted_vergino INTEGER,
    urun_id INTEGER,
    urun_isim VARCHAR(50),
    musteri_isim VARCHAR(50),
    FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
);


INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

-------------
--ORNEK1: vergi_no’su 101 olan tedarikcinin ismini 'LG' olarak güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
 
UPDATE tedarikciler
SET firma_ismi = 'LG'
WHERE vergi_no = 101;

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

-----------------------------------------------------------------------------
--ORNEK2: Tedarikciler tablosundak tüm firma isimlerini 'Samsung' olarak güncelleyeniz. 
 -----------------------------------------------------------------------------
UPDATE tedarikciler
SET firma_ismi = 'SAMSUNG';


DELETE FROM tedarikciler; -- referans tablo olduğu için silinmez
--NOT:
-- Önce mevcut yabancı anahtar kısıtlamasını silin:
--ALTER TABLE urunler DROP CONSTRAINT urunler_ted_vergino_fkey;
    
-- Tablonun içeriğini siler..
DELETE FROM tedarikciler;  -- DROP TABLE tabloyu siler.
    
-----------------------------------------------------------------------------
--ORNEK3: vergi_no’su 102 olan tedarikcinin ismini 'Samsung' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
    
UPDATE tedarikciler
SET firma_ismi = 'Samsung', irtibat_ismi ='Ali Veli'
WHERE vergi_no = 102;

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

-----------------------------------------------------------------------------
--ORNEK4: firma_ismi Samsung olan tedarikcinin irtibat_ismini 'Ayşe Yılmaz' olarak güncelleyiniz.
 -----------------------------------------------------------------------------
    UPDATE tedarikciler
SET irtibat_ismi = 'Ayşe Yılmaz'
WHERE firma_ismi = 'Samsung';
    
-----------------------------------------------------------------------------
--ORNEK5: urunler tablosundaki 'Phone' değerlerini Telefon olarak güncelleyiniz.
 -----------------------------------------------------------------------------
UPDATE urunler
SET urun_isim = 'Telefon'
WHERE urun_isim = 'Phone';
 
/-----------------------------------------------------------------------------
 --ORNEK6: urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id değerlerini bir arttırınız
 -----------------------------------------------------------------------------
UPDATE urunler
SET urun_id = urun_id + 1
WHERE urun_id > 1004;
  
 ----------------------------------------------------------------------------
 --ORNEK7: urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
 ----------------------------------------------------------------------------- 
UPDATE urunler
SET urun_id = urun_id + ted_vergino;


SELECT * FROM tedarikciler;
SELECT * FROM urunler;
    
-----------------------------------------------------------------------------
--ORNEK8: urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda 
--irtibat_ismi 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
 -----------------------------------------------------------------------------
UPDATE urunler
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')
WHERE musteri_isim = 'Ali Bak';

------------------------------------------------------------------------------
--ORNEK9: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile degistirin
 -----------------------------------------------------------------------------
UPDATE urunler
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi = 'Apple')
WHERE urun_isim = 'Laptop';


/* ============================== DELETE ===================================  */

    -- DELETE FROM tablo_adı;  Tablonun tüm içerğini siler.
    -- Bu komut bir DML komutudur. Dolayısıyla devamında WHERE gibi cümlecikler
    -- kullanılabilir.

DROP TABLE IF EXISTS ogrenciler;
CREATE TABLE ogrenciler
(
    id CHAR(3),
    isim VARCHAR(50),
    veli_isim VARCHAR(50),
    yazili_notu INTEGER
);

INSERT INTO ogrenciler VALUES('123', 'Ali Can', 'Hasan', 75);
INSERT INTO ogrenciler VALUES('124', 'Merve Gul', 'Ayşe', 85);
INSERT INTO ogrenciler VALUES('125', 'Kemal Yasa', 'Hasan', 85);
INSERT INTO ogrenciler VALUES('126', 'Nesibe Yılmaz', 'Ayşe', 95);
INSERT INTO ogrenciler VALUES('127', 'Mustafa Bak', 'Can', 99);

SELECT * FROM ogrenciler;

DROP TABLE ogrenciler;

--------------------------------------
/* =============================================================================
         Seçerek silmek için WHERE Anahtar kelimesi kullanılabilir. */ 

-----------------------------------------------------------------------------
--ORNEK1: id'si 124 olan ogrenciyi siliniz.
---------------------------------------------------------------------------- 
  
DELETE FROM ogrenciler
WHERE id = '124';
    
-----------------------------------------------------------------------------
--ORNEK2: ismi Kemal Yasa olan satırını siliniz.
 -----------------------------------------------------------------------------   
DELETE FROM ogrenciler
WHERE isim = 'Kemal Yasa';
      
-----------------------------------------------------------------------------
--ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kayıtları silelim.
 -----------------------------------------------------------------------------        
DELETE FROM ogrenciler
WHERE isim IN ('Nesibe Yılmaz', 'Mustafa Bak');
  
/----------------------------------------------------------------------------
 --ORNEK4: İsmi Ali Can ve id'si 123 olan kaydı siliniz.
 -----------------------------------------------------------------------------   
DELETE FROM ogrenciler
WHERE isim = 'Ali Can' AND id = '123';
   
----------------------------------------------------------------------------
--ORNEK5: id 'si 126'dan büyük olan kayıtları silelim.
 ----------------------------------------------------------------------------- 
DELETE FROM ogrenciler
WHERE id > '126';
 
 ----------------------------------------------------------------------------
--ORNEK6: id'si 123, 125 ve 126 olanları silelim.
 -----------------------------------------------------------------------------     
    
DELETE FROM ogrenciler
WHERE id IN ('123','125','126');
    
----------------------------------------------------------------------------
--ORNEK7:  TABLODAKİ TÜM KAYITLARI SİLELİM..
 -----------------------------------------------------------------------------     
 DELETE FROM ogrenciler; 

/* ======================== DELETE - TRUCATE - DROP ============================   
    
    1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.  Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML değil DDL komutudur. 
    
    2-) DELETE komutu beraberinde WHERE cümleciği kullanılabilir. TRUNCATE ile kullanılmaz.
    
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylıkla geri alınabilir.
    
    4-) Truncate ile silinen veriler geri alınması daha zordur. Ancak Transaction yöntemi ile geri alınması mümkün olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da  siler. Silinen tablo Veritabanının geri dönüşüm kutusuna gider. Silinen tablo aşağıdaki komut ile geri alınabilir. Veya SQL GUI'den geri alınabilir. 

/* 

=============================================================================
    Tablolar arasında ilişki var ise veriler nasıl silinebilir?
========================================================================
PostgreSQL'de ON DELETE CASCADE özelliği bulunmaktadır. Bu özellik, bir referans anahtarı (foreign key) üzerinde tanımlandığında, ana tablodaki bir satır silindiğinde, o satıra referans veren diğer tablolardaki ilgili satırların otomatik olarak silinmesini sağlar.
Örneğin, bir öğrenci tablosunda bulunan bir öğrencinin kimlik numarası, bir ders kaydı tablosunda bir referans anahtarı olarak kullanılıyorsa ve bu referans anahtarı üzerinde ON DELETE CASCADE belirtilmişse, öğrenci tablosundan bir öğrencinin kaydı silindiğinde, ilgili ders kayıtlarının otomatik olarak silinmesi sağlanır.
Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz.
Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmak yeterli
*/

DROP TABLE IF EXISTS talebeler;
CREATE TABLE talebeler
(
    id CHAR(3) PRIMARY KEY,  -- PK
    isim VARCHAR(50),
    veli_isim VARCHAR(50),
    yazili_notu INTEGER
);

INSERT INTO talebeler VALUES('123', 'Ali Can', 'Hasan', 75);
INSERT INTO talebeler VALUES('124', 'Merve Gul', 'Ayse', 85);
INSERT INTO talebeler VALUES('125', 'Kemal Yasa', 'Hasan', 85);
INSERT INTO talebeler VALUES('126', 'Nesibe Yilmaz', 'Ayse', 95);
INSERT INTO talebeler VALUES('127', 'Mustafa Bak', 'Can', 99);

CREATE TABLE notlar 
( 
    talebe_id CHAR(3) REFERENCES talebeler(id) ON DELETE CASCADE, -- FK
    ders_adi VARCHAR(30), 
    yazili_notu INTEGER
);

INSERT INTO notlar VALUES ('123', 'kimya', 75);
INSERT INTO notlar VALUES ('124', 'fizik', 65);
INSERT INTO notlar VALUES ('125', 'tarih', 90);
INSERT INTO notlar VALUES ('126', 'Matematik', 90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

DELETE FROM notlar
WHERE talebe_id = '124';

DELETE FROM talebeler
WHERE id = '124';

/* ============================= SUBQUERIES ====================================
    SORGU içinde çalışan SORGUYA SUBQUERY (ALT SORGU) denilir.
*/

DROP TABLE IF EXISTS personel;
CREATE TABLE personel
(
    id SERIAL PRIMARY KEY, 
    isim VARCHAR(50), 
    sehir VARCHAR(50), 
    maas INTEGER, 
    sirket VARCHAR(20)
);

INSERT INTO personel(id, isim, sehir, maas, sirket) VALUES
(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda'),
(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota'),
(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda'),
(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford'),
(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai'),
-- Aşağıdaki kayıt tekrar eden bir 'id' içerdiğinden ve PostgreSQL'de 'id' alanı birincil anahtar olarak tanımlandığından, bu kayıt hata verecektir.
-- (456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford'), 
(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');


DROP TABLE IF EXISTS sirketler;
CREATE TABLE sirketler
(
    sirket_id SERIAL PRIMARY KEY, 
    sirket_adi VARCHAR(20), 
    personel_sayisi INTEGER
);

INSERT INTO sirketler(sirket_id, sirket_adi, personel_sayisi) VALUES
(100, 'Honda', 12000),
(101, 'Ford', 18000),
(102, 'Hyundai', 10000),
(103, 'Toyota', 21000);

SELECT * FROM sirketler;
SELECT * FROM personel;

----------------------------------------------------------------------------
--ORNEK1: Personel sayısı 15.000’den cok olan sirketlerin isimlerini ve bu 
  --sirkette calisan personelin isimlerini ve maaşlarını listeleyin
 -----------------------------------------------------------------------------
SELECT isim, maas, sirket FROM personel
WHERE sirket IN(SELECT sirket_adi FROM sirketler
                WHERE personel_sayisi > 15000);

----------------------------------------------------------------------------
--ORNEK2: sirket_id’si 101’den büyük olan şirket çalışanlarının isim, maaş ve 
--şehirlerini listeleyiniz. 
    -----------------------------------------------------------------------------
SELECT isim, maas, sehir FROM personel
WHERE sirket IN(SELECT sirket_adi FROM sirketler
                WHERE sirket_id > 101);
   
-----------------------------------------------------------------------------
--ORNEK3: Ankara’da personeli olan şirketlerin şirket id'lerini ve personel 
  --sayılarını listeleyiniz.
 ----------------------------------------------------------------------------- 
SELECT sirket_id, personel_sayisi FROM sirketler
WHERE sirket_adi IN (SELECT sirket FROM personel 
                     WHERE sehir = 'Ankara');
   
----------------------------------------------------------------------------
--ORNEK4: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
  --toplam maaşını listeleyen bir Sorgu yazınız.
 ----------------------------------------------------------------------------
-- çözüm altta verilmiştir

                    
                    
 /* ===================== AGGREGATE METOT KULLANIMI ===========================

    Aggregate Metotları(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullanılabilir.
    Ancak, Sorgu tek bir değer döndüryor olmalıdır.

==============================================================================*/   
    
SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas) FROM personel
                                     WHERE sirket = sirketler.sirket_adi) AS toplam_maas
FROM sirketler;
 
-----------------------------------------------------------------------------
--ORNEK5: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
  --ortalama maaşını listeleyen bir Sorgu yazınız.
 -----------------------------------------------------------------------------
 
SELECT sirket_adi, personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel
                                     WHERE sirket = sirketler.sirket_adi) AS ort_maas
FROM sirketler;
    
 ----------------------------------------------------------------------------
--ORNEK6: Her şirketin ismini, personel sayısını ve o şirkete ait personelin
  --maksimum ve minumum maaşını listeleyen bir Sorgu yazınız.
 -----------------------------------------------------------------------------          
    SELECT sirket_adi, personel_sayisi, 
       (SELECT MAX(maas) FROM personel
        WHERE sirket = sirketler.sirket_adi) AS max_maas, 
       (SELECT MIN(maas) FROM personel
        WHERE sirket = sirketler.sirket_adi) AS min_maas
FROM sirketler;

 -----------------------------------------------------------------------------
--ORNEK7: Her sirketin id’sini, ismini ve toplam kaç şehirde bulunduğunu 
--listeleyen bir SORGU yazınız.
 -----------------------------------------------------------------------------*/
 SELECT sirket_id, sirket_adi, 
       (SELECT COUNT(DISTINCT sehir) FROM personel
        WHERE sirket = sirketler.sirket_adi) AS sehir_sayisi
FROM sirketler;
 

/*===================== IS NULL, IS NOT NULL, COALESCE ========================
    
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup olmadığını kontrol ederler. IS NULL, 
    bir sütunun veya ifadenin NULL olup olmadığını kontrol eder. Eğer değer NULL ise, bu koşul TRUE döndürür. 
    Bu, veritabanındaki sorgularda, özellikle de WHERE koşullarında, belirli bir sütunun NULL değerlerini bulmak 
    için kullanılır. Örnek: SELECT * FROM tablo_adi WHERE sütun_adi IS NULL; 
    Bu sorgu, belirtilen sütun_adi NULL olan tüm kayıtları seçer.
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan ilk ifadeyi döndürür. Eğer aldığı tüm
    ifadeler NULL ise NULL döndürürür. COALESCE fonksiyonu, argüman olarak verilen değerlerin listesinden ilk NULL olmayan 
    değeri döndürür. Eğer tüm değerler NULL ise, sonuç olarak NULL döndürür. Bu, bir değerin NULL olup olmadığını kontrol 
    etmek ve NULL ise başka bir değer atamak için kullanışlıdır.
Örnek: SELECT COALESCE(sütun_adi, 'Varsayılan Değer') FROM tablo_adi; Bu sorgu, sütun_adinde bir değer varsa o değeri, 
değer NULL ise 'Varsayılan Değer' metnini döndürür.

    
    sutun_adi = COALESCE(ifade1, ifade2, .....ifadeN)
    
==============================================================================*/
CREATE TABLE insanlar
(
    ssn CHAR(9),
    isim VARCHAR(50),
    adres VARCHAR(50)
);

INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, isim, adres) VALUES('456789012', NULL, 'Bursa');
INSERT INTO insanlar (ssn, isim, adres) VALUES('567890123', NULL, 'Denizli');


-- DELETE FROM insanlar; -- Bu ifade tüm kayıtları siler. Koşullu silmek istiyorsanız WHERE koşulu ekleyin.

-------------------------

/* ----------------------------------------------------------------------------
    ORNEK1: isim 'i NULL olanları sorgulayınız.
 -----------------------------------------------------------------------------*/     
SELECT * FROM insanlar
WHERE isim IS NULL;
    
/* ----------------------------------------------------------------------------
  ORNEK2: isim 'i NULL olmayanları sorgulayınız.
 -----------------------------------------------------------------------------*/  
SELECT * FROM insanlar
WHERE isim IS NOT NULL;
    
/* ----------------------------------------------------------------------------
  ORNEK3: isim 'i NULL olan kişilerin isim'ine NO NAME atayınız. 
-----------------------------------------------------------------------------*/   
UPDATE insanlar
SET isim = 'NO NAME'
WHERE isim IS NULL;
    
/* ----------------------------------------------------------------------------
  ORNEK4:   isim 'i NULL olanlara 'Henuz isim girilmedi’ , adres 'i NULL olanlara 'Henuz adres girilmedi’ ,  ssn 'i NULL olanlara ' no ssn' atayalım.
-----------------------------------------------------------------------------*/    
UPDATE insanlar
SET isim = COALESCE(isim, 'Henüz isim girilmedi'),
    adres = COALESCE(adres, 'Henüz adres girilmedi'),
    ssn = COALESCE(ssn, 'No SSN');

/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
==============================================================================*/ 

CREATE TABLE kisiler
(
    ssn CHAR(9) PRIMARY KEY,
    isim VARCHAR(50),
    soyisim VARCHAR(50),
    maas NUMERIC,
    adres VARCHAR(50)
);

INSERT INTO kisiler VALUES('123456789', 'Ali', 'Can', 3000, 'Istanbul');
INSERT INTO kisiler VALUES('234567890', 'Veli', 'Cem', 2890, 'Ankara');
INSERT INTO kisiler VALUES('345678901', 'Mine', 'Bulut', 4200, 'Ankara');
INSERT INTO kisiler VALUES('256789012', 'Mahmut', 'Bulut', 3150, 'Istanbul');
INSERT INTO kisiler VALUES('344678901', 'Mine', 'Yasa', 5000, 'Ankara');
INSERT INTO kisiler VALUES('345458901', 'Veli', 'Yilmaz', 7000, 'Istanbul');

SELECT * FROM kisiler;

-------------------------------------------------------------------------
--ORNEK1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
 ------------------------------------------------------------------------
SELECT * FROM kisiler
ORDER BY adres;   --- ASC gibi sıraladı.

/* ----------------------------------------------------------------------------
  ORNEK2: kisiler tablosunu maas'a göre sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/  
SELECT * FROM kisiler
ORDER BY maas ASC;
 
 /* ----------------------------------------------------------------------------
  ORNEK3: kisiler tablosunu maas'a göre AZALAN sırada sorgulayınız.
 -----------------------------------------------------------------------------*/ 
SELECT * FROM kisiler
ORDER BY maas DESC;
 
/* ----------------------------------------------------------------------------
  ORNEK4: ismi Mine olanları, SSN'e göre AZALAN sırada sorgulayınız.
-----------------------------------------------------------------------------*/
SELECT * FROM kisiler
WHERE isim = 'Mine'
ORDER BY ssn DESC;

/* ----------------------------------------------------------------------------
  ORNEK5: soyismi 'i Bulut olanları isim sıralı olarak sorgulayınız.
-----------------------------------------------------------------------------*/ 
SELECT * FROM kisiler
WHERE soyisim = 'Bulut'
ORDER BY 2;


/*============================= GROUP BY =====================================
    
    GROUP BY cümleciği bir SELECT ifadesinde satırları, sutunların değerlerine göre özet olarak gruplamak için kullanılır. 
   
    GROUP BY cümleceği her grup başına bir satır döndürür. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate fonksiyonları ile birlikte kullanılır.
    
==============================================================================*/ 

CREATE TABLE manav
(
    isim VARCHAR(50),
    urun_adi VARCHAR(50),
    urun_miktari NUMERIC(9)
);

INSERT INTO manav VALUES('Ali', 'Elma', 5);
INSERT INTO manav VALUES('Ayse', 'Armut', 3);
INSERT INTO manav VALUES('Veli', 'Elma', 2);
INSERT INTO manav VALUES('Hasan', 'Uzum', 4);
INSERT INTO manav VALUES('Ali', 'Armut', 2);
INSERT INTO manav VALUES('Ayse', 'Elma', 3);
INSERT INTO manav VALUES('Veli', 'Uzum', 4);
INSERT INTO manav VALUES('Ali', 'Armut', 2);
INSERT INTO manav VALUES('Veli', 'Elma', 3);
INSERT INTO manav VALUES('Ayse', 'Uzum', 4);
INSERT INTO manav VALUES('Ali', '', 2); -- Bu kayıtta 'urun_adi' boş bir string olarak girilmiş.


/* -----------------------------------------------------------------------------
  ORNEK1: kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu yazınız.
------------------------------------------------------------------------------*/  
SELECT isim, SUM(urun_miktari) AS toplam_urun 
FROM manav
GROUP BY isim;
   
   
/* ----------------------------------------------------------------------------
  ORNEK2: satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.
-----------------------------------------------------------------------------*/ 
 -- GROUP by ile birlikte WHERE cümleciği kullanılabilir.
        
SELECT urun_adi, COUNT(isim) AS kisi_sayisi
FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi;
    

SELECT * FROM manav;
    
   
/* ----------------------------------------------------------------------------
  ORNEK3: satılan meyve türüne (urun_adi) göre satılan (urun_miktari )MIN ve MAX urun miktarlarini, MAX urun miktarina göre sıralayarak listeyen sorguyu yazınız.
-----------------------------------------------------------------------------*/ 
SELECT urun_adi, MIN(urun_miktari) AS min_miktar, MAX(urun_miktari) AS maks_miktar
FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY MAX(urun_miktari) DESC;
    
/* ----------------------------------------------------------------------------
  ORNEK4: kisi ismine ve urun adına göre satılan ürünlerin toplamını gruplandıran ve isime göre ters sırasıda listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/ 
SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_miktar
FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY isim, urun_adi
ORDER BY isim DESC;
     
/* ----------------------------------------------------------------------------
  ORNEK5: kisi ismine ve urun adına göre satılan ürünlerin toplamını bulan ve bu toplam değeri 3 ve fazlası olan kayıtları toplam urun miktarlarina göre ters siralayarak listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/  
SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_miktar
FROM manav
GROUP BY isim, urun_adi
HAVING SUM(urun_miktari) >= 3
ORDER BY SUM(urun_miktari) DESC;
     
-- AGGREGATE fonksiyonları ile ilgili bir koşul koymak için GROUP BY'dan sonra HAVING cümleciği kullanılır.
 
 /* ----------------------------------------------------------------------------
  ORNEK6: satılan urun_adi'na göre MAX urun sayılarını sıralayarak listeyen Sorguyu yazınız. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarına eşit olmayan kayıtları listelemelidir.
 -----------------------------------------------------------------------------*/    
SELECT urun_adi, MAX(urun_miktari)
FROM manav
GROUP BY urun_adi
HAVING MAX(urun_miktari) <> MIN(urun_miktari)
ORDER BY MAX(urun_miktari);

/*============================= DISTINCT =====================================
    
    DISTINCT cümleciği bir SORGU ifadesinde benzer olan satırları flitrelemek
    için kullanılır. Dolayısıyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satırlar oluşturmaya yarar.
   
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_adı;
==============================================================================*/
    
     
/* ----------------------------------------------------------------------------
  ORNEK1: satılan farklı meyve türlerinin sayısını listeyen sorguyu yazınız.
-----------------------------------------------------------------------------*/   
    
SELECT COUNT(DISTINCT urun_adi) AS urun_sayisi 
FROM manav;

/* -----------------------------------------------------------------------------
  ORNEK2: satılan meyve ve isimlerin farklı olanlarını listeyen sorguyu yazınız.
------------------------------------------------------------------------------*/
     
SELECT DISTINCT urun_adi, isim  -- 2 sutun icin beraber degerlendirirek benzerli olanları cikariyor.
FROM manav;

/* ----------------------------------------------------------------------------
  ORNEK3: satılan meyvelerin urun_mikarlarinin benzersiz  olanlarının toplamlarini listeyen sorguyu yazınız.
-----------------------------------------------------------------------------*/     
SELECT SUM(DISTINCT urun_miktari) AS urun_sayisi 
FROM manav;
 
/*==================== SET OPERATORLERI: UNION, UNION ALL======================
    
    UNION, UNION ALL, INTERSECT, ve MINUS gibi SET operatorleri yardimiyla  
    Çoklu Sorgular birlestirilebilirler.

    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc 
    kumelerini birlesitirerek tek bir sonuc kumesi olusturur.    
   
    NOT:  Birleşik olan olan Sorgu ifadesinin veri türü diğer sorgulardaki 
    ifadelerin veri türü ile uyumlu olmalıdır.
    
   NOT: UNION operatoru SADECE benzersi degerleri alır. Benzerli verileri almak
    için UNION ALL kullanılır.
==============================================================================*/ 

DROP TABLE IF EXISTS personel;
CREATE TABLE personel
(
    id NUMERIC(9), 
    isim VARCHAR(50), 
    sehir VARCHAR(50), 
    maas NUMERIC(20), 
    sirket VARCHAR(20),
    CONSTRAINT personel_pk PRIMARY KEY(id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4200, 'Honda');

SELECT * FROM personel;


/* -----------------------------------------------------------------------------
  ORNEK1: Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
------------------------------------------------------------------------------*/
    
SELECT isim AS isim_veya_sehir, maas
FROM personel
WHERE maas > 4000
UNION ALL    -- UNION ALL kullanılırsa tekrarli veriler elenmez.
SELECT sehir AS isim_veya_sehir, maas
FROM personel
WHERE maas > 5000;


   
/* -----------------------------------------------------------------------------
  ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini yüksekten açağa doğru sıralayarak bir tabloda gosteren  sorguyu yaziniz.    
------------------------------------------------------------------------------*/  
    
SELECT maas, isim AS isim_veya_sehir
FROM personel
WHERE isim = 'Mehmet Ozturk'
UNION
SELECT maas, sehir
FROM personel
WHERE sehir = 'Istanbul'
ORDER BY maas DESC;

/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/ 

CREATE TABLE personel_bilgi 
(
    id NUMERIC(9), 
    tel CHAR(10) UNIQUE, 
    cocuk_sayisi NUMERIC(2), 
    CONSTRAINT fk_personel FOREIGN KEY (id) REFERENCES personel(id) 
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(453445611, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

SELECT * FROM personel_bilgi;
------------

/* -----------------------------------------------------------------------------
  ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin  
------------------------------------------------------------------------------*/    
SELECT sehir AS sehir_tel, maas AS maas_cocukSayisi
FROM personel
WHERE id = 123456789
UNION
SELECT tel, cocuk_sayisi
FROM personel_bilgi
WHERE id = 123456789;
    
    -- sehir ile tel, maas ile cocuk ayni sutunda birlestiği icin veri tipleri
    -- uygun olmalidir.
     
/*========================= SET OPERATORLERI: INTERSECT ========================
    
    INTERSECT operarotu 2 veya daha fazla Sorgu ifadesinin sonuclarini dondurmek icin kullanilir. Ancak, intersect SADECE tum sorgularin ortak verilerini (kesimlerini) dondurur. 
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    INTERSECT
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
==============================================================================*/

/* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini sorgulayiniz. 
 
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz. Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
    
SELECT id FROM personel
WHERE sehir IN ('Istanbul', 'Ankara')
INTERSECT
SELECT id FROM personel_bilgi
WHERE cocuk_sayisi IN (2, 3);
  
  
/* -----------------------------------------------------------------------------
  ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
------------------------------------------------------------------------------*/  
    
SELECT isim
FROM personel
WHERE sirket = 'Honda'
INTERSECT
SELECT isim
FROM personel
WHERE sirket = 'Ford'
INTERSECT
SELECT isim
FROM personel
WHERE sirket = 'Tofas';

  
/* -----------------------------------------------------------------------------
  ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini listeleyin
------------------------------------------------------------------------------*/    
    
SELECT isim, maas
FROM personel
WHERE sirket = 'Toyota'
INTERSECT
SELECT isim, maas
FROM personel
WHERE sirket = 'Ford';


/*============================== JOIN İSLEMLERİ ===============================
    
    Set Operatorleri (Union,Intersect,Minus) farklı tablolardaki sutunlari birlestirmek kullanilir.
    
    Join islemleri ise farklı Tablolari birlestirmek icin kullanilir. Diger bir ifade ile farkli 
    tablolardaki secilen sutunlar ile yeni bir tablo olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. 
    Çunku Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
==============================================================================*/ 

DROP TABLE IF EXISTS sirketler;
CREATE TABLE sirketler 
(
    sirket_id INTEGER,
    sirket_isim VARCHAR(20)
);


INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

----------------

DROP TABLE IF EXISTS siparisler;
CREATE TABLE siparisler
(
    siparis_id INTEGER,
    sirket_id INTEGER,
    siparis_tarihi DATE
);


INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

SELECT * FROM siparisler;
SELECT * FROM sirketler;
-------------
/*=============================== FULL JOIN  ==================================
    
    FULL JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari getirmek icin kullanilir. 

------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------
  ORNEK1: sirketler ve siparisler adındaki tablolarda yer alan sirket_isim, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------ */
  
SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi, sp.sirket_id
FROM sirketler s
FULL JOIN siparisler sp
ON s.sirket_id = sp.sirket_id;
    
    -- FULL Join'de iki tabloda var olan tum satirlar gosterilir.
    -- Birinde olupda digerlerine olmayan alanlar boş birakildi.
    -- Join isleminde genelde iki tablodaki ortak olarak bulunan sutun, ON cumleciginde kosul yapisi kullanilir.
     
   /*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
* -----------------------------------------------------------------------------
  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri 
  listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/  
    
SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi, sp.sirket_id
FROM sirketler s
INNER JOIN siparisler sp
ON s.sirket_id = sp.sirket_id;
   
    -- INNER JOIN ile sadece iki tabloki ortak olan satilar secilir.
    -- Diger ifadeyle iki tablodaki ortak olan sirket_id degerleri icin ilgili sutunlar listenir.
    -- INNER anahtar kelimesi opsiyoneldir.
    
/* =============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir.         
----------------------------------------------------------------------------- */


-- ORNEK3: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan siparis_id ve siparis_tarihleri
--listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   
    
SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi, sp.sirket_id, s.sirket_id
FROM sirketler s
LEFT JOIN siparisler sp
ON s.sirket_id = sp.sirket_id;
    
    -- Left Join’de ilk tablodaki tum satirlar gosterilir.
    -- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar gösterilir ancak ortak olmayan kisimlar bos kalir
          
/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum satirlari getirir. Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        

* * -----------------------------------------------------------------------------
  ORNEK4: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   
     
SELECT s.sirket_isim, sp.siparis_id, sp.siparis_tarihi, sp.sirket_id
FROM sirketler s
RIGHT JOIN siparisler sp
ON s.sirket_id = sp.sirket_id;
    
    -- Right Join’de 2. tablodaki tum satirlar gosterilir.
    -- 2 tablodaki satirlara 1.tablodan kosula uyan ortak satirlar gösterilir ancak ortak olmayan kisimlar bos kalir



/*=============================== ALTER TABLE ==================================
    
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin kullanilir.
    
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de kullanilir.
   
==============================================================================*/

DROP TABLE IF EXISTS personel;
CREATE TABLE personel 
(
    id INTEGER PRIMARY KEY, 
    isim VARCHAR(50), 
    sehir VARCHAR(50), 
    maas NUMERIC(20), 
    sirket VARCHAR(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
-------------

-----------------------------------------------------------------------------
--ORNEK1: personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan yeni bir sutun ekleyiniz.
------------------------------------------------------------------------------ 
    
ALTER TABLE personel
ADD COLUMN ulke_isim VARCHAR(20) DEFAULT 'TURKIYE';


SELECT * FROM personel;
      
/* -----------------------------------------------------------------------------
  ORNEK2: personel tablosuna cinsiyet Varchar2(20) ve yas Number(3) seklinde yeni sutunlar ekleyiniz.
------------------------------------------------------------------------------*/  
ALTER TABLE personel
ADD COLUMN cinsiyet VARCHAR(20),
ADD COLUMN yas INTEGER;
    
/* -----------------------------------------------------------------------------
  ORNEK3: personel tablosundan yas sutununu siliniz. 
------------------------------------------------------------------------------*/ 

ALTER TABLE personel
DROP COLUMN sirket;
    
/* -----------------------------------------------------------------------------
  ORNEK4: personel tablosundaki ulke_isim sutununun adini ulke_adi olarak degistiriniz. 
------------------------------------------------------------------------------*/  
ALTER TABLE personel
RENAME COLUMN ulke_isim TO ulke_adi;
    
   
/* -----------------------------------------------------------------------------
  ORNEK5: personel tablosunun adini isciler olarak degistiriniz. 
------------------------------------------------------------------------------*/  
ALTER TABLE personel
RENAME TO isciler;


SELECT * FROM isciler;
    
/* -----------------------------------------------------------------------------
  ORNEK6: isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ekleyiniz. 
------------------------------------------------------------------------------*/ 
--ulke_adi sütununun veri tipini değiştirme ve NOT NULL kısıtlaması ekleme 
  
ALTER TABLE isciler
ALTER COLUMN ulke_adi SET DATA TYPE VARCHAR(30),
ALTER COLUMN ulke_adi SET NOT NULL; -- Hem veri tipini degistirik hem de NOT NULL kisitlamasi ekledik

--isim sütununun veri tipini değiştirme:    
ALTER TABLE isciler
ALTER COLUMN isim SET DATA TYPE CHAR(100); -- Veritipini CHAR(100) olarak degistirdik.

--Yeni bir kayıt eklerken INSERT INTO komutunu kullanırken veri dizisini uygun hale getirme:    
INSERT INTO isciler VALUES(123452310, 'Hatice Sahin', 'Bursa', 3000, 'Almanya');



















