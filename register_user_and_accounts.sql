-- Create a PL/SQL procedure to register a new user and add accounts
CREATE OR REPLACE PROCEDURE register_user_and_accounts (
    p_name VARCHAR2,
    p_email VARCHAR2,
    p_password VARCHAR2
) AS
    v_user_id NUMBER;
    v_eur_currency NUMBER := 978; -- Currency code for EUR
    v_jod_currency NUMBER := 400; -- Currency code for JOD
    v_usd_currency NUMBER := 840; -- Currency code for USD
	v_account_number VARCHAR2(10);
BEGIN
    -- Insert the user into the "users" table
    INSERT INTO users (id, name, email, password)
    VALUES (users_seq.nextval, p_name, p_email, p_password)
    RETURNING id INTO v_user_id;

     -- Add accounts for each currency
    v_account_number := TO_CHAR(accounts_seq.nextval) || '-' || TO_CHAR(v_eur_currency);
    INSERT INTO accounts (id, user_id, number, currency, balance)
    VALUES (accounts_seq.nextval, v_user_id, v_account_number, v_eur_currency, 0);

    v_account_number := TO_CHAR(accounts_seq.nextval) || '-' || TO_CHAR(v_jod_currency);
    INSERT INTO accounts (id, user_id, number, currency, balance)
    VALUES (accounts_seq.nextval, v_user_id, v_account_number, v_jod_currency, 0);

    v_account_number := TO_CHAR(accounts_seq.nextval) || '-' || TO_CHAR(v_usd_currency);
    INSERT INTO accounts (id, user_id, number, currency, balance)
    VALUES (accounts_seq.nextval, v_user_id, v_account_number, v_usd_currency, 0);


    -- Commit the transaction
    COMMIT;
    
    -- Display a success message
    DBMS_OUTPUT.PUT_LINE('User registered successfully with user ID: ' || v_user_id);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions (e.g., rollback, error logging)
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
