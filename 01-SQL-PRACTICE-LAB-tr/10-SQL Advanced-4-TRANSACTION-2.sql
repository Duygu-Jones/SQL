--------------------------: TRANSACTION (İşlem) :--------------------------

-- TRANSACTION: Veritabanı işlemlerinin bir bütün olarak gerçekleştirilmesini sağlar.
-- İşlemler ya tamamen başarılı olur (COMMIT) ya da tamamen geri alınır (ROLLBACK).
-- BEGIN: Bir işlemi başlatır.
-- COMMIT: İşlemi onaylar ve kalıcı hale getirir.
-- SAVEPOINT: İşlem içinde geri dönülebilecek bir nokta belirler.
-- ROLLBACK: İşlemi geri alır.
-- ROLLBACK TO SAVEPOINT: İşlemi belirtilen savepoint noktasına kadar geri alır.

------------------------: TABLE CREATION :--------------------------

-- Mevcut 'accounts' ve 'transactions' tablolarını kontrol et ve sil.
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS transactions;


-- CREATE TABLE: 'accounts' tablosunu oluşturur.
BEGIN;
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(255),
    balance DECIMAL(10, 2)
);
COMMIT;

-- CREATE TABLE: 'transactions' tablosunu oluşturur.
BEGIN;
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
COMMIT;

-- INSERT INTO: 'accounts' ve 'transactions' tablolarına örnek veriler ekler.
BEGIN;
INSERT INTO accounts (account_name, balance) VALUES
('Alice', 1000.00),
('Bob', 1500.00),
('Charlie', 2000.00);
COMMIT;

SELECT * FROM accounts;

------------------------------: PRACTICES :--------------------------------

-----------------------------: Pozitif Senaryo:----------------------------
-- Alice hesabına para yatırır, Bob'un hesabından para çekilir, 
--Charlie'nin hesabına para eklenir ve ardından para çekilir.

-- 1. Alice'in hesabına 200.00 para ekleyin ve işlemi onaylayın.
BEGIN;
UPDATE accounts
SET balance = balance + 200.00
WHERE account_name = 'Alice';
COMMIT; -- Alice'in hesabına 200.00 eklendi ve işlem onaylandı.

SELECT * FROM accounts;

-- 2. Bob'un hesabından 300.00 para çekin ve işlemi onaylayın.
BEGIN;
UPDATE accounts
SET balance = balance - 300.00
WHERE account_name = 'Bob';
COMMIT; -- Bob'un hesabından 300.00 çekildi ve işlem onaylandı.

SELECT * FROM accounts;


-- 3. Charlie'nin hesabına 500.00 para ekleyin, ardından 200.00 para çekin ve işlemi onaylayın.
BEGIN;
UPDATE accounts
SET balance = balance + 500.00
WHERE account_name = 'Charlie';
SAVEPOINT before_withdraw; -- Savepoint oluşturuldu.
UPDATE accounts
SET balance = balance - 200.00
WHERE account_name = 'Charlie';
COMMIT; -- Charlie'nin hesabına 500.00 eklendi, ardından 200.00 çekildi ve işlem onaylandı.

SELECT * FROM accounts;

----------------------------------: Negatif Senaryo:-----------------------------------
-- Bob'un hesabından para çekme işlemi yapılır, ancak işlem savepoint'e geri alınır. 
-- Alice'in hesabından para çekme işlemi yapılır ve tamamen geri alınır. 
-- Bob ve Charlie'nin hesaplarına para eklenir, ancak savepoint'e geri alınarak iptal edilir.


-- 4. Bob'un hesabından 300.00 para çekin, bir savepoint oluşturun ve işlemi geri alın.
BEGIN;
SAVEPOINT before_rollback; -- Savepoint oluşturuldu.
UPDATE accounts
SET balance = balance - 300.00
WHERE account_name = 'Bob';
ROLLBACK TO SAVEPOINT before_rollback; -- İşlem savepoint'e kadar geri alındı.
COMMIT; -- Bob'un hesabından para çekilmedi.

SELECT * FROM accounts;


-- 5. Alice'in hesabından 100.00 para çekin, işlemi geri alın ve bakiyeyi kontrol edin.
BEGIN;
SAVEPOINT before_rollback; -- Savepoint oluşturuldu.
UPDATE accounts
SET balance = balance - 100.00
WHERE account_name = 'Alice';
ROLLBACK; -- İşlem geri alındı, Alice'in hesabından para çekilmedi.
SELECT balance 
FROM accounts
WHERE account_name = 'Alice'; -- Alice'in güncel bakiyesi görüntülendi.

SELECT * FROM accounts;



-- 6. Bob ve Charlie'nin hesaplarına toplam 1000.00 para ekleyin, bir savepoint oluşturun ve işlemi geri alın.
BEGIN;
SAVEPOINT before_rollback; -- Savepoint oluşturuldu.
UPDATE accounts
SET balance = balance + 500.00
WHERE account_name = 'Bob';
UPDATE accounts
SET balance = balance + 500.00
WHERE account_name = 'Charlie';
ROLLBACK TO SAVEPOINT before_rollback; -- İşlem savepoint'e kadar geri alındı.
COMMIT; -- Bob ve Charlie'nin hesaplarına para eklenmedi.

SELECT * FROM accounts;


------------------------: CLEANUP :--------------------------

-- Tabloyu silmeden önce verileri temizleyin.
DELETE FROM transactions WHERE EXISTS (SELECT 1 FROM transactions);
DELETE FROM accounts WHERE EXISTS (SELECT 1 FROM accounts);

-- Tabloları silin.
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
