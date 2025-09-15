-- 1)  Find the sum of salaries of all employees, the maximum salary, the minimum salary, and the average salary. 

select sum(salary),max(salary),min(salary),avg(salary) from employee;

+-------------+-------------+-------------+--------------+
| sum(salary) | max(salary) | min(salary) | avg(salary)  |
+-------------+-------------+-------------+--------------+
|    83000.00 |    15000.00 |     8000.00 | 13833.333333 |
+-------------+-------------+-------------+--------------+

-- 2)  Count the number of projects handled in each department.

select dnumber as departmentnumber,
    -> count(pnumber) as numberofprojects from project
    -> group by dnumber;

+------------------+------------------+
| departmentnumber | numberofprojects |
+------------------+------------------+
|                2 |                2 |
|                3 |                1 |
+------------------+------------------+

-- 3)  Count number of employees working in each department. 

select dnumber as departmentnumber ,
    -> count(employeeid) as numberofemployees
    -> from employee group by dnumber; 

+------------------+-------------------+
| departmentnumber | numberofemployees |
+------------------+-------------------+
|                1 |                 2 |
|                2 |                 2 |
|                3 |                 2 |
+------------------+-------------------+

select d.dname as departmentname ,
    -> e.dnumber as departmentnumber,
    -> count(e.employeeid) as numberofemployee
    -> from employee e join department d on e.dnumber = d.dnumber
    -> group by e.dnumber,d.dname;

+----------------+------------------+------------------+
| departmentname | departmentnumber | numberofemployee |
+----------------+------------------+------------------+
| HR             |                1 |                2 |
| IT             |                2 |                2 |
| Sales          |                3 |                2 |
+----------------+------------------+------------------+

-- 4) Find the department number and maximum salary of those departments where minimum salary is greater than 10000 rupees.

SELECT
    ->     Dnumber,
    ->     MAX(Salary) AS MaximumSalary
    -> FROM Employee
    -> GROUP BY Dnumber
    -> HAVING MIN(Salary) > 10000;

+---------+---------------+
| Dnumber | MaximumSalary |
+---------+---------------+
|       1 |      15000.00 |
|       2 |      15000.00 |
+---------+---------------+
