/*
 * MADE WITH COMBINATION OF w3 NOTES AND COLLEGE DATABASE NOTES.
 *
 * SOME SQL NOTES: 
 * 1. SQL stands for Structured Query Language
 * 2. The major commands: SELECT, UPDATE, DELETE, INSERT, WHERE
 * 3. SQL keywords aren't actually case sensitive: SELECT == select.
 * 
 * A "relation" is just a two-dimensional table. Tables have rows and columns.
 * A column is a "attribute". The amount of attributes/fields in a table is the "degree".
 * A row is a "tuple". The amount of tuples/records in a table is the "cardinality".
 *
 * "Schema" contains the header information for columns in a table.
 * EX: CoursesTaken(Student, Course, Grade)  
 * "Instance" contains the data rows (tuples) of a table.
 *
 *
 */
---------------------------------------------------------------------------------------------------------
-- DEMO SQL CODE:
-- Is a single-line comment in SQL. Multiple-line comments done with /* */
-- In this tutorial we will use the well-known Northwind sample database 
-- (included in MS Access and MS SQL Server). 

-- Most of the actions you need to perform on a database are done with SQL statements.
---------------------------------------------------------------------------------------------------------
--------------------------------------------- SELECT ----------------------------------------------------
---------------------------------------------------------------------------------------------------------
SELECT * FROM Customers;        -- Selects all the records in the "Customers" table.
                                -- The data returned is stored in a result table, called the result-set.
SELECT CustomerID, CustomerName FROM Customers  -- Selects just two of the columns from the table instead of all.

SELECT DISTINCT Country FROM Customers;         -- Returns only distinct (different) values. No duplicates.

SELECT COUNT(DISTINCT Country) FROM Customers;  -- Returns the number of different (distinct) customer countries.

---------------------------------------------------------------------------------------------------------
---------------------------------------------- WHERE ----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Not only used in SELECT statements, it is also used in UPDATE, DELETE, etc.!

SELECT * FROM Customers         -- The WHERE clause is used to filter records.
WHERE Country = 'Mexico';

SELECT * FROM Customers
WHERE CustomerID = 1;           -- Numeric fields should not be enclosed in quotation marks.

-- Operatiors for the WHERE clause:
--1. = Equal      2. > Greater than       3. < Less than      4. >= Greater than or equal     5. <= Less than or equal
--6. <> Not equal.(Can be written as != in some versions of SQL)      7. BETWEEN Between a certain range
--8. LIKE Search for a pattern            9. To specify multiple possible values in a column.

--_______________________________________________________________________________________________________
-- ******* BETWEEN Operator (Used in a WHERE clause):
-- The values can be numbers, text, or dates. Inclusive: begin and end values are included. 
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 60;

SELECT * FROM Products
WHERE Price NOT BETWEEN 10 AND 20;

SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20
AND CategoryID NOT IN (1,2,3);

SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

SELECT * FROM Orders
WHERE OrderDate BETWEEN #07/01/1996# AND #07/31/1996#;

--_______________________________________________________________________________________________________
-- ******* IN Operator (Used in a WHERE clause):
SELECT * FROM Customers
WHERE City IN ('Paris','London');   -- 	To specify multiple possible values for a column

-- Selects all customers that are from the same countries as the suppliers:
SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers);

--_______________________________________________________________________________________________________
-- ******* LIKE Operator (Used in a WHERE clause):
-- Two primary wildcards:
-- 1. The percent sign (%) represents zero, one, or multiple characters
-- 2. The underscore sign (_) represents one, single character
SELECT * FROM Customers
WHERE City LIKE 's%';               -- Returns cities starting with an 's'.

SELECT * FROM Customers
WHERE City LIKE '%a';               -- Returns cities ending with an 'a'.

-- Selects all customers with a CustomerName that have adjacent "or" characters in any position:
SELECT * FROM Customers WHERE CustomerName LIKE '%or%';

-- Selects all customers with a CustomerName that have "r" in the second position:
SELECT * FROM Customers WHERE CustomerName LIKE '_r%';

-- Selects all customers with a CustomerName that starts with "a" and are at least 3 characters in length:
SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';

-- Selects all customers with a ContactName that starts with "a" and ends with "o":
SELECT * FROM Customers WHERE ContactName LIKE 'a%o';

-- Selects all customers with a CustomerName that does NOT start with "a":
SELECT * FROM Customers WHERE CustomerName NOT LIKE 'a%';

-- ******* Wildcard Characters (Used with LIKE operator) (Like (%) and (_) above):
-- A wildcard character is used to substitute one or more characters in a string
-- All the wildcards can also be used in combinations.
-- SQL Server Wildcard Characters:
-- 1. %	Represents zero or more characters.                         EX: bl% finds bl, black, blue, and blob.
-- 2. _	Represents a single character.	                            EX: h_t finds hot, hat, and hit.
-- 3. [] Represents any single character within the brackets.	    EX: h[oa]t finds hot and hat, but not hit.
-- 4. ^	Represents any character not in the brackets.	            EX: h[^oa]t finds hit, but not hot and hat.
-- 5. -	Represents any single character within the specified range.	EX: c[a-b]t finds cat and cbt.

---------------------------------------------------------------------------------------------------------
---------------------------------------- AND, OR and NOT ------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- The WHERE clause can be combined with AND, OR, and NOT operators.
-- The AND and OR operators are used to filter records based on more than one condition:
-- The NOT operator displays a record if the condition(s) is NOT TRUE.

SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin';

SELECT * FROM Customers
WHERE City = 'Berlin' OR City = 'Munchen';

SELECT * FROM Customers
WHERE NOT Country = 'Germany';

-- A harder combination:
SELECT * FROM Customers
WHERE NOT Country = 'Germany' AND NOT Country='USA';

---------------------------------------------------------------------------------------------------------
------------------------------------------- ORDER BY ----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- The ORDER BY keyword is used to sort the result-set in ascending or descending order.
-- Ascending order by default. To sort the records in descending order, use the DESC keyword.

SELECT * FROM Customers     -- Selects all customers from the "Customers" table, sorted by the "Country" column.
ORDER BY Country;

SELECT * FROM Customers
ORDER BY Country DESC;

-- Orders by (several columns) Country, but if some rows have the same Country, it orders them by CustomerName:
SELECT * FROM Customers
ORDER BY Country, CustomerName;

SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;

---------------------------------------------------------------------------------------------------------
----------------------------------------- INSERT INTO ---------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Used to insert new records in a table. There are two ways to do it:
-- 1. Specify both the column names and the values to be inserted:
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
--
-- 2. If you are adding values for all the columns of the table, you do not need to specify the column names
-- in the SQL query. However, make sure the order of the values is in the same order as the columns in the table:
INSERT INTO Customers
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');

-- It is also possible to only insert data in specific columns.
-- The following SQL statement will insert a new record, but only insert data in the "CustomerName", 
-- "City", and "Country" columns (CustomerID will be updated automatically as it is a auto-increment field):
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');     -- Columns left blank wil have 'null' inside of them.

-- NULL:
-- SPEAKING OF NULL VALUES, It is not possible to test for NULL values with comparison operators, such as =, <, or <>.
-- We will have to use the IS NULL and IS NOT NULL operators instead:
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NULL;
--
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NOT NULL;

---------------------------------------------------------------------------------------------------------
-------------------------------------------- UPDATE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Used to modify the existing records in a table.
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City = 'Frankfurt'
WHERE CustomerID = 1;       -- Careful! If you omit the WHERE clause, all records in the table will be updated!

-- UPDATE Multiple Records:
UPDATE Customers
SET ContactName = 'Juan'
WHERE Country = 'Mexico'    -- Update the ContactName to "Juan" for all records where country is "Mexico". LOL.

---------------------------------------------------------------------------------------------------------
-------------------------------------------- DELETE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Used to delete existing records in a table.
DELETE FROM Customers 
WHERE CustomerName = 'Alfreds Futterkiste';
                            -- Careful! If you omit the WHERE clause, all records in the table will be deleted!

-- DELETE FROM Customers    -- THIS WOULD DELETE ALL ROWS W/O DELETING THE TABLE.

---------------------------------------------------------------------------------------------------------
------------------------------------------ SELECT TOP ---------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Used to specify the number of records to return.
-- Useful on large tables with thousands of records. Returning a large number of records can impact performance.
-- DIFFERENT BASED ON DATABASE SYSTEM IE: SQL Server, MySQL, Oracle.

-- ******* SQL Server / MS Access Syntax:
SELECT TOP 3 * FROM Customers;                        -- Selects the first three records from the "Customers" table.

-- ******* MySQL Syntax:
--SELECT * FROM Customers LIMIT 3;                    -- Selects the first three records from the "Customers" table.

-- ******* Oracle Syntax:
--SELECT * FROM Customers FETCH FIRST 3 ROWS ONLY;    -- Selects the first three records from the "Customers" table.

-- More examples (primarily w/ SQL Server):
SELECT TOP 50 PERCENT * FROM Customers;                     -- Selects percentage.

SELECT TOP 3 * FROM Customers WHERE Country = 'Germany';    -- Filters results further.

---------------------------------------------------------------------------------------------------------
------------------------------------ MIN(), MAX() and Aliases -------------------------------------------
---------------------------------------------------------------------------------------------------------
SELECT MIN(Price) AS SmallestPrice  -- Returns the smallest value of the selected column.
FROM Products;                      -- AS renames a column or table with an alias. For result-set readability.
                                    -- An alias only exists for the duration of the query.

SELECT MAX(Price) AS LargestPrice   -- Returns the largest value of the selected column.
FROM Products;

-- More alias examples:
SELECT CustomerID AS ID, CustomerName AS Customer   -- Multiple aliases.
FROM Customers;

-- Note: It requires double quotation marks or square brackets if the alias name contains spaces:
SELECT CustomerName AS Customer, ContactName AS [Contact Person]
FROM Customers;

-- Creates an alias named "Address" that combine four columns (Address, PostalCode, City and Country):
SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;

-- Alias can also be applied to entire tables. This example uses two tables (Customers & Orders):
SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;
-- You could also do the above w/o aliases like: Orders.OrderID, Customers.CustomerName, etc...

---------------------------------------------------------------------------------------------------------
-------------------------------------- COUNT(), AVG(), SUM() --------------------------------------------
---------------------------------------------------------------------------------------------------------
-- The COUNT() function returns the number of rows that matches a specified criterion.
SELECT COUNT(ProductID)
FROM Products;

-- The AVG() function returns the average value of a numeric column. 
SELECT AVG(Price)
FROM Products;

-- The SUM() function returns the total sum of a numeric column. 
SELECT SUM(Quantity)
FROM OrderDetails;

-- Note: NULL values are not counted in any of the above functions.

---------------------------------------------------------------------------------------------------------
---------------------------------------------- JOIN -----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Used to combine rows from two or more tables, based on a related column between them.

/* Here are the different types of the JOINs in SQL:
 *
 * (INNER) JOIN: Returns records that have matching values in both tables.
 * LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table.
 * RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table.
 * FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table.
 */

--_______________________________________________________________________________________________________
-- ******* INNER JOIN. 
-- *Only* selects records that have matching (CustomerID) values in both tables:
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

-- (EX: Join 3 Tables) selects all orders with customer and shipper information:
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);

--_______________________________________________________________________________________________________
-- ******* LEFT JOIN. AKA LEFT OUTER JOIN.
-- Returns all records from the left table (table1), and the matching records from the right table (table2). 
-- The result is 0 records from the right side, if there is no match.

-- Select all customers, and any orders they might have:
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;
-- See above that LEFT JOIN keyword returns all records from the left table (Customers), 
-- even if there are no matches in the right table (Orders).

--_______________________________________________________________________________________________________
-- ******* RIGHT JOIN. AKA RIGHT OUTER JOIN.
-- Returns all records from the right table (table2), and the matching records from the left table (table1). 
-- The result is 0 records from the left side, if there is no match.

-- Select all employees, and any orders they might have:
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;
-- See above that RIGHT JOIN keyword returns all records from the right table (Employees), 
-- even if there are no matches in the left table (Orders).

--_______________________________________________________________________________________________________
-- ******* FULL JOIN. AKA FULL OUTER JOIN.
-- Returns all records when there is a match in left (table1) or right (table2) table records.
-- Can potentially return very large result-sets.

-- Selects all customers, and all orders:
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;

--_______________________________________________________________________________________________________
-- ******* SELF JOIN.
-- A join, but the table is joined with itself. Typically different aliases will be used for the same table.

-- Matches customers that are from the same city:
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;
-- Above is essentially iterating through a copy of itself to match customers in the same city with each other.
-- (Of course you cannot match with yourself, note the <> relation).

---------------------------------------------------------------------------------------------------------
---------------------------------------------- UNION ----------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- Operator used to combine the result-set of two or more SELECT statements. Some rules:
-- 1. Every SELECT statement within UNION must have the same number of columns.
-- 2. The columns must also have similar data types.
-- 3. The columns in every SELECT statement must also be in the same order.

-- Returns the cities (only distinct values) from both the "Customers" and the "Suppliers" table:
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

-- Returns the German cities (*duplicate* values also) from both the "Customers" and the "Suppliers" table:
SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION ALL
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

-- Lists all customers and suppliers:
SELECT 'Customer' AS Type, ContactName, City, Country
FROM Customers
UNION
SELECT 'Supplier', ContactName, City, Country
FROM Suppliers;
-- Above, we have created a temporary column/alias named "Type", 
-- that lists whether the contact person is a "Customer" or a "Supplier".