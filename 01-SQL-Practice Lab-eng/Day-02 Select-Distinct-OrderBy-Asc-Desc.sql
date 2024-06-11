
--------------------------Day-2: QUERYING DATA (DQL)---------------------------
------------------SELECT:  DISTINCT - ORDER BY; ASC-DESC-----------------------

---DQL (Data Query Language) 
-- DQL includes commands focused on querying and retrieving data using SELECT.
-- SELECT and its variations form the core of DQL, including WHERE, GROUP BY, HAVING, and JOIN.

-- DISTINCT: Selects only distinct (different) values.
-- ORDER BY: Sorts the result set in either ascending or descending order.
-- ASC: Sorts the result set in ascending order (default).
-- DESC: Sorts the result set in descending order.



-- Create 'Employees' table
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY, -- Primary key with auto increment
    FirstName VARCHAR(255) NOT NULL, -- First name of the employee, cannot be null
    LastName VARCHAR(255) NOT NULL, -- Last name of the employee, cannot be null
    Department VARCHAR(255), -- Department of the employee
    Salary REAL, -- Salary of the employee
    HireDate DATE -- Hire date of the employee
);

-- Insert data into 'Employees' table
INSERT INTO Employees (FirstName, LastName, Department, Salary, HireDate) VALUES
('John', 'Doe', 'HR', 50000, '2021-01-15'),
('Jane', 'Smith', 'Finance', 60000, '2020-05-10'),
('Alice', 'Johnson', 'IT', 75000, '2019-03-20'),
('Bob', 'Williams', 'IT', 72000, '2018-07-22'),
('Charlie', 'Brown', 'Marketing', 55000, '2021-09-30');


SELECT * FROM employees e 


-- Task 1: Simple SELECT Query
-- Question: Retrieve all records from the Employees table.
-- NOTE: This query selects all columns and rows from the Employees table.
SELECT * 
FROM Employees;

-- Task 2: SELECT with DISTINCT
-- Question: Retrieve distinct departments from the Employees table.
-- NOTE: This query selects unique values from the Department column in the Employees table.
SELECT DISTINCT Department 
FROM Employees;

-- Task 3: SELECT with ORDER BY (Ascending)
-- Question: Retrieve all employees and order the results by Salary in ascending order.
-- NOTE: This query selects all columns from the Employees table and orders the rows by Salary in ascending order.
SELECT * 
FROM Employees 
ORDER BY Salary ASC;

-- Task 4: SELECT with ORDER BY (Descending)
-- Question: Retrieve all employees and order the results by HireDate in descending order.
-- NOTE: This query selects all columns from the Employees table and orders the rows by HireDate in descending order.
SELECT * 
FROM Employees 
ORDER BY HireDate DESC;

-- Task 5: SELECT with ORDER BY Multiple Columns
-- Question: Retrieve all employees and order the results by Department and then by LastName within each department in ascending order.
-- NOTE: This query selects all columns from the Employees table and orders the rows by Department and then by LastName in ascending order.
SELECT * 
FROM Employees 
ORDER BY Department ASC, LastName ASC;










