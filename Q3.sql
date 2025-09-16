-- Q-3)  RETREIVING DATA USING SELECT COMMANDS

-- 1)  List the records in the Employee table order by salary in ascending/descending order. 

SELECT *
    -> FROM Employee
    -> ORDER BY Salary ASC;

+---------+------------+------------+--------------+--------+----------+----------+---------+
| Name    | EmployeeID | BirthDate  | HouseName    | Gender | Salary   | SuperEID | Dnumber |
+---------+------------+------------+--------------+--------+----------+----------+---------+
| Frank   |        106 | 1995-11-30 | Sunrise Home | M      |  8000.00 |      105 |       3 |
| Alice   |        101 | 1985-04-12 | Rose Villa   | F      | 15000.00 |     NULL |       1 |
| Bob     |        102 | 1990-09-21 | Green House  | M      | 15000.00 |      101 |       1 |
| Charlie |        103 | 1988-12-02 | Blue Cottage | M      | 15000.00 |      101 |       2 |
| Diana   |        104 | 1992-07-18 | Lake View    | F      | 15000.00 |      103 |       2 |
| Eve     |        105 | 1983-03-05 | Hill Top     | F      | 15000.00 |      101 |       3 |
+---------+------------+------------+--------------+--------+----------+----------+---------+

SELECT *
    -> FROM Employee
    -> ORDER BY Salary DESC;

+---------+------------+------------+--------------+--------+----------+----------+---------+
| Name    | EmployeeID | BirthDate  | HouseName    | Gender | Salary   | SuperEID | Dnumber |
+---------+------------+------------+--------------+--------+----------+----------+---------+
| Alice   |        101 | 1985-04-12 | Rose Villa   | F      | 15000.00 |     NULL |       1 |
| Bob     |        102 | 1990-09-21 | Green House  | M      | 15000.00 |      101 |       1 |
| Charlie |        103 | 1988-12-02 | Blue Cottage | M      | 15000.00 |      101 |       2 |
| Diana   |        104 | 1992-07-18 | Lake View    | F      | 15000.00 |      103 |       2 |
| Eve     |        105 | 1983-03-05 | Hill Top     | F      | 15000.00 |      101 |       3 |
| Frank   |        106 | 1995-11-30 | Sunrise Home | M      |  8000.00 |      105 |       3 |
+---------+------------+------------+--------------+--------+----------+----------+---------+

-- 2)  Display only those Employees whose Dnumber is 30. 

SELECT * FROM EMPLOYEE WHERE DNUMBER = 3;

+-------+------------+------------+--------------+--------+----------+----------+---------+
| Name  | EmployeeID | BirthDate  | HouseName    | Gender | Salary   | SuperEID | Dnumber |
+-------+------------+------------+--------------+--------+----------+----------+---------+
| Eve   |        105 | 1983-03-05 | Hill Top     | F      | 15000.00 |      101 |       3 |
| Frank |        106 | 1995-11-30 | Sunrise Home | M      |  8000.00 |      105 |       3 |
+-------+------------+------------+--------------+--------+----------+----------+---------+

-- 3)  Retrieve the name and birthdate of Employee working in a particular department. 

-- Aliases are short names we give to tables (or columns) to make queries shorter and easier to read.
    -- Employee E → E is an alias for Employee table.
    -- Department D → D is an alias for Department table.
        -- Makes referencing columns easier, especially when:
        -- You join multiple tables.
        -- Tables have columns with the same name (like Dnumber exists in both tables)
            -- SQL is case insensitive, meaning Alias E is the same as Alias e.

SELECT E.name,e.birthdate from employee e join department D on e.Dnumber = D.dnumber where d.dname='HR';

+-------+------------+
| name  | birthdate  |
+-------+------------+
| Alice | 1985-04-12 |
| Bob   | 1990-09-21 |
+-------+------------+

-- 4)  For every project located in “Cochin”, list the project number, the controlling department no and the department manager’s name, Housename and birth date. 

SELECT 
    p.Pnumber,
    p.Dnumber AS ControllingDeptNo,
    e.Name AS ManagerName,
    e.HouseName,
    e.BirthDate
FROM Project p
JOIN Department d ON p.Dnumber = d.Dnumber
JOIN Employee e ON d.ManagerID = e.EmployeeID
WHERE p.Plocation = 'Kochi';

+---------+-------------------+-------------+--------------+------------+
| Pnumber | ControllingDeptNo | ManagerName | HouseName    | BirthDate  |
+---------+-------------------+-------------+--------------+------------+
|       1 |                 2 | Charlie     | Blue Cottage | 1988-12-02 |
+---------+-------------------+-------------+--------------+------------+

-- 5)  List the employees who work in more than one project.

SELECT e.Name,e.EmployeeID,COUNT(w.Pnumber) AS Numberofprojects 
FROM Employee e JOIN Works_on w ON e.EmployeeID = w.EmployeeID 
GROUP BY e.Name,e.EmployeeID HAVING COUNT(w.Pnumber) > 1;

+-------+------------+------------------+
| Name  | EmployeeID | Numberofprojects |
+-------+------------+------------------+
| Diana |        104 |                2 |
+-------+------------+------------------+
