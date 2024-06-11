-----------------------------Day-5: JOIN DATA ------------------------------------
------------------JOINS: INNER - LEFT - RIGHT - FULL- UNION- ALL ----------------


-- INNER JOIN: Returns records that have matching values in both tables.
-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table. The result is NULL from the right side, if there is no match.
-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table. The result is NULL from the left side, if there is no match.
-- FULL JOIN: Returns all records when there is a match in either left or right table. The result is NULL from the left side, if there is no match.
-- UNION: Combines the result set of two or more SELECT statements, removing duplicates.
-- UNION ALL: Combines the result set of two or more SELECT statements, including duplicates.


-- Create 'Customers' table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY, 		-- Primary key with auto increment
    CustomerName VARCHAR(255) NOT NULL 	-- Name of the customer, cannot be null
);

-- Create 'Orders' table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY, 	-- Primary key with auto increment
    OrderDate DATE NOT NULL, 		-- Date of the order, cannot be null
    CustomerID INT, 				-- ID of the customer who placed the order
    Amount REAL, 					-- Amount of the order
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) -- Foreign key constraint
);

-- Insert data into 'Customers' table
INSERT INTO Customers (CustomerName) VALUES
('Alice'),
('Bob'),
('Charlie'),
('David');

-- Insert data into 'Orders' table
INSERT INTO Orders (OrderDate, CustomerID, Amount) VALUES
('2024-01-01', 1, 100.0),
('2024-01-02', 2, 150.0),
('2024-01-03', 1, 200.0),
('2024-01-04', 3, 250.0);


SELECT * FROM customers c 
SELECT * FROM orders o  



-- Task 1: Using INNER JOIN
-- Question: Retrieve all customers and their orders.
SELECT
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.Amount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Task 2: Using LEFT JOIN
-- Question: Retrieve all customers and their orders, including customers with no orders.
SELECT
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Task 3: Using RIGHT JOIN
-- Question: Retrieve all orders and their customers, including orders with no customers.
SELECT
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Task 4: Using FULL JOIN
-- Question: Retrieve all customers and their orders, including customers with no orders and orders with no customers.
SELECT
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.Amount
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Task 5: Using UNION
-- Question: Combine the customer names from the Customers table and the customer names from the Orders table.
SELECT
    CustomerName
FROM Customers
UNION
SELECT
    CustomerName
FROM Orders;

-- Task 6: Using UNION ALL
-- Question: Combine the customer names from the Customers table and the customer names from the Orders table, including duplicates.
SELECT
    CustomerName
FROM Customers
UNION ALL
SELECT
    CustomerName
FROM Orders;


--------------------ADDITIONAL PRACTICE FOR JOINING DATA------------------------

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

-- Create 'Departments' table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Create 'Projects' table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

-- Create 'EmployeeProjects' table
CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Create 'Salaries' table
CREATE TABLE Salaries (
    EmployeeID INT,
    SalaryDate DATE,
    Amount DECIMAL(10, 2),
    PRIMARY KEY (EmployeeID, SalaryDate),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into 'Departments' table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Sales'),
(4, 'Marketing');

-- Insert data into 'Employees' table
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID, Salary) VALUES
(101, 'John', 'Doe', '1985-03-15', '2010-07-01', 1, 75000.00),
(102, 'Jane', 'Smith', '1990-06-24', '2012-08-15', 2, 60000.00),
(103, 'Sam', 'Brown', '1988-11-30', '2015-01-10', 1, 80000.00),
(104, 'Lisa', 'Jones', '1992-04-21', '2018-03-05', 3, 72000.00),
(105, 'Tom', 'Harris', '1983-09-10', '2009-11-30', 4, 68000.00);

-- Insert data into 'Projects' table
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES
(201, 'Project Alpha', '2023-01-01', '2023-06-30'),
(202, 'Project Beta', '2023-02-15', '2023-07-31'),
(203, 'Project Gamma', '2023-05-01', '2023-12-31');

-- Insert data into 'EmployeeProjects' table
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
(101, 201, 'Manager', 150),
(102, 202, 'Developer', 120),
(103, 203, 'Analyst', 130),
(104, 201, 'Tester', 80),
(105, 202, 'Designer', 110);

-- Insert data into 'Salaries' table
INSERT INTO Salaries (EmployeeID, SalaryDate, Amount) VALUES
(101, '2024-01-01', 78000.00),
(102, '2024-01-01', 63000.00),
(103, '2024-01-01', 82000.00),
(104, '2024-01-01', 75000.00),
(105, '2024-01-01', 70000.00);

----------------------------

-- Verification queries
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Projects;
SELECT * FROM EmployeeProjects;
SELECT * FROM Salaries;
----------------------------

-- 1. List the first and last names of all employees.
SELECT
    FirstName,
    LastName
FROM Employees;

-- 2. List the distinct department names.
SELECT DISTINCT
    DepartmentName
FROM Departments;

-- 3. List the names of employees with a salary greater than 70,000.
SELECT
    FirstName,
    LastName
FROM Employees
WHERE Salary > 70000;

-- 4. List employees born after 1990 and with a salary greater than 65,000.
SELECT
    FirstName,
    LastName
FROM Employees
WHERE BirthDate > '1990-01-01' AND Salary > 65000;

-- 5. List employees ordered by salary in descending order.
SELECT
    *
FROM Employees
ORDER BY Salary DESC;

-- 6. List employees ordered by birthdate in ascending order.
SELECT
    *
FROM Employees
ORDER BY BirthDate ASC;

-- 7. List employees with a salary between 60,000 and 80,000.
SELECT
    *
FROM Employees
WHERE Salary BETWEEN 60000 AND 80000;

-- 8. List employees whose department ID is 1, 2, or 3.
SELECT
    *
FROM Employees
WHERE DepartmentID IN (1, 2, 3);

-- 9. List employees whose last name starts with 'S'.
SELECT
    *
FROM Employees
WHERE LastName LIKE 'S%';

-- 10. List the number of employees in each department.
SELECT
    DepartmentID,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

-- 11. Calculate the total hours worked by each employee on projects.
SELECT
    EmployeeID,
    SUM(HoursWorked) AS TotalHours
FROM EmployeeProjects
GROUP BY EmployeeID;

-- 12. List projects where the total hours worked is more than 100.
SELECT
    ProjectID,
    SUM(HoursWorked) AS TotalHours
FROM EmployeeProjects
GROUP BY ProjectID
HAVING SUM(HoursWorked) > 100;

-- 13. List the names of employees working in the 'Engineering' department.
SELECT
    e.FirstName,
    e.LastName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Engineering';

-- 14. List each employee's name, salary, and department name.
SELECT
    e.FirstName,
    e.LastName,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 15. List the names, last names, and roles of employees working on projects.
SELECT
    e.FirstName,
    e.LastName,
    ep.Role
FROM Employees e
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID;

-- 15a. List the names, last names, roles of employees, and the names of projects they are working on.
SELECT
    e.FirstName,
    e.LastName,
    ep.Role,
    p.ProjectName
FROM Employees e
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID;

-- 16. Find the employee with the highest salary.
SELECT
    *
FROM Employees
ORDER BY Salary DESC
LIMIT 1;

-- Alternative way to find the employee with the highest salary
SELECT
    *
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- 17. Calculate the average hours worked on each project.
SELECT
    ProjectID,
    AVG(HoursWorked) AS AvgHours
FROM EmployeeProjects
GROUP BY ProjectID;

-- 18. List each employee's most recent salary.
SELECT
    e.FirstName,
    e.LastName,
    s.SalaryDate,
    s.Amount
FROM Salaries s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
WHERE s.SalaryDate = (
    SELECT MAX(SalaryDate)
    FROM Salaries
    WHERE EmployeeID = s.EmployeeID
);

-- 19. List the names of employees not working on any projects.
-- Using LEFT JOIN
SELECT
    e.FirstName,
    e.LastName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.EmployeeID IS NULL;

-- Alternative using WHERE
SELECT
    FirstName,
    LastName
FROM Employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM EmployeeProjects);

-- 20. Calculate the average salary for each department.
SELECT
    DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID;

-- Alternative with department names
SELECT
    e.DepartmentID,
    d.DepartmentName,
    AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY e.DepartmentID, d.DepartmentName;






-------------------------ADDITIONAL NOTES AND PRACTICES:--------------------------------------

-- TABLE 'companies'
CREATE TABLE companies (
    company_id INT,  
    company_name VARCHAR(20)
);

INSERT INTO companies VALUES (100, 'IBM');
INSERT INTO companies VALUES (101, 'GOOGLE');
INSERT INTO companies VALUES (102, 'MICROSOFT');
INSERT INTO companies VALUES (103, 'APPLE');

-- TABLE 'orders'
CREATE TABLE orders (
    order_id INT,
    company_id INT,
    order_date DATE
);

INSERT INTO orders VALUES (11, 101, '2023-02-17');  
INSERT INTO orders VALUES (22, 102, '2023-02-18');  
INSERT INTO orders VALUES (33, 103, '2023-01-19');  
INSERT INTO orders VALUES (44, 104, '2023-01-20');  
INSERT INTO orders VALUES (55, 105, '2022-12-21');

SELECT * FROM companies;
SELECT * FROM orders;

-- JOINS: Combining columns from related tables based on a common column (typically PK and FK).

---INNER JOIN: Shows only the common values in the base column.

-- Example:
-- List company_id, company_name, order_id, and order_date for records where company_id is the same in both tables.
SELECT companies.company_id, company_name, order_id, order_date
FROM companies
INNER JOIN orders
ON companies.company_id = orders.company_id;

---LEFT JOIN: Shows all values from the left (first) table.
-- The order of tables matters.

-- Example:
-- List all records from the companies table with company_id, company_name, order_id, and order_date.
SELECT companies.company_id, company_name, order_id, order_date
FROM companies 
LEFT JOIN orders
ON companies.company_id = orders.company_id;

---RIGHT JOIN: Shows all values from the right (second) table.
-- The order of tables matters.

-- Example:
-- List all records from the orders table with company_id, company_name, order_id, and order_date.
SELECT orders.company_id, company_name, order_id, order_date
FROM companies 
RIGHT JOIN orders
ON companies.company_id = orders.company_id;

-- NOTE: LEFT and RIGHT JOIN can be used interchangeably by changing the table order.
-- Example of equivalent queries:
SELECT orders.company_id, company_name, order_id, order_date
FROM companies 
RIGHT JOIN orders
ON companies.company_id = orders.company_id;

SELECT orders.company_id, company_name, order_id, order_date
FROM orders 
LEFT JOIN companies
ON companies.company_id = orders.company_id;

-- 35-FULL JOIN: Shows all records from both tables.

-- Example:
-- List all records from both tables with all columns.
SELECT companies.company_id AS company_id, 
       company_name,
       orders.company_id AS order_company_id,
       order_id, order_date
FROM companies 
FULL JOIN orders
ON companies.company_id = orders.company_id;

-- Shortcut to select all columns:
SELECT * 					
FROM orders 
FULL JOIN companies
ON companies.company_id = orders.company_id;

-- TABLE 'employees'
CREATE TABLE employees (
    id INT,					-- Employee's own id
    name VARCHAR(20),  		
    title VARCHAR(60), 		
    manager_id INT 		-- Employee's manager id
);

INSERT INTO employees VALUES (1, 'John Doe', 'SDET', 2);
INSERT INTO employees VALUES (2, 'Jane Smith', 'QA', 3);
INSERT INTO employees VALUES (3, 'Emily Davis', 'QA Lead', 4);  
INSERT INTO employees VALUES (4, 'Michael Brown', 'CEO', NULL); -- CEO, top manager, no manager, NULL

SELECT * FROM employees;

---SELF JOIN: Allows INNER JOIN on a column within the same table.

-- Example:
-- Create a query that shows each employee's name along with their manager's name.
SELECT e.name AS employee, m.name AS manager
FROM employees AS e 
INNER JOIN employees AS m 
ON e.manager_id = m.id;

-- Another way:
SELECT e.name AS employee, m.name AS manager
FROM employees AS e
INNER JOIN employees AS m
ON m.id = e.manager_id;

-- Show employee first:
SELECT e.id AS e_id, e.name AS e_name, e.title AS e_title,
       m.name AS manager_name, m.title AS manager_title, m.id AS m_id
FROM employees AS e
INNER JOIN employees AS m
ON m.id = e.manager_id;

-- Show manager first:
SELECT m.id AS m_id, m.name AS m_name, m.title AS m_title,
       e.name AS e_name, e.title AS e_title
FROM employees AS m
INNER JOIN employees AS e
ON m.id = e.manager_id;






