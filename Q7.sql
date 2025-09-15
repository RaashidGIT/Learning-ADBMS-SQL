-- 1) Make list of all project numbers for projects that involve an employee whose name is “Raju” either as a worker or as a manager of the department that controls project.

SELECT PNUMBER
FROM WORKS_ON
WHERE EMPLOYEEID IN (
    SELECT EMPLOYEEID
    FROM EMPLOYEE
    WHERE NAME = 'ALICE'
)
UNION
SELECT P.PNUMBER
FROM PROJECT P
JOIN DEPARTMENT D ON P.DNUMBER = D.DNUMBER
JOIN EMPLOYEE E ON D.MANAGERID = E.EMPLOYEEID
WHERE E.NAME = 'ALICE';


+---------+
| PNUMBER |
+---------+
|       2 |
+---------+
