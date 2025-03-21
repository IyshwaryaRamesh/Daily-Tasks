create database Emp;
create table Employees (EmployeeID int primary key, Name varchar(50), Age INT CHECK (AGE>=18), Salary DECIMAL(10,2), Constraint chk_salary check (Salary >= 30000));
INSERT INTO Employees (EmployeeID, Name, Age, Salary) 
VALUES (1, 'John Doe', 25, 50000);

INSERT INTO Employees (EmployeeID, Name, Age, Salary) 
VALUES (2, 'Alice', 16, 40000); 

SELECT CONSTRAINT_NAME, CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
WHERE CONSTRAINT_NAME IN (
    SELECT CONSTRAINT_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE TABLE_NAME = 'Employees'
);

EXEC sp_helpconstraint 'Employees';

ALTER TABLE Employees DROP CONSTRAINT chk_Salary;

ALTER TABLE Employees ADD CONSTRAINT chk_NewSalary CHECK (Salary >= 35000);



