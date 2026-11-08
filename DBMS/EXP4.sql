CREATE TABLE Department (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL UNIQUE
);

CREATE TABLE Student (
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    age NUMBER CHECK (age >= 17 AND age <= 30),
    email VARCHAR2(50) UNIQUE,
    gender VARCHAR2(20) DEFAULT 'Not Specified',
    dept_id NUMBER,
    CONSTRAINT fk_dept
        FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES (1, 'Computer Science');
INSERT INTO Department VALUES (2, 'Electronics');

INSERT INTO Student
(roll_no, name, age, email, gender, dept_id)
VALUES
(101, 'Arun', 20, 'arun@email.com', 'Male', 1);

INSERT INTO Student
(roll_no, name, age, email, dept_id)
VALUES
(102, 'Priya', 21, 'priya@email.com', 2);

SELECT * FROM Department;

SELECT * FROM Student;

-- PART 7: TEST NOT NULL CONSTRAINT
-- Execute separately to test the error

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES (103, NULL, 22, 'test1@email.com', 1);

-- PART 8: TEST UNIQUE CONSTRAINT
-- Execute separately to test the error

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES (104, 'Kumar', 23, 'arun@email.com', 1);

-- PART 9: TEST PRIMARY KEY CONSTRAINT
-- Execute separately to test the error

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES (101, 'Ravi', 22, 'ravi@email.com', 1);

-- PART 10: TEST CHECK CONSTRAINT
-- Execute separately to test the error

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES (105, 'Sita', 35, 'sita@email.com', 1);

-- PART 11: TEST FOREIGN KEY CONSTRAINT
-- Execute separately to test the error

-- INSERT INTO Student
-- (roll_no, name, age, email, dept_id)
-- VALUES (106, 'Meena', 20, 'meena@email.com', 9);

-- PART 12: ADD AN ADDITIONAL CHECK CONSTRAINT

ALTER TABLE Student
ADD CONSTRAINT chk_name CHECK (LENGTH(name) >= 3);

DESC Student;

SELECT * FROM Student;

COMMIT;