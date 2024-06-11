-----------------------------Day-7: SQL Basics-----------------------------------
------------------------------------- ALIES  ------------------------------------

-- Create 'workers' table
CREATE TABLE workers(
    worker_id CHAR(9),
    worker_name VARCHAR(50),
    worker_birth_city VARCHAR(50)
);

-- Insert data into 'workers' table
INSERT INTO workers VALUES ('123456789', 'John Doe', 'New York'); 
INSERT INTO workers VALUES ('234567890', 'Jane Smith', 'Los Angeles');  
INSERT INTO workers VALUES ('345678901', 'Michael Johnson', 'Chicago');

-- ALIASES: Creating temporary names -------------------------------------------------

-- Example:
-- 1. Display the 'workers' table without any aliases.
SELECT * FROM workers;

-- 2. Assign a temporary alias to the 'worker_id' column.
SELECT worker_id AS id 
FROM workers; 
-- In the displayed report, the 'worker_id' column is temporarily named 'id'.

-- 3. Assign temporary aliases to multiple columns.
SELECT 
    worker_id AS id, 
    worker_name AS name 
FROM workers;

-- 4. Concatenate two columns using the || symbol and assign a temporary name.
SELECT 
    worker_id || ' - ' || worker_name AS id_name 
FROM workers; 
-- Since two columns are concatenated, a temporary common name 'id_name' is assigned.
-- A '-' symbol is added between the columns using || ' - ' ||.

-- 5. Assign a temporary name to the entire 'workers' table.
SELECT * 
FROM workers AS employees;

























