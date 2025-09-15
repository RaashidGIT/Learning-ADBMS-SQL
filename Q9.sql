-- 1)  Create a view to display the department no, minimum salary, maximum salary and average salary in each department.

CREATE VIEW DEPT_SALARY_STATS AS
SELECT DNUMBER, 
       MIN(SALARY) AS MIN_SALARY, 
       MAX(SALARY) AS MAX_SALARY, 
       AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY DNUMBER;


SELECT * FROM DEPT_SALARY_STATS;

+---------+------------+------------+--------------+
| DNUMBER | MIN_SALARY | MAX_SALARY | AVG_SALARY   |
+---------+------------+------------+--------------+
|       1 |   15000.00 |   15000.00 | 15000.000000 |
|       2 |   15000.00 |   15000.00 | 15000.000000 |
|       3 |    8000.00 |   15000.00 | 11500.000000 |
+---------+------------+------------+--------------+

-- 2)  Create a view displaying the employee name, project name, and hours worked by her/him.

CREATE VIEW HOURS_WORKED AS
SELECT 
    E.NAME AS EMPLOYEE_NAME, 
    P.PNAME AS PROJECT_NAME, 
    W.HOURS AS WORK_HOURS
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.EMPLOYEEID = W.EMPLOYEEID
JOIN PROJECT P ON W.PNUMBER = P.PNUMBER;


SELECT * FROM HOURS_WORKED;

+---------------+----------------------+------------+
| EMPLOYEE_NAME | PROJECT_NAME         | WORK_HOURS |
+---------------+----------------------+------------+
| Alice         | Inventory Management |        5.0 |
| Charlie       | Inventory Management |       20.0 |
| Diana         | Inventory Management |       10.0 |
| Diana         | Banking App          |       12.0 |
| Eve           | Banking App          |       18.0 |
| Frank         | Banking App          |       25.0 |
+---------------+----------------------+------------+
