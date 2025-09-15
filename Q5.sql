-- 1)  Retrieve all employees whose name begins with Á’.

SELECT * FROM EMPLOYEE WHERE NAME LIKE 'A%';

+-------+------------+------------+------------+--------+----------+----------+---------+
| Name  | EmployeeID | BirthDate  | HouseName  | Gender | Salary   | SuperEID | Dnumber |
+-------+------------+------------+------------+--------+----------+----------+---------+
| Alice |        101 | 1985-04-12 | Rose Villa | F      | 15000.00 |     NULL |       1 |
+-------+------------+------------+------------+--------+----------+----------+---------+

-- 2)  Find all employees who were born during 1990s (1990-1999).

SELECT * FROM EMPLOYEE WHERE BIRTHDATE LIKE '199%';

+-------+------------+------------+--------------+--------+----------+----------+---------+
| Name  | EmployeeID | BirthDate  | HouseName    | Gender | Salary   | SuperEID | Dnumber |
+-------+------------+------------+--------------+--------+----------+----------+---------+
| Bob   |        102 | 1990-09-21 | Green House  | M      | 15000.00 |      101 |       1 |
| Diana |        104 | 1992-07-18 | Lake View    | F      | 15000.00 |      103 |       2 |
| Frank |        106 | 1995-11-30 | Sunrise Home | M      |  8000.00 |      105 |       3 |
+-------+------------+------------+--------------+--------+----------+----------+---------+
