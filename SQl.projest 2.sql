-- =========================================
-- Data Transformer Project
-- Corporate Data Analysis System
-- =========================================

DROP DATABASE IF EXISTS data_transformer;

CREATE DATABASE data_transformer;

USE data_transformer;

-- =========================================
-- Customers Table


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

INSERT INTO Customers (FirstName, LastName, Email, RegistrationDate)
VALUES
('John', 'Doe', 'john.doe@email.com', '2022-03-15'),
('Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
('Ravi', 'Kumar', 'ravi.kumar@email.com', '2022-08-10'),
('Meena', 'Rao', 'meena.rao@email.com', '2023-01-05'),
('Arjun', 'Nair', 'arjun.nair@email.com', '2023-05-20');

SELECT * FROM Customers;

-- =========================================
-- Orders Table
-- =========================================

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2023-07-01', 150.50),
(1, '2023-07-03', 200.75),
(2, '2023-07-10', 1200.50),
(3, '2023-07-11', 600.00),
(5, '2023-07-15', 90.00);

SELECT * FROM Orders;

-- =========================================
-- Employees Table
-- =========================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (FirstName, LastName, Department, HireDate, Salary)
VALUES
('Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
('Susan', 'Lee', 'HR', '2021-03-20', 55000.00),
('David', 'Brown', 'IT', '2019-06-11', 72000.00),
('Priya', 'Singh', 'Sales', '2022-02-01', 41000.00),
('Karan', 'Mehta', 'Finance', '2020-09-09', 63000.00);

SELECT * FROM Employees;

-- =========================================
-- INNER JOIN
-- =========================================

SELECT
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.TotalAmount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID;

-- =========================================
-- LEFT JOIN
-- =========================================

SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;


---------------  RIGHT JOIN ---------------

      
SELECT
    o.OrderID,
    o.TotalAmount,
    c.FirstName,
    c.LastName
FROM Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID;


-------------- FULL OUTER JOIN --------------
SELECT
    o.OrderID,
    o.TotalAmount,
    c.FirstName,
    c.LastName
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT
    o.OrderID,
    o.TotalAmount,
    c.FirstName,
    c.LastName
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

----------- Subquery ----------------
select distinct 
              c.FirstName, 
              c.LastName
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where 
o.TotalAmount > (select avg(TotalAmount) from Orders);
 
-------------- Subquery ------------------
select FirstName, 
       LastName, 
       Salary
from Employees
where Salary > (select avg(Salary) from Employees);
 
-------------- Extract year and month from OrderDate---------------
select OrderID, 
year(OrderDate) as OrderYear, 
month(OrderDate) as OrderMonth
from Orders;
 
-------------- Difference in days between order date and current date -------
select OrderID, 
OrderDate, datediff(curdate(), 
OrderDate) as DaysSinceOrder
from Orders;
 
------------- Format OrderDate to a readable format (DD-MMM-YYYY)-------------
select OrderID, 
date_format(OrderDate, '%d-%b-%Y') as FormattedDate
from Orders;
 
-------------- 10. Concatenate FirstName and LastName into a full name ----------
select concat(FirstName, ' ', LastName) as FullName
from Customers;
 
-------------- Replace part of a string: replace 'John' with 'Jonathan' ----------
select FirstName, replace(FirstName, 'John', 'Jonathan') as UpdatedName
from Customers;
 
------------- Convert FirstName to uppercase and LastName to lowercase----------
select upper(FirstName) as FirstUpper, lower(LastName) as LastLower
from Customers;
 
----------- Trim extra spaces from the Email field-------------
select trim(Email) as CleanEmail
from Customers;
 
--------------- Running total of TotalAmount for each order (window function)---------
select OrderID, OrderDate, TotalAmount,
sum(TotalAmount) over (order by OrderDate) as RunningTotal
from Orders;
 
------------------ Rank orders based on TotalAmount using RANK()-----------
select OrderID, TotalAmount,
rank() over (order by TotalAmount desc) as OrderRank
from Orders;
 
----------- Assign a discount based on TotalAmount using CASE ----------
select OrderID, TotalAmount,
case
    when TotalAmount > 1000 then '10% off'
    when TotalAmount > 500 then '5% off'
    else 'No discount'
end as Discount
from Orders;
 
------------ Categorize employees' salaries as high, medium, or low -----------
select FirstName, LastName, Salary,
case
    when Salary >= 60000 then 'High'
    when Salary >= 45000 then 'Medium'
    else 'Low'
end as SalaryCategory
from Employees;


     

