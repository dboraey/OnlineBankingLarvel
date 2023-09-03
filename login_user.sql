-- Create a PL/SQL login procedure
CREATE OR REPLACE PROCEDURE login_user (
    p_username VARCHAR2,
    p_password VARCHAR2,
    p_success OUT VARCHAR2,
    p_user_id OUT NUMBER
) AS
BEGIN
    -- Initialize the output parameters
    p_success := 'FAILURE';
    p_user_id := NULL;

    -- Check if the provided username and password exist in the "users" table
    SELECT id
    INTO p_user_id
    FROM users
    WHERE username = p_username AND password = p_password;

    -- If a matching user is found, set success to 'SUCCESS'
    IF p_user_id IS NOT NULL THEN
        p_success := 'SUCCESS';
    END IF;
END;
/


