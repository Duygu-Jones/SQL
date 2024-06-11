-----------------------------Day-6: SQL FUNCTIONS-1 ------------------------------------
--------------------AGGREGATE FUNCS: COUNT - SUM- AVG- MAX- MIN-------------------------


-- Aggregate functions perform a calculation on a set of values and return a single value.
-- COUNT: Returns the number of rows that matches a specified criterion.
-- SUM: Returns the total sum of a numeric column.
-- AVG: Returns the average value of a numeric column.
-- MAX: Returns the largest value of a selected column.
-- MIN: Returns the smallest value of a selected column.


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

-- Practical Questions with Aggregate Functions

-- 1. Count the total number of employees.
SELECT
    COUNT(*) AS TotalEmployees
FROM Employees;

-- 2. Calculate the total salary paid to all employees.
SELECT
    SUM(Salary) AS TotalSalary
FROM Employees;

-- 3. Find the average salary of employees.
SELECT
    AVG(Salary) AS AverageSalary
FROM Employees;

-- 4. Find the maximum salary among employees.
SELECT
    MAX(Salary) AS MaxSalary
FROM Employees;

-- 5. Find the minimum salary among employees.
SELECT
    MIN(Salary) AS MinSalary
FROM Employees;

-- 6. Calculate the total hours worked by each employee on projects.
SELECT
    EmployeeID,
    SUM(HoursWorked) AS TotalHours
FROM EmployeeProjects
GROUP BY EmployeeID;

-- 7. Find the average number of hours worked per project for each employee.
SELECT
    EmployeeID,
    AVG(HoursWorked) AS AverageHoursPerProject
FROM EmployeeProjects
GROUP BY EmployeeID;

-- 8. Calculate the total salary paid to employees in each department.
SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

-- 9. Find the employee with the highest total salary paid, including all recorded salaries.
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    SUM(s.Amount) AS TotalSalaryPaid
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSalaryPaid DESC
LIMIT 1;

-- 10. Calculate the average salary for employees in each department, but only include departments with more than one employee.
SELECT
    DepartmentID,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

-- Notes on Commands:
-- COUNT: Returns the number of rows that matches a specified criterion.
-- SUM: Returns the total sum of a numeric column.
-- AVG: Returns the average value of a numeric column.
-- MAX: Returns the largest value of a selected column.
-- MIN: Returns the smallest value of a selected column.


