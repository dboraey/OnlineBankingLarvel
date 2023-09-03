-- Create a PL/SQL procedure to perform debit or credit transaction on an account
CREATE OR REPLACE PROCEDURE add_transaction (
    p_account_number VARCHAR2,
    p_transaction_type VARCHAR2, -- 'DEBIT' or 'CREDIT'
    p_transaction_amount NUMBER
) AS
    v_account_id NUMBER;
    v_balance NUMBER;
BEGIN
    -- Get the account ID and current balance
    SELECT id, balance
    INTO v_account_id, v_balance
    FROM accounts
    WHERE number = p_account_number;

    -- Check if the account exists
    IF v_account_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Account not found.');
        RETURN;
    END IF;

    -- Perform the transaction
    IF p_transaction_type = 'DEBIT' THEN
        IF p_transaction_amount <= v_balance THEN
            -- Debit the account balance
            UPDATE accounts
            SET balance = balance - p_transaction_amount
            WHERE id = v_account_id;
            
			  -- Insert a transaction record
            INSERT INTO transaction (account_id, type, transaction_date, amount)
            VALUES (v_account_id, 'DEBIT', SYSTIMESTAMP, p_transaction_amount);

            DBMS_OUTPUT.PUT_LINE('Debit transaction successful. New balance: ' || (v_balance - p_transaction_amount));
        ELSE
            DBMS_OUTPUT.PUT_LINE('Insufficient balance for debit transaction.');
        END IF;
    ELSIF p_transaction_type = 'CREDIT' THEN
        -- Credit the account balance
        UPDATE accounts
        SET balance = balance + p_transaction_amount
        WHERE id = v_account_id;
        
		  -- Insert a transaction record
        INSERT INTO transaction (account_id, type, transaction_date, amount)
        VALUES (v_account_id, 'CREDIT', SYSTIMESTAMP, p_transaction_amount);


        DBMS_OUTPUT.PUT_LINE('Credit transaction successful. New balance: ' || (v_balance + p_transaction_amount));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid transaction type.');
    END IF;
    
    COMMIT;
END;
/
