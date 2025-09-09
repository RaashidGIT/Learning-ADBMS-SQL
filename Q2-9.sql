// Schema description for the SQL table for the questions from (2-9) :-

-- ========================
-- 1. Create Tables
-- ========================

CREATE TABLE Department (
    Dname VARCHAR(50) NOT NULL UNIQUE,
    Dnumber INT PRIMARY KEY,
    ManagerID INT,
    Mgr_start_date DATE NOT NULL
);

CREATE TABLE Employee (
    Name VARCHAR(50) NOT NULL,
    EmployeeID INT PRIMARY KEY,
    BirthDate DATE,
    HouseName VARCHAR(100),
    Gender CHAR(1),
    Salary DECIMAL(10,2) CHECK (Salary BETWEEN 5000 AND 25000),
    SuperEID INT,
    Dnumber INT,
    FOREIGN KEY (SuperEID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber)
);

ALTER TABLE Department
ADD CONSTRAINT fk_manager FOREIGN KEY (ManagerID)
REFERENCES Employee(EmployeeID);

CREATE TABLE DeptLocations (
    Dnumber INT,
    Dlocation VARCHAR(100),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber)
);

CREATE TABLE Project (
    Pname VARCHAR(50) NOT NULL,
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(100),
    Dnumber INT NOT NULL,
    FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber)
);

CREATE TABLE Works_on (
    EmployeeID INT,
    Pnumber INT,
    Hours DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (EmployeeID, Pnumber),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (Pnumber) REFERENCES Project(Pnumber)
);

CREATE TABLE Dependent (
    EmployeeID INT,
    DependName VARCHAR(50) NOT NULL,
    Sex CHAR(1),
    BirthDate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (EmployeeID, DependName),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- ========================
-- 2. Insert Data
-- ========================

-- Insert Departments first
INSERT INTO Department (Dname, Dnumber, ManagerID, Mgr_start_date) VALUES
('HR', 1, NULL, '2020-01-10'),
('IT', 2, NULL, '2020-02-15'),
('Sales', 3, NULL, '2020-03-20'),
('Finance', 4, NULL, '2020-04-25');

-- Insert Employees
INSERT INTO Employee (Name, EmployeeID, BirthDate, HouseName, Gender, Salary, SuperEID, Dnumber) VALUES
('Alice',   101, '1985-04-12', 'Rose Villa',   'F', 20000, NULL, 1),
('Bob',     102, '1990-09-21', 'Green House',  'M', 15000, 101, 1),
('Charlie', 103, '1988-12-02', 'Blue Cottage', 'M', 18000, 101, 2),
('Diana',   104, '1992-07-18', 'Lake View',    'F', 12000, 103, 2),
('Eve',     105, '1983-03-05', 'Hill Top',     'F', 22000, 101, 3),
('Frank',   106, '1995-11-30', 'Sunrise Home', 'M',  8000, 105, 3);

-- Update Department Managers  // Automatically updates ManagerID in department table depending on the Dnumber from the Employee table
UPDATE Department SET ManagerID = 102 WHERE Dnumber = 4;  -- Finance -> Bob
UPDATE Department SET ManagerID = 101 WHERE Dnumber = 1;  -- HR -> Alice
UPDATE Department SET ManagerID = 103 WHERE Dnumber = 2;  -- IT -> Charlie
UPDATE Department SET ManagerID = 105 WHERE Dnumber = 3;  -- Sales -> Eve

-- Insert Projects
INSERT INTO Project (Pname, Pnumber, Plocation, Dnumber) VALUES
('Payroll System', 1, 'Kochi', 1),
('Inventory Management', 2, 'Trivandrum', 2),
('Banking App', 3, 'Kozhikode', 3);

-- Insert Works_on
INSERT INTO Works_on (EmployeeID, Pnumber, Hours) VALUES
(101, 1, 10),   -- Alice works 10 hours on Payroll System
(101, 2, 5),    -- Alice works 5 hours on Inventory Management
(102, 1, 15),   -- Bob works 15 hours on Payroll System
(103, 2, 20),   -- Charlie works 20 hours on Inventory Management
(104, 2, 10),   -- Diana works 10 hours on Inventory Management
(104, 3, 12),   -- Diana works 12 hours on Banking App
(105, 3, 18),   -- Eve works 18 hours on Banking App
(106, 3, 25);   -- Frank works 25 hours on Banking App
