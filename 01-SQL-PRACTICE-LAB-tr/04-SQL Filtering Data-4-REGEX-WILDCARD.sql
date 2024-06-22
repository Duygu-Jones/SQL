-- WILDCARD ve REGEX Kullanımları


CREATE TABLE employees2
(
id CHAR (9),
name VARCHAR(50),
state VARCHAR (50),
salary SMALLINT,
company VARCHAR (20)
);

INSERT INTO employees2 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO employees2 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO employees2 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM'); 
INSERT INTO employees2 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO employees2 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO employees2 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE'); 
INSERT INTO employees2 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM employees2;

-- WILDCARDS 
--SQL'de WILDCARDS
--LIKE Koşulu: Wildcard ile kullanılır.
--1) % yüzde işareti wildcard: sıfır veya daha fazla karakter olup olmadığını sorgular

-- %a 
-- , Sophia, Olivia, Isabella, Emma, Mia, Ava, a

-- %a% 
-- Ayşe, Fatma, Ahmet, Aslı, Canan, Melisa 

-- % -> 0 karakter veya 1 karakter herhangi bir karakter, birden fazla karakter

-- a%
-- Adam, Alexander, Aaron, Andrew, Anthony, a

-- Kısaca yorum satırı nasıl yapılır -> Ctrl+/ 
SELECT * FROM employees2;

-- 'E' ile başlayan çalışan 'name' değerlerini çağır.

SELECT Name FROM employees2 WHERE Name LIKE 'E%';

-- 'e' ile biten çalışan 'name' değerlerini çağır.
SELECT Name FROM Employees2 WHERE Name LIKE '%e';

-- 'e' harfi herhangi bir yerde olan isimleri getir

SELECT Name FROM Employees2 WHERE Name LIKE '%e%';

SELECT * FROM words

SELECT * FROM employees2;

-- 'B' ile başlayıp 't' ile biten çalışan 'name' değerlerini al
-- x alanı LIKE _wildcard ile WHERE 
SELECT Name FROM employees2 WHERE Name LIKE 'B%t';

-- isimde herhangi bir yerde 'a' harfi olan isimleri al
SELECT Name FROM employees2 WHERE Name LIKE '%a%';

-- herhangi bir yerde 'e' veya 'r' harfi olan isimleri al

SELECT Name FROM employees2 WHERE Name LIKE '%e%' OR Name LIKE '%r%';

SELECT Name FROM employees2 WHERE Name LIKE '%e%r%'; -- sıralama önemli

INSERT INTO employees2 VALUES (123456712,'xcreu','x',6000,'x');

SELECT Name FROM employees2 WHERE Name LIKE '%e%r%' OR Name LIKE '%r%e%'; 
SELECT Name FROM employees2 WHERE Name ~ 'e';

---- WILDCARD 

-- _ -> sadece bir karakter 

-- İkinci karakteri 'e' olan ve dördüncü karakteri 'n' olan eyalet değerlerini al 

SELECT State FROM employees2 WHERE State LIKE '_e_n%';

SELECT * FROM employees2;
-- sondan ikinci karakteri 'i' olan eyalet değerlerini al

SELECT State FROM employees2 WHERE State LIKE '%i_';

-- İkinci karakteri 'e' olan ve en az 6 karakter olan eyalet değerlerini al

SELECT State FROM employees2 WHERE State LIKE '_e____%';

-- ikinci karakterden sonra herhangi bir yerde 'i' harfi bulunan eyalet değerlerini al 

SELECT State FROM employees2 WHERE State LIKE '__%i%';

CREATE TABLE words
(
word_id CHAR(10) UNIQUE, 
word VARCHAR(50) NOT NULL, 
number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001,'hot', 3);
INSERT INTO words VALUES (1002,'hat', 3);
INSERT INTO words VALUES (1003,'hit', 3);
INSERT INTO words VALUES (1004,'hbt', 3);
INSERT INTO words VALUES (1008,'hct', 3); 
INSERT INTO words VALUES (1005,'adem',4);
INSERT INTO words VALUES (1006,'selena', 6);
INSERT INTO words VALUES (1007,'yusuf', 5);
INSERT INTO words VALUES (1009,'hoait', 5);
INSERT INTO words VALUES (1010,'htc', 3);
INSERT INTO words VALUES (1011,'haxxyt', 6);
SELECT * FROM words;

SELECT word FROM words WHERE word ~ 'tc';

-- sıralama önemli
--- NOT LIKE

-- içinde 'h' harfi olmayan kelime değerlerini al 

SELECT word FROM words WHERE word NOT LIKE '%h%';

-- 't' veya 'f' harfi ile biten kelime değerlerini al 
SELECT word FROM words WHERE word LIKE '%t' OR word LIKE '%f';

-- 't' veya 'f' harfi ile bitmeyen kelime değerlerini al 

SELECT word FROM words WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

-- herhangi bir karakter ile başlayan ve içinde 'a' veya 'e' harfi olmayan kelime değerlerini al 

SELECT word FROM words WHERE word NOT LIKE '_%a%' AND word NOT LIKE '_%e%';

-- 'a' veya 'e' harfi içermeyen kelime değerlerini al 
SELECT word FROM words WHERE word NOT LIKE '%a%' AND word NOT LIKE '%e%';

-- REGEX
------ Düzenli İfade Koşulu: -- REGEX 

-- ilk karakteri 'h', ikinci karakteri 'o', 'a', 'i' ve son karakteri 't' olan kelime değerlerini al

-- 1.yol 
SELECT word FROM words 
WHERE word 
LIKE 'ho%t' OR word 
LIKE 'ha%t' OR word 
LIKE 'hi%t'

-- 2.yol 
--3 harfli
SELECT word FROM words WHERE word ~ 'h[oai]t';
SELECT * FROM words 
-- ilk karakteri 'h', ikinci karakteri 'o', 'a', 'i' ve son karakteri 't' olan kelime değerlerini al, 
-- 3 harften fazla olsa bile 
SELECT word FROM words WHERE word ~ 'h[oai](.*)t';

SELECT * FROM words

INSERT INTO words VALUES (1011,'habit',5);
INSERT INTO words VALUES (1012,'ahmet',5);
INSERT INTO words VALUES (1013,'ahmetaga',8);

SELECT word FROM words WHERE word ~ 'h(.*)[oae]t';

SELECT word FROM words WHERE word ~ 'h(.*)[oae]t$';

SELECT word FROM words WHERE word ~ '^h(.*)[oae]t';

SELECT word FROM words WHERE word ~ 'h'

-- ^ -> ilk harf 
-- $ -> son harf 
-- (.*) -> herhangi bir karakter 
-- . -> _ -> bir karakter 
-- * -> % -> 0, 1, birden fazla karakter 

-- ilk karakteri 'h', son karakteri 't' ve ikinci karakteri herhangi bir karakter olan kelime değerlerini al
-- 'a' ile 'e' arasında 
SELECT word FROM words WHERE word ~ '^h[a-e](.*)t$';

-- ilk karakteri 's', 'a' veya 'y' olan kelime değerlerini al 

SELECT word FROM words WHERE word ~ '^[say]';

-- son karakteri 'm', 'a' veya 'f' olan kelime değerlerini al 

SELECT word FROM words WHERE word ~ '[maf]$'

-- ilk karakteri 's' ve son karakteri 'a' olan kelime değerlerini al 
-- 's' sadece bir karakter, bu yüzden ^ dememize gerek yok 
Select word from words where word ~ '^s(.*)a$';

--- Aşağıdaki kod çalışmayacaktır, eğer sadece bir karakter varsa köşeli parantez içine koymaya gerek yok, 
-- ortada ekstra karakterler olacaksa (.*) kullanılabilir, 
-- '^sa$'; bu regex çalışmayacaktır çünkü ortada başka karakterler olabileceğini belirtmemiz gerekir 
--HATA!!
Select word from words where word ~ '^s[a]$';
Select word from words where word ~ '^sa$';
Select word from words where word ~ '^s(.*)a$';
-- herhangi bir yerde 'a' harfi içeren kelimeleri al 

SELECT word from words where word ~ 'a';

-- ilk karakteri 'd' ile 't' arasında olan, herhangi bir karakter ile devam eden ve üçüncü karakteri 'l' olan kelime değerlerini al 
SELECT word from words where word ~ '^[d-t].l'

SELECT word from words where word ~ '^[a-e](.*)m$'; --adem
SELECT word from words where word ~ '^[a-e].e'; --adem

-- ilk karakteri 'd' ile 't' arasında olan, herhangi bir karakter ile devam eden ve dördüncü karakteri 'e' olan kelime değerlerini al 

SELECT word from words where word ~ '^[d-t]..e'

-- ilk karakteri 'r' ile 'z' arasında olan, herhangi bir karakter ile devam eden ve dördüncü karakteri 'u' olan kelime değerlerini al

SELECT word from words where word ~ '^[r-z]..u';

SELECT word from words where word ~

 '[r-z]..u';

CREATE TABLE workers3
(
id CHAR (9),
name VARCHAR (50),
state VARCHAR (50), 
salary SMALLINT, 
company VARCHAR (20)
);

INSERT INTO workers3 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO workers3 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO workers3 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM'); 
INSERT INTO workers3 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO workers3 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO workers3 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE'); 
INSERT INTO workers3 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM workers3;

-- EN
--^ köşeli parantez dışında yazılırsa, ilk harf anlamına gelir
--^ Köşeli parantez içinde yazılırsa, bu karakter dışındaki herhangi bir karakter anlamına gelir

-- 'E' ile başlayıp 'y' ile biten workers3'ten isim değerlerini alın

SELECT name FROM workers3 WHERE Name ~ '^E(.*)y$'

-- 'E' ile başlamayan ve 'y' ile bitmeyen workers2'den isim değerlerini alın
SELECT name FROM workers3 WHERE Name ~ '^[^E](.*)[^y]$';

-- 'J', 'B' veya 'E' ile başlayıp 'r' veya 't' ile biten isim değerlerini alın

SELECT name FROM workers3 WHERE Name ~ '^[JBA](.*)[rt]$'

-- 'J', 'B' veya 'E' ile başlayıp veya 'r' veya 't' ile biten isim değerlerini alın

SELECT name FROM workers3 WHERE Name ~ '^[JBE]' OR Name ~ '[rt]$'

-- 'J', 'B' veya 'E' ile başlamayan VE 'r' veya 't' ile bitmeyen isim değerlerini alın

SELECT name FROM workers3 WHERE Name ~ '^[^JBE](.*)[^rt]$';

DROP TABLE workers2

CREATE TABLE workers2
(
id CHAR (9),
name VARCHAR (50),
state VARCHAR (50), 
salary SMALLINT, 
company VARCHAR (20),
number_of_employees numeric(6)
);

INSERT INTO workers2 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM',15000); 
INSERT INTO workers2 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE',34900); 
INSERT INTO workers2 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM',903400); 
INSERT INTO workers2 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE',259000); 
INSERT INTO workers2 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT',90100); 
INSERT INTO workers2 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE',56900); 
INSERT INTO workers2 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM',45690);
INSERT INTO workers2 VALUES (123456711, 'Maks Stelon', 'Ohio', 12500, 'IBM',5790);
INSERT INTO workers2 VALUES (123456712, 'Maksim Mark', 'Ohio', 3500, 'Google',3090);
SELECT * FROM workers2;

-- herhangi bir yerde 'a' veya 'k' harfi içeren isim değerlerini al
-- Aşağıdaki kodlar aynı sonucu arar
SELECT name FROM workers2 WHERE name ~ 'a' OR name ~ 'k';  = SELECT name FROM workers2 WHERE name ~ '[ak]';

SELECT name FROM workers2 WHERE name ~ 'ak';  = SELECT name FROM workers2 WHERE name LIKE '%ak%';

SELECT name FROM workers2 WHERE name LIKE '%ak%';

SELECT name FROM workers2 WHERE name ~ '[ak]';

-- isim alanında her iki harf de bulunur ancak sıralama önemlidir
SELECT name FROM workers2 WHERE name ~ 'a(.*)k';

SELECT * FROM workers2;

-- İlk harfi 'A' ile 'F' arasında olan, ikinci harfi herhangi bir karakter olan ve üçüncü harfi 'a' olan isim değerlerini alın

SELECT name FROM workers2 WHERE name ~ '^[A-F].a'

-- üçüncü karakteri 'o' veya 'x' olan eyalet değerlerini alın

SELECT state FROM workers2 WHERE state  ~ '..[ox]'

-- Caret sembolünü kullandığımızda başlangıçtan itibaren demek
SELECT state FROM workers2 WHERE state  ~ '^..[ox]'

-- üçüncü karakteri 'o' veya 'x' olmayan eyalet değerlerini alın

SELECT state FROM workers2 WHERE state !~ '^..[ox]'

SELECT state FROM workers2 WHERE state ~ '^..[^ox]'
```