CREATE DATABASE IF NOT EXISTS CollegeDB;

USE CollegeDB;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 17 AND age <= 30),
    email VARCHAR(50) UNIQUE,
    gender VARCHAR(10) DEFAULT 'Not Specified',
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 6),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
CREATE TABLE Enrollment (
    roll_no INT,
    course_id INT,
    marks INT CHECK (marks BETWEEN 0 AND 100),
    PRIMARY KEY (roll_no, course_id),
    FOREIGN KEY (roll_no) REFERENCES Student(roll_no),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical');

INSERT INTO Student
(roll_no, name, age, email, gender, dept_id)
VALUES
(101, 'Arun', 20, 'arun@email.com', 'Male', 1),
(102, 'Priya', 21, 'priya@email.com', 'Female', 2),
(103, 'Kumar', 22, 'kumar@email.com', 'Male', 1),
(104, 'Sita', 19, 'sita@email.com', 'Female', 3),
(105, 'Meena', 23, 'meena@email.com', 'Female', 2);

INSERT INTO Course
(course_id, course_name, credits, dept_id)
VALUES
(1, 'Data Structures', 4, 1),
(2, 'Digital Circuits', 3, 2),
(3, 'Thermodynamics', 4, 3),
(4, 'DBMS', 4, 1);
INSERT INTO Enrollment
(roll_no, course_id, marks)
VALUES
(101, 1, 85),
(101, 4, 78),
(102, 2, 60),
(102, 4, 55),
(103, 1, 90),
(103, 4, 88),
(104, 3, 70),
(105, 2, 45);

SELECT * FROM Department;

-- SAMPLE OUTPUT:
-- +---------+------------------+
-- | dept_id | dept_name        |
-- +---------+------------------+
-- | 1       | Computer Science |
-- | 2       | Electronics      |
-- | 3       | Mechanical       |
-- +---------+------------------+


SELECT * FROM Student;

-- SAMPLE OUTPUT:
-- +---------+-------+-----+-----------------+--------+---------+
-- | roll_no | name  | age | email           | gender | dept_id |
-- +---------+-------+-----+-----------------+--------+---------+
-- | 101     | Arun  | 20  | arun@email.com  | Male   | 1       |
-- | 102     | Priya | 21  | priya@email.com | Female | 2       |
-- | 103     | Kumar | 22  | kumar@email.com | Male   | 1       |
-- | 104     | Sita  | 19  | sita@email.com  | Female | 3       |
-- | 105     | Meena | 23  | meena@email.com | Female | 2       |
-- +---------+-------+-----+-----------------+--------+---------+


SELECT * FROM Course;

-- SAMPLE OUTPUT:
-- +-----------+-----------------+---------+---------+
-- | course_id | course_name     | credits | dept_id |
-- +-----------+-----------------+---------+---------+
-- | 1         | Data Structures | 4       | 1       |
-- | 2         | Digital Circuits| 3       | 2       |
-- | 3         | Thermodynamics  | 4       | 3       |
-- | 4         | DBMS            | 4       | 1       |
-- +-----------+-----------------+---------+---------+


SELECT * FROM Enrollment;

-- SAMPLE OUTPUT:
-- +---------+-----------+-------+
-- | roll_no | course_id | marks |
-- +---------+-----------+-------+
-- | 101     | 1         | 85    |
-- | 101     | 4         | 78    |
-- | 102     | 2         | 60    |
-- | 102     | 4         | 55    |
-- | 103     | 1         | 90    |
-- | 103     | 4         | 88    |
-- | 104     | 3         | 70    |
-- | 105     | 2         | 45    |
-- +---------+-----------+-------+
SELECT name, dept_id
FROM Student
WHERE dept_id IN (
    SELECT dept_id
    FROM Department
    WHERE dept_name IN ('Computer Science', 'Mechanical')
);

-- SAMPLE OUTPUT:
-- +-------+---------+
-- | name  | dept_id |
-- +-------+---------+
-- | Arun  | 1       |
-- | Kumar | 1       |
-- | Sita  | 3       |
-- +-------+---------+

SELECT name
FROM Student
WHERE roll_no NOT IN (
    SELECT roll_no
    FROM Enrollment
    WHERE course_id = 4
);

-- SAMPLE OUTPUT:
-- +-------+
-- | name  |
-- +-------+
-- | Sita  |
-- | Meena |
-- +-------+

SELECT DISTINCT s.name, e.marks
FROM Student s
JOIN Enrollment e ON s.roll_no = e.roll_no
WHERE e.marks > ANY (
    SELECT marks
    FROM Enrollment
    WHERE course_id = 2
);

-- SAMPLE OUTPUT:
-- +-------+-------+
-- | name  | marks |
-- +-------+-------+
-- | Arun  | 85    |
-- | Arun  | 78    |
-- | Priya | 55    |
-- | Kumar | 90    |
-- | Kumar | 88    |
-- | Sita  | 70    |
-- +-------+-------+

SELECT DISTINCT dept_id
FROM Course
WHERE credits = ANY (
    SELECT credits
    FROM Course
    WHERE dept_id = 1
);

-- SAMPLE OUTPUT:
-- +---------+
-- | dept_id |
-- +---------+
-- | 1       |
-- | 3       |
-- +---------+

SELECT DISTINCT s.name, e.marks
FROM Student s
JOIN Enrollment e ON s.roll_no = e.roll_no
WHERE e.marks > ALL (
    SELECT marks
    FROM Enrollment
    WHERE course_id = 2
);

-- SAMPLE OUTPUT:
-- +-------+-------+
-- | name  | marks |
-- +-------+-------+
-- | Arun  | 85    |
-- | Kumar | 90    |
-- | Kumar | 88    |
-- | Sita  | 70    |
-- +-------+-------+

SELECT course_name, credits
FROM Course
WHERE credits >= ALL (
    SELECT credits
    FROM Course
    WHERE dept_id = (
        SELECT dept_id
        FROM Department
        WHERE dept_name = 'Electronics'
    )
);

-- SAMPLE OUTPUT:
-- +-----------------+---------+
-- | course_name     | credits |
-- +-----------------+---------+
-- | Data Structures | 4       |
-- | Digital Circuits| 3       |
-- | Thermodynamics  | 4       |
-- | DBMS            | 4       |
-- +-----------------+---------+

SELECT dept_name
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Student s
    WHERE s.dept_id = d.dept_id
);

-- SAMPLE OUTPUT:
-- +------------------+
-- | dept_name        |
-- +------------------+
-- | Computer Science |
-- | Electronics      |
-- | Mechanical       |
-- +------------------+

SELECT name
FROM Student s
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollment e
    WHERE e.roll_no = s.roll_no
);

-- SAMPLE OUTPUT:
-- Empty set


-- Departments that offer NO courses

SELECT dept_name
FROM Department d
WHERE NOT EXISTS (
    SELECT 1
    FROM Course c
    WHERE c.dept_id = d.dept_id
);

SELECT roll_no
FROM Enrollment
WHERE course_id = 4 AND marks > 80

UNION

SELECT roll_no
FROM Enrollment
WHERE course_id = 1 AND marks > 80;

-- SAMPLE OUTPUT:
-- +---------+
-- | roll_no |
-- +---------+
-- | 101     |
-- | 103     |
-- +---------+

SELECT roll_no
FROM Enrollment
WHERE course_id = 4 AND marks > 80

UNION ALL

SELECT roll_no
FROM Enrollment
WHERE course_id = 1 AND marks > 80;

-- SAMPLE OUTPUT:
-- +---------+
-- | roll_no |
-- +---------+
-- | 103     |
-- | 101     |
-- | 103     |
-- +---------+


-- ============================================================
-- PART 12: INTERSECT OPERATOR
-- Students enrolled in BOTH course 1 and course 4
-- ============================================================

-- INTERSECT is supported in MySQL 8.0.31 and later.
-- Uncomment the following query if your DBMS supports it.

-- SELECT roll_no
-- FROM Enrollment
-- WHERE course_id = 1
-- INTERSECT
-- SELECT roll_no
-- FROM Enrollment
-- WHERE course_id = 4;

-- MySQL-compatible alternative:

SELECT roll_no
FROM Enrollment
WHERE course_id = 1
AND roll_no IN (
    SELECT roll_no
    FROM Enrollment
    WHERE course_id = 4
);

-- SAMPLE OUTPUT:
-- +---------+
-- | roll_no |
-- +---------+
-- | 101     |
-- | 103     |
-- +---------+


-- ============================================================
-- PART 13: EXCEPT / MINUS (BONUS)
-- Students in course 1 but NOT in course 4
-- ============================================================

-- EXCEPT support depends on your DBMS version.
-- MySQL-compatible alternative:

SELECT roll_no
FROM Enrollment
WHERE course_id = 1
AND roll_no NOT IN (
    SELECT roll_no
    FROM Enrollment
    WHERE course_id = 4
);

-- SAMPLE OUTPUT:
-- Empty set


-- ============================================================
-- PART 14: CONSTRAINT VIOLATION TESTS
-- Execute each query separately to test the constraints.
-- These statements are commented out to prevent errors
-- from interrupting the script.
-- ============================================================


-- NOT NULL constraint violation

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES
-- (106, NULL, 22, 'test1@email.com', 1);

-- EXPECTED ERROR:
-- Column 'name' cannot be null


-- UNIQUE constraint violation

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES
-- (107, 'Ravi', 23, 'arun@email.com', 1);

-- EXPECTED ERROR:
-- Duplicate entry 'arun@email.com' for key 'email'


-- CHECK constraint violation

-- INSERT INTO Enrollment
-- (roll_no, course_id, marks)
-- VALUES
-- (101, 2, 150);
-- EXPECTED ERROR:
-- Check constraint is violated
-- FOREIGN KEY constraint violation
-- INSERT INTO Enrollment
-- (roll_no, course_id, marks)
-- VALUES
-- (999, 1, 70);
-- EXPECTED ERROR:
-- A foreign key constraint fails

SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;