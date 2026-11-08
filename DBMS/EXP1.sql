
CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Student(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(30),
    Department VARCHAR(20),
    Age INT,
    CGPA DECIMAL(3,2)
);

INSERT INTO Student VALUES
(101, 'Anu', 'CSE', 20, 8.90);

INSERT INTO Student VALUES
(102, 'Bala', 'ECE', 21, 8.50);

INSERT INTO Student VALUES
(103, 'Charles', 'IT', 20, 9.10);

INSERT INTO Student VALUES
(104, 'Divya', 'CSE', 22, 8.70);

INSERT INTO Student VALUES
(105, 'Esha', 'AIDS', 21, 9.20);

SELECT * FROM Student;

-- SAMPLE OUTPUT:
-- +-----------+-------------+------------+-----+------+
-- | StudentID | StudentName | Department | Age | CGPA |
-- +-----------+-------------+------------+-----+------+
-- | 101       | Anu         | CSE        | 20  | 8.90 |
-- | 102       | Bala        | ECE        | 21  | 8.50 |
-- | 103       | Charles     | IT         | 20  | 9.10 |
-- | 104       | Divya       | CSE        | 22  | 8.70 |
-- | 105       | Esha        | AIDS       | 21  | 9.20 |
-- +-----------+-------------+------------+-----+------+

SELECT * FROM Student
WHERE Department = 'CSE';

-- SAMPLE OUTPUT:
-- +-----------+-------------+------------+-----+------+
-- | StudentID | StudentName | Department | Age | CGPA |
-- +-----------+-------------+------------+-----+------+
-- | 101       | Anu         | CSE        | 20  | 8.90 |
-- | 104       | Divya       | CSE        | 22  | 8.70 |
-- +-----------+-------------+------------+-----+------+

SELECT * FROM Student
WHERE CGPA > 8.8;

-- SAMPLE OUTPUT:
-- +-----------+-------------+------------+-----+------+
-- | StudentID | StudentName | Department | Age | CGPA |
-- +-----------+-------------+------------+-----+------+
-- | 101       | Anu         | CSE        | 20  | 8.90 |
-- | 103       | Charles     | IT         | 20  | 9.10 |
-- | 105       | Esha        | AIDS       | 21  | 9.20 |
-- +-----------+-------------+------------+-----+------+

SELECT * FROM Student
ORDER BY CGPA DESC;

-- SAMPLE OUTPUT:
-- +-----------+-------------+------------+-----+------+
-- | StudentID | StudentName | Department | Age | CGPA |
-- +-----------+-------------+------------+-----+------+
-- | 105       | Esha        | AIDS       | 21  | 9.20 |
-- | 103       | Charles     | IT         | 20  | 9.10 |
-- | 101       | Anu         | CSE        | 20  | 8.90 |
-- | 104       | Divya       | CSE        | 22  | 8.70 |
-- | 102       | Bala        | ECE        | 21  | 8.50 |
-- +-----------+-------------+------------+-----+------+

SELECT COUNT(*) AS TotalStudents
FROM Student;

-- SAMPLE OUTPUT:
-- +---------------+
-- | TotalStudents |
-- +---------------+
-- | 5             |
-- +---------------+

SELECT AVG(CGPA)
FROM Student;

-- SAMPLE OUTPUT:
-- +-----------+
-- | AVG(CGPA) |
-- +-----------+
-- | 8.880000  |
-- +-----------+
