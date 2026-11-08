CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

INSERT INTO Employee
(EmpID, Name, Department, Salary, JoinDate)
VALUES
(101, 'Anjali Sharma', 'IT', 45000.00, '2023-06-15');

INSERT INTO Employee
(EmpID, Name, Department, Salary, JoinDate)
VALUES
(102, 'Ravi Kumar', 'HR', 38000.00, '2022-03-10'),
(103, 'Priya Singh', 'Finance', 52000.00, '2021-11-01'),
(104, 'Karthik Iyer', 'IT', 47000.00, '2023-01-20');

SELECT * FROM Employee;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- | 102   | Ravi Kumar    | HR         | 38000.00 | 2022-03-10 |
-- | 103   | Priya Singh   | Finance    | 52000.00 | 2021-11-01 |
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

SELECT * FROM Employee
WHERE Department = 'IT';

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

SELECT Name, Salary
FROM Employee
WHERE Salary > 40000;

-- SAMPLE OUTPUT:
-- +---------------+----------+
-- | Name          | Salary   |
-- +---------------+----------+
-- | Anjali Sharma | 45000.00 |
-- | Priya Singh   | 52000.00 |
-- | Karthik Iyer  | 47000.00 |
-- +---------------+----------+

SELECT * FROM Employee
WHERE Department = 'IT' AND Salary >= 45000;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

SELECT * FROM Employee
WHERE Salary BETWEEN 40000 AND 50000;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

SELECT * FROM Employee
WHERE Department IN ('IT', 'Finance');

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- | 103   | Priya Singh   | Finance    | 52000.00 | 2021-11-01 |
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

SELECT * FROM Employee
WHERE Name LIKE 'A%';

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- +-------+---------------+------------+----------+------------+

SELECT * FROM Employee
WHERE Department = 'IT'
ORDER BY Salary DESC;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 104   | Karthik Iyer  | IT         | 47000.00 | 2023-01-20 |
-- | 101   | Anjali Sharma | IT         | 45000.00 | 2023-06-15 |
-- +-------+---------------+------------+----------+------------+

UPDATE Employee
SET Salary = 48000.00
WHERE EmpID = 101;

SELECT * FROM Employee
WHERE EmpID = 101;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | IT         | 48000.00 | 2023-06-15 |
-- +-------+---------------+------------+----------+------------+

UPDATE Employee
SET Salary = Salary + 2000,
    Department = 'Systems'
WHERE Department = 'IT';

SELECT * FROM Employee;

-- SAMPLE OUTPUT:
-- +-------+---------------+------------+----------+------------+
-- | EmpID | Name          | Department | Salary   | JoinDate   |
-- +-------+---------------+------------+----------+------------+
-- | 101   | Anjali Sharma | Systems    | 50000.00 | 2023-06-15 |
-- | 102   | Ravi Kumar    | HR         | 38000.00 | 2022-03-10 |
-- | 103   | Priya Singh   | Finance    | 52000.00 | 2021-11-01 |
-- | 104   | Karthik Iyer  | Systems    | 49000.00 | 2023-01-20 |
-- +-------+---------------+------------+----------+------------+

DELETE FROM Employee
WHERE EmpID = 102;

DELETE FROM Employee
WHERE Salary < 40000;

ALTER TABLE Employee
ADD Email VARCHAR(100);


ALTER TABLE Employee
MODIFY COLUMN Name VARCHAR(80);

ALTER TABLE Employee
RENAME COLUMN Email TO ContactEmail;

ALTER TABLE Employee
DROP COLUMN ContactEmail;

ALTER TABLE Employee
RENAME TO Staff;
