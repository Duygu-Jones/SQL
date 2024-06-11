-----------------------------Day-3: FILTERING DATA-----------------------------------
------------------------------- WHERE IN/ NOT IN------------------------------



---- Verification queries
--check or drop the tables before creating.
SELECT * FROM products p 
SELECT * FROM sales s 


-- Create 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create 'sales' table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into 'products' table
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 800.00),
(2, 'Smartphone', 'Electronics', 600.00),
(3, 'Tablet', 'Electronics', 300.00),
(4, 'Headphones', 'Accessories', 50.00),
(5, 'Charger', 'Accessories', 20.00);

-- Insert data into 'sales' table
INSERT INTO sales VALUES
(1, 1, '2024-01-01', 5, 4000.00),
(2, 2, '2024-01-01', 10, 6000.00),
(3, 3, '2024-01-02', 15, 4500.00),
(4, 4, '2024-01-02', 20, 1000.00),
(5, 5, '2024-01-03', 25, 500.00),
(6, 1, '2024-01-03', 3, 2400.00),
(7, 2, '2024-01-04', 8, 4800.00),
(8, 3, '2024-01-04', 12, 3600.00),
(9, 4, '2024-01-05', 18, 900.00),
(10, 5, '2024-01-05', 22, 440.00);

-- Practical Questions with IN and NOT IN

-- 1. Find the products that belong to the 'Electronics' or 'Accessories' category.
-- Query: Display the product names that belong to the 'Electronics' or 'Accessories' category.
SELECT product_name
FROM products
WHERE category IN ('Electronics', 'Accessories');

-- 2. Find the products that do not belong to the 'Electronics' category.
-- Query: Display the product names that do not belong to the 'Electronics' category.
SELECT product_name
FROM products
WHERE category NOT IN ('Electronics');

-- 3. Find the products that have product_id 1, 3, or 5.
-- Query: Display the product names that have product_id 1, 3, or 5.
SELECT product_name
FROM products
WHERE product_id IN (1, 3, 5);

-- 4. Find the products that do not have product_id 2 or 4.
-- Query: Display the product names that do not have product_id 2 or 4.
SELECT product_name
FROM products
WHERE product_id NOT IN (2, 4);

-- 5. Find the products that belong to the 'Electronics' category and have a price of 300 or 800.
-- Query: Display the product names that belong to the 'Electronics' category and have a price of 300 or 800.
SELECT product_name
FROM products
WHERE category = 'Electronics' AND price IN (300, 800);
