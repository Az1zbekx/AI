CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    DepartmentID INT NULL,
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(50),
    EmployeeID INT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


SELECT e.*, d.DepartmentName
FROM Employees AS e
JOIN Departments As d
ON e.DepartmentID = d.DepartmentID;

SELECT e.*, d.DepartmentName
FROM Employees AS e
LEFT JOIN Departments As d
ON e.DepartmentID = d.DepartmentID;

SELECT e.*, d.DepartmentName
FROM Employees AS e
RIGHT JOIN Departments As d
ON e.DepartmentID = d.DepartmentID;

SELECT e.*, d.DepartmentName
FROM Employees AS e
FULL JOIN Departments As d
ON e.DepartmentID = d.DepartmentID;

SELECT d.*,
p.EmployeeID,
p.ProjectID,
p.ProjectName
FROM Departments AS d
CROSS JOIN Projects As p;

SELECT 
DepartmentName,
COALESCE(SUM(Salary),0) AS TotalSalary 
FROM Departments AS d
LEFT JOIN Employees As e
ON d.DepartmentID = e.DepartmentID
GROUP By DepartmentName;

SELECT 
e.EmployeeID,
e.Name,
e.Salary,
p.ProjectID,
p.ProjectName,
d.DepartmentID,
d.DepartmentName
FROM Employees AS e
LEFT JOIN Projects AS p
ON e.EmployeeID = p.EmployeeID
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;