-- Q-11) TRIGGERS

-- 1)  1.	Create a table Student (id, name, dob) and insert few records. Create trigger to prevent updating and deletion from the student table.

CREATE TABLE STUDENT(
    ROLLNO INT PRIMARY KEY,
    NAME VARCHAR(20),
    DOB DATE
);

-- Insert sample records
INSERT INTO STUDENT VALUES(1,'ANU','2003-08-16');
INSERT INTO STUDENT VALUES(2,'RAHUL','2003-01-01');
INSERT INTO STUDENT VALUES(3,'MEENA','2003-12-04');

+--------+-------+------------+
| ROLLNO | NAME  | DOB        |
+--------+-------+------------+
|      1 | ANU   | 2003-08-16 |
|      2 | RAHUL | 2003-01-01 |
|      3 | MEENA | 2003-12-04 |
+--------+-------+------------+

-- Trigger to prevent UPDATE
DELIMITER $$
CREATE TRIGGER PREVENT_UPDATE_STUDENT
BEFORE UPDATE ON STUDENT
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'UPDATE NOT ALLOWED';
END$$
DELIMITER ;

-- Trigger to prevent DELETE
DELIMITER $$
CREATE TRIGGER PREVENT_DELETE_STUDENT
BEFORE DELETE ON STUDENT
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'DELETION NOT ALLOWED';
END$$
DELIMITER ;

-- ✅ Test Inserts (will work)
INSERT INTO STUDENT VALUES(4,'RAGHU','2003-08-16');

-- ❌ Test Update (will fail)
UPDATE STUDENT SET NAME='HELLO' WHERE ROLLNO=1;

-- ❌ Test Delete (will fail)
DELETE FROM STUDENT WHERE ROLLNO=2;


-- View current student records
SELECT * FROM STUDENT;

+--------+-------+------------+
| ROLLNO | NAME  | DOB        |
+--------+-------+------------+
|      1 | ANU   | 2003-08-16 |
|      2 | RAHUL | 2003-01-01 |
|      3 | MEENA | 2003-12-04 |
|      4 | RAGHU | 2003-08-16 |
+--------+-------+------------+

-- 2)  Consider the schema: -
                -- Product (prod_id, prod_name, price, quantity_available) 
                -- Sale (sale_id, prod_id, quantity)
        -- Create a trigger to update the quantity in stock after each sale.

-- Drop old tables if they exist
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Product;

-- Step 1: Create Product table
CREATE TABLE Product (
    prodid INT PRIMARY KEY,
    prod_name VARCHAR(50),
    price DECIMAL(10,2),
    quantity_available INT
);

-- Step 2: Insert sample products
INSERT INTO Product VALUES (1, 'LAPTOP', 60000, 10);
INSERT INTO Product VALUES (2, 'MOBILE', 25000, 20);
INSERT INTO Product VALUES (3, 'HEADPHONES', 2000, 50);

--  Output BEFORE Trigger fires (initial stock)
SELECT * FROM Product;

+--------+------------+----------+--------------------+
| prodid | prod_name  | price    | quantity_available |
+--------+------------+----------+--------------------+
|      1 | LAPTOP     | 60000.00 |                 10 |
|      2 | MOBILE     | 25000.00 |                 20 |
|      3 | HEADPHONES |  2000.00 |                 50 |
+--------+------------+----------+--------------------+

-- Step 3: Create Sale table
CREATE TABLE Sale (
    sale_id INT PRIMARY KEY,
    prod_id INT,
    quantity INT,
    FOREIGN KEY (prod_id) REFERENCES Product(prodid)
);

-- Step 4: Create Trigger to update stock after each sale
DELIMITER $$

CREATE TRIGGER update_quantity_after_sale
AFTER INSERT ON Sale
FOR EACH ROW
BEGIN
    UPDATE Product
    SET quantity_available = quantity_available - NEW.quantity
    WHERE prodid = NEW.prod_id;
END$$

DELIMITER ;

-- Step 5: Insert sales (this should auto update stock)
INSERT INTO Sale VALUES (101, 1, 2);   -- Laptop: 10 → 8
INSERT INTO Sale VALUES (102, 2, 5);   -- Mobile: 20 → 15
INSERT INTO Sale VALUES (103, 3, 10);  -- Headphones: 50 → 40

--  Output AFTER Trigger fires (updated stock)
SELECT * FROM Product;

+--------+------------+----------+--------------------+
| prodid | prod_name  | price    | quantity_available |
+--------+------------+----------+--------------------+
|      1 | LAPTOP     | 60000.00 |                 10 |
|      2 | MOBILE     | 25000.00 |                 20 |
|      3 | HEADPHONES |  2000.00 |                 50 |
+--------+------------+----------+--------------------+

+--------+------------+----------+--------------------+
| prodid | prod_name  | price    | quantity_available |
+--------+------------+----------+--------------------+
|      1 | LAPTOP     | 60000.00 |                  8 |
|      2 | MOBILE     | 25000.00 |                 15 |
|      3 | HEADPHONES |  2000.00 |                 40 |
+--------+------------+----------+--------------------+

-- 3)  Drop the trigger created in Q1

-- Drop trigger that prevents UPDATE
DROP TRIGGER IF EXISTS PREVENT_UPDATE_STUDENT;

-- Drop trigger that prevents DELETE
DROP TRIGGER IF EXISTS PREVENT_DELETE_STUDENT;
