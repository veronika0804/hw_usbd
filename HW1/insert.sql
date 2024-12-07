CREATE DATABASE isolation_test;
\c isolation_test

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO accounts (name, balance) VALUES 
('Alice', 1000),
('Bob', 1000);