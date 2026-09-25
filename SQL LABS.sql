-- =====================================================
-- BANKING DATABASE
-- =====================================================

CREATE DATABASE BankingDB;

USE BankingDB;


-- =====================================================
-- LAB 1
-- CREATE CUSTOMERS TABLE
-- =====================================================

CREATE TABLE Customers (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    AccountCreationDate DATE
);


-- Add DateOfBirth column
ALTER TABLE Customers
ADD DateOfBirth DATE;


-- Modify Phone column
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);


-- Add Primary Key
ALTER TABLE Customers
ADD PRIMARY KEY (CustomerID);


-- Check Customers table
SELECT * FROM Customers;

DESCRIBE Customers;

show create table Customers;

-- =====================================================
-- LAB 2
-- BANKING DATABASE RELATIONSHIPS
-- =====================================================


-- =====================================================
-- 1. CREATE BRANCHES TABLE
-- =====================================================

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);


-- Add Primary Key to Branches

ALTER TABLE Branches
ADD PRIMARY KEY (BranchID);


-- Insert branch

INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');


SELECT * FROM Branches;

DESCRIBE Branches;

delete from Branches where BranchName = 'Pune Main Branch';

select * from Branches;

-- =====================================================
-- 2. CREATE ACCOUNTS TABLE
-- =====================================================

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts

select * from Accounts;
-- Add Primary Key to Accounts

ALTER TABLE Accounts
ADD PRIMARY KEY (AccountID);


-- Add CustomerID to Accounts

ALTER TABLE Accounts
ADD CustomerID INT;


-- Add BranchID to Accounts

ALTER TABLE Accounts
ADD BranchID INT;


-- Add minimum balance constraint

ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance >= 1000);


-- Check Accounts

DESCRIBE Accounts;


-- =====================================================
-- INSERT ACCOUNT
-- =====================================================

INSERT INTO Accounts
(AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES
(201, 101, 11, 'Savings', 25000);
insert into Accounts(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

DESCRIBE Accounts;

SELECT * FROM Accounts;

SHOW CREATE TABLE Accounts;

-- =====================================================
-- 3. CREATE TRANSACTIONS TABLE
-- =====================================================

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

select* from Transactions;
-- Add Primary Key

ALTER TABLE Transactions
ADD PRIMARY KEY (TransactionID);


-- Add AccountID

ALTER TABLE Transactions
ADD AccountID INT;


-- =====================================================
-- 4. CREATE LOANS TABLE
-- =====================================================

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

select * from Loans;

-- Add Primary Key

ALTER TABLE Loans
ADD PRIMARY KEY (LoanID);


-- Add CustomerID

ALTER TABLE Loans
ADD CustomerID INT;


-- =====================================================
-- FOREIGN KEY RELATIONSHIPS
-- =====================================================


-- 5. Accounts → Customers

ALTER TABLE Accounts
ADD CONSTRAINT fk_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);


-- 6. Accounts → Branches

ALTER TABLE Accounts
ADD CONSTRAINT fk_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);


-- 7. Transactions → Accounts

ALTER TABLE Transactions
ADD CONSTRAINT fk_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);


-- 8. Loans → Customers

ALTER TABLE Loans
ADD CONSTRAINT fk_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);


-- =====================================================
-- CHECK TABLE STRUCTURES
-- =====================================================



DESCRIBE Branches;



DESCRIBE Transactions;

DESCRIBE Loans;


-- =====================================================
-- SHOW COMPLETE TABLE DEFINITIONS
-- =====================================================



SHOW CREATE TABLE Transactions;

SHOW CREATE TABLE Loans;

-- lab 3
-- =====================================================
-- INSERT CUSTOMER
-- =====================================================

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(101, 'Rahul', 'Sharma', 'rahul@gmail.com', '9876543210', '1998-04-15');
INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

UPDATE Customers
SET Phone='9999999999'
WHERE CustomerID=101;

SELECT * FROM Customers;
SELECT * FROM Customers
WHERE CustomerID = 101;

UPDATE Customers
SET Email='rahul.sharma@gmail.com'
WHERE CustomerID=101;


-- lab 4

	
SELECT * FROM Customers;	

	
SELECT FirstName, LastName, Email, Phone
FROM Customers;

SELECT *
FROM Accounts
WHERE AccountType = 'Savings';

SELECT *
FROM Accounts
WHERE Balance > 25000;

SELECT *
FROM Transactions
WHERE Amount BETWEEN 5000 AND 20000;

SELECT *
FROM Customers
WHERE CustomerID IN (101,102,103);

SELECT *
FROM Customers
WHERE FirstName LIKE 'R%';

/*
Activity



Perform the following investigations:

Retrieve all current account records
Find accounts with balance less than 15000
Display transactions between 1000 and 10000
Retrieve customer records for CustomerID 104 and 105
Display customers whose last name starts with S

*/

SELECT * FROM Accounts;

select* from Accounts where Balance <15000; 

SELECT *
FROM Transactions
WHERE Amount BETWEEN 1000 AND 10000;

select * from Customers where CustomerID between 104 and 105;

select *from Customers;

select * from Customers where LastName like"S%";

SELECT *
FROM Customers
ORDER BY FirstName ASC;

SELECT *
FROM Accounts
ORDER BY Balance DESC;

SELECT DISTINCT AccountType
FROM Accounts;

SELECT *
FROM Accounts
ORDER BY Balance DESC
LIMIT 3;

SELECT *
FROM Transactions
LIMIT 5 OFFSET 2;

/*
Activity

Generate the following reports:

Display customers sorted by LastName
Retrieve top 5 transactions with highest amount
Display unique transaction types
Skip the first 3 transaction records and display the next 4 records

*/

select*from Customers order by LastName asc;

select * from Transactions order by Amount  desc limit 5;

SELECT DISTINCT TransactionType
FROM Transactions;

select * from Transactions limit 4 offset 3;

SELECT *
FROM Customers
WHERE Phone IS NULL;

SELECT *
FROM Customers
WHERE Email IS NOT NULL;

SELECT *
FROM Customers
WHERE Email IS NULL;

SELECT *
FROM Customers
WHERE Email IS NULL OR Email = '';

SELECT *
FROM Accounts
WHERE Balance IS NOT NULL;

SELECT AccountID,
       Balance,
       CASE
           WHEN Balance >= 50000 THEN 'Premium Account'
           WHEN Balance >= 25000 THEN 'Standard Account'
           ELSE 'Basic Account'
       END AS AccountCategory
FROM Accounts;

SELECT TransactionID, Amount,
       CASE
           WHEN Amount >= 10000 THEN 'High Transaction'
           WHEN Amount >= 5000 THEN 'Medium Transaction'
           ELSE 'Low Transaction'
       END AS Transaction_Category
FROM Transactions;

SELECT AccountID,
       Balance,
       RANK() OVER (ORDER BY Balance DESC) AS BalanceRank
FROM Accounts;

SELECT TransactionID,
       Amount,
       SUM(Amount) OVER (ORDER BY TransactionDate) AS RunningTotal
FROM Transactions;

SELECT TransactionID,
       Amount,
       AVG(Amount) OVER () AS AverageTransaction
FROM Transactions;

-- 1. Rank customers based on account balance
SELECT CustomerID, Balance,
       RANK() OVER (ORDER BY Balance DESC) AS Balance_Rank
FROM Accounts;
--  2. Generate running total for account balances
SELECT CustomerID, Balance,
       SUM(Balance) OVER (ORDER BY CustomerID) AS Running_Total
FROM Accounts;
-- 3. Display maximum transaction amount using a window function
SELECT TransactionID, Amount,
       MAX(Amount) OVER () AS Maximum_Transaction
FROM Transactions;

-- lab 5

SELECT *
FROM Customers
WHERE FirstName LIKE 'A%';

select * from Customers where Email like '%gmail%' ;

select * from Customers where LastName like '%kar';

/*

Perform the following searches:

Display customers whose first name starts with R
Find customers whose email contains yahoo
Display customers whose last name starts with P
Search customers whose phone number ends with 99
*/ 

select * from Customers where FirstName like'R%';

select * from CUstomers where Email like'%yahoo';

select * from Customers where LastName like'P%';

select * from Customers where Phone like'%99';

SELECT *
FROM Accounts
WHERE AccountType IN ('Savings', 'Current');

SELECT *
FROM Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal');

SELECT *
FROM Customers
WHERE CustomerID IN (101,102,105);

/*
Perform the following filtering operations:

Display accounts belonging to Salary and Savings account types
Retrieve transactions for Payment and Deposit categories
Display customer records for CustomerID 103 and 104
Retrieve selected account records using AccountID values
*/

select*from Accounts;
select * from Accounts where AccountType in ('Salary','Savings');

select*from Transactions;
select*from Transactions where TransactionType in ('Payment','Deposite');

select*from Customers where CustomerID in(103,104);

select AccountID from Accounts;

select * from Customers order by LastName asc;

select*from Accounts order by Balance desc;

SELECT *
FROM Transactions
ORDER BY TransactionDate DESC;

/*
Generate the following reports:

Display customers sorted by FirstName
Display accounts sorted by AccountType
Display transactions sorted by Amount in descending order
Display customers sorted by DateOfBirth

*/

select * from Customers order by FirstName ;

select*from Accounts order by AccountType;

select * from Transactions order by Amount desc;

select * from Customers where DateOfBirth ;

SELECT *
FROM Accounts
ORDER BY Balance DESC
LIMIT 5;

SELECT *
FROM Customers
LIMIT 3;

SELECT *
FROM Transactions
LIMIT 5 OFFSET 3;

/*
Perform the following operations:

Display top 3 transactions with highest amount
Retrieve only 4 customer records
Skip first 2 account records and display next 3 records
Display top 5 latest transactions

*/

select*from Transactions order by Amount  asc limit 3;

select * from Customers limit 4;

select * from Accounts order by AccountID limit 3 offset 2;
select * from Accounts;
select * from Transactions;

select * from Transactions order by Amount desc limit 5;

SELECT *
FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY Balance DESC;

SELECT *
FROM Customers
WHERE FirstName LIKE 'S%'
LIMIT 5;

SELECT *
FROM Transactions
WHERE TransactionType IN ('Deposit','Withdrawal')
ORDER BY TransactionDate DESC;



-- lab 6


select * from customers;

-- Display all customer FirstName in uppercase
select FirstName ,upper(FirstName) as UpperCaseName  from Customers;

-- Display all customer FirstName in lowercase.

select FirstName, lower(FirstName) from Customers;

-- Find the total number of characters in each customer FirstName

select FirstName , length(FirstName) as Namelenght from Customers;

select FirstName , left(FirstName,3) as First3charcters from Customers;

select concat(FirstName,'_',LastName)  as FullName from Customers; 


SELECT ROUND(1256.75) AS Rounded_Value;

SELECT CEIL(1256.25) AS Ceiling_Value;

SELECT FLOOR(1256.75) AS Floor_Value;  -- it gives nearest minimun number

SELECT ABS(-2500) AS Absolute_Value;  -- returns absolute positive values

SELECT MOD(25,4) AS Remainder;       -- mod gives division

select * from customers;

select  curdate();

select now();

select CustomerID ,year(DateOfBirth)  as BirthOfYear from Customers;

SELECT
CustomerID,
MONTH(DateOfBirth) AS BirthMonth
FROM customers;

SELECT
CustomerID,
DATEDIFF(CURDATE(),DateOfBirth) AS Days
FROM customers;

SELECT
    FirstName,
    DateOfBirth,
    IF(YEAR(DateOfBirth) <= 1995,
       'Adult',
       'Young') AS Category
FROM Customers;

SELECT
    FirstName,
    IFNULL(Phone, 'Not Available') AS PhoneNumber
FROM Customers;

SELECT GREATEST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS LatestBirthDate;

SELECT LEAST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS EarliestBirthDate;

SELECT
    FirstName,
    NULLIF(FirstName,'Priya') AS Result
FROM Customers;

SELECT SUM(Balance) as total_balance
FROM Accounts;

SELECT AVG(Balance) AS average_balance
FROM Accounts;

SELECT MAX(Balance) AS highest_balance
FROM Accounts;

SELECT MIN(Balance) AS lowest_balance
FROM Accounts;

SELECT COUNT(*) AS total_accounts
FROM Accounts;

SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;

SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 25000;

-- lab 7

Select
    LoanID,
    CustomerID, LoanAmount, RANK() OVER(
        ORDER BY LoanAmount DESC
    ) AS LoanRank
FROM Loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    DENSE_RANK() OVER(
        ORDER BY LoanAmount DESC
    ) AS DenseRank
FROM Loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        ORDER BY LoanAmount DESC
    ) AS RowNumber
FROM Loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        PARTITION BY CustomerID
        ORDER BY LoanAmount DESC
    ) AS RowNum
FROM Loans;

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LAG(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS PreviousLoanAmount
FROM Loans;

SELECT
    LoanID, CustomerID, LoanAmount,
    LEAD(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS NextLoanAmount
FROM Loans;

-- lab 8 ------------------------------------------------------------------------------

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID;


SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
LEFT JOIN Transactions t
ON a.AccountID = t.AccountID;

SELECT
   *
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE t.TransactionType = 'Deposit';

select * from Accounts a inner join Transactions t 
on a.AccountID = t.AccountID 
where a.Balance > 30000 
order by a.Balance desc;

