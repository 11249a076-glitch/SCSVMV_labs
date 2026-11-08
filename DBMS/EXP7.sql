CREATE TABLE STUDENT (
    ROLLNO NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(30),
    DEPARTMENT VARCHAR2(20),
    MARKS NUMBER(3)
);

INSERT INTO STUDENT VALUES (101, 'ARUN', 'CSE', 85);
INSERT INTO STUDENT VALUES (102, 'PRIYA', 'ECE', 90);
INSERT INTO STUDENT VALUES (103, 'KUMAR', 'CSE', 78);
INSERT INTO STUDENT VALUES (104, 'DIVYA', 'IT', 88);
INSERT INTO STUDENT VALUES (105, 'RAHUL', 'CSE', 92);

COMMIT;

SELECT * FROM STUDENT;

-- Sample Output:
-- ROLLNO  NAME   DEPARTMENT  MARKS
-- 101     ARUN   CSE         85
-- 102     PRIYA  ECE         90
-- 103     KUMAR  CSE         78
-- 104     DIVYA  IT          88
-- 105     RAHUL  CSE         92

CREATE VIEW CSE_STUDENTS AS
SELECT ROLLNO, NAME, MARKS
FROM STUDENT
WHERE DEPARTMENT = 'CSE';

SELECT * FROM CSE_STUDENTS;

-- Sample Output:
-- ROLLNO  NAME   MARKS
-- 101     ARUN   85
-- 103     KUMAR  78
-- 105     RAHUL  92

DROP VIEW CSE_STUDENTS;

CREATE SEQUENCE STUDENT_SEQ
START WITH 106
INCREMENT BY 1
NOCACHE
NOCYCLE;
SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;
SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;

-- Sample Output:
-- NEXTVAL
-- 106
-- 107

INSERT INTO STUDENT
VALUES (STUDENT_SEQ.NEXTVAL, 'SNEHA', 'CSE', 89);

COMMIT;
SELECT * FROM STUDENT;

-- Sample Output:
-- The table now contains 6 students.
-- SNEHA has roll number 108 and marks 89.

-- Remove the sequence
DROP SEQUENCE STUDENT_SEQ;

CREATE INDEX IDX_STUDENT_NAME
ON STUDENT(NAME);

SELECT * FROM STUDENT
WHERE NAME = 'ARUN';

-- Sample Output:
-- ROLLNO  NAME  DEPARTMENT  MARKS
-- 101     ARUN  CSE         85
DROP INDEX IDX_STUDENT_NAME;

INSERT INTO STUDENT
VALUES (106, 'MOHAN', 'IT', 80);
SAVEPOINT SP1;

INSERT INTO STUDENT
VALUES (107, 'LATHA', 'ECE', 87);
SELECT * FROM STUDENT;

-- Sample Output:
-- Both MOHAN and LATHA are present.

-- Step 3: Roll back to the savepoint
-- This cancels the LATHA insertion only.

ROLLBACK TO SP1;
SELECT * FROM STUDENT;

-- Sample Output:
-- MOHAN remains in the table.
-- LATHA is removed because her insertion was after SP1.
-- Step 5: Save the remaining changes permanently
COMMIT;

-- ============================================================
-- 7. DIFFERENCE BETWEEN COMMIT AND ROLLBACK
-- ============================================================
-- COMMIT:
-- Saves all current transaction changes permanently.
-- ROLLBACK:
-- Cancels all uncommitted changes in the current transaction.
-- ROLLBACK TO SP1:
-- Cancels changes made after the specified savepoint,
-- while preserving changes made before that savepoint.