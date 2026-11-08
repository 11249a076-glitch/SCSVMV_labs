CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);

INSERT INTO Department VALUES
(10, 'CSE'),
(20, 'ECE'),
(30, 'IT'),
(40, 'MECH');

SELECT * FROM Department;

-- Expected Output:
-- dept_id  dept_name
-- 10       CSE
-- 20       ECE
-- 30       IT
-- 40       MECH

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30) NOT NULL,
    dept_id INT,
    cgpa DECIMAL(3,2),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Student VALUES
(101, 'Anu', 10, 8.70),
(102, 'Bala', 10, 7.90),
(103, 'Charan', 20, 8.20),
(104, 'Divya', 30, 9.10),
(105, 'Esha', NULL, 7.50);

SELECT * FROM Student;

-- Expected Output:
-- student_id  student_name  dept_id  cgpa
-- 101         Anu           10       8.70
-- 102         Bala          10       7.90
-- 103         Charan        20       8.20
-- 104         Divya         30       9.10
-- 105         Esha          NULL     7.50

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(40) NOT NULL,
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Course VALUES
(501, 'DBMS', 10, 4),
(502, 'Data Structures', 10, 4),
(503, 'Digital Systems', 20, 3),
(504, 'Web Technology', 30, 3);

SELECT * FROM Course;

-- Expected Output:
-- course_id  course_name       dept_id  credits
-- 501        DBMS              10       4
-- 502        Data Structures   10       4
-- 503        Digital Systems   20       3
-- 504        Web Technology    30       3

CREATE TABLE Enrollment (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Enrollment VALUES
(1, 101, 501, 5, 88),
(2, 101, 502, 5, 91),
(3, 102, 501, 5, 76),
(4, 103, 503, 5, 84),
(5, 104, 504, 5, 95);

SELECT * FROM Enrollment;

-- Expected Output:
-- enroll_id  student_id  course_id  semester  marks
-- 1          101         501        5         88
-- 2          101         502        5         91
-- 3          102         501        5         76
-- 4          103         503        5         84
-- 5          104         504        5         95

SELECT s.student_id, s.student_name, d.dept_name
FROM Student s
INNER JOIN Department d
ON s.dept_id = d.dept_id;

-- Expected Output:
-- 101  Anu     CSE
-- 102  Bala    CSE
-- 103  Charan  ECE
-- 104  Divya   IT

SELECT s.student_id, s.student_name, d.dept_name
FROM Student s
LEFT JOIN Department d
ON s.dept_id = d.dept_id;

-- Expected Output:
-- 101  Anu     CSE
-- 102  Bala    CSE
-- 103  Charan  ECE
-- 104  Divya   IT
-- 105  Esha    NULL

SELECT d.dept_id, d.dept_name, s.student_name
FROM Department d
LEFT JOIN Student s
ON d.dept_id = s.dept_id
ORDER BY d.dept_id;

-- Expected Output:
-- 10  CSE   Anu
-- 10  CSE   Bala
-- 20  ECE   Charan
-- 30  IT    Divya
-- 40  MECH  NULL

SELECT s.student_name, c.course_name, e.marks
FROM Enrollment e
INNER JOIN Student s
ON e.student_id = s.student_id
INNER JOIN Course c
ON e.course_id = c.course_id
ORDER BY s.student_id, e.course_id;

-- Expected Output:
-- Anu     DBMS              88
-- Anu     Data Structures   91
-- Bala    DBMS              76
-- Charan  Digital Systems   84
-- Divya   Web Technology    95

SELECT c.course_id, c.course_name, d.dept_name
FROM Course c
INNER JOIN Department d
ON c.dept_id = d.dept_id
ORDER BY c.course_id;

-- Expected Output:
-- 501  DBMS              CSE
-- 502  Data Structures   CSE
-- 503  Digital Systems   ECE
-- 504  Web Technology    IT

SELECT d.dept_name, s.student_name
FROM Student s
RIGHT JOIN Department d
ON s.dept_id = d.dept_id
ORDER BY d.dept_id;

-- Expected Output:
-- CSE   Anu
-- CSE   Bala
-- ECE   Charan
-- IT    Divya
-- MECH  NULL

SELECT student_id, student_name, cgpa
FROM Student
WHERE cgpa > (
    SELECT AVG(cgpa)
    FROM Student
);

-- Expected Output:
-- 101  Anu    8.70
-- 104  Divya  9.10

SELECT student_id, student_name
FROM Student
WHERE dept_id = (
    SELECT dept_id
    FROM Department
    WHERE dept_name = 'CSE'
);

-- Expected Output:
-- 101  Anu
-- 102  Bala

SELECT student_id, student_name
FROM Student
WHERE student_id IN (
    SELECT student_id
    FROM Enrollment
    WHERE course_id = (
        SELECT course_id
        FROM Course
        WHERE course_name = 'DBMS'
    )
);

-- Expected Output:
-- 101  Anu
-- 102  Bala

SELECT course_id, course_name, credits
FROM Course
WHERE credits > ANY (
    SELECT credits
    FROM Course
    WHERE dept_id = 20
);

-- Expected Output:
-- 501  DBMS             4
-- 502  Data Structures  4

SELECT s.student_id, s.student_name, s.dept_id, s.cgpa
FROM Student s
WHERE s.dept_id IS NOT NULL
AND s.cgpa > (
    SELECT AVG(s2.cgpa)
    FROM Student s2
    WHERE s2.dept_id = s.dept_id
);

-- Expected Output:
-- 101  Anu  10  8.70

SELECT student_id, student_name, cgpa
FROM Student
WHERE cgpa = (
    SELECT MAX(cgpa)
    FROM Student
);

-- Expected Output:
-- 104  Divya  9.10

SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;