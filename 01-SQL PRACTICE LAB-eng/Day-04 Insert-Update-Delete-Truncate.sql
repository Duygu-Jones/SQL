--------------------------Day-4: MODIFYING DATA (DML)---------------------------
------------------------INSERT - UPDATE - DELETE & TRUNCATE---------------------

-- INSERT: Adds new rows of data into a table.
-- UPDATE: Modifies existing data in a table based on a condition.
-- DELETE: Removes specific rows of data from a table based on a condition.
-- TRUNCATE: Removes all rows from a table, but keeps the table structure intact.

-- Create 'Electronics' table
CREATE TABLE Electronics (
    ProductID SERIAL PRIMARY KEY, 		-- Primary key with auto increment
    ProductName VARCHAR(255) NOT NULL, 	-- Name of the product, cannot be null
    Category VARCHAR(255), 				-- Category of the product
    Price REAL 							-- Price of the product
);


-- Insert data into 'Electronics' table
INSERT INTO Electronics (ProductName, Category, Price) VALUES
('Apple iPhone 12', 'Electronics', 799.99),
('Samsung Galaxy S21', 'Electronics', 699.99),
('Sony WH-1000XM4', 'Electronics', 349.99),
('Apple MacBook Pro', 'Computers', 1299.99),
('Dell XPS 13', 'Computers', 999.99),
('Logitech Mouse', 'Accessories', 29.99),
('HP Envy 13', 'Computers', 899.99),
('Apple AirPods', 'Accessories', 199.99),
('Samsung Galaxy Buds', 'Accessories', 149.99);


SELECT * FROM electronics e 



-- Task 1: Using INSERT
-- Question: Insert a new product 'Google Pixel 5' into the Electronics table with the category 'Electronics' and price 699.99.
INSERT INTO Electronics (ProductName, Category, Price) VALUES
('Google Pixel 5', 'Electronics', 699.99);

-- Task 2: Using UPDATE
-- Question: Update the price of 'Apple iPhone 12' in the Electronics table to 749.99.
UPDATE Electronics
SET Price = 749.99
WHERE ProductName = 'Apple iPhone 12';

-- Task 3: Using DELETE
-- Question: Delete the product 'Logitech Mouse' from the Electronics table.
DELETE FROM Electronics
WHERE ProductName = 'Logitech Mouse';

-- Task 4: Using TRUNCATE
-- Question: Remove all data from the Electronics table but keep the table structure.
TRUNCATE TABLE Electronics;








