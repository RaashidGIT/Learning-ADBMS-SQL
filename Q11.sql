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
