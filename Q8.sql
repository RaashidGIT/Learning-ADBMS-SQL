-- Q8)  NESTED QUERIES & JOINT OPERATIONS

-- 1)  Retrieve the name of each employee who has a dependent with the same name and is the same sex as Employee.

-- -------------------------------
-- Insert values into DEPENDENT table, which was empty all this time.
-- -------------------------------
INSERT INTO DEPENDENT VALUES(101, 'ALICE', 'F', '2005-07-21', 'DAUGHTER');
INSERT INTO DEPENDENT VALUES(102, 'BOB', 'M', '2008-10-05', 'SON');
INSERT INTO DEPENDENT VALUES(105, 'David', 'M', '2006-02-14', 'SON');
INSERT INTO DEPENDENT VALUES(104, 'Emily', 'F', '2010-06-30', 'DAUGHTER');

+------------+------------+------+------------+--------------+
| EmployeeID | DependName | Sex  | BirthDate  | Relationship |
+------------+------------+------+------------+--------------+
|        101 | ALICE      | F    | 2005-07-21 | DAUGHTER     |
|        102 | BOB        | M    | 2008-10-05 | SON          |
|        104 | Emily      | F    | 2010-06-30 | DAUGHTER     |
|        105 | David      | M    | 2006-02-14 | SON          |
+------------+------------+------+------------+--------------+

-- -------------------------------
-- Employees who have a dependent with the same name and same gender
-- -------------------------------

SELECT E.NAME
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.EMPLOYEEID = D.EMPLOYEEID
WHERE E.NAME = D.DEPENDNAME AND E.GENDER = D.SEX;

+-------+
| NAME  |
+-------+
| Alice |
| Bob   |
+-------+

-- --------------------------------------
-- 2)  Employees who have no dependents
-- --------------------------------------
SELECT E.NAME
FROM EMPLOYEE E
WHERE E.EMPLOYEEID NOT IN (
    SELECT D.EMPLOYEEID FROM DEPENDENT D
);

+---------+
| NAME    |
+---------+
| Charlie |
| Frank   |
+---------+

-- Charlie (103) and Frank (106) from EMPLOYEE table shows up in output because there is no dependent equivalent values for EmployeeID (103) and (104) in the DEPENDENT table.
----------------------------------------------------
-- 3)  Managers who have at least one dependent
----------------------------------------------------

SELECT E.NAME AS MGR_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.EMPLOYEEID = D.MANAGERID
WHERE E.EMPLOYEEID IN (
    SELECT EMPLOYEEID FROM DEPENDENT
);

+----------+
| MGR_NAME |
+----------+
| Alice    |
| Bob      |
| Eve      |
+----------+

-- ----------------------------------------------
-- Q4: Employee and their immediate supervisor
-- ----------------------------------------------

SELECT E.Name AS EMPLOYEE_NAME,
       S.Name AS SUPERVISOR_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE S 
       ON E.SuperEID = S.EmployeeID;

+---------------+-----------------+
| EMPLOYEE_NAME | SUPERVISOR_NAME |
+---------------+-----------------+
| Alice         | NULL            |
| Bob           | Alice           |
| Charlie       | Alice           |
| Diana         | Charlie         |
| Eve           | Alice           |
| Frank         | Eve             |
+---------------+-----------------+
