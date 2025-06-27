-- Insert test customer to check loan reminder logic
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (5, 'Grace Soon', TO_DATE('1980-04-10', 'YYYY-MM-DD'), 5000, SYSDATE);

-- Insert loan due within next 30 days (e.g., 10 days from now)
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 5, 8000, 6, SYSDATE, SYSDATE + 10);

COMMIT;
--scenerio 3
-- Enable DBMS output to display messages
SET SERVEROUTPUT ON;

-- PL/SQL block to print reminders for loans due within the next 30 days
DECLARE
    v_name Customers.Name%TYPE;
    v_due_date Loans.EndDate%TYPE;
BEGIN
    FOR loan_rec IN (
        SELECT C.Name, L.EndDate
        FROM Loans L
        JOIN Customers C ON L.CustomerID = C.CustomerID
        WHERE L.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Loan for ' || loan_rec.Name || 
            ' is due on ' || TO_CHAR(loan_rec.EndDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/
