/*
TRIM(Sütun parametresi) string ifadenin başındaki ve sonundaki boşluk karakterlerini siler


LTRIM sadece soldan boşluk siler
RTRIM sadece sağdan boşluk siler

REPLACE(sütun,'değişecek ifade','yeni ifade') belirtilen ifadeyi o sütunda bulursa, belirlediğiniz yeni ifade ile değiştirir
bir değişiklik yaptığı için UPDATE ile kullanılır

CONCAT(sütunadı, 'string') iki veya daha fazla dizeyi birleştirme işlemi için kullanılır

SUBSTRING(sütun adı,başlangıç index,bitiş index) o sütunda belirtilen index aralığındaki string değerini verir
istediğimiz bir sütunda stringlerin istediğimiz kısımlarını değiştirebiliriz. Tek index ilede çalışır belirtilen kısımdan 
en sona kadar alır

UPPER (sütun adı) o sütundaki strng değerleri büyük harfle getirir 

LOWER (sütun adı) o sütundaki strn değerleri küçük harfle getirir 

INITCAP(sütun adı) o sütundaki her bir satırdaki stringlerin baş harfini büyük harf yapar


LENGTH(sütun adı) belirtilen sütundaki her satır içinde bulunan stringlerin uzunluklarını alır 

REVERSE(sütun adı) sütunu ters çevirir

LEFT() / RIGHT() (Başlangıç ve Son Karakterler): Bir dizinin başlangıç veya sonundaki belirli karakterleri alır.
LEFT(sütun, 3) ilk 3 karakteri alır RIGHT olsa son 3 karakteri alırdı

--FETCH NEXT n ROW ONLY: sadece sıradaki ilk n satırı getirir
--                LIMIT n : sadece sıradaki ilk n satırı getirir
--                OFFSET n : n satırı atlayıp sonrakileri getirir


*/