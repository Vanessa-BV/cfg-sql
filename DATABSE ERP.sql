CREATE DATABASE ERP; 
USE ERP;

-- Create first table "Employees"
CREATE TABLE Employees
( 
Employee_ID INT PRIMARY KEY,
First_name VARCHAR(30), 
Last_name VARCHAR(30), 
Starte_date DATE
)
; 

-- Create second table "Emp_salary"
CREATE TABLE Emp_salary
(
Employee_ID INT, 
Salary INT, 
Currency CHAR(3)
)
; 

-- Drop table "Employees" to adjust te constraints on column "Employee_ID" and create new table "Employees" with column "Employee_ID" as PRIMARY KEY 
Drop TABLE Employees;
CREATE TABLE Employees
( 
Employee_ID INT UNIQUE NOT NULL PRIMARY KEY,
First_name VARCHAR(30), 
Last_name VARCHAR(30), 
Starte_date DATE
)
; 

-- Alter table "Emp_salary" to add Foreign constraint on column "Employee_ID" 
ALTER TABLE Emp_salary
ADD CONSTRAINT FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID); 

-- Insert values into table "Employees" 
INSERT INTO Employees (Employee_ID, First_Name, Last_name, Starte_date)
VALUES 
(1, 'Peter', 'Parker', '2010-11-01'),
(2, 'Brigitte', 'Schmidt', '2009-09-15'),
(3, 'Henry', 'Smith', '2019-05-01'), 
(4, 'Juan', 'Gonzalez', '2022-08-01'), 
(5, 'Laura', 'Hall', '2010-03-20'), 
(6, 'Romee', 'Heijn', '2014-02-17'), 
(7, 'Joost', 'Ernberg', '2013-07-27'), 
(8, 'Jens', 'Mueller', '2010-04-23'), 
(9, 'Saskia', 'Jones', '2019-07-18'), 
(10, 'Joe', 'Williams', '2011-01-22')
; 

-- Alter tables "Employees", as typo was found on column "start_date" 
ALTER TABLE Employees
RENAME COLUMN Starte_date to Start_date;

-- Insert value into table "Emp_salary" 
INSERT INTO Emp_salary (Salary, Currency)
VALUES
(7589,'EUR'), 
(3570,'EUR'),
(3689,'EUR'), 
(9973,'EUR'),
(2970,'EUR'),
(6743,'EUR'),
(3870,'EUR'),
(9744,'EUR'),
(4780,'EUR'),
(2489,'EUR');

-- Create third table "Clients"
CREATE TABLE Clients 
(
Client_ID INT UNIQUE NOT NULL PRIMARY KEY, 
Client_name VARCHAR(50)
)
;

-- Create fourth table "Client_address"
CREATE TABLE Client_address
(
Client_ID INT UNIQUE NOT NULL, 
City VARCHAR(20),
Country VARCHAR(20)
)
; 

-- Alter table "Client_address" to add Foreign constraint on column "Client_ID" 
ALTER TABLE Client_address
ADD CONSTRAINT FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Insert values into table "Clients"
INSERT INTO Clients (Client_ID, Client_name)
VALUES
(100,'Peach Inc.'),
(101,'Banque Paris'),
(102,'Appeltaart BV'),
(103,'Druckerei GmbH'),
(104,'AMW AG'),
(105,'Air Hamburg GmbH'),
(106,'Les amis du livre'),
(107,'Web Designers Inc.'),
(108,'Museum Friends BV'),
(109,'Antwerp Classics BV')
; 

-- Insert values into table "Client_address"
INSERT INTO Client_address (Client_ID, City, Country)
VALUES
(100,'New York','United States'),
(101,'Paris','France'),
(102,'Brussels','Belgium'),
(103,'Berlin','Germany'),
(104,'Munich','Germany'),
(105,'Hamburg','Germany'),
(106,'Lyon','France'),
(107,'Chicago','United States'),
(108,'Amsterdam','The Netherlands'),
(109,'Antwerp','Belgium')
;

-- Create fifth table "Invoices"
CREATE TABLE Invoices
(
Invoice_number INT UNIQUE PRIMARY KEY,
Net_Amount INT,
Currency CHAR(3),
Client_ID INT UNIQUE 
)
;

-- Alter table "Invoices" to add Foreign constraint on column "Client_ID" 
ALTER TABLE Invoices
ADD CONSTRAINT FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Insert values into table "Invoices"
INSERT INTO Invoices (Invoice_number, Net_Amount, Currency, Client_ID)
VALUES 
(7401300,20000,'EUR',100),
(7401301,35000,'EUR',101),
(7401302,47990,'EUR',102),
(7401303,39500,'EUR',103),
(7401304,55000,'EUR',104),
(7401305,67500,'EUR',105),
(7401306,28900,'EUR',106),
(7401307,27900,'EUR',107),
(7401308,37600,'EUR',108),
(7401309,76000,'EUR',109)
;

-- Insert values into table "Emp_salary"
INSERT INTO Emp_salary (Employee_ID)
VALUES
('1'),
('2'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9'),
('10');

-- Look at table "Emp_salary" 
SELECT * FROM Emp_salary;

-- Delete values from table "Emp_salary". This was done due to an error when adding values: Employee_ID was NULL in the rows where Salary and Currency was entered, since I had not entered the WHERE clause.
DELETE FROM Emp_salary; 

-- Add values to table "Emp_salary". Now with values on all rows for each column. 
INSERT INTO Emp_salary (Employee_ID, Salary, Currency)
VALUES
(1,7589,'EUR'), 
(2,3570,'EUR'),
(3,3689,'EUR'), 
(4,9973,'EUR'),
(5,2970,'EUR'),
(6,6743,'EUR'),
(7,3870,'EUR'),
(8,9744,'EUR'),
(9,4780,'EUR'),
(10,2489,'EUR');

-- Create sixth table "Employee_role" 
CREATE TABLE Employee_role
(
Employee_ID INT NOT NULL UNIQUE,
Role VARCHAR(10) NOT NULL
)
;

-- Alter table "Employee_role" to add Foreign constraint on column "Employee_ID" 
ALTER TABLE Employee_role
ADD CONSTRAINT FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID); 

-- Insert values into table "Employee_role"
INSERT INTO Employee_role
VALUES 
(1,'Consultant'),
(2,'HR'),
(3,'Finance'),
(4,'Consultant'),
(5,'HR'),
(6,'Sales'),
(7,'Marketing'),
(8,'Consultant'),
(9,'Consultant'),
(10,'Marketing')
;

-- Take a look at the employee tables 
SELECT * FROM Employees;
SELECT * FROM emp_salary;
SELECT * FROM employee_role;

-- Create a view using inner join tables "Employees", "Emp_salary " and "Emp_role" to combine employees' names, salary and role within the company. The result shall be put in descending order on salary, thus starting with the highest salary.
CREATE VIEW emp_salary_role
AS SELECT first_name AS 'First name', last_name AS 'Last name', salary AS Salary, currency AS Currency, role AS Role
FROM employees
INNER JOIN emp_salary
ON employees.employee_ID = emp_salary.employee_ID
INNER JOIN employee_role
ON employees.employee_ID = employee_role.employee_ID
ORDER BY emp_salary.salary DESC;

-- Create a view using inner join tables "Clients" and "Client_address" to view clients' names and their location. The result shall be put in order by country. 
CREATE VIEW client_locations
AS SELECT clients.client_name AS Client, client_address.city AS City, client_address.country AS Country
FROM clients
INNER JOIN client_address 
ON clients.client_ID = client_address.client_ID
ORDER BY client_address.country;

-- Create a view using inner join tables "Clients" and "Client_address". View all clients that are located in Germany.
CREATE VIEW clients_in_germany
AS SELECT clients.client_name AS Client, client_address.city AS City, client_address.country AS Country
FROM clients
INNER JOIN client_address 
ON clients.client_ID = client_address.client_ID
WHERE country = 'Germany';

--  Create a view using inner join tables "Client_address" and "Invoices" to view the total generated revenue by country in descending order. 
CREATE VIEW revenue_by_country
AS SELECT client_address.country AS Country, sum(invoices.net_amount) AS 'Revenue in EUR (net amounts)'
FROM client_address
INNER JOIN invoices 
ON client_address.client_ID = invoices.client_ID
GROUP BY client_address.country
ORDER BY net_amount DESC;

-- Update value in row (table "invoices"). Change amount of invoice 7401306 to 27500 EUR.
UPDATE invoices
SET net_amount = 27500
WHERE invoice_number = 7401306;

-- Create stored function to show full name of employees
CREATE FUNCTION full_name(first_name VARCHAR(30), last_name VARCHAR(30))
RETURNS VARCHAR(60) DETERMINISTIC
RETURN CONCAT(first_name,' ', last_name); 

-- Run stored function "full_name" to combine first and last name in "Employees" table
SELECT employee_ID AS ID, full_name(first_name, last_name) AS Employee
FROM employees;

-- Run stored function to get the full name and role
SELECT employee_role.role AS Role, full_name(first_name, last_name) AS Employee
FROM employees
INNER JOIN employee_role
ON employees.employee_ID = employee_role.employee_ID
ORDER BY role; 

-- Query and subquery to identify whose salary is higher than average, using stored function to show full name
SELECT emp_salary.salary AS 'Salary in EUR', full_name(first_name, last_name) AS Employee
FROM employees
INNER JOIN emp_salary
ON employees.employee_ID = emp_salary.employee_ID
WHERE salary > (SELECT AVG(salary) 
FROM emp_salary)
;

-- Create seventh table "Emp_date": End date and start date
Create table Emp_date
(
Employee_ID INT UNIQUE NOT NULL, 
Start_date DATE, 
End_date DATE
)
; 

-- Alter table "Emp_date" to add Foreign constraint on column "Employee_ID" 
ALTER TABLE Emp_date
ADD CONSTRAINT FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID); 

-- Insert data into tables Emp_date
INSERT INTO Emp_date (Employee_ID, Start_date, End_date)
VALUES 
(1,'2010-11-01',NULL), 
(2,'2009-09-15',NULL),  
(3,'2019-05-01','2022-12-20'), 
(4,'2022-08-01','2022-12-31'),
(5,'2010-03-20',NULL), 
(6,'2014-02-17',NULL), 
(7,'2013-07-27',NULL), 
(8,'2010-04-23','2023-01-31'), 
(9,'2019-07-17',NULL), 
(10,'2011-01-22',NULL); 

-- Remove column "start_date" from "Employees" table and add column "Active_emp" 
ALTER TABLE Employees
DROP COLUMN Start_date; 

ALTER TABLE Employees
ADD COLUMN Active_emp BOOLEAN NOT NULL; 

-- Update column "Active_emp" in table "Employees" 
UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 1; 

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 2;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 3;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 4;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 5;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 6;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 7;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 8;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 9;

UPDATE Employees
SET Active_emp = true 
WHERE employee_ID = 10;

-- VIEW: Calculate how many years employees have been at the company in descending order, using the stored function "full_name"
CREATE VIEW Emp_years
AS SELECT full_name(first_name, last_name) AS Employee, year(CURDATE()) - year(start_date) AS 'Employment years' 
FROM employees
INNER JOIN emp_date
ON employees.employee_ID = emp_date.employee_ID
ORDER BY year(CURDATE()) - year(start_date) DESC;

-- VIEW: Calculate which employees have been at the company for 10 years or more in descending order, using the stored function "full_name"
CREATE VIEW emp_10years
AS SELECT full_name(first_name, last_name) AS Employee, year(CURDATE()) - year(start_date) AS 'Employment years' 
FROM employees
INNER JOIN emp_date
ON employees.employee_ID = emp_date.employee_ID
WHERE year(CURDATE()) - year(start_date) >= 10
ORDER BY year(CURDATE()) - year(start_date) DESC;

DELIMITER //
-- Create Stored Procedure to enter new clients 
CREATE PROCEDURE Insert_new_client
(
IN client_ID INT, 
IN client_name VARCHAR(50)
)
BEGIN

INSERT INTO clients(client_id,client_name)
VALUES (client_id,client_name);

END//
DELIMITER ;

-- Running stored procedure "Insert_new_client"
CALL Insert_Client_Value(110, 'We repair Laptops GmbH');

DELIMITER //
-- Create Stored Procedure to enter new client address
CREATE PROCEDURE Insert_new_client_address
(
IN client_ID INT, 
IN city VARCHAR(20),
IN country VARCHAR(20)
)
BEGIN

INSERT INTO client_address(client_id,city,country)
VALUES (client_id,city,country);

END//
DELIMITER ;

-- Running stored procedure "Insert_new_client_address"
CALL Insert_new_client_address(110,'Hamburg','Germany');

-- GROUP BY and HAVING --> Countries in which the company has two or more clients (e.g., when considering where to expand)
SELECT 
COUNT(client_ID), country
FROM client_address
GROUP BY country
HAVING COUNT(country)>=2; 

-- Calculating top 5 client based on revenu in DESC order 
SELECT clients.client_name AS Client, invoices.net_amount AS 'Revenue in EUR (net amounts)'
FROM clients
INNER JOIN invoices 
ON clients.client_ID = invoices.client_ID
ORDER BY invoices.net_amount DESC
LIMIT 5;

-- Create stored function "no_of_years"
DELIMITER //
CREATE FUNCTION no_of_years(date1 date) RETURNS int DETERMINISTIC
BEGIN
 DECLARE date2 DATE;
  Select current_date()into date2;
  RETURN year(date2)-year(date1);
END; 
DELIMITER //

-- Run stored function "no_of_years"
SELECT employee_ID, no_of_years(start_date) AS 'Years' FROM Emp_date;

