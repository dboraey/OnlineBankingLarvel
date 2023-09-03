-- Create a PL/SQL procedure to retrieve transaction history for an account
CREATE OR REPLACE PROCEDURE get_account_transaction_history (
    p_account_number VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    -- Declare a cursor
    OPEN p_cursor FOR
    SELECT t.id AS transaction_id, 
           t.transaction_date,
           t.amount,
           t.transaction_type,
           a.number AS account_number
    FROM transaction t
    JOIN accounts a ON t.account_id = a.id
    WHERE a.number = p_account_number
    ORDER BY t.transaction_date DESC;
END;
/
