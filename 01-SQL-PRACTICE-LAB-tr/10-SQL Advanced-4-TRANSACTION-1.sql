--------------------------: TRANSACTION (İşlem) :--------------------------

-- TRANSACTION: Veritabanı işlemlerinin bir bütün olarak gerçekleştirilmesini sağlar.
-- İşlemler ya tamamen başarılı olur (COMMIT) ya da tamamen geri alınır (ROLLBACK).
-- BEGIN: Bir işlemi başlatır.
-- COMMIT: İşlemi onaylar ve kalıcı hale getirir.
-- SAVEPOINT: İşlem içinde geri dönülebilecek bir nokta belirler.
-- ROLLBACK: İşlemi geri alır.
-- ROLLBACK TO SAVEPOINT: İşlemi belirtilen savepoint noktasına kadar geri alır.
-- Transaction yönetimini biz kontrol edebilmemiz için BEGIN-COMMIT-SAVEPOINT-ROLLBACK kullanılır.

------------------------: TABLE CREATION :--------------------------

-- Mevcut 'accounts' tablosunu kontrol et ve sil.
DROP TABLE IF EXISTS accounts;


-- CREATE TABLE: 'accounts' tablosunu oluşturur.
BEGIN;
CREATE TABLE accounts (
    account_no INT UNIQUE,
    name VARCHAR(50),
    balance REAL
);
COMMIT;



-- INSERT INTO: 'accounts' tablosuna örnek veriler ekler.
BEGIN;
INSERT INTO accounts VALUES(1234, 'Harry Potter', 10000.3);
INSERT INTO accounts VALUES(5678, 'Jack Sparrow', 5000.5);
COMMIT;

SELECT * FROM accounts;

----------------------------------------------------------
-- Bir bank hesabından diğerine 1000 TL gönderileceği bir senaryo:
-- Gönderici hesaptan 1000 TL eksilir, alıcı hesapta 1000 TL artar.
-- Transaction yönetimini biz yapmazsak, sistem hatalarında veriler tutarsız olabilir.
-- Bu nedenle transaction'ı biz yönetmeliyiz.

------------------------: NEGATIVE SCENARIO :--------------------------

-- Senaryo: Gönderici hesap başarısız bir güncelleme sonucu 1000 TL kaybeder, 
--          alıcı hesapta bir değişiklik olmaz, işlemi geri al.

BEGIN;
SAVEPOINT sp; -- Kayıt noktası oluştur

-- try {
UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234; -- Gönderici hesaptan 1000 TL eksilt
UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678; -- Alıcı hesaba 1000 TL ekle (hata oluştuğunu varsayalım)

-- } catch (hata) {
ROLLBACK TO sp; -- Hata oluştuğunda işlemi kayıt noktasına kadar geri al
-- }
COMMIT; -- İşlemi sonlandır


SELECT * FROM accounts; -- Hesap bakiyelerini kontrol et

------------------------: POSITIVE SCENARIO :--------------------------

-- Senaryo: Gönderici hesaptan 1000 TL eksilir ve alıcı hesaba başarılı bir şekilde 1000 TL eklenir.

BEGIN;
SAVEPOINT sp; -- Kayıt noktası oluştur

-- try {
UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234; -- Gönderici hesaptan 1000 TL eksilt
UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678; -- Alıcı hesaba 1000 TL ekle
COMMIT; -- İşlemi onayla ve sonlandır

-- } catch (hata) {
ROLLBACK TO sp; -- Hata durumunda işlemi geri al
-- }


SELECT * FROM accounts; -- Hesap bakiyelerini kontrol et

------------------------: ADDITIONAL PRACTICE :--------------------------

-- 1. Gönderici hesabın bakiyesinin yeterli olup olmadığını kontrol edin ve işlem yapın. 
-- Eğer yeterli değilse işlemi geri alın.
BEGIN;
SAVEPOINT sp; -- Kayıt noktası oluştur

IF (SELECT balance FROM accounts WHERE account_no = 1234) >= 1000 THEN
    -- try {
    UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234;
    UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678;
    COMMIT;
   
    -- } catch (hata) {
    ROLLBACK TO sp; -- Hata durumunda işlemi geri al
    -- }    
ELSE
    ROLLBACK;
END IF;
SELECT * FROM accounts;

-------------------------------------------------------------------------------------------

-- 2. Alıcı hesap yerine yanlış bir hesaba para gönderme senaryosu ve işlemi geri alma.
BEGIN;
SAVEPOINT sp; -- Kayıt noktası oluştur

-- try {
UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234;
UPDATE accounts SET balance = balance + 1000 WHERE account_no = 9999; -- Yanlış hesap numarası

-- } catch (hata) {
ROLLBACK TO sp; -- Hata durumunda işlemi geri al
-- }
COMMIT;


SELECT * FROM accounts;

--------------------------------------------------------------------------------------


-- 3. Birden fazla savepoint kullanarak işlemi yönetme ve geri alma.
BEGIN;
SAVEPOINT sp1; -- Kayıt noktası oluştur

-- try {
UPDATE accounts SET balance = balance - 500 WHERE account_no = 1234;

SAVEPOINT sp2; -- İkinci kayıt noktası oluştur
UPDATE accounts SET balance = balance + 500 WHERE account_no = 5678;

SAVEPOINT sp3; -- Üçüncü kayıt noktası oluştur
UPDATE accounts SET balance = balance - 300 WHERE account_no = 5678;

-- } catch (hata) {
ROLLBACK TO sp2; -- İşlemi sp2 noktasına kadar geri al
-- }
COMMIT;



SELECT * FROM accounts;

------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM accounts WHERE EXISTS (SELECT 1 FROM accounts);

-- Tabloları silin.
DROP TABLE IF EXISTS accounts;
