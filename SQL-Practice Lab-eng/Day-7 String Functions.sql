-----------------------------Day-7: SQL FUNCTIONS-1 ------------------------------------
-----------STRING FUNCS: CONCAT - LOWER- UPPER- TRIM- LENGTH- SUBSTRING-----------------


-- Notes on String Functions:
-- String Functions: Used to manipulate text strings in various ways.
-- CONCAT: Concatenates two or more strings.
-- LOWER: Converts a string to lowercase.
-- UPPER: Converts a string to uppercase.
-- TRIM: Removes leading and trailing spaces from a string.
-- LENGTH: Returns the length of a string.
-- SUBSTRING: Extracts a part of a string starting at a specified position.


-- Verification queries
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Projects;
SELECT * FROM EmployeeProjects;
SELECT * FROM Salaries;
------------------------check or drop the tables before creating.


-- Create 'Employees' table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

-- Insert data into 'Employees' table
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID, Salary) VALUES
(101, 'John', 'Doe', '1985-03-15', '2010-07-01', 1, 75000.00),
(102, 'Jane', 'Smith', '1990-06-24', '2012-08-15', 2, 60000.00),
(103, 'Sam', 'Brown', '1988-11-30', '2015-01-10', 1, 80000.00),
(104, 'Lisa', 'Jones', '1992-04-21', '2018-03-05', 3, 72000.00),
(105, 'Tom', 'Harris', '1983-09-10', '2009-11-30', 4, 68000.00);

-- Practical Questions with String Functions

-- 1. Concatenate the first name and last name of each employee.
-- Soru: Her çalışanın ilk ve son adını birleştirin.
SELECT
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- 2. Convert the first names of all employees to lowercase.
-- Soru: Tüm çalışanların ilk adlarını küçük harfe dönüştürün.
SELECT
    LOWER(FirstName) AS LowerFirstName
FROM Employees;

-- 3. Convert the last names of all employees to uppercase.
-- Soru: Tüm çalışanların soyadlarını büyük harfe dönüştürün.
SELECT
    UPPER(LastName) AS UpperLastName
FROM Employees;

-- 4. Remove leading and trailing spaces from first names.
-- Soru: İlk adlardan baştaki ve sondaki boşlukları kaldırın.
-- (Note: For demonstration, assuming FirstName has leading/trailing spaces, though they don't in this dataset)
SELECT
    TRIM(FirstName) AS TrimmedFirstName
FROM Employees;

-- 5. Calculate the length of each employee's first name.
-- Soru: Her çalışanın ilk adının uzunluğunu hesaplayın.
SELECT
    FirstName,
    LENGTH(FirstName) AS FirstNameLength
FROM Employees;

-- 6. Extract the first three characters of each employee's last name.
-- Soru: Her çalışanın soyadının ilk üç karakterini çıkarın.
SELECT
    LastName,
    SUBSTRING(LastName, 1, 3) AS LastNameStart
FROM Employees;

-- 7. Concatenate the first name and last name of each employee, and convert the result to uppercase.
-- Soru: Her çalışanın ilk ve soyadını birleştirin ve sonucu büyük harfe dönüştürün.
SELECT
    UPPER(CONCAT(FirstName, ' ', LastName)) AS FullNameUpper
FROM Employees;

-- 8. Convert the first letter of each employee's first name to uppercase and the rest to lowercase.
-- Soru: Her çalışanın ilk adının ilk harfini büyük, diğer harflerini küçük yapın.
SELECT
    CONCAT(UPPER(SUBSTRING(FirstName, 1, 1)), LOWER(SUBSTRING(FirstName, 2))) AS ProperFirstName
FROM Employees;

-- 9. Extract the last three characters of each employee's last name.
-- Soru: Her çalışanın soyadının son üç karakterini çıkarın.
SELECT
    LastName,
    SUBSTRING(LastName, LENGTH(LastName) - 2, 3) AS LastNameEnd
FROM Employees;

-- 10. Calculate the total length of first and last names concatenated for each employee.
-- Soru: Her çalışanın ilk ve soyadının birleştirilmiş toplam uzunluğunu hesaplayın.
SELECT
    FirstName,
    LastName,
    LENGTH(CONCAT(FirstName, ' ', LastName)) AS FullNameLength
FROM Employees;



----------------------------------ADDITIONAL STRING FUNCTIONS: --And PRACTICES---------------

/*
1) TRIM(column parameter) removes leading and trailing spaces from the string value.
	LTRIM only removes leading spaces.
	RTRIM only removes trailing spaces.

2) REPLACE(column, 'old value', 'new value') finds the specified value in the column and replaces it with the new specified value.
   	It is used with UPDATE because it makes changes.

3) CONCAT(column name, 'string') is used to concatenate two or more strings.

4) SUBSTRING(column name, start index, end index) returns the string value within the specified index range in that column.
	We can change the parts of strings in a column as we want.
	It also works with a single index and takes from the specified part to the end.

5) UPPER(column name) converts the string values in that column to uppercase.

6) LOWER(column name) converts the string values in that column to lowercase.

7) INITCAP(column name) capitalizes the first letter of each word in the strings of that column.

8) LENGTH(column name) returns the length of the strings in the specified column for each row.

9) REVERSE(column name) reverses the string value in the column.

10) LEFT() / RIGHT() (Starting and Ending Characters): Takes the specified number of characters from the start or end of a string.

11) LEFT(column, 3) takes the first 3 characters; if it were RIGHT, it would take the last 3 characters.

12) FETCH NEXT n ROW ONLY: fetches only the next n rows.
                  LIMIT n: fetches only the next n rows - termination function.
                  OFFSET n: skips n rows and fetches the subsequent rows.
                  
-- NOTE: In SQL, the index starts from 1!!! -----------------------------------------------*/


-- Create 'developers' table
CREATE TABLE developers (
    developer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    prog_lang VARCHAR(50),
    email VARCHAR(100),
    salary REAL
);

-- Insert data into 'developers' table
INSERT INTO developers (name, prog_lang, email, salary) VALUES 
('Alice Johnson', 'Python', 'alice.johnson@example.com', 70000),
('Bob Smith', 'Java', 'bob.smith@example.com', 80000),
('Charlie Brown', 'JavaScript', 'charlie.brown@example.com', 75000),
('David Wilson', 'Ruby', 'david.wilson@example.com', 68000),
('Eve Davis', 'Python', 'eve.davis@example.com', 72000);

SELECT * FROM developers;

---String Functions ----------------------------------------------------------------------------------

-- Show the character count of the 'name' values in the 'developers' table.
SELECT name, LENGTH(name)
FROM developers;

-- In the 'developers' table, remove the leading and trailing spaces from the 'name' values.
UPDATE developers
SET name = TRIM(name);

-- In the 'developers' table, replace the 'Alice' in the 'name' values with 'Aly'.
UPDATE developers
SET name = REPLACE(name, 'Alice', 'Aly');

SELECT * FROM developers;

-- UPPER-LOWER-INITCAP Functions: ------------------------------------------------------------------------------------------------

-- In the 'developers' table, display all records with:
-- name values in lowercase,
-- prog_lang values in uppercase,
-- email values with the first letter capitalized.
SELECT 
    LOWER(name), 
    UPPER(prog_lang), 
    INITCAP(email)
FROM developers;

-- In the 'employees' table, remove the substring (_Branch) from the 'city' values for records where 'company' is 'Vakko'.
-- For company 'Vakko', remove the last 7 characters including the space.
UPDATE employees
SET city = SUBSTRING(city, 1, LENGTH(city) - 7) 
WHERE company = 'Vakko';

SELECT * FROM employees;

-- NOTE:
-- SUBSTRING Function: 
-- Takes the first parameter, starts from the character specified in the second parameter, and 
-- returns the number of characters specified in the last parameter. --> Starts from the 1st index and takes characters up to the -7th index.
-- If only the starting index is given, it takes characters from the start index to the end.

-- Display all words and the first 2 characters of each word from the 'words' table.
SELECT word, SUBSTRING(word, 1, 2) 
FROM words;

-- Display all words and the remaining part of each word from the 2nd index in the 'words' table.
SELECT word, SUBSTRING(word, 2) 
FROM words;

-- INITCAP: Capitalizes the first letter - Sentence case

-- Display all words with the first letter capitalized and the rest in lowercase from the 'words' table.
SELECT INITCAP(word) 
FROM words;


--FETCH NEXT (number) ROW ONLY - OFFSET -----------------------------------------------------------------------------------
-- FETCH NEXT n ROW ONLY  : Fetches only the next n rows
--                LIMIT n : Fetches only the next n rows
--                OFFSET n: Skips n rows and fetches the next rows

-- fetch next = Limit same function

-- Fetch the first 3 records from the 'developers' table in insertion order.
SELECT * 
FROM developers
LIMIT 3;

-- Alternatively:
SELECT *
FROM developers
FETCH NEXT 3 ROW ONLY; -- Fetches the first 3 rows

-- Fetch the first 3 records after skipping the first 2 records from the 'developers' table in insertion order.
SELECT * 
FROM developers
OFFSET 2 ROWS -- 'ROWS' is optional
FETCH NEXT 3 ROW ONLY;

-- Alternatively:
SELECT * 
FROM developers
OFFSET 2 ROWS -- 'ROWS' is optional
LIMIT 3;

-- Fetch the first 3 records with the lowest salary from the 'developers' table.
SELECT * 
FROM developers
ORDER BY salary ASC
LIMIT 3;

-- NOTE: The LIMIT Function: Terminating function, no code should be written after it, hence it should be at the end.

-- Fetch all information of the developer with the second highest salary from the 'developers' table.
SELECT *
FROM developers
ORDER BY salary DESC -- Order by descending salary
OFFSET 1 -- Skip the first record
LIMIT 1; -- Fetch the next one










