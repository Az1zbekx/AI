CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


select 
c.CustomerID,
c.CustomerName,
o.OrderID,
o.OrderDate
from Customers as c
left join Orders as o
on c.CustomerID = o.CustomerID


select 
c.CustomerID,
c.CustomerName
from Customers as c
left join Orders as o
on c.CustomerID = o.CustomerID
where o.OrderID is null

SELECT 
o.OrderID,
p.ProductName,
od.Quantity
FROM Orders AS o
JOIN OrderDetails AS od
ON o.OrderID = od.OrderID
JOIN Products AS p
ON od.ProductID = p.ProductID;

SELECT C.CustomerID
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID 
HAVING COUNT(*) > 1;

SELECT *
FROM (
    SELECT 
        od.OrderID,
        p.ProductName,
        od.Price,
        ROW_NUMBER() OVER(PARTITION BY od.OrderID ORDER BY od.Price DESC) AS rn
    FROM OrderDetails od
    JOIN Products p
    ON od.ProductID = p.ProductID
) t
WHERE rn = 1;

SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rn
    FROM Orders
) t
WHERE rn = 1;

SELECT C.CustomerID, C.CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(CASE WHEN P.Category <> 'Electronics' THEN 1 END) = 0;

SELECT C.CustomerID, C.CustomerName
FROM Customers As C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE P.Category = 'Stationery'


SELECT
C.CustomerID,
C.CustomerName,
SUM(OD.Quantity * OD.Price) AS TotalSpent
FROM Customers AS C
JOIN Orders AS O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CustomerName;