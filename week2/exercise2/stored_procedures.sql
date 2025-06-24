-- Scenario 1: Process Monthly Interest
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
  FOR rec IN (SELECT account_id, balance FROM savings_accounts) LOOP
    UPDATE savings_accounts
    SET balance = balance + (rec.balance * 0.01)
    WHERE account_id = rec.account_id;
  END LOOP;
  COMMIT;
END;
/

-- Scenario 2: Update Employee Bonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
  dept_id IN NUMBER,
  bonus_percent IN NUMBER
) AS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * bonus_percent / 100)
  WHERE department_id = dept_id;
  COMMIT;
END;
/

-- Scenario 3: Transfer Funds Between Accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
  source_account_id IN NUMBER,
  target_account_id IN NUMBER,
  amount IN NUMBER
) AS
  source_balance NUMBER;
BEGIN
  SELECT balance INTO source_balance FROM accounts WHERE account_id = source_account_id;

  IF source_balance >= amount THEN
    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = source_account_id;

    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = target_account_id;

    COMMIT;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
  END IF;
END;
/

-- Execution Section (runs right after creation)
BEGIN
  ProcessMonthlyInterest;
  UpdateEmployeeBonus(101, 10);
  TransferFunds(1001, 1002, 500);
END;
/
