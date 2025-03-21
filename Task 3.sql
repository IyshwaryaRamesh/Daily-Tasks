create database empl;
use empl;
CREATE TABLE employees (
    id INT PRIMARY KEY,  
    name VARCHAR(50),  
    age INT,             
    salary DECIMAL(10,2) 
);

ALTER TABLE employees 
ADD CONSTRAINT chk_age CHECK (age >= 18);

ALTER TABLE employees 
ADD CONSTRAINT chk_salary CHECK (salary >= 30000);

ALTER TABLE employees 
ALTER COLUMN name VARCHAR(50) NOT NULL;

ALTER TABLE employees 
ALTER COLUMN age INT NOT NULL;

ALTER TABLE employees 
ALTER COLUMN salary DECIMAL(10,2) NOT NULL;

SELECT name, definition 
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('employees');

SELECT COLUMN_NAME, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'employees';

INSERT INTO employees (id, name, age, salary) 
VALUES (1, 'Alice', 25, 50000);

INSERT INTO employees (id, name, age, salary) 
VALUES (2, 'Bob', 16, 40000);  


