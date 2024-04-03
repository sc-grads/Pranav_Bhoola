--SECTION 16 VIEWS

if exists (select * from sys.views where name = 'ViewByDepartment')
drop view ViewByDepartment
go

create view ViewByDepartment as 
select  D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as totalAmount 
from tblDepartment as D 
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 129 
--order by D.Department, T.EmployeeNumber
go


Create View ViewSummary as 
select D.Department, T.EmployeeNumber as EmpNum, sum (T.Amount) as TotalAmount 
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department 
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber 
group by D.Department, T.EmployeeNumber 
--order by D.Department , T.EmployeeNumber 
go 



select * from ViewByDepartment
select * from ViewSummary

--Altering and dropping views 
--drop view 

drop view [dbo].[ViewByDepartment]

select * from sys.views

if exists (select * from sys.views where name = 'ViewByDepartment')

select * from sys.tables

--SECURING VIEWS 

--ways to retrive views 

select V.name, S.text from sys.syscomments as S
inner join sys.views as V
on S.id = V.object_id 
select OBJECT_DEFINITION(object_id ('dbo.ViewByDepartment'))
select * from sys.sql_modules


--ADDING NEW ROWS TO VIEW 
begin tran 

insert into [dbo].[ViewByDepartment] (EmployeeNumber, DateOfTransaction, TotalAmount)
values (132,'2015-07-07', 999.99)

select * from ViewByDepartment order by Department, EmployeeNumber 

rollback tran 

begin tran 
select * from ViewByDepartment order by EmployeeNumbe, DateOfTransaction 
-- Select * from tblTransaction where EmployeeNumber in (132,142)

update ViewByDepartment 
set EmployeeNumber = 142
where EmployeeNumber = 132 

--DELETING ROWS IN A VIEW 

select * from ViewByDepartment
delete from ViewByDepartment 
where TotalAmount = 999.99 and EmployeeNumber = 132
go 

Create View ViewSimple 
as 
select * from tblTransaction
go 

begin Tran 
delete from ViewSimple
where Amount = 999.99 and EmployeeNumber = 132
Rollback Tran 


--CREATING AN INDEX VIEW 

create unique clustered index index_ViewByDepartment 
on dbo.ViewByDepartment 
(EmployeeNumber, Department)
