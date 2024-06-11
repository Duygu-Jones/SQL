-----------------------------Day-10: DEFINING DATA (DDL)----------------------------------
------------------------- CREATE Table - ALTER Table - DROP Table-------------------------


-- Create 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    hire_date DATE,
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Insert data into 'employees' table
INSERT INTO employees VALUES 
(1, 'John', 'Doe', '1985-03-15', '2010-07-01', 1, 75000.00),
(2, 'Jane', 'Smith', '1990-06-24', '2012-08-15', 2, 60000.00),
(3, 'Sam', 'Brown', '1988-11-30', '2015-01-10', 1, 80000.00);

-- Create 'departments' table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert data into 'departments' table
INSERT INTO departments VALUES 
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Sales');

------------------------------------ Practical Questions on Defining Data:--------------------------

-- 1. Add a new column 'email' to the 'employees' table.
ALTER TABLE employees
ADD email VARCHAR(100);
-- NOTE: Adds a new column 'email' to the 'employees' table.

-- 2. Change the data type of the 'salary' column in the 'employees' table to INT.
ALTER TABLE employees
ALTER COLUMN salary INT;
-- NOTE: Changes the data type of the 'salary' column to INT in the 'employees' table.

-- 3. Rename the 'departments' table to 'dept'.
ALTER TABLE departments
RENAME TO dept;
-- NOTE: Renames the 'departments' table to 'dept'.

-- 4. Drop the 'birth_date' column from the 'employees' table.
ALTER TABLE employees
DROP COLUMN birth_date;
-- NOTE: Drops the 'birth_date' column from the 'employees' table.

-- 5. Add a NOT NULL constraint to the 'department_name' column in the 'dept' table.
ALTER TABLE dept
ALTER COLUMN department_name SET NOT NULL;
-- NOTE: Adds a NOT NULL constraint to the 'department_name' column in the 'dept' table.

-- 6. Create a new table 'projects' with columns 'project_id', 'project_name', 'start_date', 'end_date'.
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);
-- NOTE: Creates a new table 'projects' with specified columns.

-- 7. Add a foreign key constraint to the 'department_id' column in the 'employees' table referencing the 'dept' table.
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES dept(department_id);
-- NOTE: Adds a foreign key constraint to the 'department_id' column in the 'employees' table referencing 'dept' table.

-- 8. Drop the 'projects' table.
DROP TABLE projects;
-- NOTE: Drops the 'projects' table.

-- 9. Rename the 'first_name' column to 'fname' and 'last_name' column to 'lname' in the 'employees' table.
ALTER TABLE employees
RENAME COLUMN first_name TO fname;
ALTER TABLE employees
RENAME COLUMN last_name TO lname;
-- NOTE: Renames the 'first_name' column to 'fname' and 'last_name' column to 'lname' in the 'employees' table.

-- 10. Create a new table 'salaries' with columns 'employee_id', 'salary_date', 'amount', and add a foreign key constraint to 'employee_id'.
CREATE TABLE salaries (
    employee_id INT,
    salary_date DATE,
    amount DECIMAL(10, 2),
    PRIMARY KEY (employee_id, salary_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
-- NOTE: Creates a new table 'salaries' with specified columns and a foreign key constraint on 'employee_id'.






------------------------ADDITIONAL PRACTICE AND NOTES FOR ALTER TABLE:
-- Create 'companies' table
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50)
);

-- Insert data into 'companies' table
INSERT INTO companies VALUES 
(101, 'TechCorp'),
(102, 'HealthInc'),
(103, 'EduGlobal'),
(104, 'AutoWorks');

-- Create 'orders' table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    company_id INT,
    order_date DATE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- Insert data into 'orders' table
INSERT INTO orders VALUES 
(1, 101, '2024-01-01'),
(2, 102, '2024-01-02'),
(3, 103, '2024-01-03'),
(4, 104, '2024-01-04'),
(5, 105, '2024-01-05'); -- This will cause a foreign key violation

-- Create 'employees' table
CREATE TABLE employees (
    employee_id CHAR(9),
    name VARCHAR(50),
    city_of_birth VARCHAR(50),
    salary REAL
);

-- Insert data into 'employees' table
INSERT INTO employees VALUES
('123456789', 'John Doe', 'New York', 50000),
('234567890', 'Jane Smith', 'Los Angeles', 60000),
('345678901', 'Emily Davis', 'Chicago', 70000);

-- ALTER TABLE: Used to update a table: DDL --------------------------------------------------------------------------------
/*
    add column ==> adds a new column
    drop column ==> removes an existing column
    rename column.. to.. ==> renames a column
    rename.. to.. ==> renames the table
*/

-- Add a new column 'age' (int) to the 'employees' table.
ALTER TABLE employees
ADD COLUMN age INT;
-- Adds a new column 'age' to the 'employees' table. The new column will have a default value of NULL.

-- Add a new column 'remote' (boolean) to the 'employees' table with a default value of TRUE.
ALTER TABLE employees
ADD COLUMN remote BOOLEAN DEFAULT TRUE;
-- Adds a new column 'remote' to the 'employees' table with a default value of TRUE.

-- Drop the 'age' column from the 'employees' table.
ALTER TABLE employees
DROP COLUMN age;
-- Removes the 'age' column from the 'employees' table.

-- Update the data type of the 'salary' column in the 'employees' table to REAL.
ALTER TABLE employees
ALTER COLUMN salary TYPE REAL;
-- Changes the data type of the 'salary' column to REAL in the 'employees' table.

-- Rename the 'salary' column to 'income' in the 'employees' table.
ALTER TABLE employees
RENAME COLUMN salary TO income;
-- Renames the 'salary' column to 'income' in the 'employees' table.

-- Rename the 'employees' table to 'staff'.
ALTER TABLE employees
RENAME TO staff;
-- Renames the 'employees' table to 'staff'.

-- Update the data type of the 'employee_id' column in the 'staff' table to VARCHAR.
ALTER TABLE staff
ALTER COLUMN employee_id TYPE VARCHAR(20);
-- Changes the data type of the 'employee_id' column to VARCHAR in the 'staff' table.

-- Update the data type of the 'employee_id' column in the 'staff' table back to INT.
ALTER TABLE staff
ALTER COLUMN employee_id TYPE INT USING employee_id::INT;
-- Changes the data type of the 'employee_id' column back to INT in the 'staff' table, using casting.

-- Add a NOT NULL constraint to the 'name' column in the 'staff' table.
ALTER TABLE staff
ALTER COLUMN name SET NOT NULL;
-- Adds a NOT NULL constraint to the 'name' column in the 'staff' table.

-- Add a PRIMARY KEY constraint to the 'company_id' column in the 'companies' table.
ALTER TABLE companies
ADD PRIMARY KEY(company_id);
-- Adds a PRIMARY KEY constraint to the 'company_id' column in the 'companies' table.

-- Add a UNIQUE constraint to the 'company_name' column in the 'companies' table.
ALTER TABLE companies
ADD UNIQUE(company_name);
-- Adds a UNIQUE constraint to the 'company_name' column in the 'companies' table.

-- Optionally, a named constraint can be added. If no name is provided, the column name is used by default.
ALTER TABLE companies
ADD CONSTRAINT unique_company_name UNIQUE(company_name);
-- Adds a UNIQUE constraint to the 'company_name' column with a specific name.

-- Add a FOREIGN KEY constraint to the 'company_id' column in the 'orders' table.
-- The 'orders' and 'companies' tables are related through the 'company_id' column.
ALTER TABLE orders
ADD FOREIGN KEY(company_id) REFERENCES companies(company_id);
-- Adds a FOREIGN KEY constraint to the 'company_id' column in the 'orders' table.

-- Remove orders with company_id 104 and 105 to resolve foreign key constraint issues.
DELETE FROM orders WHERE company_id IN (104, 105);
-- Deletes records from 'orders' table where 'company_id' is 104 or 105.

-- Drop the FOREIGN KEY constraint from the 'orders' table.
ALTER TABLE orders
DROP CONSTRAINT orders_company_id_fkey;
-- Removes the FOREIGN KEY constraint from the 'company_id' column in the 'orders' table.

-- Remove the NOT NULL constraint from the 'name' column in the 'staff' table.
ALTER TABLE staff
ALTER COLUMN name DROP NOT NULL;
-- Removes the NOT NULL constraint from the 'name' column in the 'staff' table.

-- Select all data from the 'staff' table.
SELECT * FROM staff;

-- Select all data from the 'companies' table.
SELECT * FROM companies;

-- Select all data from the 'orders' table.
SELECT * FROM orders;








