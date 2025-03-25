USE SalesDB;

--SELECT * FROM Salesman WHERE name = 'Mc Lyon';
-- 1
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE salesman_id = (SELECT salesman_id FROM Salesman WHERE name = 'Mc Lyon');
--2
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE salesman_id IN (SELECT salesman_id FROM Salesman WHERE city = 'London');
--3
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE salesman_id IN (SELECT salesman_id FROM Customer WHERE customer_id = 3007);
--4
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE ord_date = '2012-10-10' 
AND purch_amt > (SELECT AVG(purch_amt) FROM Orders WHERE ord_date = '2012-10-10');
--5
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE salesman_id IN (SELECT salesman_id FROM Salesman WHERE city = 'New York');
--6
SELECT commission 
FROM Salesman 
WHERE city = 'Paris';
--7
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE salesman_id = (SELECT salesman_id FROM Salesman WHERE name = 'Mc Lyon') 
AND customer_id < 2001;
--8
SELECT grade, COUNT(*) AS customer_count 
FROM Customer 
WHERE city = 'New York' 
AND grade > (SELECT AVG(grade) FROM Customer) 
GROUP BY grade;
--9
SELECT ord_no, purch_amt, ord_date, salesman_id 
FROM Orders 
WHERE salesman_id = (SELECT salesman_id FROM Salesman WHERE commission = (SELECT MAX(commission) FROM Salesman));
--10
SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id, c.cust_name 
FROM Orders o 
JOIN Customer c ON o.customer_id = c.customer_id 
WHERE o.ord_date = '2012-08-17';

--or

SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id,
       (SELECT cust_name FROM Customer WHERE Customer.customer_id = Orders.customer_id) AS cust_name
FROM Orders 
WHERE ord_date = '2012-08-17';

--11
SELECT salesman_id, name 
FROM Salesman 
WHERE salesman_id IN (
    SELECT salesman_id 
    FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) > 1
);

--12
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE purch_amt > (SELECT AVG(purch_amt) FROM Orders);

--13
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE purch_amt >= (SELECT AVG(purch_amt) FROM Orders);

--14
SELECT * FROM Customer 
WHERE EXISTS (
    SELECT 1 FROM Customer WHERE city = 'London'
);

--15
SELECT * FROM Customer 
WHERE EXISTS (
    SELECT 1 FROM Customer WHERE city = 'London'
);

--16
SELECT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
WHERE s.salesman_id IN (
    SELECT salesman_id FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) > 1
);

--17
SELECT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
WHERE s.salesman_id IN (
    SELECT salesman_id FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) = 1
);

--18
SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
JOIN Customer c ON s.salesman_id = c.salesman_id
WHERE c.customer_id IN (
    SELECT customer_id FROM Orders 
    GROUP BY customer_id 
    HAVING COUNT(ord_no) > 1
);

--19
SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
WHERE s.city IN (SELECT DISTINCT city FROM Customer);

--20
SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
WHERE EXISTS (
    SELECT 1 FROM Customer c WHERE c.city = s.city
);

--21
SELECT s.salesman_id, s.name, s.city, s.commission 
FROM Salesman s
WHERE s.name < ANY (
    SELECT cust_name FROM Customer
);

--22
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE grade > ALL (
    SELECT grade FROM Customer 
    WHERE city > 'New York'
);

--23
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE purch_amt > ANY (
    SELECT purch_amt FROM Orders 
    WHERE ord_date = '2012-09-10'
);

--24
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE purch_amt < ANY (
    SELECT purch_amt FROM Orders 
    WHERE customer_id IN (
        SELECT customer_id FROM Customer WHERE city = 'London'
    )
);

--25
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id 
FROM Orders 
WHERE purch_amt < (
    SELECT MAX(purch_amt) FROM Orders 
    WHERE customer_id IN (
        SELECT customer_id FROM Customer WHERE city = 'London'
    )
);

--26
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE grade > ALL (
    SELECT grade FROM Customer WHERE city = 'New York'
);

--27
SELECT s.name, s.city, SUM(o.purch_amt) AS total_order_amt 
FROM Salesman s
JOIN Orders o ON s.salesman_id = o.salesman_id
WHERE s.city IN (SELECT DISTINCT city FROM Customer)
GROUP BY s.salesman_id, s.name, s.city;

--28
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE grade NOT IN (
    SELECT DISTINCT grade FROM Customer WHERE city = 'London'
);

--29
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE grade NOT IN (
    SELECT DISTINCT grade FROM Customer WHERE city = 'Paris'
);

--30
SELECT customer_id, cust_name, city, grade, salesman_id 
FROM Customer 
WHERE NOT EXISTS (
    SELECT 1 FROM Customer c2 
    WHERE c2.city = 'Dallas' AND c2.grade = Customer.grade
);

--31

CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(50),
    pro_price DECIMAL(10,2),
    pro_com INT
);

CREATE TABLE company_mast (
    com_id INT PRIMARY KEY,
    com_name VARCHAR(50)
);

INSERT INTO company_mast VALUES
(11, 'Samsung'),
(12, 'iBall'),
(13, 'Epsion'),
(14, 'Zebronics'),
(15, 'Asus'),
(16, 'Frontech');

INSERT INTO item_mast VALUES
(101, 'Mother Board', 3200.00, 15),
(102, 'Key Board', 450.00, 16),
(103, 'ZIP drive', 250.00, 14),
(104, 'Speaker', 550.00, 16),
(105, 'Monitor', 5000.00, 11),
(106, 'DVD drive', 900.00, 12),
(107, 'CD drive', 800.00, 12),
(108, 'Printer', 2600.00, 13),
(109, 'Refill cartridge', 350.00, 13),
(110, 'Mouse', 250.00, 12);

SELECT c.com_name, AVG(i.pro_price) AS avg_price 
FROM item_mast i 
JOIN company_mast c ON i.pro_com = c.com_id 
GROUP BY c.com_name;

--32

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'company_mast';

--33

SELECT i.PRO_NAME AS Product_Name, i.PRO_PRICE AS Price, c.COM_NAME AS Company
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
WHERE i.PRO_PRICE = (
    SELECT MAX(PRO_PRICE)
    FROM item_mast
    WHERE PRO_COM = i.PRO_COM
);

--34
CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept INT
);

INSERT INTO emp_details VALUES
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);

SELECT EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT
FROM emp_details
WHERE EMP_LNAME IN ('Gabriel', 'Dosio');

--35
SELECT EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT
FROM emp_details
WHERE EMP_DEPT IN (89, 63);

--36
CREATE TABLE emp_department (
    dpt_code INT PRIMARY KEY,
    dpt_name VARCHAR(50),
    dpt_allotment DECIMAL(10,2)
);

INSERT INTO emp_department VALUES
(57, 'IT', 65000),
(63, 'Finance', 15000),
(47, 'HR', 240000),
(27, 'RD', 55000),
(89, 'QC', 75000);

SELECT e.EMP_FNAME, e.EMP_LNAME
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE
WHERE d.DPT_ALLOTMENT > 50000;

--37
SELECT DPT_CODE, DPT_NAME, DPT_ALLOTMENT
FROM emp_department
WHERE DPT_ALLOTMENT > (SELECT AVG(DPT_ALLOTMENT) FROM emp_department);

--38
SELECT d.DPT_NAME
FROM emp_department d
JOIN emp_details e ON d.DPT_CODE = e.EMP_DEPT
GROUP BY d.DPT_NAME
HAVING COUNT(e.EMP_IDNO) > 2;

--39
WITH RankedDepartments AS (
    SELECT DPT_ALLOTMENT, 
           RANK() OVER (ORDER BY DPT_ALLOTMENT ASC) AS Rank
    FROM emp_department
)
SELECT e.EMP_FNAME, e.EMP_LNAME
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE
WHERE d.DPT_ALLOTMENT = (
    SELECT DPT_ALLOTMENT FROM RankedDepartments WHERE Rank = 2
);























