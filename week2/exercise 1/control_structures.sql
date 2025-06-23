BEGIN
  -- Scenario 1
  FOR rec1 IN (SELECT customer_id, age FROM customers) LOOP
    IF rec1.age > 60 THEN
      UPDATE customers
      SET loan_interest_rate = loan_interest_rate - 1
      WHERE customer_id = rec1.customer_id;
    END IF;
  END LOOP;

  -- Scenario 2
  FOR rec2 IN (SELECT customer_id, balance FROM customers) LOOP
    IF rec2.balance > 10000 THEN
      UPDATE customers
      SET IsVIP = 'TRUE'
      WHERE customer_id = rec2.customer_id;
    END IF;
  END LOOP;

  -- Scenario 3
  FOR rec3 IN (
    SELECT c.name, l.due_date
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || rec3.name || 
                         ', your loan is due on ' || TO_CHAR(rec3.due_date, 'DD-MON-YYYY'));
  END LOOP;

  COMMIT;
END;
