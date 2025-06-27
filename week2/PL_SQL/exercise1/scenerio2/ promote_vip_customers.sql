-- Insert a customer with a high balance to test VIP logic
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (4, 'Richie Rich', TO_DATE('1970-12-12', 'YYYY-MM-DD'), 15000, SYSDATE);

COMMIT;

-- Scenario 2: Promote to VIP if balance > 10,000
BEGIN
    FOR cust IN (
        SELECT CustomerID, Balance
        FROM Customers
    ) LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = cust.CustomerID;

            -- Optional output log
            DBMS_OUTPUT.PUT_LINE('Promoted to VIP: Customer ID ' || cust.CustomerID);
        END IF;
    END LOOP;
    COMMIT;
END;
/
--Verify VIP Customers
SELECT 
    CustomerID,
    Name,
    Balance,
    IsVIP
FROM Customers
WHERE IsVIP = 'Y';
