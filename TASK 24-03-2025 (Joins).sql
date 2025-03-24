create database SQL_JOIN_TASK;
go

Use SQL_JOIN_TASK;
go

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

CREATE TABLE company_mast (
    com_id INT PRIMARY KEY,
    com_name VARCHAR(100)
);

CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(100),
    pro_price DECIMAL(10,2),
    pro_com INT,
    FOREIGN KEY (pro_com) REFERENCES company_mast(com_id)
);

CREATE TABLE emp_department (
    dpt_code INT PRIMARY KEY,
    dpt_name VARCHAR(100),
    dpt_allotment DECIMAL(10,2)
);

CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept INT,
    FOREIGN KEY (emp_dept) REFERENCES emp_department(dpt_code)
);

INSERT INTO salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

INSERT INTO customer VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);

INSERT INTO orders VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006);

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

INSERT INTO emp_department VALUES
(57, 'IT', 65000),
(63, 'Finance', 15000),
(47, 'HR', 240000),
(27, 'RD', 55000),
(89, 'QC', 75000);

INSERT INTO emp_details VALUES
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57);

SELECT s.name AS Salesman, c.cust_name, s.city 
FROM salesman s
JOIN customer c ON s.city = c.city;

SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;

SELECT c.cust_name, c.city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id;

SELECT c.cust_name, c.city AS customer_city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

SELECT c.cust_name, c.city AS customer_city, s.name AS Salesman, s.city AS salesman_city, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.city <> s.city AND s.commission > 0.12;

SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name AS Salesman, s.commission
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission, 
                c.customer_id, c.cust_name, c.city AS customer_city, c.grade, 
                o.ord_no, o.purch_amt, o.ord_date
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id
JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.cust_name, c.city, c.grade, s.name AS Salesman, s.city AS salesman_city
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC;

SELECT c.cust_name, c.city AS customer_city, c.grade, s.name AS Salesman, s.city AS salesman_city
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id ASC;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.ord_date ASC;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name AS Salesman, s.commission
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN salesman s ON c.salesman_id = s.salesman_id;

SELECT DISTINCT s.name AS Salesman
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
ORDER BY s.name ASC;

SELECT s.name AS Salesman, c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT DISTINCT s.name AS Salesman
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.purch_amt >= 2000 OR o.purch_amt IS NULL;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.grade IS NOT NULL;

SELECT * FROM salesman, customer;

SELECT * FROM salesman s, customer c WHERE s.city = c.city;

SELECT * FROM salesman s, customer c WHERE s.city IS NOT NULL AND c.grade IS NOT NULL;

SELECT * FROM salesman s, customer c WHERE s.city <> c.city AND c.grade IS NOT NULL;

SELECT * FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id;

SELECT i.pro_name, i.pro_price, c.com_name FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id;

SELECT c.com_name, AVG(i.pro_price) AS avg_price FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
GROUP BY c.com_name;

SELECT c.com_name, AVG(i.pro_price) AS avg_price FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
GROUP BY c.com_name HAVING AVG(i.pro_price) >= 350;

SELECT i.pro_name, i.pro_price, c.com_name FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
WHERE i.pro_price = (SELECT MAX(pro_price) FROM item_mast WHERE pro_com = i.pro_com);

SELECT e.*, d.* 
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code;

SELECT e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code;

SELECT e.emp_fname, e.emp_lname FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code
WHERE d.dpt_allotment > 50000;

SELECT d.dpt_name FROM emp_department d
JOIN emp_details e ON d.dpt_code = e.emp_dept
GROUP BY d.dpt_name HAVING COUNT(e.emp_idno) > 2;




