-------------------------------DATA SSCIENCE SQL LESSONS-------------------------------
-------------------------------PAGE: Blue Page: PRACTICES------------------------------

											--Date: 28 may 2024 Tuesday (-Monday holiday)
											--Section: 5 
---------------------------------------------------------------------------------------

-- TEAM LEAD: 
-- "Bana şirketimizde çalışan bütün elemanların listesini döker misiniz?
--  Türkçesi: "PERSONEL tablosundaki bütün kayıtları bütün alanlarıyla birlikte listele"

SELECT * FROM personel


--Team LEAD:
-- Şirketimizde çalışan bütün elemanların ad, soyad ve maaş bilgilerine ihtiyacım var. 
-- Bu listeyi bana getirebilir misiniz?

SELECT ad, soyad, maas FROM personel



--Team LEAD:
-- Şimdiye kadar en az bir sipariş vermiş olan müşterilerin ID'lerinin listesini istiyorum. 

SELECT musteri_id FROM siparis  -- tüm listeyi getirir
SELECT DISTINCT  musteri_id FROM siparis  --UNIQUE olaak listeler


--Team LEAD:
-- Şirketimize ilk siparişi vermiş olan müşterimize küçük bir ödül vermek istiyorum. 
-- Bana söz konusu müşterinin ID’sini bulabilir misiniz?

SELECT * FROM siparis 

SELECT musteri_id AS musteri
FROM siparis 
ORDER BY id 
LIMIT 1;




--------------------------------PAGE: Blue Page: PRACTICES----------------------------------------
																	--Date: 29 may 2024 Wednesday
																	--Section: 6


SELECT * FROM personel

/*-- TEAM LEAD: 
Çocuklar; elemanların adını, soyadını ve maaşını listelediğiniz ekranda 
küçük bir değişiklik istiyorum. Ad sütunununbaşlığı ‘A’, 
soyad sütununun başlığı ise ‘S’ olsun. Maaş sütununun başlığı 
yine ‘MAAŞ’ olarak kalabilir. 
*/
SELECT  
	ad AS a,
	soyad AS s,
	maas
FROM personel

--NOT: çift tırnak field isimlerini, tek tırnak value ları belirlemek için kullanılır
-- a ve s harflerini büyük harf yapmak için alttaki gibi "" cift tirnak ile kullanılailbir
SELECT  
	ad AS "A",
	soyad AS "S",
	maas
FROM personel



-----------------WHERE:

--Team LEAD: 
--İsmi Mehmet olan bütün şirket çalışanlarının listesini istiyorum. 
SELECT * 
FROM personel p 
WHERE ad = 'Mehmet'



-- TEAM LEAD: 
-- 1 Kasım 1978 tarihinde doğmuş olan bütün çalışanların ad, soyad ve doğum günü bilgilerini istiyorum.  
--  DAte formatı: yyyy-mm-dd

SELECT ad,soyad,dogum
FROM personel p
WHERE dogum = '1978-11-01'



-------------- AND Operators:

-- TEAM LEAD: 
-- Mehmet Ozman adlı çalışanımızın bütün özlük bilgilerini istiyorum.

SELECT *
FROM personel p 
WHERE ad = 'Mehmet'
AND soyad = 'Ozman'





						

---------------------------------PAGE: Blue Page: PRACTICES-----------------------------------------
																		--Date: 30 may 2024 Thursday
																		--Section: 7

-----------WHERE:


 

-- TEAM LEAD: 
--Şirketimizde çalışıp, adı Mehmet veya Dilek olan kişilerin tam listesini istiyorum.
SELECT * 
FROM personel 
WHERE ad = 'Mehmet'
OR ad = 'Dilek'


-- TEAM LEAD: 
-- Adı Mehmet veya Dilek olan ve maaş 1400 TL'nin üzerinde olan çalışanların listesini istiyorum.
SELECT *
FROM personel p 
WHERE 
	(ad = 'Mehmet' OR ad = 'Dilek') 
	AND maas > 1400
	
	
--TEAM Lead:
/* Maaşı 1000  ile 2000  arasında olan bütün çalışanların 
 * id, ad, soyad ve maaş bilgilerini istiyorum. 
 * Liste maaş tutarına göre sıralanmış olsun. 
 * */
SELECT id,ad, soyad,maas
FROM personel p 
WHERE maas
BETWEEN 1000 AND 2000
ORDER BY maas


-- TEAM LEAD: 
-- 1978 yılında doğmuş bütün çalışanların ad, soyad ve doğum günü bilgilerini istiyorum. 
SELECT ad, soyad, dogum
FROM personel p 
WHERE dogum 
BETWEEN '1978-01-01' AND '1978-12-31'


-- TEAM LEAD: 
-- bana her bir çalışanın ID’sini, adını, soyadını ve Marduk geldiğinde
-- (21 aralık 2012)kaç gündür yaşıyor olacağını içeren bir liste hazırlar mısınız?
SELECT id, ad, soyad,
('2012-12-21' - dogum) 
AS gunfarki
FROM personel p 



--------------- IN:

-- TEAM LEAD: 
-- - İsmi Mehmet, Dilek veya Cengiz olan bütün çalışanları listeleyin. Liste ad ve soyada göre sıralanmış olsun.
SELECT *
FROM personel
WHERE ad IN('Mehmet','Dilek','Cengiz')
ORDER BY ad, soyad;

--LIKE örneği
SELECT *
FROM personel
WHERE soyad LIKE '%oğlu'

-- Count örnegi
-- şirkette çalışan kişi sayısı

SELECT count(*)AS toplam  --count(id) olarak da yazabilirdik
FROM personel p 

-- SUM örneği
-- Toplam maaş ödemesi ne kadar olacak

SELECT SUM(maas) AS toplam_maas
FROM personel p 

-- TEAM LEAD: 
-- İsmi Mehmet Olan elemanlar toplam kaç TL maaş alıyor?

SELECT SUM(maas) AS toplam_mehmet_maas
FROM personel p 
WHERE ad = 'Mehmet'

SELECT *
FROM personel p


-- TEAM LEAD: 
-- Muhasebe departmanında bu ay toplam TL maaş ödemesi yapılacak?
--bu soruyu 2 aşamada çözeceğiz.

--ilk olrak muhasebenin departman id sini bulalım
SELECT id
FROM departman d 
WHERE ad = 'Muhasebe';

-- ikinci aşamada departman id ye göre hesap yapacağız
SELECT sum(maas) AS toplam_muh_maas 
FROM personel p 
WHERE departman_id = 1





--------------------------------PAGE: Blue Page: PRACTICES--------------------------------------------
																			--Date: 31 may 2024 Friday
																			--Section: 8


---------------------SUM:

--Team LEAD: Her bir (each) departmana toplam kaç TL maaş ödeyeceğiz?
SELECT * FROM personel p 

SELECT departman_id, 
SUM(maas) AS toplam_departm_maas 
FROM personel p 
GROUP BY departman_id

----------------------AVG:

--Team LEAD: Her bir (each) departmana ortalama kaç TL maaş ödeyeceğiz?
SELECT departman_id, 
AVG(maas) AS ort_departm_maas 
FROM personel p 
GROUP BY departman_id


----------------------ROUND:

--virgülden sonra 0 hane
SELECT departman_id, 
ROUND(AVG(maas)) AS ort_departm_maas 
FROM personel p 
GROUP BY departman_id

--virgülden sonra 2 hane
SELECT departman_id, 
ROUND(AVG(maas),2) AS ort_departm_maas 
FROM personel p 
GROUP BY departman_id


---------------------MIN-MAX:

-- Şirketimizde en yüksek maaşı alan kişi kaç TL alıyor?
SELECT max(maas) AS max_maas 
FROM personel p 

--Şirketimizde ödenen en yüksek maaş ile en düşük maaş arasındaki fark ne kadardır?
SELECT 
(MAX(maas)- MIN(maas)) 
AS maas_fark
FROM personel p 


--------------------GROUP BY:

-- herbir departmanda kaç kiş çalışıyor
SELECT 
departman_id,
count(*) AS toplam 
FROM personel p 
GROUP BY departman_id
ORDER BY departman_id 

--  çalışanlardan herbir ülkeden kaç kişi bulunuyor
SELECT 
	ulke_id,
	count(*) AS kisi_sayisi 
FROM personel p 
GROUP BY ulke_id 
ORDER BY count(*)




--------------------------------PAGE: Blue Page: PRACTICES-----------------------------------------------
																			--Date: 01 June 2024 saturday
																			--Section: 9








