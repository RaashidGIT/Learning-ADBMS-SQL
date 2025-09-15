-- 1)  Insert a single record into department table. 

INSERT INTO Department (Dname, Dnumber, ManagerID, Mgr_start_date)
     VALUES ('Finance', 4, NULL, '2022-05-01');

-- 2)  Insert more than a record into Employee table using a single insert command. 

INSERT INTO Department (Dname, Dnumber, ManagerID, Mgr_start_date)
     VALUES ('HR', 1, NULL, '2021-03-15'),
            ('IT', 2, NULL, '2020-07-10'),
            ('Sales', 3, NULL, '2023-01-05');

+---------+---------+-----------+----------------+
| Dname   | Dnumber | ManagerID | Mgr_start_date |
+---------+---------+-----------+----------------+
| HR      |       1 |      NULL | 2021-03-15     |
| IT      |       2 |      NULL | 2020-07-10     |
| Sales   |       3 |      NULL | 2023-01-05     |
| Finance |       4 |      NULL | 2022-05-01     |
+---------+---------+-----------+----------------+

-- 3)  Update the employee table to set the salary of all employees to Rs15000/- whom are getting a (salary > 10,000).

 UPDATE Employee
     SET Salary = 15000
     WHERE Salary > 10000;

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

-- 4)  Move a project “P1” of department no D1 to another department D2. 

UPDATE Project
     SET Dnumber = 2
     WHERE Pname = 'Payroll System' AND Dnumber = 1;

+----------------------+---------+------------+---------+
| Pname                | Pnumber | Plocation  | Dnumber |
+----------------------+---------+------------+---------+
| Payroll System       |       1 | Kochi      |       1 |
| Inventory Management |       2 | Trivandrum |       2 |
| Banking App          |       3 | Kozhikode  |       3 |
+----------------------+---------+------------+---------+

+----------------------+---------+------------+---------+
| Pname                | Pnumber | Plocation  | Dnumber |
+----------------------+---------+------------+---------+
| Payroll System       |       1 | Kochi      |       2 |
| Inventory Management |       2 | Trivandrum |       2 |
| Banking App          |       3 | Kozhikode  |       3 |
+----------------------+---------+------------+---------+

-- 5)  Delete only those who are working on a particular project say ‘’P1’’.

DELETE FROM Works_on
    -> WHERE Pnumber = 1;

+------------+---------+-------+
| EmployeeID | Pnumber | Hours |
+------------+---------+-------+
|        101 |       1 |  10.0 |
|        101 |       2 |   5.0 |
|        102 |       1 |  15.0 |
|        103 |       2 |  20.0 |
|        104 |       2 |  10.0 |
|        104 |       3 |  12.0 |
|        105 |       3 |  18.0 |
|        106 |       3 |  25.0 |
+------------+---------+-------+

+------------+---------+-------+
| EmployeeID | Pnumber | Hours |
+------------+---------+-------+
|        101 |       2 |   5.0 |
|        103 |       2 |  20.0 |
|        104 |       2 |  10.0 |
|        104 |       3 |  12.0 |
|        105 |       3 |  18.0 |
|        106 |       3 |  25.0 |
+------------+---------+-------+
