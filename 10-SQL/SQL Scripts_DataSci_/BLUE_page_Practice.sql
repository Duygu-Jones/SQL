-------------------------------DATA SSCIENCE SQL LESSONS-------------------------------
-------------------------------PAGE: Blue Page: PRACTICES------------------------------

											--Date: 28 may 2024 Tuesday (-Monday holiday)
											--Section: 5 | Day-5
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












----------------------------PAGE: Blue Page: PRACTICES-----------------------------------
															--Date: 29 may 2024 Wednesday
															--Section: 6






						

----------------------------PAGE: Blue Page: PRACTICES-----------------------------------
															--Date: 30 may 2024 Thursday
															--Section: 7





---------------------------PAGE: Blue Page: PRACTICES-----------------------------------
															--Date: 31 may 2024 Friday
															--Section: 8










