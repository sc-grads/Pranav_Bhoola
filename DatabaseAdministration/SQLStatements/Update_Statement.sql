select
FirstName +' '+ LastName as FullName,
TerritoryName,
TerritoryGroup,
SalesQuota,
SalesYTD, 
SalesLastYear 
into SalesStaff 
From
Sales.vSalesPerson

SELECT * FROM [Sales].[vSalesPerson]

drop table SalesStaff;

SELECT * FROM SalesStaff



UPDATE SalesStaff SET salesquota = 50000.00

UPDATE SalesStaff SET salesquota = salesquota + 150000.00

UPDATE SalesStaff SET salesquota = salesquota + 150000.00, salesYTD = salesYTD -500, salesLastYear = salesLastYear *1.50

UPDATE SalesStaff SET territoryname = 'UK' where territoryname = 'United Kingdom'