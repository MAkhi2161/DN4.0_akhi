--scenerio 1:Monthly Interest for Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    -- Apply 1% interest to all savings accounts
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    COMMIT;
END;
/
--To Execute the Procedure
BEGIN
    ProcessMonthlyInterest;
END;
/
--To Verify the Update
SELECT AccountID, CustomerID, AccountType, Balance
FROM Accounts
WHERE AccountType = 'Savings';
