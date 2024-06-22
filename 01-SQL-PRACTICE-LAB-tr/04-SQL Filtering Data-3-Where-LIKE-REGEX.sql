-----------------------------: REGEX - LIKE WILDCARD :------------------------

		
		--	LIKE: Belirli kalıpları kullanarak sorgulama yapmamızı sağlar.
		--	ILIKE: Kalıpları büyük/küçük harf duyarsız olarak eşleştirir.

-- SYMBOLS:
		--	LIKE = ~~
		--	ILIKE = ~~*
		--	NOT LIKE = !~~
		--	NOT ILIKE = !~~*
		
		--  REGEXP_LIKE = ~
		--  REGEXP_LIKE = ~*
		--	NOT REGEXP_LIKE = !~
		--	NOT REGEXP_LIKE = !~*


--LIKE / ILIKE Koşulu:-------------------------------------------------------
--WHERE koşulundan sonra kullanılır,
--Belirli karakter dizilerini (kalıpları) kullanarak sorguları filtrelememizi sağlar.
--Tablo içinde arama yapmak ve istenen değişkenleri bulmak için kullanılır, aramayı daraltır.

--Kullanılan SYMBOLS: 
		--WILDCARD  (%) : Joker sembolü % sıfır veya daha fazla karakteri temsil eder.
		--UnderScore(_) : Alt çizgi _ tek bir karakteri temsil eder.
						
			 --Kullanım:
				-- 'A%n' == 'A....n' ==> A ile başlayıp n ile biten isimleri bulur.
				-- 'A%' ==> 'A....'
				-- '%A' ==> ... +A 
				-- '%e%' ==> ...+ e + ...
				-- '%e%a%' => ...+ e +... a 
				-- veya
				-- '%a%e%' => ... + a ... + e + ...
				-- '%an%' ==> 'an' hecesini içeren kelimeleri bulur.
				-- '__v_' ==> 3. harfi v olan 4 harfli kelime
				-- '__v%' ==> 3. harfi v olan kelimeler


--REGEXP_LIKE(~): ---------------------------------------------------------------------------------------------------------
	--REGEXP_LIKE => Daha karmaşık sorgular için bir dizede herhangi bir metni veya kodu aramamızı sağlar,
			--kendi sözdizimini kullanarak.
			--PostgreSQL'de REGEXP_LIKE '~' karakteri ile kullanılır.
	
	-- Kullanılan SYMBOLSv:
		
		-- (~) : Büyük/küçük harf duyarlı REGEXP_LIKE için
		-- (~*): Büyük/küçük harf duyarsız REGEXP_LIKE için
				--Regex'i büyük/küçük harf duyarsız yapmak için ~ sembolünden sonra * ekleyin (aksi belirtilmedikçe varsayılan).
		
		-- [] : Köşeli parantezler; içlerinde bulunan herhangi bir karakteri temsil eder.
				--[abcd] a, b, c veya d karakterlerinden herhangi birini temsil eder.
				--[a-z] a'dan z'ye olan alfabetik aralıkta herhangi bir karakteri temsil eder.
		
		-- (^) : Bir dizenin başlangıcını temsil eder.
		-- ($) : Bir dizenin sonunu temsil eder.
		
		-- (.*): DotStar: 0 veya daha fazla karakteri temsil eder --> İstenirse parantez () ile kullanılabilir.
	    -- (.) : Dot: Tam olarak bir karakteri temsil eder --> İstenirse parantez () ile kullanılabilir.
		
		--NOT LIKE : Verilen kalıpla eşleşmeyen dizeleri filtreler --> Büyük/küçük harf duyarlı
		--NOT ILIKE: Verilen kalıpla eşleşmeyen dizeleri filtreler --> Büyük/küçük harf duyarsız
		-- (!~) : Verilen kalıpla eşleşmeyen dizeleri filtreler --> Büyük/küçük harf duyarlı
		-- (!~*) : Verilen kalıpla eşleşmeyen dizeleri filtreler --> Büyük/küçük harf duyarsız

------------------------: TABLE CREATION :--------------------------

-- 'Electronics' tablosunu oluştur
CREATE TABLE Electronics (
    ProductID SERIAL PRIMARY KEY, -- Otomatik artan birincil anahtar
    ProductName VARCHAR(255) NOT NULL, -- Ürün adı, boş olamaz
    Category VARCHAR(255), -- Ürünün kategorisi
    Price REAL -- Ürünün fiyatı
);

-- 'Electronics' tablosuna veri ekle
INSERT INTO Electronics (ProductName, Category, Price) VALUES
('Apple iPhone 12', 'Smartphones', 799.99),
('Samsung Galaxy S21', 'Smartphones', 699.99),
('Sony WH-1000XM4', 'Headphones', 349.99),
('Apple MacBook Pro', 'Laptops', 1299.99),
('Dell XPS 13', 'Laptops', 999.99),
('Logitech Mouse', 'Accessories', 29.99),
('HP Envy 13', 'Laptops', 899.99),
('Apple AirPods', 'Accessories', 199.99),
('Samsung Galaxy Buds', 'Accessories', 149.99);



------------------------: PRACTICES :--------------------------

-- Elektronik tablosunu görüntüle
SELECT * FROM electronics;

--  1: LIKE 
-- Soru: ProductName 'Apple' ile başlayan tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName LIKE 'Apple%';

--  2: ILIKE 
-- Soru: ProductName 'galaxy' kelimesini büyük/küçük harf duyarsız olarak içeren tüm ürünleri Electronics tablosundan getir.
-- NOT: ILIKE, büyük/küçük harf duyarsız kalıp eşleştirme için kullanılır.
SELECT *
FROM Electronics
WHERE ProductName ILIKE '%galaxy%';

--  3: NOT LIKE 
-- Soru: ProductName 'Apple' kelimesini içermeyen tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName NOT LIKE '%Apple%';

--  4: NOT ILIKE 
-- Soru: ProductName 'galaxy' kelimesini büyük/küçük harf duyarsız olarak içermeyen tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName NOT ILIKE '%galaxy%';

--  5: REGEXP_LIKE 
-- Soru: ProductName 'Pro' kelimesini düzenli ifadeler kullanarak içeren tüm ürünleri Electronics tablosundan getir.
-- NOT: REGEXP_LIKE, düzenli ifade kalıp eşleştirme için kullanılır.
SELECT *
FROM Electronics
WHERE ProductName ~ 'Pro';

--  6: NOT REGEXP_LIKE 
-- Soru: ProductName 'Pro' kelimesini düzenli ifadeler kullanarak içermeyen tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName !~ 'Pro';

--  7: Joker karakter % 
-- Soru: ProductName '13' ile biten tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName LIKE '%13';

--  8: Joker karakter (_)
-- Soru: ProductName ikinci karakteri 'a' olan tüm ürünleri Electronics tablosundan getir.
-- NOT: _ (alt çizgi) tek bir karakteri temsil eder.
SELECT *
FROM Electronics
WHERE ProductName LIKE '_a%';

--  9: REGEXP_LIKE ve []
-- Soru: ProductName bir rakam (0-9) içeren tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName ~ '[0-9]';

--  10: REGEXP_LIKE ve başlangıç (^) ve bitiş ($)
-- Soru: ProductName 'Apple' ile başlayıp bir rakamla biten tüm ürünleri Electronics tablosundan getir.
SELECT *
FROM Electronics
WHERE ProductName ~ '^Apple.*[0-9]$';



------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM Electronics WHERE EXISTS (SELECT 1 FROM Electronics);

-- Tabloları silin.
DROP TABLE IF EXISTS Electronics CASCADE;
