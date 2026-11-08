CREATE TABLE Employee(
    EmpID INT PRIMARY KEY,
    Name VARCHAR(30),
    Department VARCHAR(20),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee VALUES (101,'Arun','HR',35000);
INSERT INTO Employee VALUES (102,'Priya','IT',45000);
INSERT INTO Employee VALUES (103,'Kavin','Finance',50000);
INSERT INTO Employee VALUES (104,'Divya','IT',55000);

SELECT * FROM Employee;

-- SAMPLE OUTPUT:
-- +-------+-------+------------+----------+
-- | EmpID | Name  | Department | Salary   |
-- +-------+-------+------------+----------+
-- | 101   | Arun  | HR         | 35000.00 |
-- | 102   | Priya | IT         | 45000.00 |
-- | 103   | Kavin | Finance    | 50000.00 |
-- | 104   | Divya | IT         | 55000.00 |
-- +-------+-------+------------+----------+

GRANT SELECT ON Employee TO user1;

GRANT SELECT, INSERT ON Employee TO user1;

REVOKE INSERT ON Employee FROM user1;

REVOKE ALL PRIVILEGES ON Employee FROM user1;

SET AUTOCOMMIT=0;

UPDATE Employee
SET Salary=48000
WHERE EmpID=102;

SAVEPOINT SP1;

UPDATE Employee
SET Salary=60000
WHERE EmpID=104;

ROLLBACK TO SP1;

COMMIT;

SELECT * FROM Employee;

-- SAMPLE OUTPUT:
-- +-------+-------+------------+----------+
-- | EmpID | Name  | Department | Salary   |
-- +-------+-------+------------+----------+
-- | 101   | Arun  | HR         | 35000.00 |
-- | 102   | Priya | IT         | 48000.00 |
-- | 103   | Kavin | Finance    | 50000.00 |
-- | 104   | Divya | IT         | 55000.00 |
-- +-------+-------+------------+----------+

DELETE FROM Employee
WHERE EmpID=101;

ROLLBACK;

SELECT * FROM Employee;

-- SAMPLE OUTPUT:
-- +-------+-------+------------+----------+
-- | EmpID | Name  | Department | Salary   |
-- +-------+-------+------------+----------+
-- | 101   | Arun  | HR         | 35000.00 |
-- | 102   | Priya | IT         | 48000.00 |
-- | 103   | Kavin | Finance    | 50000.00 |
-- | 104   | Divya | IT         | 55000.00 |
-- +-------+-------+------------+----------+

CREATE TABLE Book(
    BookID INT PRIMARY KEY,
    Title VARCHAR(50),
    Author VARCHAR(40),
    Category VARCHAR(30),
    Price DECIMAL(8,2)
);

INSERT INTO Book VALUES
(101,'Database System','Korth','Database',550),
(102,'C Programming','Dennis Ritchie','Programming',450),
(103,'Java Programming','Herbert Schildt','Programming',650),
(104,'Python Basics','Mark Lutz','Programming',700),
(105,'Computer Networks','Andrew Tanenbaum','Networking',600);

SELECT * FROM Book;

-- SAMPLE OUTPUT:
-- +--------+-------------------+------------------+-------------+--------+
-- | BookID | Title             | Author           | Category    | Price  |
-- +--------+-------------------+------------------+-------------+--------+
-- | 101    | Database System   | Korth            | Database    | 550.00 |
-- | 102    | C Programming     | Dennis Ritchie   | Programming | 450.00 |
-- | 103    | Java Programming  | Herbert Schildt  | Programming | 650.00 |
-- | 104    | Python Basics     | Mark Lutz        | Programming | 700.00 |
-- | 105    | Computer Networks | Andrew Tanenbaum | Networking  | 600.00 |
-- +--------+-------------------+------------------+-------------+--------+

GRANT SELECT ON Book TO student1;

GRANT INSERT, UPDATE ON Book TO student1;

REVOKE UPDATE ON Book FROM student1;

REVOKE ALL PRIVILEGES ON Book FROM student1;

UPDATE Book
SET Price=Price*1.10
WHERE Category='Programming';

SELECT * FROM Book;

-- SAMPLE OUTPUT:
-- +--------+-------------------+------------------+-------------+--------+
-- | BookID | Title             | Author           | Category    | Price  |
-- +--------+-------------------+------------------+-------------+--------+
-- | 101    | Database System   | Korth            | Database    | 550.00 |
-- | 102    | C Programming     | Dennis Ritchie   | Programming | 495.00 |
-- | 103    | Java Programming  | Herbert Schildt  | Programming | 715.00 |
-- | 104    | Python Basics     | Mark Lutz        | Programming | 770.00 |
-- | 105    | Computer Networks | Andrew Tanenbaum | Networking  | 600.00 |
-- +--------+-------------------+------------------+-------------+--------+

SAVEPOINT SP_Book;

UPDATE Book
SET Price=800
WHERE BookID=104;

ROLLBACK TO SP_Book;

DELETE FROM Book
WHERE BookID=105;

ROLLBACK;

SELECT * FROM Book;

-- SAMPLE OUTPUT:
-- +--------+-------------------+------------------+-------------+--------+
-- | BookID | Title             | Author           | Category    | Price  |
-- +--------+-------------------+------------------+-------------+--------+
-- | 101    | Database System   | Korth            | Database    | 550.00 |
-- | 102    | C Programming     | Dennis Ritchie   | Programming | 450.00 |
-- | 103    | Java Programming  | Herbert Schildt  | Programming | 650.00 |
-- | 104    | Python Basics     | Mark Lutz        | Programming | 700.00 |
-- | 105    | Computer Networks | Andrew Tanenbaum | Networking  | 600.00 |
-- +--------+-------------------+------------------+-------------+--------+


