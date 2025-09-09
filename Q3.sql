-- 1)  List the records in the Employee table order by salary in ascending/descending order. 

SELECT *
    -> FROM Employee
    -> ORDER BY Salary ASC;

SELECT *
    -> FROM Employee
    -> ORDER BY Salary DESC;

-- 2)  Display only those Employees whose Dnumber is 30. 

SELECT * FROM EMPLOYEE WHERE DNUMBER = 3;

-- 3)  Retrieve the name and birthdate of Employee working in a particular department. 

-- Aliases are short names we give to tables (or columns) to make queries shorter and easier to read.
    -- Employee E → E is an alias for Employee table.
    -- Department D → D is an alias for Department table.
        -- Makes referencing columns easier, especially when:
        -- You join multiple tables.
        -- Tables have columns with the same name (like Dnumber exists in both tables)
            -- SQL is case insensitive, meaning Alias E is the same as Alias e.

SELECT E.name,e.birthdate from employee e join department D on e.Dnumber = D.dnumber where d.dname='HR';

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

-- 5)  List the employees who work in more than one project.

SELECT e.Name,e.EmployeeID,COUNT(w.Pnumber) AS Numberofprojects 
FROM Employee e JOIN Works_on w ON e.EmployeeID = w.EmployeeID 
GROUP BY e.Name,e.EmployeeID HAVING COUNT(w.Pnumber) > 1;
