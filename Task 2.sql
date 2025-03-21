create database Cust;
CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO customers (name, city) VALUES
('Alice', 'New York'),
('Bob', 'Chicago'),
('Alice', 'New York'), 
('Alice', 'New York'); 

UPDATE TOP (1) customers
SET city = 'San Francisco'
WHERE name = 'Alice' AND city = 'New York';

SELECT * FROM customers;

