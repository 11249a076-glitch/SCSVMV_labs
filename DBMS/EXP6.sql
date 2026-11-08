CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Designation VARCHAR(30),
    Salary DECIMAL(10,2),
    City VARCHAR(30),
    DOJ DATE
);

INSERT INTO Employee VALUES
(1, 'Aarav Sharma', 'IT', 'Developer', 55000, 'Chennai', '2021-03-15'),
(2, 'Priya Nair', 'IT', 'Team Lead', 75000, 'Chennai', '2019-06-10'),
(3, 'Rohit Verma', 'HR', 'Executive', 35000, 'Bangalore', '2022-01-20'),
(4, 'Sneha Iyer', 'HR', 'Manager', 65000, 'Bangalore', '2018-11-05'),
(5, 'Karthik Raj', 'Finance', 'Analyst', 45000, 'Chennai', '2020-07-01'),
(6, 'Divya Menon', 'Finance', 'Manager', 70000, 'Mumbai', '2017-09-25'),
(7, 'Arjun Das', 'IT', 'Developer', 58000, 'Mumbai', '2021-12-12'),
(8, 'Fatima Khan', 'HR', 'Executive', 36000, 'Chennai', '2023-02-18'),
(9, 'Vikram Singh', 'Finance', 'Analyst', 47000, 'Bangalore', '2022-05-30'),
(10, 'Meera Pillai', 'IT', 'Developer', 59000, 'Bangalore', '2020-08-14');
SELECT * FROM Employee;

SELECT COUNT(*) AS TotalEmployees
FROM Employee;

-- Sample Output:
-- TotalEmployees
-- 10

SELECT SUM(Salary) AS TotalSalary
FROM Employee;

-- Sample Output:
-- TotalSalary
-- 545000.00

SELECT AVG(Salary) AS AverageSalary
FROM Employee;

-- Sample Output:
-- AverageSalary
-- 54500.000000

SELECT
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employee;

-- Sample Output:
-- HighestSalary | LowestSalary
-- 75000.00      | 35000.00

SELECT Department, COUNT(*) AS EmpCount
FROM Employee
GROUP BY Department
ORDER BY Department;

-- Sample Output:
-- Department | EmpCount
-- Finance    | 3
-- HR         | 3
-- IT         | 4

SELECT Department, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department
ORDER BY AvgSalary DESC;

-- Sample Output:
-- Department | AvgSalary
-- IT         | 61750.00
-- Finance    | 54000.00
-- HR         | 45333.33

SELECT Department, COUNT(*) AS EmpCount
FROM Employee
GROUP BY Department
HAVING COUNT(*) > 3;

-- Sample Output:
-- Department | EmpCount
-- IT         | 4

SELECT Department, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department
HAVING AVG(Salary) > 50000
ORDER BY AvgSalary DESC;

-- Sample Output:
-- Department | AvgSalary
-- IT         | 61750.00
-- Finance    | 54000.00

SELECT Department, City, COUNT(*) AS EmpCount
FROM Employee
WHERE Salary > 40000
GROUP BY Department, City
HAVING COUNT(*) >= 2
ORDER BY Department;

-- Sample Output:
-- Department | City      | EmpCount
-- Finance    | Bangalore | 1  -- Excluded by HAVING
-- (Only groups with at least 2 qualifying employees are shown.)
-- IT         | Bangalore | 1  -- Excluded by HAVING
-- IT         | Chennai   | 2

SELECT City, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY City
HAVING SUM(Salary) > 100000
ORDER BY TotalSalary DESC;

-- Sample Output:
-- City      | TotalSalary
-- Chennai   | 210000.00
-- Bangalore | 207000.00
-- Mumbai    | 128000.00

SELECT COUNT(DISTINCT Designation) AS TotalDesignations
FROM Employee;

SELECT Department, MAX(Salary) AS MaximumSalary
FROM Employee
GROUP BY Department;

-- Sample Output:
-- Finance | 70000.00
-- HR      | 65000.00
-- IT      | 75000.00

SELECT Department, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department
HAVING AVG(Salary) < 50000;

-- Sample Output:
-- Department | AvgSalary
-- HR         | 45333.33

SELECT YEAR(DOJ) AS JoiningYear, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY YEAR(DOJ)
ORDER BY JoiningYear;

-- Sample Output:
-- JoiningYear | EmployeeCount
-- 2017        | 1
-- 2018        | 1
-- 2019        | 1
-- 2020        | 2
-- 2021        | 2
-- 2022        | 2
-- 2023        | 1

SELECT Department, COUNT(*) AS EmployeeCount,
       COUNT(DISTINCT City) AS CityCount
FROM Employee
GROUP BY Department
HAVING COUNT(DISTINCT City) > 1;

-- Sample Output:
-- Department | EmployeeCount | CityCount
-- Finance    | 3             | 3
-- HR         | 3             | 2
-- IT         | 4             | 3

SELECT City, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY City
ORDER BY TotalSalary DESC
LIMIT 1;

-- Sample Output:
-- City    | TotalSalary
-- Chennai | 210000.00

SELECT Designation, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Designation
HAVING COUNT(*) > 2
ORDER BY EmployeeCount DESC;