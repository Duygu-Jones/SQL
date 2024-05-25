----------------------------------------DAY'7-------------------------------------------------------------------------------------

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

--ORNEKLER
--iki tablodaki şirket id'si AYNI olanların şirket id, şirket ismi,
--sipariş tarihini,sipariş id'sini  listeleyiniz.

SELECT sirketler.sirket_id, sirket_isim,siparis_id,siparis_tarihi --ortak olan sutunun ait oldugu tabloyu belirt
FROM sirketler
INNER JOIN siparis  							--INNER ILE sadece ORTAK olan kayitlari GORUNTULEMEMIZ saglar
ON sirketler.sirket_id=siparis.sirket_id 		--Hangi sutun uzerinden birlestirme yapacagimizi soyler
	
	--iki tablo birlestirildi artik, ikinci tablodan istenen (sirket_isim,siparis_id,siparis_tarihi) ni de SELECT yapabiliriz
	--INNER JOIN ile ortak sutun uzerinden tablolari birlestirdik
	--INNER JOIN ortak kayitlari birlstirdihi icin tablo sirasi onemsizdir

--34-LEFT JOIN:-----------------------------------------------------------------------------------
			--SADECE Sol tablodaki(ilk) tüm verileri getirir. ==> SOLUNDA KALAN/ILK tablo dur
			--Tablo sirasi onemlidir

--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş id'sini  listeleyiniz.      
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler LEFT JOIN siparis		--soldaki yani ilk tablo olan sirketlerin kayitlarini getirir
ON sirketler.sirket_id=siparis.sirket_id   

--34-RIGHT JOIN:----------------------------------------------------------------------------------
  			--Sağ tablodaki(ikinci tablodaki) tüm verileri getirir
			--Tablo sirasi onemlidir

--siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    
SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler RIGHT JOIN siparis	--sagindaki yani ikinci tablo olan "siparis" tablosunun kayitlarini GETIRIR-select ile
ON sirketler.sirket_id=siparis.sirket_id 

--****************************
--NOTE: LEFT ve RIGHT JOIN i tablo sırasını değiştirerek birbirinin yerine kullanılabilir.
		--**** bu iki sorgu sonucuda aynidir, tablo yerlerini degistirip, left veya right kullanilarak 
		--tablonun nerede oldugunun bir onemi kalmaz--sonuc olarak iki tabloda birlestirilmis olur 
		--tek bir tabloyla islem yapilir gibi olur
--****************************		

--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş id'sini  listeleyiniz. 
SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi--istedigimiz sutunlari gosterir/
FROM sirketler RIGHT JOIN siparis									--diger tabloda olmayan variable lar var ise NULL olarak gorunur
ON sirketler.sirket_id=siparis.sirket_id  
-----
SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi --istedigimiz sutunlari gosterir
FROM siparis LEFT JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id 
--****************************

--35-FULL JOIN:----------------------------------------------------------------------------------
			--iki tablodaki baz alınan sütundaki tüm kayıtları getirir.
			
--her iki tablodaki tüm kayıtların tüm bilgilerini listeleyiniz.
	--her iki tablodaki butun sutunlari secmek icin;
SELECT sirketler.sirket_id AS sirketler_id, --sirketlere ait tum sutunlar
		sirket_isim,
		siparis.sirket_id AS siparis_sirket_id,--siparislere ait tum sutunlar
		siparis_id,siparis_tarihi
FROM sirketler FULL JOIN siparis 	--tablo sirasi onemli degil
ON sirketler.sirket_id=siparis.sirket_id; --ortak sutun uzerinden birlestir

------ayni islem kisa yolu; tumunu secmek icin * all
SELECT * 					
FROM siparis FULL JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id;


-----------------TABLA personeller-----------------------
CREATE TABLE personeller  (
id int,					--yoneticinin kendi id'si
isim varchar(20),  		
title varchar(60), 		
yonetici_id int 		--personelin yonetici id'si
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null); --CEO, kendisi top yonetici, yoneticisi yok NULL

SELECT * FROM personeller;

--36-SELF JOIN : ----------------------------------------------------------------
			--tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 

--herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.
SELECT p.isim AS personel, y.isim AS yonetici  --4-son adim; her bir field'i p ve y ile ayirdik->hangisinin field'i oldugunu soyledik
FROM personeller AS p 				--TABLO		--1-ayni tabloda personelleri p ile adlandirildi 
INNER JOIN personeller AS y		--ICINDE		--2-ayni taboldaki yoneticileri y olarak adladirildi 
ON p.yonetici_id=y.id;		--TABLO				--3-ve bu iki tanimin ortak sutunlari uzerinden tekrardan birlestir dedik 

--****bu iki tabla ayirili ayri olusturulabilir, calisan personel ve yoneticiler seklinde iki tablo var aslinda, 
--**calisanlar birbrilerinin yoneticisi==> id leri bu yuzden ortak

--personel-yonetici isimleri
SELECT p.isim AS personel,y.isim AS yonetici
FROM personeller AS p
INNER JOIN personeller AS y
ON y.id=p.yonetici_id

---------personel once gosterimi
SELECT p.id p_id, p.isim p_isim,p.title p_title,
	   y.isim yoneticisi,y.title y_title,y.id y_id
FROM personeller AS p
INNER JOIN personeller AS y
ON y.id=p.yonetici_id

---------yonetici once gosterimi
SELECT y.id y_id, y.isim y_isim,y.title y_title,
		p.isim p_isim,p.title p_title
FROM personeller AS y
INNER JOIN personeller AS p
ON y.id=p.yonetici_id



--37--LIKE Conditions:------------------------------------------------------------------------------------------------------
		
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


--LIKE / ILIKE  Cond.:--------------------------------------------------------------------------------------------------------
--WHERE komutundan sonra kullanılır, 
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
				 
 
--TABLE developers kullanalim-------------------------------------------------------------------
--developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.

SELECT name, LENGTH(name)
FROM developers --"Ayse Han" degerininin sonunda bosluk-space var
--------
UPDATE developers
SET name= TRIM(name) --kelimelerin basindan ve sonundan bosluklari siler ve set eder

SELECT * FROM developers; --tablomuz harf aratmaya hazirdir

--tablodan 'Enes Can' goruntuleyin
SELECT * FROM developers WHERE name='Enes Can'
------------------------------------------------------------------------------------------------

--LIKE:-----------------------------------------------------------------------------------------
	--LIKE '%' isareti ile gosterilir
	-- CASE SENSITIVE dir. karakteri oldugu gibi arar. 


--ORN: isim 'E' ile basliyor devamini getir, 0 veya daha fazla karakter gelebilir;
SELECT * 
FROM developers 
WHERE name LIKE 'E%' --> "E gibi biseydi ama devamini sen getir", dedik -E iceren degerleri getirir==>desen cizmis olduk


--ILIKE:----------------------------------------------------------------------------------------
		--LIKE gibi ancak CASE IN-SENSITIVE dir.
		--wildcard(joker-%): joker dedigimiz % isareti==> 0 veya daha fazla karakteri temsil eder.  

--ORN: buyuk/kucuk harf belirsiz 'E/e' harfi ile baslayan kayit getir;
SELECT * 
FROM developers 
WHERE name ILIKE 'e%' --> ILIKE: case IN-sensitive, kucuk/buyuk harf farketmeksizin e iceren getirir
-----ayni
SELECT * 
FROM developers 
WHERE name ILIKE 'E%'

--ORN: a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin
SELECT name,city
FROM developers
WHERE city ILIKE '%A' -->//Ankara, Bursa getirdi
		
		--------------------------------------------------------------------

--ORN: Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
SELECT name,salary
FROM developers
WHERE name LIKE 'T%n' -->'T....n' veya 'Tn' demek

--ORN: Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin -- '...an...'
SELECT name,salary
FROM developers
WHERE name LIKE '%an%' 

--ORN: Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin  --sirasi onemsiz
	--AND ile
SELECT *
FROM developers
WHERE name LIKE '%e%'AND name LIKE '%a%' -->'Hande', 'Kemal'

	-- OR ile (aynisi)
SELECT *
FROM developers
WHERE name LIKE '%e%a%' OR name LIKE '%a%e%' -->'Hande', 'Kemal'


-- NOTE: underScore: (_) 'alt_tire' tek bir karakteri temsil eder!!!!

--ORN:'al..' kelimenin cogunlugunu hatirliyorum sadece 1 harfi hatilayamiyorum; 
SELECT*
FROM developers
WHERE name ILIKE 'al_'  --> 'Ali' getirir

--Isminin ikinci harfi u olan devlerin tum bilgilerini yazdiran QUERY yazin--> '_u....' gibi
SELECT *
FROM developers
WHERE name LIKE '_u%' --> 'Kubra'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin
								--> prog_lang '__v_'  gelecek karakter sayisi kesin ise _ adeti kadar kullanilir
SELECT *
FROM developers
WHERE prog_lang LIKE '__v_'  -->// 'java' 

--eger '__v%'  eger % girilirse sonrasinda karakterler gelebilir bu durumda 'JavaScript' kayitlari gelir:) 


---**********ODEV*******************
--1-Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.
SELECT *
FROM developers
WHERE prog_lang ILIKE 'J____%'

--HINT:sadece JavaScript olacak??? 

--2-Isminin 2. harfi e,  4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. 
SELECT*
FROM developers
WHERE name ILIKE '_e_y%'

--3-ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin
SELECT*
FROM developers
WHERE name ILIKE '%_%'

---*********************************


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


--38-REGEXP_LIKE(~): ---------------------------------------------------------------------------------------------------------
	--REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
			--veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
			--(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
	
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
				


--ORNEKLER
--h harfinden sonra a veya i harfini sonra ise t harfini --> '?h a?i ?t'
	--içeren kelimelerin TUM bilgilerini yazdiran QUERY yaziniz.
	 -->('h' harfi digerlerine gore basta; devaminda gelecek olan harf a veya i==> biri gelecek; bunlardan sonra da t ile devam edecek)
SELECT *
FROM words
WHERE word ~ 'h[ai]t' ; --> hat,hit OLABILIR (a veya i)   --> ~ Case Sensitive regexp_like
-----------
SELECT *
FROM words
WHERE word ~* 'h[ai]t' ; --> hat,Hit,hAt,ahata OLABILIR    --> ~* Case IN-sensitive regexp_like


--NOTE: (~*) küçük/büyük harf hassasiyeti olmasın demek
--		[ - ] verilen araliktan sadece bir harfi temsil eder
--		[c-f] => d,e harflerinden biri OLABILIR gibi


--ORNEK
--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
		---> (a'dan k'ya kadar olan harflerden birisi h'den sonra, t'den once; araya gelecek) demek
SELECT *
FROM words
WHERE word ~* 'h[a-k]t';  


-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
		--> [m veya i biri olabilir] demek
		--> [m-i] ise m ile i araligindan bir harf olabilir demek
SELECT *
FROM words
WHERE word ~* '[mi]';  


--- NOTE: ^ :kelimenin başlangıcını gösterir, 
--		  $ :kelimenin bitişini gösterir


--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin --> kelime kesin a ile basliyor
	--> a ile baslayan degerleri getir dedik
SELECT *
FROM words
WHERE word ~* '^a' ; 

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
	--> [kelime a veya s ile baslayn] kayitlari getirir
SELECT *
FROM words
WHERE word ~* '^[as]'; 

--m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
	-->m' den sonra baska bir karakter yok demek SONU
SELECT *
FROM words
WHERE word ~* 'm$';

-- NOTE: (.*)--> 0 veya daha fazla karakteri temsil eder
--       (.) --> sadece 1 karakteri temsil eder 
  		        -->istenirse () parantez icinde code yazilabilir


--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~* '^y.*f$'
------------
SELECT *
FROM words
WHERE word ~* '^y(.*)f$'

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~* '^y.f$'


--NOT LIKE : verilen karakter desenine benzemeyenleri filtreler -->Case Senst.
--NOT ILIKE: verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.
--  (!~)   : verilen karakter desenine benzemeyenleri filtreler -->Case Sensit.
--  (!~*)  : verilen karakter desenine benzemeyenleri filtreler -->Case IN-Secst.


-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--1.yol: NOT LIKE-ILIKE ile;
SELECT *
FROM words 
WHERE word NOT ILIKE 'h%'

--2.yol: NOT Regex_LIKE ile; (!~*)
SELECT *
FROM words 
WHERE word !~* '^h'

--************ ÖDEV *************
--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.




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


  
  
















