-- Create a PL/SQL procedure to retrieve user accounts after login with a cursor
CREATE OR REPLACE PROCEDURE get_user_accounts (
    p_user_id NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    -- Declare a cursor
    OPEN p_cursor FOR
    SELECT a.number AS account_number, 
           c.currency_code AS currency, 
           a.balance
    FROM accounts a
    JOIN currencies c ON a.currency = c.currency_id
    WHERE a.user_id = p_user_id;
END;
/
