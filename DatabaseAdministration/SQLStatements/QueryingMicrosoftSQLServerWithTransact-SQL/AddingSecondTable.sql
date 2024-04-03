--SECTION 11 ADDING A SECOND TABLE 

USE [70-461]
GO

create table tblTransaction 
(
Amount smallmoney NOT NULL,
DateofTransaction smalldatetime NULL,
EmployeeNumber int NOT NULL) 

INSERT INTO tblTransaction 
values 
(303.56, '20141014', 458),
(174.45 ,'20141027', 700)

select * from tblTransaction 

truncate table tblTransaction 
---
--WRITING A JOIN QUERY
select tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName, sum (Amount) as SumofAmount 
from tblEmployee 
join tblTransaction 
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
Group by tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName
order by EmployeeNumber

select * from tblEmployee
where EmployeeNumber = 1046

select tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName, sum (Amount) as SumofAmount 
from tblEmployee 
left join tblTransaction 
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
Group by tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName


select tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName, sum (Amount) as SumofAmount 
from tblEmployee 
right join tblTransaction 
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
Group by tblEmployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName

--CREATING A THIRD TABLE 


select count(Department) as NumberOfDepartment
from 
(select Department, COUNT (*) AS NumberOfDepartment 
from tblEmployee 
group by Department)as newTable   --derived table 

select distinct Department, '' as DepartmentHead
into tblDepartment 
from tblEmployee


--JOINING THREE TABLES

SELECT *
FROM tblDepartment
left join tblEmployee
on tblDepartment.Department = tblEmployee.Department
left join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber


SELECT tblDepartment.Department, sum(Amount) as SumOfAmount 
FROM tblDepartment
left join tblEmployee
on tblDepartment.Department = tblEmployee.Department
left join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblDepartment.Department 

insert into tblDepartment (Department,DepartmentHead)
values ('Accounts','James')


SELECT  DepartmentHead, sum(Amount) as SumOfAmount 
FROM tblDepartment
left join tblEmployee
on tblDepartment.Department = tblEmployee.Department
left join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by  DepartmentHead
order by DepartmentHead

select D.DepartmentHead, sum (T.Amount) as SumOFAmount 
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.DepartmentHead
order by d.DepartmentHead