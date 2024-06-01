-------------------------------------------DAY'8----------------------------------------------------------------------------------
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

--NOTE: SQL de index 1 den baslar!!!

8) LENGTH(sütun adı) belirtilen sütundaki her satır içinde bulunan stringlerin uzunluklarını alır 

9) REVERSE(sütun adı) sütunu ters çevirir

10) LEFT() / RIGHT() (Başlangıç ve Son Karakterler): Bir dizinin başlangıç veya sonundaki belirli karakterleri alır.
11) LEFT(sütun, 3) ilk 3 karakteri alır RIGHT olsa son 3 karakteri alırdı

12) FETCH NEXT n ROW ONLY  : sadece sıradaki ilk n satırı getirir
                  LIMIT n  : sadece sıradaki ilk n satırı getirir - terminate fonk
                  OFFSET n : n satırı atlayıp sonrakileri getirir

*/------------------------------------------------------------------------------------------------------------------------
---TABLE developers Kullanalim----

SELECT * FROM developers;


--39-String Fonksiyonlar----------------------------------------------------------------------------------

--Developers tablosunda name degerlerinin karakter sayisini gosteriniz
SELECT name,LENGTH(name)
FROM developers

--Ayşenur Han değerinde en sonda boşluk var:
	--developers tablosunda name değerlerindeki 
	--başlangıç ve sondaki boşlukları kaldırınız.
UPDATE developers
SET name=TRIM(name)

--developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.
UPDATE developers
SET name=REPLACE(name,'Ayşenur','Ayşe')

SELECT * FROM developers;


-- UPPER-LOWER-INITCAP Fonks:------------------------------------------------------------------------------------------------

--developers tablosundaki tüm kayıtların 
--name değerlerini kucuk harfe 
-- prog_lang değerlerini buyuk harfe
-- email degerlerini ilk harfi buyuk olacak sekilde çevirerek görüntüleyiniz.
SELECT UPPER (prog_lang), LOWER(name), INITCAP(email)
FROM developers


--calisanlar3 tablosunda isyeri='Vakko' olan kayıtlarda (_Şubesi) ifadesini siliniz. 
	-- isyeri Vakko olanlarin Sehir bilgisini--> boslukla birlikte 7 karakter sondan silinecek --> LENGTH()-7
		--(2 kez UPDATE edildigi icin "Ankara Subesi Subesi" olmustu, ikinci (_Subesi) ifadesini boslukla birlikte silelim)
UPDATE calisanlar3
SET sehir = SUBSTRING(sehir,1, LENGTH(sehir)-7) --sehir degerlerinin=> [1.index ve sondan 7.(-) indexe kadar olan karakterlerini] getirir 
WHERE isyeri='Vakko' 							--[] bunun disindakileri siler

SELECT * FROM calisanlar3;

--NOTE:
--SUBSTRING Fonksiyonu: 
--ilk parametreyi alır, ikinci parametrede verilen rakama göre hangi karakterden başlayacağını ve
--son parametreye göre de kaç karakter döndüreceğini anlar. --> 1.indexten baslar -7.indexe kadarini alir
--ilk baslangic index girilirse sadece, burdan baslayip sonuna kadar yazdirir

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.
SELECT word, SUBSTRING(word, 1,2) FROM words;

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) 2.indexten itibaren kalanini görüntüleyiniz.
SELECT word, SUBSTRING(word,2) FROM words;


--INITCAP: ilk harfi buyuk yapar-Tumce duzeni

--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.
SELECT INITCAP(word) FROM words;


----40-FETCH NEXT (sayi) ROW ONLY - OFFSET-----------------------------------------------------------------------------------
-- FETCH NEXT n ROW ONLY  : sadece sıradaki ilk n satırı getirir
--                LIMIT n : sadece sır adaki ilk n satırı getirir
--                OFFSET n: n satırı atlayıp sonrakileri getirir

--fetch next = Limit ayni fonks. 

--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.
SELECT * 
FROM developers
LIMIT 3;
----aynisi 
SELECT*
FROM developers
FETCH NEXT 3 ROW ONLY; --Ilk 3 kaydi getir dedik

--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.
SELECT * 
FROM developers
OFFSET 2 ROW--ROW zorunlu değil
FETCH NEXT 3 ROW ONLY;
-------
SELECT * 
FROM developers
OFFSET 2 ROW--ROW zorunlu değil
LIMIT 3;

--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.
SELECT * 
FROM developers
ORDER BY salary ASC
LIMIT 3;

--NOTE: LIMIT Fonks: terminate-sonlandirici fonk denir, bu fonks dan sonra code yazilmaz, haliyle sonda olmalidir

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.
SELECT*
FROM developers
ORDER BY salary DESC 	--buyukten-kucuge siraladik
OFFSET 1 				--ilk kaydi atla 
LIMIT 					--kalanlar icinden ilkini getir dedik


--41-ALTER TABLE:tabloyu güncellemek için kullanılır:DDL----------------------------------------------------------------
		/*
		add column ==> yeni sutun ekler
		drop column ==> mevcut olan sutunu siler
		rename column.. to.. ==> sutunun ismini degistirir      
		rename.. to.. ==> tablonun ismini degistirir*/


--calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.
ALTER TABLE calisanlar3
ADD COLUMN yas INT; -- yeni ekeldigimiz yas sutununda default deger [Null] gorunur


--calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun
ALTER TABLE calisanlar3
ADD COLUMN remote BOOLEAN DEFAULT TRUE; -- Boolean Data Type'inda yeni ekledigimiz sutuna DEFAULT Degerini True atadik

ALTER TABLE calisanlar3
DROP COLUMN yas; 		-- mevcut bir sutunu cikarmis olduk


--calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.
ALTER TABLE calisanlar3
ALTER COLUMN maas TYPE REAL

--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.
ALTER TABLE calisanlar3
RENAME COLUMN maas TO gelir;

SELECT*FROM calisanlar3;

--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.
ALTER TABLE calisanlar3
RENAME TO employees; --tablo ismi degistirildi. Select ile gorunturken artik yeni isim kullanilir

SELECT*FROM employees;

--employees tablosunda id sütunun data tipini varchar olarak güncelleyiniz.
ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20)

--employees tablosunda id sütunun data tipini INT olarak güncelleyiniz.
ALTER TABLE employees
ALTER COLUMN id TYPE INT USING id::INT
	--id DATA TYPE varchar ==> INT'e cevir dedik; fakat SQL de buna hemen izin vermez
	--(USING sutunName::DATA TYPE )==> ile casting islemini onalladigimizi SQL'e soyleriz

SELECT*FROM employees;

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.
ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL 
							   
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
	

--sirketler tablosunda sirket_id sütununa PRIMARY KEY constrainti ekleyiniz.
SELECT * FROM sirketler;

ALTER TABLE sirketler
ADD PRIMARY KEY(sirket_id)

--sirketler tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.
ALTER TABLE sirketler
ADD UNIQUE(sirket_isim)

-- veya Constraint de isimlendirme yapilabilir; isim verilmezse sutun ismini default olarak kullanir==>constraintler seklemsinde isim gorunur
ALTER TABLE sirketler
ADD ConstNameEkle UNIQUE(sirket_isim)

--NOTE: FK eklemek icin diger tablodaki ile ortak olan (Pk) olarak isaretlenmis sutun ile esitlenmelidir, 
		--degeri NUll olan fk degerlerini silip fk olusturulabilir

--siparis tablosunda sirket_id sütununa FK constrainti ekleyiniz. 
	-->Siparsi ve Sirketler taplolari sirket_id ortak sutunu sayesinde iliskili idi
ALTER TABLE siparis
ADD FOREIGN KEY(sirket_id) REFERENCES sirketler(sirket_id)
		--(ERROR:  Key (sirket_id)=(104) is not present in table
		-- "sirketler".insert or update on table "siparis" violates foreign key constraint "siparis_sirket_id_fkey" )

DELETE FROM siparis WHERE sirket_id IN (104,105) --eslesmeyen kayitlar ilk olark silinir sonra FK ile refere edilir

SELECT * FROM siparis

--siparis tablosundaki FK constrainti kaldırınız.
ALTER TABLE siparis
DROP CONSTRAINT siparis_sirket_id_fkey 
		--yukarda bu const eklerken isim vermedigimiz icin burada Default ismi kullandik silmek icin
		--diger const de ayni sekilde yapilir
		
--employees tablosunda isim sütununda NOT NULL constraintini kaldırınız.-Const degil idi
ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL


--42-TRANSACTION   : databasede en küçük işlem birimi ------------------------------------------------------------------------------
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
--Bir bank hesabindan digerine 1000tl gonderilecegi bir senaryo icin;
--Gonderici hesaptan -1000tl eksilir, alici hesapta +1000tl artar

UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
-------sistemde hata oluşur ise;
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
-------veriler tutarsız olur
--yani gonderici hesaptan 1000tl cikar fakat alici hesaba ulasmadan arada kalir, 

--bu durumda ikinci UPDATE islemi gerceklesemedigi icin birinci UPDATE de iptal olmali(transac biz yonetmezsek yapmaz)
--ve islem geri alinmali otomatik olarak 1000tl ciktigi hesaba geri donmeli
--*****birbirime bagli UPDATE islemlerinde TRANSACTION'i biz yonetmeliyiz

SELECT * FROM hesaplar;



-------------------Negative Senario------------------------------
BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM hesaplar;

	SAVEPOINT x; 	--x adinda bir savepoint olusturulur, guvenlik icin asagidaki kodlarda bir hata olursa ROLLBACK ile buraya x noktasina islemi basa dondurur

--try{
	UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemde hata oluştu, --veriler tutarsız
--catch bloğuna git -->
	UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--bu işlem başarısız
	COMMIT;

--}catch(hata){
	ROLLBACK TO x; --> SAVEPOINT x; basa don
--}



-----------------------------Pozitive Senario----------------------
BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM hesaplar;

	SAVEPOINT x;
--try{
	UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı

	UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı

	COMMIT;

--}catch(hata){
	ROLLBACK TO x;
--}
























