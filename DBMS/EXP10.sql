CREATE TABLE dept (
    deptno NUMBER(2) PRIMARY KEY,
    dname  VARCHAR2(20)
);

CREATE TABLE emp (
    empno  NUMBER(4) PRIMARY KEY,
    ename  VARCHAR2(20) NOT NULL,
    job    VARCHAR2(15),
    sal    NUMBER(8,2),
    deptno NUMBER(2) REFERENCES dept(deptno)
);

CREATE TABLE emp_audit (
    audit_id  NUMBER GENERATED ALWAYS AS IDENTITY,
    empno     NUMBER,
    action    VARCHAR2(10),
    old_sal   NUMBER,
    new_sal   NUMBER,
    changed_on DATE DEFAULT SYSDATE
);

INSERT INTO dept VALUES (10, 'ACCOUNTING');
INSERT INTO dept VALUES (20, 'RESEARCH');
INSERT INTO dept VALUES (30, 'SALES');

INSERT INTO emp VALUES (101, 'SMITH', 'CLERK', 8000, 20);
INSERT INTO emp VALUES (102, 'ALLEN', 'SALESMAN', 15000, 30);
INSERT INTO emp VALUES (103, 'WARD', 'SALESMAN', 12500, 30);
INSERT INTO emp VALUES (104, 'JONES', 'MANAGER', 29750, 20);
INSERT INTO emp VALUES (105, 'KING', 'PRESIDENT', 50000, 10);

COMMIT;

SELECT * FROM dept;
SELECT * FROM emp;

DECLARE
    v_sal  emp.sal%TYPE;
    v_name emp.ename%TYPE;
BEGIN
    SELECT ename, sal
    INTO v_name, v_sal
    FROM emp
    WHERE empno = 102;

    IF v_sal >= 30000 THEN
        DBMS_OUTPUT.PUT_LINE(v_name || ': Grade A');
    ELSIF v_sal >= 10000 THEN
        DBMS_OUTPUT.PUT_LINE(v_name || ': Grade B');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_name || ': Grade C');
    END IF;
END;
/

-- Expected output:
-- ALLEN: Grade B

DECLARE
    v_job   emp.job%TYPE;
    v_sal   emp.sal%TYPE;
    v_bonus NUMBER;
BEGIN
    SELECT job, sal
    INTO v_job, v_sal
    FROM emp
    WHERE empno = 103;

    v_bonus :=
        CASE v_job
            WHEN 'SALESMAN' THEN v_sal * 0.10
            WHEN 'MANAGER'  THEN v_sal * 0.15
            ELSE v_sal * 0.05
        END;

    DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus);
END;
/

-- Expected output:
-- Bonus: 1250

DECLARE
    v_name emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_name
    FROM emp
    WHERE empno = 999;

    DBMS_OUTPUT.PUT_LINE(v_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee with that number.');

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one row returned.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Error ' || SQLCODE || ': ' || SQLERRM
        );
END;
/

-- Expected output:
-- No employee with that number.

DECLARE
    e_low_salary EXCEPTION;
    v_sal emp.sal%TYPE;
BEGIN
    SELECT sal
    INTO v_sal
    FROM emp
    WHERE empno = 101;

    IF v_sal < 10000 THEN
        RAISE e_low_salary;
    END IF;

EXCEPTION
    WHEN e_low_salary THEN
        DBMS_OUTPUT.PUT_LINE(
            'Salary below minimum: ' || v_sal
        );
END;
/

-- Expected output:
-- Salary below minimum: 8000

BEGIN
    INSERT INTO emp
    VALUES (101, 'DUP', 'CLERK', 5000, 10);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Employee number already exists'
        );
END;
/

-- Expected: ORA-20001: Employee number already exists
-- The duplicate row is not inserted.

CREATE OR REPLACE PROCEDURE raise_salary (
    p_empno   IN emp.empno%TYPE,
    p_percent IN NUMBER
) IS
BEGIN
    UPDATE emp
    SET sal = sal + sal * p_percent / 100
    WHERE empno = p_empno;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Employee not found'
        );
    END IF;

    COMMIT;
END raise_salary;
/

EXEC raise_salary(101, 10);

SELECT empno, ename, sal
FROM emp
WHERE empno = 101;

-- Expected salary for SMITH: 8800

CREATE OR REPLACE PROCEDURE get_emp_info (
    p_empno IN emp.empno%TYPE,
    p_name  OUT emp.ename%TYPE,
    p_sal   OUT emp.sal%TYPE
) IS
BEGIN
    SELECT ename, sal
    INTO p_name, p_sal
    FROM emp
    WHERE empno = p_empno;
END get_emp_info;
/

DECLARE
    v_name emp.ename%TYPE;
    v_sal  emp.sal%TYPE;
BEGIN
    get_emp_info(104, v_name, v_sal);
    DBMS_OUTPUT.PUT_LINE(v_name || ' earns ' || v_sal);
END;
/

-- Expected output:
-- JONES earns 29750

CREATE OR REPLACE PROCEDURE square_it (
    p_num IN OUT NUMBER
) IS
BEGIN
    p_num := p_num * p_num;
END square_it;
/

DECLARE
    n NUMBER := 7;
BEGIN
    square_it(n);
    DBMS_OUTPUT.PUT_LINE('Result: ' || n);
END;
/

-- Expected output:
-- Result: 49

CREATE OR REPLACE FUNCTION annual_sal (
    p_empno IN emp.empno%TYPE
)
RETURN NUMBER IS
    v_sal emp.sal%TYPE;
BEGIN
    SELECT sal
    INTO v_sal
    FROM emp
    WHERE empno = p_empno;

    RETURN v_sal * 12;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END annual_sal;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(annual_sal(102));
END;
/

-- Expected output:
-- 180000


-- Call function from SQL
SELECT ename, annual_sal(empno) AS yearly
FROM emp;

CREATE OR REPLACE TRIGGER trg_check_sal
BEFORE INSERT OR UPDATE OF sal ON emp
FOR EACH ROW
BEGIN
    IF :NEW.sal < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'Salary cannot be negative'
        );
    END IF;

    :NEW.ename := UPPER(:NEW.ename);
END;
/

CREATE OR REPLACE TRIGGER trg_emp_audit
AFTER INSERT OR UPDATE OR DELETE ON emp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO emp_audit
            (empno, action, new_sal)
        VALUES
            (:NEW.empno, 'INSERT', :NEW.sal);

    ELSIF UPDATING THEN
        INSERT INTO emp_audit
            (empno, action, old_sal, new_sal)
        VALUES
            (:OLD.empno, 'UPDATE', :OLD.sal, :NEW.sal);

    ELSIF DELETING THEN
        INSERT INTO emp_audit
            (empno, action, old_sal)
        VALUES
            (:OLD.empno, 'DELETE', :OLD.sal);
    END IF;
END;
/

UPDATE emp
SET sal = 9000
WHERE empno = 101;

DELETE FROM emp
WHERE empno = 103;

SELECT * FROM emp_audit;

ROLLBACK;

CREATE OR REPLACE TRIGGER trg_no_weekend
BEFORE INSERT OR UPDATE OR DELETE ON emp
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
        RAISE_APPLICATION_ERROR(
            -20011,
            'Changes not allowed on weekends'
        );
    END IF;
END;
/

SELECT trigger_name, status
FROM user_triggers;

BEGIN
    UPDATE emp
    SET sal = sal + 500
    WHERE deptno = 30;

    DBMS_OUTPUT.PUT_LINE(
        SQL%ROWCOUNT || ' row(s) updated'
    );

    ROLLBACK;
END;
/

-- Expected output:
-- 2 row(s) updated

DECLARE
    CURSOR c_emp IS
        SELECT ename, sal
        FROM emp
        ORDER BY sal DESC;

    v_name emp.ename%TYPE;
    v_sal  emp.sal%TYPE;
BEGIN
    OPEN c_emp;

    LOOP
        FETCH c_emp INTO v_name, v_sal;
        EXIT WHEN c_emp%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_name, 10) || v_sal
        );
    END LOOP;

    CLOSE c_emp;
END;
/

-- Expected order before the salary procedure's update:
-- KING      50000
-- JONES     29750
-- ALLEN     15000
-- WARD      12500
-- SMITH      8800