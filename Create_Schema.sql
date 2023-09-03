CONNECT SYS/your_password AS SYSDBA
-- Create the new schema/user "OnlineBanking"
CREATE USER OnlineBanking
  IDENTIFIED BY 'Online@2023'; -- Replace 'your_password' with the actual password

-- Grant necessary privileges to the new schema
GRANT CONNECT, RESOURCE TO OnlineBanking;
GRANT CREATE TABLE TO OnlineBanking;


-- Create the "users" table
CREATE TABLE users (
  id NUMBER PRIMARY KEY,
  name VARCHAR2(50) NOT NULL,
  email VARCHAR2(100) UNIQUE,
  Password VARCHAR2(50)
  -- Add other columns as needed
);

-- Create the "accounts" table
CREATE TABLE accounts (
  id NUMBER PRIMARY KEY,
  user_id NUMBER REFERENCES users(user_id),
  number VARCHAR2(20) NOT NULL,
  currency	NUMBER,
  balance NUMBER(10, 2) DEFAULT 0
  -- Add other columns as needed
);

-- Create the "transaction" table
CREATE TABLE transaction (
  id NUMBER PRIMARY KEY,
  account_id NUMBER REFERENCES accounts(account_id),
  type VARCHAR2(20) NOT NULL,
  transaction_date TIMESTAMP,
  amount NUMBER(10, 2) NOT NULL,
  transaction_type VARCHAR2(20) NOT NULL
);


CREATE TABLE CURRENCIES (
    currency_id NUMBER PRIMARY KEY,
    currency_code VARCHAR2(3) UNIQUE NOT NULL,
    currency_name VARCHAR2(50) NOT NULL
    -- Add other columns as needed
);


-- Insert data into the "CURRENCIES" table
INSERT INTO CURRENCIES (currency_id, currency_code, currency_name)
VALUES (840, 'USD', 'US Dollar');

INSERT INTO CURRENCIES (currency_id, currency_code, currency_name)
VALUES (978, 'EUR', 'Euro');

INSERT INTO CURRENCIES (currency_id, currency_code, currency_name)
VALUES (400, 'JOD', 'JOR Dinar');

-- Add more rows as needed
