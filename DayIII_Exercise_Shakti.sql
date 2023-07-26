--Que 1

CREATE PROC ProductsAvailable @inputBranch varchar(64)
As
	SELECT DISTINCT(item) FROM sales where branch = @inputBranch

EXEC ProductsAvailable 'London-1'


--Que 2
CREATE PROC SalesAmountForSeller @inputSeller varchar(64)
As
	SELECT 'Sales Amount for Seller ' + @inputSeller+ ' is' , SUM(quantity * unit_price) FROM sales WHERE seller = @inputSeller

EXEC SalesAmountForSeller 'Charles'

--Que 3
CREATE FUNCTION udf_DateOfHighestUnitsSold(@pid int)
	returns table
as
	return
	(
		SELECT date, MAX(quantity) HighestQuantity FROM sales GROUP BY date
	)

SELECT * FROM udf_DateOfHighestUnitsSold(1)


--Que 4
CREATE FUNCTION udf_BranchDetails(@inputBranch varchar(64))
	returns table
as
	return
	(
		SELECT branch, item, unit_price FROM sales where branch = @inputBranch
	)

SELECT * FROM udf_BranchDetails('London-1')

--Que 5
CREATE PROC QueryAnyTable @inputTableName NVARCHAR(128)
As
	DECLARE @sqlquery NVARCHAR(MAX)
	SET @sqlquery = 'SELECT * FROM ' + QUOTENAME(@inputTableName)
	EXEC sp_executesql @sqlquery

EXEC QueryAnyTable 'Sales'