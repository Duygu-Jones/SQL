
-----------------------------Day-9: SQL Basics-----------------------------------
------------------------------- IF EXISTS----------------------------------

-- TABLE 1:
CREATE TABLE march(     
    product_id INT,      
    customer_name VARCHAR(50),
    product_name VARCHAR(50)
);

-- Insert data into 'march' table
INSERT INTO march VALUES (10, 'Mark', 'Honda');
INSERT INTO march VALUES (20, 'John', 'Toyota');
INSERT INTO march VALUES (30, 'Amy', 'Ford');
INSERT INTO march VALUES (20, 'Mark', 'Toyota');
INSERT INTO march VALUES (10, 'Adam', 'Honda');
INSERT INTO march VALUES (40, 'John', 'Hyundai');
INSERT INTO march VALUES (20, 'Eddie', 'Toyota');

-- TABLE 2:
CREATE TABLE april(     
    product_id INT,
    customer_name VARCHAR(50),
    product_name VARCHAR(50)
);

-- Insert data into 'april' table
INSERT INTO april VALUES (10, 'Hasan', 'Honda');
INSERT INTO april VALUES (10, 'Kemal', 'Honda');
INSERT INTO april VALUES (20, 'Ayse', 'Toyota');
INSERT INTO april VALUES (50, 'Yasar', 'Volvo');
INSERT INTO april VALUES (20, 'Mine', 'Toyota');

-- Display all data from 'march' table
SELECT * FROM march;

-- Display all data from 'april' table
SELECT * FROM april;

-- EXISTS Condition -----------------------------------------------------------------------------------------------

-- The EXISTS condition is used to check whether the result of a subquery is empty or not.
-- If the subquery result is not empty, the condition is satisfied, and the rest of the query is executed.
-- If the subquery returns at least one row, the EXISTS result is true.
-- If the subquery returns no rows, the EXISTS result is false.

-- Examples:
-- 1. List all product details from April if 'Toyota' was sold in March.
-- EXISTS
SELECT *
FROM april
WHERE EXISTS (
    SELECT product_name 
    FROM march 
    WHERE product_name = 'Toyota'
);

-- 2. List all product details from April if 'Volvo' was sold in March.
-- EXISTS
SELECT *
FROM april
WHERE EXISTS (
    SELECT product_name 
    FROM march 
    WHERE product_name = 'Volvo'
);

-- 3. List product_id and customer_name from March if the product was also sold in April.
-- EXISTS
SELECT product_id, customer_name
FROM march
WHERE EXISTS (
    SELECT product_name 
    FROM april 
    WHERE april.product_name = march.product_name
);

-- Use m (for March) and a (for April) as table aliases for temporary column naming.
SELECT product_id, customer_name
FROM march AS m
WHERE EXISTS (
    SELECT product_name 
    FROM april AS a 
    WHERE a.product_name = m.product_name
);

-- 4. List the product names and the customer names who purchased these products in April if the products were sold in both March and April.
-- EXISTS
SELECT product_name, customer_name
FROM april AS a
WHERE EXISTS (
    SELECT product_name 
    FROM march AS m 
    WHERE m.product_name = a.product_name
);

-- 5. List the product names and the customer names who purchased these products in March if the products were sold in March but not in April.
-- NOT EXISTS
SELECT product_name, customer_name
FROM march AS m
WHERE NOT EXISTS (
    SELECT product_name
    FROM april AS a 
    WHERE a.product_name = m.product_name
);











