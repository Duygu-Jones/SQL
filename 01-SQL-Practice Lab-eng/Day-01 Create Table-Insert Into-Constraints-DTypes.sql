
-----------------Day-1: CREATE DATABASE- TABLE -INSERT DATA -CONSTRAINTS -------------------


-- CREATE DATABASE: Creates a new database.
-- CREATE TABLE: Creates a new table in the database.
-- INSERT DATA: Adds new rows of data into a table.
-- CONSTRAINTS: Defines rules to limit the type of data that can go into a table to ensure data integrity.



--Scenario: Creating the Customers, Orders, and Products Tables
--We will create three tables: Customers, Orders, and Products. The relationships will be as follows:

	--Each customer can place multiple orders.
	--Each order can contain multiple products.


-- Create 'Customers' table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY, -- Primary key with auto increment
    FirstName VARCHAR(255) NOT NULL, -- First name of the customer, cannot be null
    LastName VARCHAR(255) NOT NULL, -- Last name of the customer, cannot be null
    Email VARCHAR(255) UNIQUE -- Email of the customer, must be unique
);

-- Insert data into 'Customers' table
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Johnson', 'alice.johnson@example.com');

------------------------------------------

-- Create 'Products' table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY, -- Primary key with auto increment
    ProductName VARCHAR(255) NOT NULL, -- Name of the product, cannot be null
    Price REAL NOT NULL -- Price of the product
);


-- Insert data into 'Products' table
INSERT INTO Products (ProductName, Price) VALUES
('Book', 10.99),
('Pen', 1.50),
('Notebook', 5.75);

----------------------------------------

-- Create 'Orders' table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY, -- Primary key with auto increment
    CustomerID INT NOT NULL, -- ID of the customer placing the order, cannot be null
    OrderDate DATE NOT NULL, -- Date of the order, cannot be null
    TotalAmount REAL, -- Total amount of the order
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) -- Foreign key referencing 'Customers' table
);


-- Insert data into 'Orders' table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-01-15', 25.98),
(2, '2024-02-20', 15.99),
(3, '2024-03-10', 30.50);

------------------------------------------

-- Create 'OrderDetails' table to capture the relationship between Orders and Products
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY, -- Primary key with auto increment
    OrderID INT NOT NULL, -- ID of the order
    ProductID INT NOT NULL, -- ID of the product
    Quantity INT NOT NULL, -- Quantity of the product ordered
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), -- Foreign key referencing 'Orders' table
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) -- Foreign key referencing 'Products' table
);


-- Insert data into 'OrderDetails' table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2), -- Order 1 includes 2 units of Product 1 (Book)
(1, 2, 3), -- Order 1 includes 3 units of Product 2 (Pen)
(2, 3, 1), -- Order 2 includes 1 unit of Product 3 (Notebook)
(3, 1, 1), -- Order 3 includes 1 unit of Product 1 (Book)
(3, 3, 2); -- Order 3 includes 2 units of Product 3 (Notebook)

------------------------------------------

/*------ Constraints:
 
PRIMARY KEY: 
	Ensures each row in the table has a unique identifier. 
	In this case, CustomerID, ProductID, OrderID, and OrderDetailID are primary keys.

FOREIGN KEY: 
	Enforces a link between columns in two tables. 
	Here, CustomerID in the Orders table must match a valid CustomerID in the Customers table. 
	Similarly, OrderID and ProductID in the OrderDetails table must match valid OrderID in the Orders table 
	and ProductID in the Products table, respectively.

NOT NULL: 
	Ensures that a column cannot have a NULL value. 
	For example, FirstName, LastName, and Email in the Customers table, 
	ProductName and Price in the Products table, OrderDate in the Orders table, and 
	Quantity in the OrderDetails table cannot be NULL.

UNIQUE: 
Ensures all values in a column are unique. In this case, Email in the Customers table must be unique.

 ----------------------------------------------------------*/


/*--SQL DATA TYPES:
 
1. **INT**:
   - Stores integer values.
   - Example: `CustomerID INT NOT NULL`

2. **SERIAL**:
   - Auto-incrementing integer, typically used for primary keys.
   - Example: `CustomerID SERIAL PRIMARY KEY`

3. **VARCHAR(n)**:
   - Stores variable-length character strings, where `n` defines the maximum number of characters.
   - Example: `Email VARCHAR(255) UNIQUE`

4. **CHAR(n)**:
   - Stores fixed-length character strings, where `n` defines the number of characters.
   - Example: `Code CHAR(10)`

5. **TEXT**:
   - Stores large amounts of text data.
   - Example: `Description TEXT`

6. **DATE**:
   - Stores date values (year, month, day).
   - Example: `OrderDate DATE NOT NULL`

7. **TIME**:
   - Stores time values (hour, minute, second).
   - Example: `StartTime TIME`

8. **TIMESTAMP**:
   - Stores date and time values.
   - Example: `CreatedAt TIMESTAMP`

9. **REAL**:
   - Stores floating-point numbers with single precision.
   - Example: `Price REAL NOT NULL`

10. **DOUBLE PRECISION**:
    - Stores floating-point numbers with double precision.
    - Example: `Latitude DOUBLE PRECISION`

11. **NUMERIC(p, s)**:
    - Stores exact numeric values with precision `p` and scale `s`.
    - Example: `Salary NUMERIC(10, 2)`

12. **BOOLEAN**:
    - Stores `TRUE` or `FALSE` values.
    - Example: `IsActive BOOLEAN`

13. **BLOB**:
    - Stores binary large objects, such as images or files.
    - Example: `ProfilePicture BLOB`

14. **ENUM**:
    - Stores a predefined list of values.
    - Example: `Status ENUM('Pending', 'Approved', 'Rejected')`

15. **ARRAY**:
    - Stores an array of values.
    - Example: `Tags VARCHAR(255)[]`

These data types cover a wide range of uses in SQL, providing the flexibility needed for 
various types of data storage and manipulation. 
 */



