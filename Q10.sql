--  Creating a new database

CREATE DATABASE Q9;

--  Using that database

USE Q9;

-- 1)  Create a procedure to generate all the prime numbers below the given number and count them

DELIMITER $$

CREATE PROCEDURE GeneratePrimes(IN limit_num INT)
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE j INT;
    DECLARE isPrime BOOLEAN;
    DECLARE prime_count INT DEFAULT 0;

    DROP TEMPORARY TABLE IF EXISTS PrimeNumbers;
    CREATE TEMPORARY TABLE PrimeNumbers (prime INT);

    prime_loop: WHILE i < limit_num DO
        SET j = 2;
        SET isPrime = TRUE;

        inner_loop: WHILE j <= SQRT(i) DO
            IF i % j = 0 THEN
                SET isPrime = FALSE;
                LEAVE inner_loop;
            END IF;
            SET j = j + 1;
        END WHILE inner_loop;

        IF isPrime THEN
            INSERT INTO PrimeNumbers VALUES(i);
            SET prime_count = prime_count + 1;
        END IF;

        SET i = i + 1;
    END WHILE prime_loop;

    SELECT * FROM PrimeNumbers;
    SELECT prime_count AS Total_Primes;
END$$

DELIMITER ;

CALL GeneratePrimes(20);

+-------+
| prime |
+-------+
|     2 |
|     3 |
|     5 |
|     7 |
|    11 |
|    13 |
|    17 |
|    19 |
+-------+

+--------------+
| Total_Primes |
+--------------+
|            8 |
+--------------+

-- 2)  Procedure to update salary of an employee & fetch top 5 highest-paid employees

CREATE TABLE PR_EMPLOYEE(
    EMP_ID INT PRIMARY KEY,
    ENAME VARCHAR(10),
    BASIC DECIMAL(10,2),
    DEPT VARCHAR(20)
);

INSERT INTO PR_EMPLOYEE VALUES
(1,"GOVIND",30000,'IT'),
(2,"AYUSH",35000,'HR'),
(3,"RAASHID",50000,'FINANCE'),
(4,"ANU",45000,'IT'),
(5,"LAL",50000,'FINANCE'),
(6,"MEENA",28000,'HR'),
(7,"RAJ",60000,'IT'),
(8,"HARI",40000,'HR'),
(9,"ARAVIND",47000,'FINANCE'),
(10,"GOKUL",52000,'IT');

+--------+---------+----------+---------+
| EMP_ID | ENAME   | BASIC    | DEPT    |
+--------+---------+----------+---------+
|      1 | GOVIND  | 30000.00 | IT      |
|      2 | AYUSH   | 35000.00 | HR      |
|      3 | RAASHID | 50000.00 | FINANCE |
|      4 | ANU     | 45000.00 | IT      |
|      5 | LAL     | 50000.00 | FINANCE |
|      6 | MEENA   | 28000.00 | HR      |
|      7 | RAJ     | 60000.00 | IT      |
|      8 | HARI    | 40000.00 | HR      |
|      9 | ARAVIND | 47000.00 | FINANCE |
|     10 | GOKUL   | 52000.00 | IT      |
+--------+---------+----------+---------+

--  Write a procedure to update the value

DELIMITER $$

CREATE PROCEDURE UPDATE_SAL(
    IN p_emp_id INT,
    IN p_percent DECIMAL(5,2)
)
BEGIN
    UPDATE PR_EMPLOYEE
    SET BASIC = BASIC + (BASIC * p_percent / 100)
    WHERE EMP_ID = p_emp_id;
END$$

DELIMITER ;

--  Call the function

CALL UPDATE_SAL(3, 10);        -- Increase RAASHID salary by 10%

+--------+---------+----------+---------+
| EMP_ID | ENAME   | BASIC    | DEPT    |
+--------+---------+----------+---------+
|      1 | GOVIND  | 30000.00 | IT      |
|      2 | AYUSH   | 35000.00 | HR      |
|      3 | RAASHID | 55000.00 | FINANCE |
|      4 | ANU     | 45000.00 | IT      |
|      5 | LAL     | 50000.00 | FINANCE |
|      6 | MEENA   | 28000.00 | HR      |
|      7 | RAJ     | 60000.00 | IT      |
|      8 | HARI    | 40000.00 | HR      |
|      9 | ARAVIND | 47000.00 | FINANCE |
|     10 | GOKUL   | 52000.00 | IT      |
+--------+---------+----------+---------+

--  Fetching the top 5 highest earners

SELECT ENAME, BASIC AS SALARY, DEPT
FROM PR_EMPLOYEE
ORDER BY BASIC DESC
LIMIT 5;

+---------+----------+---------+
| ENAME   | SALARY   | DEPT    |
+---------+----------+---------+
| RAJ     | 60000.00 | IT      |
| RAASHID | 55000.00 | FINANCE |
| GOKUL   | 52000.00 | IT      |
| LAL     | 50000.00 | FINANCE |
| ARAVIND | 47000.00 | FINANCE |
+---------+----------+---------+

