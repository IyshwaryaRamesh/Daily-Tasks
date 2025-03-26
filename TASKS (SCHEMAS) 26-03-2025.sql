CREATE DATABASE SourceDB;
GO

CREATE DATABASE TargetDB;
GO

USE SourceDB;
GO

CREATE SCHEMA CustomSchema AUTHORIZATION dbo;
GO

CREATE TABLE CustomSchema.Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT,
    Department NVARCHAR(50)
);

INSERT INTO CustomSchema.Employees (EmployeeID, Name, Age, Department)
VALUES (1, 'Alice', 30, 'HR'),
       (2, 'Bob', 28, 'IT'),
       (3, 'Charlie', 35, 'Finance');

USE TargetDB;
GO

-- TASK 1

SELECT * INTO dbo.Employees FROM SourceDB.CustomSchema.Employees;

ALTER TABLE dbo.Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID); --just to avoid duplication 

--task 2

USE TargetDB;
GO

CREATE SCHEMA CustomSchema AUTHORIZATION dbo;
GO

SELECT * INTO TargetDB.CustomSchema.Employees FROM SourceDB.CustomSchema.Employees;

--task 3

USE TargetDB;
GO

CREATE LOGIN UserA WITH PASSWORD = 'SecurePass123'; --Authentication 
CREATE USER UserA FOR LOGIN UserA;

GRANT SELECT ON SCHEMA::CustomSchema TO UserA; --only can read/select data

REVOKE ALTER ON SCHEMA::CustomSchema FROM UserA; --permanently deny the access to alter
DENY CONTROL ON SCHEMA::CustomSchema TO UserA; --can't perform any actions on table like insert, update, drop


