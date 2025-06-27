-- scenerio 1: Apply 1% discount to interest rates for customers above 60
BEGIN
    FOR cust IN (
        SELECT CustomerID, DOB
        FROM Customers
    ) LOOP
        DECLARE
            v_age NUMBER;
        BEGIN
            v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12);

            IF v_age > 60 THEN
                UPDATE Loans
                SET InterestRate = InterestRate - 1
                WHERE CustomerID = cust.CustomerID;

                -- Optional: log the update (only visible if DBMS_OUTPUT is ON)
                DBMS_OUTPUT.PUT_LINE('Interest rate updated for Customer ID: ' || cust.CustomerID || ', Age: ' || v_age);
            END IF;
        END;
    END LOOP;
    COMMIT;
END;
/
----SQL query to see the effect
SELECT 
    L.LoanID, 
    C.CustomerID,
    C.Name, 
    TO_CHAR(C.DOB, 'DD-MON-YYYY') AS DOB,
    FLOOR(MONTHS_BETWEEN(SYSDATE, C.DOB)/12) AS Age,
    L.InterestRate
FROM Loans L
JOIN Customers C ON L.CustomerID = C.CustomerID;
