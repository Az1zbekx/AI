CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


WITH Top10Employees AS (
    SELECT TOP 10 PERCENT * FROM Employees
    ORDER BY Salary DESC
),
DepartmentTable AS ( 
    SELECT Department, AVG(Salary) AS AverageSalary,
    CASE 
        WHEN AVG(Salary) > 80000 THEN 'High'
        WHEN AVG(Salary) BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
    FROM Top10Employees
    GROUP BY Department
)
SELECT * FROM DepartmentTable
ORDER BY AverageSalary DESC
OFFSET 2 ROW FETCH NEXT 5 ROWS ONLY;



WITH CHooseOrders AS (
    SELECT 
        * 
    FROM Orders
    WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'
),
CHooseOrders2 AS (
    SELECT *,
        CASE 
            WHEN Status in ('Shipped', 'Delivered') THEN 'Completed'
            WHEN Status = 'Pending' THEN 'Pending'
            WHEN Status = 'Cancelled' THEN 'Canselled' 
        END AS OrderStatus
    FROM CHooseOrders
),
ChooseOrders3 AS (
    SELECT  
        OrderStatus, 
        COUNT(TotalAmount) AS TotalNumberOfOrders, 
        SUM(TotalAmount) AS TotalRevenue 
    FROM CHooseOrders2
    GROUP BY OrderStatus
)
SELECT 
    * 
FROM ChooseOrders3
WHERE TotalRevenue > 5000
ORDER BY TotalRevenue;


WITH RankedProducts AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Category 
               ORDER BY Price DESC
           ) AS rn
    FROM Products
)
SELECT 
    Category,
    ProductName,
    Price,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')
    ) AS InventoryStatus
FROM RankedProducts
WHERE rn = 1
ORDER BY Price DESC
OFFSET 5 ROWS;



