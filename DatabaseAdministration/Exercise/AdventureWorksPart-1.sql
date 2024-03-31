--Question 1

select * from [HumanResources].[Employee]
order by JobTitle 

--Question 2 

select P.* from [Person].[Person] as P
order by Lastname 

--Question 3 

select FirstName, LastName, BusinessEntityID as Employee_id from [Person].[Person]
order by LastName

--Question 4 
select * from [Production].[Product]

select ProductID, ProductNumber, Name as ProductName from [Production].[Product]
where SellStartDate is not null and ProductLine = 'T' 
order by ProductName

--Question 5 

select * from [Sales].[SalesOrderHeader]

select SalesOrderID, CustomerID, OrderDate, SubTotal, taxamt*100/subtotal as tax_percent
from [Sales].[SalesOrderHeader] order by SubTotal

--Question 6 

select distinct JobTitle from [HumanResources].[Employee]
order by JobTitle

--Question 7 
select * from [Sales].[SalesOrderHeader]

select CustomerID,sum(Freight) as Total_Freight from [Sales].[SalesOrderHeader]
group by CustomerID order by CustomerID 

--Question 8 

select CustomerID, SalesPersonID, avg(SubTotal) as avg_subtotal,sum(SubTotal) as sum_subtotal  from [Sales].[SalesOrderHeader]
group by CustomerID, SalesPersonID order by CustomerID desc

--Question 9
select * from [Production].[ProductInventory]

select ProductID, sum(Quantity) as total_quantity from [Production].[ProductInventory]
where shelf IN ('A','C','H') group by ProductID
having sum(quantity) > 500 order by ProductID 

--Question 10 

select sum(Quantity) as total_quantity from [Production].[ProductInventory]
group by locationid *10

--Question 11 
select * from [Person].[Person]
select * from [Person].[PersonPhone]


select P.BusinessEntityID, FirstName, LastName, PhoneNumber as person_phone   from [Person].[Person] as P 
join [Person].[PersonPhone] as PP 
on P.businessentityID  = PP.businessentityID where LastName LIKE 'L%' 
order by lastname, firstname

--Question 12

select salespersonid, customerid, sum(subtotal) as sum_subtotal from [Sales].[SalesOrderHeader] s 
group by rollup (salespersonid, customerid)

--Question 13 

select LocationID, Shelf, sum(Quantity) as TotalQuantity from [Production].[ProductInventory]
group by locationid, shelf 


--Question 14 

select locationid, shelf, sum(quantity) as TotalQuantity from [Production].[ProductInventory]
group by grouping sets ( rollup (locationid, shelf), cube (locationid, shelf) )

--Question 15 

select LocationID, sum(Quantity) as TotalQuantity from [Production].[ProductInventory]
group by LocationID

--Question 16 

select * from [Person].[Address]
select * from  [Person].[BusinessEntityAddress]


select PA.City, COUNT(BE.AddressID) NoOfEmployees from [Person].[BusinessEntityAddress] as BE   
join [Person].[Address] as PA 
on BE.AddressID = PA.AddressID group by PA.City order by PA.City 

--Question 17 
select * from Sales.SalesOrderHeader

select datepart(YEAR,OrderDate) as YearOfOrder ,sum(TotalDue) as TotalSales from Sales.SalesOrderHeader
group by datepart(YEAR,OrderDate) order by datepart(YEAR,OrderDate)

--Question 18 

select datepart(YEAR,OrderDate) as YEAROFORDERDATE, sum (TotalDue) as TOTALDUEORDER  from [Sales].[SalesOrderHeader]
group by datepart(YEAR,OrderDate)  
having datepart(YEAR,OrderDate) <= 2016 order by datepart(YEAR,OrderDate)


--Question 19 

select ContactTypeID, Name from [Person].[ContactType]
where Name LIKE '%Manager%' order by Name desc

--Question 20

select PP.BusinessEntityID, LastName, FirstName from [Person].[BusinessEntityContact] as BE 
join [Person].[ContactType] as PC on PC.ContactTypeID = BE.ContactTypeID
join [Person].[Person] AS PP on PP.BusinessEntityID = BE.PersonID
where PC.Name = 'Purchasing Manager'order by LastName, FirstName

--Question 21

select row_number() over (partition by PostalCode order by SalesYTD desc) as "Row Number",
pp.LastName, sp.SalesYTD, pa.PostalCode from [Sales].[SalesPerson] as sp
join [Person].[Person] as pp on sp.BusinessEntityID = pp.BusinessEntityID
join Person.Address as pa on pa.AddressID = pp.BusinessEntityID
where TerritoryID is not null and SalesYTD <> 0 order by PostalCode
 
--Question 22

select * from [Person].[BusinessEntityContact]
select * from [Person].[ContactType] 

select PC.ContactTypeID, PC.Name as CTypeName,  COUNT(*) as NoContacts from [Person].[BusinessEntityContact] as BE
join [Person].[ContactType] as PC on PC.ContactTypeID = BE.ContactTypeID  
group by pc.ContactTypeID, PC.Name having COUNT(*) >= 100 
order by COUNT(*) desc  

--Question 23
 
select CAST(HR.RateChangeDate as varchar(10)) as FromDate, CONCAT(LastName, ', ', FirstName, ' ', MiddleName) as NameInFull,
(40 * HR.Rate) as SalaryInAWeek
from [Person].[Person] as P
join [HumanResources].[EmployeePayHistory] AS HR on HR.BusinessEntityID = P.BusinessEntityID
order by NameInFull

--Question 24 

select CAST(HR.RateChangeDate as varchar(10)) as FromDate, CONCAT(LastName, ', ', FirstName, ' ', MiddleName) as NameInFull,
(40 * HR.Rate) as SalaryInAWeek
from [Person].[Person] as P
join [HumanResources].[EmployeePayHistory] AS HR on HR.BusinessEntityID = P.BusinessEntityID
where HR.RateChangeDate = (select MAX(RateChangeDate) from HumanResources.EmployeePayHistory where BusinessEntityID = HR.BusinessEntityID)
order by NameInFull

--Question 25 
select * from [Sales].[SalesOrderDetail]

select SalesOrderID, ProductID, OrderQty,
sum(OrderQty) over (partition by SalesOrderID) as "Total Quantity", 
avg(OrderQty) over (partition by  SalesOrderID) as "Avg Quantity",
count(OrderQty) over (partition by  SalesOrderID) as "No of Orders",
min(OrderQty) over (partition by SalesOrderID) as "Min Quantity",
max(OrderQty) over (partition by  SalesOrderID) as "Max Quantity"
from [Sales].[SalesOrderDetail] where SalesOrderID in (43659,43664) 
   