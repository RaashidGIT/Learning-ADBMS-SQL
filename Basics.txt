-- List all databases
SHOW DATABASES;

-- Create a new database
CREATE DATABASE dbname;

-- Use a database
USE dbname;

-- Delete a database
DROP DATABASE dbname;

-- List all tables in current database
SHOW TABLES;

-- Show table structure (columns, types, keys, etc.)
DESCRIBE table_name;
-- OR
SHOW COLUMNS FROM table_name;

-- Create a new table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2),
    DeptID INT
);

-- Delete a table
DROP TABLE Employee;

-- Change table name
RENAME TABLE old_table TO new_table;

-- Insert data
INSERT INTO Employee (EmpID, Name, Salary, DeptID)
VALUES (1, 'Alice', 50000, 101);

-- View all rows
SELECT * FROM Employee;

-- Update data
UPDATE Employee
SET Salary = 60000
WHERE EmpID = 1;

-- Delete data
DELETE FROM Employee
WHERE EmpID = 1;

-- Add Primary Key
ALTER TABLE Employee ADD PRIMARY KEY (EmpID);

-- Add Foreign Key
ALTER TABLE Employee
ADD CONSTRAINT fk_dept FOREIGN KEY (DeptID) REFERENCES Department(DeptID);

-- Drop Constraint
ALTER TABLE Employee DROP FOREIGN KEY fk_dept;

-- Show current database
SELECT DATABASE();

-- Show user
SELECT USER();

-- Show server version
SELECT VERSION();

-- Show current date & time
SELECT NOW();

-- Show all indexes of a table
SHOW INDEX FROM Employee;
