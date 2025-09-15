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
