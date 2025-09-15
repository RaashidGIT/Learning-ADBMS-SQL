-- 1)  Find the sum of salaries of all employees, the maximum salary, the minimum salary, and the average salary. 

select sum(salary),max(salary),min(salary),avg(salary) from employee;

-- 2)  Count the number of projects handled in each department.

select dnumber as departmentnumber,
    -> count(pnumber) as numberofprojects from project
    -> group by dnumber;

-- 3)  Count number of employees working in each department. 

select dnumber as departmentnumber ,
    -> count(employeeid) as numberofemployees
    -> from employee group by dnumber; 

select d.dname as departmentname ,
    -> e.dnumber as departmentnumber,
    -> count(e.employeeid) as numberofemployee
    -> from employee e join department d on e.dnumber = d.dnumber
    -> group by e.dnumber,d.dname;

-- 4) Find the department number and maximum salary of those departments where minimum salary is greater than 10000 rupees.

