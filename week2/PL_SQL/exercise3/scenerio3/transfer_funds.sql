--scenerio 3: Transfer Funds Between Accounts
-- Add two test accounts for the same or different customer
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 1, 'Savings', 5000, SYSDATE);  -- From Account

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (4, 1, 'Checking', 2000, SYSDATE);  -- To Account

COMMIT;

-- Step 1: Create the stored procedure
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    -- Get the balance of the source account
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_from_account_id;

    -- Check if the source account has sufficient funds
    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
    END IF;

    -- Deduct from source
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_from_account_id;

    -- Add to target
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_to_account_id;

    COMMIT;
END;
/
--Execute the Procedure 
BEGIN
    TransferFunds(3, 4, 1000); -- Transfer 1000 from AccountID 3 to AccountID 4
END;
/
--verify the result
SELECT AccountID, CustomerID, AccountType, Balance
FROM Accounts
WHERE AccountID IN (3, 4);
