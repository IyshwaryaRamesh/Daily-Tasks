CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 60000),
(2, 'Bob', 'Finance', 55000),
(3, 'Charlie', 'HR', 48000),
(4, 'David', 'HR', 52000),
(5, 'Eve', 'IT', 70000);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderAmount DECIMAL(10,2)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 101, '2024-02-01', 200),
(2, 102, '2024-02-02', 150),
(3, 101, '2024-02-05', 300),
(4, 103, '2024-02-10', 250),
(5, 101, '2024-02-15', 400);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 201, 10, '2024-03-01'),
(2, 202, 5, '2024-03-02'),
(3, 201, 7, '2024-03-03'),
(4, 203, 3, '2024-03-04');

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount) VALUES
(1, 301, '2024-02-25', 100),
(2, 302, '2024-03-05', 250),
(3, 303, '2024-03-10', 300);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    StockQuantity INT
);

INSERT INTO Products (ProductID, ProductName, Price, StockQuantity) VALUES
(1, 'Laptop', 1000, 50),
(2, 'Mouse', 20, 200),
(3, 'Keyboard', 30, 80);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(100),
    Email VARCHAR(100),
    Status VARCHAR(20)
);

INSERT INTO Users (UserID, Username, Email, Status) VALUES
(1, 'JohnDoe', 'john@example.com', 'inactive'),
(2, 'JaneDoe', 'jane@example.com', 'active'),
(3, 'MikeSmith', 'mike@example.com', 'inactive');

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, Name, City) VALUES
(101, 'Alice Johnson', 'New York'),
(102, 'Bob Williams', 'Los Angeles'),
(103, 'Charlie Brown', 'Chicago');

SELECT Name 
FROM Employees 
WHERE Department = 'HR' 
AND Salary > 50000;

SELECT CustomerID, COUNT(*) AS DuplicateCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID;

SELECT * 
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());

UPDATE Products
SET Price = Price * 1.10
WHERE StockQuantity < 100;

--

ALTER TABLE Users ADD LastLoginDate DATE;

UPDATE Users
SET LastLoginDate = '2023-03-10' WHERE UserID = 1;
UPDATE Users
SET LastLoginDate = '2024-03-01' WHERE UserID = 2;
UPDATE Users
SET LastLoginDate = '2023-01-15' WHERE UserID = 3;

DELETE FROM Users
WHERE Status = 'inactive'
AND LastLoginDate < DATEADD(YEAR, -1, GETDATE());

SELECT * FROM Orders;

SELECT C.CustomerID, C.Name, SUM(O.OrderAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name;

SELECT Name 
FROM Employees E1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees E2
    WHERE E1.Department = E2.Department
);

