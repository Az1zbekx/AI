drop table if exists employees;

create table employees(
    EmployeeID int,
    Name NVARCHAR(50),
    department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Karimov', 'IT', 5500.00, '2019-03-15'),
(2, 'Malika Toshmatova', 'HR', 4200.00, '2020-06-01'),
(3, 'Jasur Rahimov', 'Finance', 6100.00, '2018-11-20'),
(4, 'Nilufar Yusupova', 'Marketing', 4800.00, '2021-01-10'),
(5, 'Bobur Xasanov', 'IT', 5900.00, '2017-07-22'),
(6, 'Zulfiya Mirzayeva', 'HR', 4100.00, '2022-03-05'),
(7, 'Sardor Nazarov', 'Finance', 5700.00, '2019-09-14'),
(8, 'Dilorom Qodirova', 'Sales', 4500.00, '2020-12-18'),
(9, 'Ulugbek Ergashev', 'IT', 6300.00, '2016-05-30'),
(10, 'Feruza Holmatova', 'Marketing', 4700.00, '2021-08-25'),
(11, 'Sherzod Tursunov', 'Sales', 4300.00, '2022-01-17'),
(12, 'Kamola Abdullayeva', 'HR', 4000.00, '2023-02-28'),
(13, 'Nodir Hamidov', 'IT', 5800.00, '2018-04-11'),
(14, 'Oydin Rахimova', 'Finance', 5500.00, '2019-10-07'),
(15, 'Firdavs Yoldoshev', 'Operations', 5000.00, '2020-03-22'),
(16, 'Barno Sobirov', 'Marketing', 4600.00, '2021-11-13'),
(17, 'Mansur Qosimov', 'IT', 6500.00, '2015-08-19'),
(18, 'Sabohat Norova', 'HR', 4250.00, '2022-07-04'),
(19, 'Davron Umarov', 'Sales', 4400.00, '2021-05-29'),
(20, 'Lola Baxtiyorova', 'Finance', 5900.00, '2017-12-03'),
(21, 'Akbar Ismoilov', 'IT', 5600.00, '2019-02-14'),
(22, 'Maftuna Xoliqova', 'Operations', 4800.00, '2020-09-08'),
(23, 'Parviz Rajabov', 'Sales', 4350.00, '2022-04-20'),
(24, 'Gulnora Hasanova', 'HR', 4150.00, '2023-01-09'),
(25, 'Temur Yunusov', 'IT', 7000.00, '2014-06-16'),
(26, 'Shahnoza Tillayeva', 'Marketing', 4900.00, '2020-11-27'),
(27, 'Ikrom Salimov', 'Finance', 5400.00, '2018-08-31'),
(28, 'Nozima Xudoyberdiyeva', 'Operations', 5100.00, '2019-07-15'),
(29, 'Behruz Eshmatov', 'Sales', 4250.00, '2022-10-02'),
(30, 'Mohira Saidova', 'HR', 4300.00, '2021-03-18'),
(31, 'Ortiq Normatov', 'IT', 5750.00, '2018-01-25'),
(32, 'Xurshida Qurbonova', 'Finance', 5650.00, '2019-05-12'),
(33, 'Laziz Ashrapov', 'Marketing', 4550.00, '2021-09-06'),
(34, 'Muazzam Tojiboyeva', 'Operations', 4950.00, '2020-04-23'),
(35, 'Sanjar Xoliqov', 'Sales', 4450.00, '2022-06-14'),
(36, 'Iroda Majidova', 'HR', 4200.00, '2023-03-01'),
(37, 'Komiljon Rустамов', 'IT', 6200.00, '2016-10-08'),
(38, 'Hulkar Norqoziyeva', 'Finance', 5300.00, '2019-12-19'),
(39, 'Shuhrat Baxtiyorov', 'Operations', 5200.00, '2018-06-27'),
(40, 'Dilnoza Yusupova', 'Marketing', 4700.00, '2021-07-31'),
(41, 'Vohid Olimov', 'Sales', 4500.00, '2020-08-16'),
(42, 'Nasiba Qosimova', 'HR', 4100.00, '2022-11-22'),
(43, 'Eldor Iskandarov', 'IT', 5950.00, '2017-03-09'),
(44, 'Manzura Haydarova', 'Finance', 5500.00, '2019-01-28'),
(45, 'Asilbek Rahmatullayev', 'Operations', 5050.00, '2020-05-17'),
(46, 'Sevinch Tursunova', 'Marketing', 4650.00, '2021-10-04'),
(47, 'Murod Xudoynazarov', 'Sales', 4300.00, '2022-08-11'),
(48, 'Zarnigor Hamroyeva', 'HR', 4300.00, '2023-04-15'),
(49, 'Jahongir Mirzayev', 'IT', 6800.00, '2015-02-20'),
(50, 'Sanam Botirov', 'Finance', 5800.00, '2018-09-03')



SELECT *,
ROW_NUMBER() OVER(ORDER BY Salary DESC) AS Rank
FROM employees;


with NewEmp AS (
    SELECT *,
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS Rank
    FROM employees
)
SELECT * FROM NewEmp
WHERE Rank IN (
SELECT Rank 
FROM NewEmp
GROUP BY Rank
HAVING COUNT(Rank) >=2
)

SELECT DISTINCT * 
FROM(
    SELECT Department, Salary,
    DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) as Rank
    FROM employees
) AS t
WHERE Rank <=2
ORDER BY department, Rank;


SELECT Name, department, Salary, HireDate
FROM(
    SELECT *,
    DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary) as Rank
    FROM employees
) AS t
WHERE Rank = 1
ORDER BY Salary;


SELECT Department,
SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary) AS SumSalary
FROM employees;

SELECT DISTINCT Department,
AVG(Salary) OVER(PARTITION BY Department) AS SumSalary
FROM employees;

SELECT *,
ABS(AVG(Salary) OVER(PARTITION BY Department) - Salary) AS Difference
FROM employees
ORDER BY EmployeeID;

SELECT *,
AVG(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS AvgSum
FROM employees

SELECT *,
SUM(Salary) OVER() AS SumLast3Employee
FROM(
    SELECT TOP 3 * FROM employees
    ORDER BY HireDate DESC
) as t


SELECT *,
AVG(Salary) OVER(ORDER BY EmployeeID) AS Avg
FROM employees;

SELECT *,
MAX(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MAX
FROM employees;

SELECT *,
    CAST(
        (Salary / SUM(Salary) OVER(PARTITION BY Department) * 100) 
    AS DECIMAL(10, 2)) AS p
FROM Employees
ORDER BY EmployeeID;