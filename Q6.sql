-- Q-6)  DATE FUNCTIONS

-- 1)  1.	List all employees whose age lies between 25 - 45 years

SELECT
    NAME,
    EMPLOYEEID,
    BIRTHDATE,
    TIMESTAMPDIFF(YEAR, BIRTHDATE, CURDATE()) AS AGE
FROM
    EMPLOYEE
WHERE
    TIMESTAMPDIFF(YEAR, BIRTHDATE, CURDATE()) BETWEEN 25 AND 45
ORDER BY
    AGE;

+---------+------------+------------+------+
| NAME    | EMPLOYEEID | BIRTHDATE  | AGE  |
+---------+------------+------------+------+
| Frank   |        106 | 1995-11-30 |   29 |
| Diana   |        104 | 1992-07-18 |   33 |
| Bob     |        102 | 1990-09-21 |   34 |
| Charlie |        103 | 1988-12-02 |   36 |
| Alice   |        101 | 1985-04-12 |   40 |
| Eve     |        105 | 1983-03-05 |   42 |
+---------+------------+------------+------+

-- 2)  Calculate the service period of all managers.

SELECT 
    E.EMPLOYEEID,
    E.NAME AS MANAGER_NAME,
    D.DNAME AS DEPARTMENT_NAME,
    D.MGR_START_DATE AS START_DATE,
    CONCAT(
        TIMESTAMPDIFF(YEAR, D.MGR_START_DATE, '2030-01-01'), 'YEARS',
        TIMESTAMPDIFF(MONTH, D.MGR_START_DATE, '2030-01-01') % 12, 'MONTHS'
    ) AS SERVICE_PERIOD_IN_2030 
FROM 
    EMPLOYEE E 
JOIN 
    DEPARTMENT D ON E.EMPLOYEEID = D.MANAGERID 
ORDER BY 
    MGR_START_DATE;

+------------+--------------+-----------------+------------+------------------------+
| EMPLOYEEID | MANAGER_NAME | DEPARTMENT_NAME | START_DATE | SERVICE_PERIOD_IN_2030 |
+------------+--------------+-----------------+------------+------------------------+
|        101 | Alice        | HR              | 2020-01-10 | 9YEARS11MONTHS         |
|        103 | Charlie      | IT              | 2020-02-15 | 9YEARS10MONTHS         |
|        105 | Eve          | Sales           | 2020-03-20 | 9YEARS9MONTHS          |
|        102 | Bob          | Finance         | 2020-04-25 | 9YEARS8MONTHS          |
+------------+--------------+-----------------+------------+------------------------+
