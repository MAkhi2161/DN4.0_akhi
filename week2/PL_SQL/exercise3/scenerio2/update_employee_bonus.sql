--scenerio2:Update Employee Bonus
--Insert a test employee for IT department
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (3, 'Charlie Clark', 'Engineer', 50000, 'IT', TO_DATE('2020-02-10', 'YYYY-MM-DD'));

COMMIT;

-- Step 1: Create the stored procedure
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percent / 100)
    WHERE Department = p_department;

    COMMIT;
END;
/

-- Step 2: Execute the procedure (example: 10% bonus to IT department)
BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

-- Step 3: View updated salaries for IT department employees
SELECT EmployeeID, Name, Department, Salary
FROM Employees
WHERE Department = 'IT';
