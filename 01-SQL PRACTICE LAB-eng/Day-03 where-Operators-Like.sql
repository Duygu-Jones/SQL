
--------------------------Day-3: FILTERING DATA (DQL)---------------------------
------------------SELECT - FROM - WHERE: and/or/between/in/ LIKE/ ILIKE---------

-- SELECT: Used to select data from a database.
-- FROM: Specifies the table from which to retrieve the data.
-- WHERE: Used to filter records based on a specified condition.
-- AND: Combines multiple conditions in a WHERE clause; all conditions must be true.
-- OR: Combines multiple conditions in a WHERE clause; at least one condition must be true.
-- BETWEEN: Filters the result set within a specified range.
-- IN: Allows specifying multiple values in a WHERE clause.
-- LIKE: Searches for a specified pattern in a column.
-- ILIKE: Searches for a specified pattern in a column, case-insensitively (PostgreSQL specific).


-- NOTE: The WHERE clause is used to filter records based on specific conditions.

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



-- Task 1: Using WHERE
-- Question: Retrieve all employees from the Employees table who work in the 'IT' department.
-- NOTE: This query selects all employees who work in the 'IT' department.
SELECT *
FROM Employees
WHERE Department = 'IT';

-- Task 2: Using AND, OR, NOT
-- Question: Retrieve all employees from the Employees table who work in the 'IT' department and have a salary greater than 70000.
SELECT *
FROM Employees
WHERE Department = 'IT' AND Salary > 70000;

-- Task 3: Using BETWEEN
-- Question: Retrieve all employees from the Employees table who were hired between '2019-01-01' and '2020-12-31'.
SELECT *
FROM Employees
WHERE HireDate BETWEEN '2019-01-01' AND '2020-12-31';

-- Task 4: Using IN
-- Question: Retrieve all employees from the Employees table who work in either the 'HR', 'IT', or 'Marketing' departments.
SELECT *
FROM Employees
WHERE Department IN ('HR', 'IT', 'Marketing');

-- Task 5: Using LIKE
-- Question: Retrieve all employees from the Employees table whose last name starts with 'J'.
SELECT *
FROM Employees
WHERE LastName LIKE 'J%';






