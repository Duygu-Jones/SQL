--------------------------Day-3: REGEX - LIKE Continue--------------------------

--LIKE Conditions:-------------------------------------------------------------
		
		--	LIKE: Allows us to query using specific patterns
		--	ILIKE: Matches patterns case-insensitively
		--	LIKE = ~~
		--	ILIKE = ~~*
		--	NOT LIKE = !~~
		--	NOT ILIKE = !~~*
		
		--  REGEXP_LIKE= ~
		--  REGEXP_LIKE= ~*
		--	NOT REGEXP_LIKE = !~*
		--	NOT REGEXP_LIKE = !~


--LIKE / ILIKE  Conditions:-------------------------------------------------------
--Used after the WHERE clause,
--Allows us to filter queries using specific character strings (patterns)
--Used in tables to search and find desired variables, narrowing the search

--Used SYMBOLS: 
		--WILDCARD (%) : The wildcard symbol % represents 0 or more characters.
		--UnderScore     (_) : The underscore _ represents a single character.
						
			 --Usage:
				--   'A%n' == 'A....n' ==> Finds names that start with A and end with n
				--   'A%' ==> 'A....'  
				--   '%A' ==> ... +A 
				--   '%e%' ==> ...+ e + ... 
				--  '%e%a%' => ...+ e +... a 
				--	 or
				--  '%a%e%' => ... + a ... + e + ...
				--  '%an%'  ==> Finds words containing the syllable 'an'
				
				--  '__v_'  ==> Means a 4-letter word with v as the 3rd letter
				--  '__v%'  ==> Means words with v as the 3rd letter


--REGEXP_LIKE(~): ---------------------------------------------------------------------------------------------------------
	--REGEXP_LIKE => Allows for searching any text or code within a string for more complex queries,
			--using its own syntax.
			--In PostgreSQL, REGEXP_LIKE is used with the ‘’ ~ ‘’ character.
	
	-- Used SYMBOLS:
		
		-- (~) : For case-sensitive REGEXP_LIKE
		-- (~*): For case-insensitive REGEXP_LIKE
				--To make the regex case-insensitive, add * after the ~ symbol (default unless otherwise specified).
		
		-- []  : Square brackets; represent any one character inside them.
				--[abcd] represents any one of the characters a, b, c, or d.
				-- [a-z] represents any one character in the alphabet range a to z.
		
		-- (^) : Represents the beginning of a string.
		-- ($) : Represents the end of a string.
		
		-- (.*): DotStar: Represents 0 or more characters --> Can be used with parentheses () if desired.
	    -- (.) : Dot: Represents exactly one character --> Can be used with parentheses () if desired.
		
		--NOT LIKE : Filters out strings that do not match the given pattern --> Case Sensitive
		--NOT ILIKE: Filters out strings that do not match the given pattern --> Case Insensitive
		--  (!~)   : Filters out strings that do not match the given pattern --> Case Sensitive
		--  (!~*)  : Filters out strings that do not match the given pattern --> Case Insensitive




-- Create 'Electronics' table
CREATE TABLE Electronics (
    ProductID SERIAL PRIMARY KEY, -- Primary key with auto increment
    ProductName VARCHAR(255) NOT NULL, -- Name of the product, cannot be null
    Category VARCHAR(255), -- Category of the product
    Price REAL -- Price of the product
);

-- Insert data into 'Electronics' table
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


SELECT * FROM electronics e 


-- Task 1: Using LIKE
-- Question: Retrieve all products from the Electronics table whose ProductName starts with 'Apple'.
-- This query selects all products whose ProductName starts with 'Apple'.
SELECT *
FROM Electronics
WHERE ProductName LIKE 'Apple%';

-- Task 2: Using ILIKE
-- Question: Retrieve all products from the Electronics table whose ProductName contains the word 'galaxy' case-insensitively.
-- NOTE: ILIKE is used for case-insensitive pattern matching.
SELECT *
FROM Electronics
WHERE ProductName ILIKE '%galaxy%';

-- Task 3: Using NOT LIKE
-- Question: Retrieve all products from the Electronics table whose ProductName does not contain the word 'Apple'.
SELECT *
FROM Electronics
WHERE ProductName NOT LIKE '%Apple%';

-- Task 4: Using NOT ILIKE
-- Question: Retrieve all products from the Electronics table whose ProductName does not contain the word 'galaxy' case-insensitively.
SELECT *
FROM Electronics
WHERE ProductName NOT ILIKE '%galaxy%';

-- Task 5: Using REGEXP_LIKE
-- Question: Retrieve all products from the Electronics table whose ProductName contains the word 'Pro' using regular expressions.
-- NOTE: REGEXP_LIKE is used for regular expression pattern matching.
SELECT *
FROM Electronics
WHERE ProductName ~ 'Pro';

-- Task 6: Using NOT REGEXP_LIKE
-- Question: Retrieve all products from the Electronics table whose ProductName does not contain the word 'Pro' using regular expressions.
SELECT *
FROM Electronics
WHERE ProductName !~ 'Pro';

-- Task 7: Using Wildcard %
-- Question: Retrieve all products from the Electronics table whose ProductName ends with '13'.
SELECT *
FROM Electronics
WHERE ProductName LIKE '%13';

-- Task 8: Using Wildcard _
-- Question: Retrieve all products from the Electronics table whose ProductName has 'a' as the second character.
-- NOTE: _ (underscore) represents a single character.
SELECT *
FROM Electronics
WHERE ProductName LIKE '_a%';

-- Task 9: Using REGEXP_LIKE with square brackets
-- Question: Retrieve all products from the Electronics table whose ProductName contains any single digit (0-9).
SELECT *
FROM Electronics
WHERE ProductName ~ '[0-9]';

-- Task 10: Using REGEXP_LIKE with beginning (^) and ending ($) symbols
-- Question: Retrieve all products from the Electronics table whose ProductName starts with 'Apple' and ends with a digit.
SELECT *
FROM Electronics
WHERE ProductName ~ '^Apple.*[0-9]$';




















