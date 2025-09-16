-- Q-10) STORED PROCEDURES & FUNCTIONS

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

--  3) 	Consider the relations
    --           Customer(cust_id, cust_name, address)
    --           Order(ord_no, cust_id, ord_date, ship_date, status, comments)
    --           Field “Status” takes values like “delivered”, “pending”, “shipped” “cancelled”. 
    --       Insert few records and create a stored procedure to return the count of orders delivered, pending, shipped and cancelled.

-- ---------------------------------------------------
-- Step 1: Create tables
-- ---------------------------------------------------
CREATE TABLE Customer (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE `Order` (
    ord_no INT PRIMARY KEY,
    cust_id INT,
    ord_date DATE,
    ship_date DATE,
    status VARCHAR(20),
    comments VARCHAR(100),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

-- ---------------------------------------------------
-- Step 2: Insert sample records
-- ---------------------------------------------------
INSERT INTO Customer VALUES
(1, 'Alice', 'Kozhikode'),
(2, 'Bob', 'Bangalore'),
(3, 'Charlie', 'Chennai');

INSERT INTO `Order` VALUES
(101, 1, '2025-01-01', '2025-01-05', 'delivered', 'On time'),
(102, 1, '2025-01-03', NULL, 'pending', 'Awaiting stock'),
(103, 2, '2025-01-04', '2025-01-07', 'shipped', 'Dispatched via courier'),
(104, 3, '2025-01-05', NULL, 'cancelled', 'Customer cancelled'),
(105, 2, '2025-01-06', '2025-01-09', 'delivered', 'Late delivery');

-- ---------------------------------------------------
-- Step 3: Create stored procedure to return counts
-- ---------------------------------------------------
DELIMITER $$

CREATE PROCEDURE GetOrderStatusCounts()
BEGIN
    SELECT 
        SUM(status = 'delivered') AS delivered_count,
        SUM(status = 'pending') AS pending_count,
        SUM(status = 'shipped') AS shipped_count,
        SUM(status = 'cancelled') AS cancelled_count
    FROM `Order`;
END$$

DELIMITER ;

-- ---------------------------------------------------
-- Step 4: Call the procedure
-- ---------------------------------------------------
CALL GetOrderStatusCounts();

+-----------------+---------------+---------------+-----------------+
| delivered_count | pending_count | shipped_count | cancelled_count |
+-----------------+---------------+---------------+-----------------+
|               2 |             1 |             1 |               1 |
+-----------------+---------------+---------------+-----------------+

-- 4)  Create a function to find the factorial of a number passed as parameter.

DELIMITER $$

CREATE FUNCTION factorial(n INT) 
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE result BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT 1;

    IF n < 0 THEN
        RETURN NULL; -- factorial is not defined for negative numbers
    END IF;

    WHILE i <= n DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;

    RETURN result;
END$$

DELIMITER ;

--  Testing the functions

SELECT factorial(5); 

+--------------+
| factorial(5) |
+--------------+
|          120 |
+--------------+
    
SELECT factorial(0); 

+--------------+
| factorial(0) |
+--------------+
|            1 |
+--------------+

SELECT factorial(10); 

+---------------+
| factorial(10) |
+---------------+
|       3628800 |
+---------------+

-- 5)  Write a function to check a number is perfect, abundant or deficient.

DELIMITER $$

CREATE FUNCTION CHECK_NUMBER_TYPE(n INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE sum_div INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;

    -- Loop through divisors
    WHILE i <= n/2 DO
        IF n % i = 0 THEN
            SET sum_div = sum_div + i;
        END IF;
        SET i = i + 1;
    END WHILE;

    -- Compare sum of divisors
    IF sum_div = n THEN
        RETURN 'PERFECT';
    ELSEIF sum_div > n THEN
        RETURN 'ABUNDANT';
    ELSE
        RETURN 'DEFICIENT';
    END IF;
END$$

DELIMITER ;

--  Testing the functions

SELECT CHECK_NUMBER_TYPE(6) AS NUM_6,
       CHECK_NUMBER_TYPE(12) AS NUM_12,
       CHECK_NUMBER_TYPE(8) AS NUM_8;

+---------+----------+-----------+
| NUM_6   | NUM_12   | NUM_8     |
+---------+----------+-----------+
| PERFECT | ABUNDANT | DEFICIENT |
+---------+----------+-----------+
