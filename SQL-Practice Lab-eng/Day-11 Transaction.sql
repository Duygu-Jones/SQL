-----------------------------Day-11: ADVANCED SQL----------------------------------------
------------------------- TRANSACTION: BEGIN - COMMIT- SAVEPOINT- ROLLBACK---------------


-- 42-TRANSACTION: The smallest unit of operation in the database:
--       BEGIN     : Starts a transaction
--       COMMIT    : Approves and ends the transaction
--       SAVEPOINT : Creates a savepoint
--       ROLLBACK  : Reverts the changes to the current state and ends the transaction
-- To control transaction management, we use BEGIN-COMMIT-SAVEPOINT-ROLLBACK

-- TABLE 'accounts' -------------------------
CREATE TABLE accounts
(
    account_no INT UNIQUE,
    name VARCHAR(50),
    balance REAL
);
INSERT INTO accounts VALUES (1234, 'Harry Potter', 10000.3);
INSERT INTO accounts VALUES (5678, 'Jack Sparrow', 5000.5);

SELECT * FROM accounts;

----------------------------------------------------------
-- A scenario where 1000 currency units will be transferred from one bank account to another;
-- The sender account balance decreases by 1000, and the recipient account balance increases by 1000

-- Decrease 1000 from sender account
UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234;

-- If there is an error in the system:
-- Increase 1000 in recipient account
UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678;

-- Data becomes inconsistent
-- The 1000 currency units leave the sender's account but don't reach the recipient, getting stuck in between.

-- In this case, if the second UPDATE operation fails, the first UPDATE should also be cancelled (transactions don't automatically do this)
-- And the operation should be reverted automatically, returning the 1000 currency units to the sender's account.
-- ***** In interconnected UPDATE operations, we should manage the TRANSACTION

SELECT * FROM accounts;

------------------- Negative Scenario ------------------------------
BEGIN;
CREATE TABLE accounts
(
    account_no INT UNIQUE,
    name VARCHAR(50),
    balance REAL
);
COMMIT;

BEGIN;
INSERT INTO accounts VALUES (1234, 'Harry Potter', 10000.3);
INSERT INTO accounts VALUES (5678, 'Jack Sparrow', 5000.5);

SELECT * FROM accounts;

SAVEPOINT x; -- Creates a savepoint named 'x', if there is an error in the following code, ROLLBACK to this point

-- try {
    UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234;
    -- An error occurred in the system, data is inconsistent
    -- go to catch block -->
    UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678; -- This operation failed
    COMMIT;

-- } catch (error) {
    ROLLBACK TO x; --> Rolls back to SAVEPOINT x;
-- }

----------------------------- Positive Scenario ----------------------
BEGIN;
CREATE TABLE accounts
(
    account_no INT UNIQUE,
    name VARCHAR(50),
    balance REAL
);
COMMIT;

BEGIN;
INSERT INTO accounts VALUES (1234, 'Harry Potter', 10000.3);
INSERT INTO accounts VALUES (5678, 'Jack Sparrow', 5000.5);

SELECT * FROM accounts;

SAVEPOINT x;
-- try {
    UPDATE accounts SET balance = balance - 1000 WHERE account_no = 1234; -- Successful

    UPDATE accounts SET balance = balance + 1000 WHERE account_no = 5678; -- Successful

    COMMIT;

-- } catch (error) {
    ROLLBACK TO x;
-- }

   
   
   
   
   
   
   
   
   
   