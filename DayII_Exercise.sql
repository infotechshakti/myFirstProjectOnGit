SELECT * FROM SALES WHERE branch = 'London-1'
SELECT * FROM temp_SALES

--Q1
SELECT branch FROM SALES WHERE item LIKE 'Cell Phone%' AND quantity > 0

--Q2
SELECT branch, SUM(quantity) as ItemsSold
FROM SALES
WHERE date BETWEEN '2021-12-01' AND '2021-12-31'
GROUP BY branch;

--Q3
SELECT branch FROM SALES WHERE quantity > 3

--Q4
CREATE TABLE [dbo].[temp_sales](
	[branch] [varchar](64) NOT NULL,
	[date] [datetime] NULL,
	[seller] [varchar](64) NOT NULL,
	[item] [varchar](64) NOT NULL,
	[quantity] [int] NULL,
	[unit_price] [int] NULL
)

INSERT INTO [temp_sales] SELECT * FROM sales WHERE branch LIKE 'London%';

--Q5
SELECT branch,date,seller,item,quantity,unit_price,
CASE
	WHEN branch LIKE 'London%' THEN 'United Kingdom'
	WHEN branch LIKE 'Paris%' THEN 'France'
	ELSE 'OTHER'
END AS Country
FROM Sales;

--Q6
SELECT branch,date,SUM(quantity * unit_price) as SalesAmount, MAX(unit_price) as ExpensiveItemSold
FROM Sales
GROUP BY branch,date

--Q7

DECLARE @quota int
SET @quota = 500
IF @quota < (SELECT SUM(quantity * unit_price) as SalesAmount FROM Sales GROUP BY branch, date)
	PRINT 'WE HAVE REACHED THE QUOTA'
ELSE
	PRINT 'OTHER'


SELECT SUM(quantity * unit_price) as SalesAmount, 'WE HAVE REACHED THE QUOTA' as QuotaRemark
FROM Sales
GROUP BY branch, date
HAVING SUM(quantity * unit_price) > 500;