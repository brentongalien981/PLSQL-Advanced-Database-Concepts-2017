/*
CREATE PROCEDURE DoThings
(
	@NewDepartmentName VARCHAR(50),
	@NewEmployeeName VARCHAR(50),
	@NewEmployeeUsername VARCHAR(50)
)
AS
-- Create a new department
INSERT INTO Departments (Department)
VALUES (@NewDepartmentName)

-- Obtain the ID of the created department
DECLARE @NewDepartmentID INT
SET @NewDepartmentID = scope_identity()

-- Create a new employee
INSERT INTO Employees (DepartmentID, Name, Username)
VALUES (@NewDepartmentID, @NewEmployeeName, @NewEmployeeUsername)

-- Obtain the ID of the created employee
DECLARE @NewEmployeeID INT
SET @NewEmployeeID = scope_identity()

-- List the departments together with their employees
SELECT Departments.Department, Employees.Name
FROM Departments
INNER JOIN Employees ON Departments.DepartmentID =
Employees.DepartmentID

-- Delete the new employee
DELETE FROM Employees
WHERE EmployeeID = @NewEmployeeID

-- Delete the new department
DELETE FROM Departments
WHERE DepartmentID = @NewDepartmentID
*/

EXECUTE DoThings 'Research', 'Cristian Darie', 'cristian'