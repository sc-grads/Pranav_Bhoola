-- SECTION 20 COMBINE DATASETS 
--UNION AND UNION ALL 

select convert (char(5),'hi') as Greeting 
union
select convert (char(11),'hello there') 
union 
select convert (char(11),'bonjou')
union all
select convert (char(11),'hi')


select convert(tinyint , 45) as MyColumn 
union 
select convert (bigint, 456)

select 'hi there' --WONT WORK 
union 
select 4


--Intersect and Except
select *, ROW_NUMBER() over (order by (select null)) %3 as shouldidelete
--into tblTransactionNew 
from [dbo].[tblTransaction]

--Quiz 

SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'Y%'
UNION
SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'YA%'

SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'Y%'
UNION ALL
SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'YA%'

SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'Y%'
INTERSECT
SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'YA%'

SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'Y%'
EXCEPT
SELECT DISTINCT EmployeeFirstName from [dbo].[tblEmployee] where [EmployeeFirstName] like 'YA%'


--CASE STATEMENT 
declare @myOption as varchar (10) = 'Option C'

select case when @myOption = 'Option A' then 'First Option'
when @myOption = 'Option B' then 'Second Option'
else 'No Option' END as MyOption 
go

declare @myOption as varchar (10) = 'Option A'

select case @myOption when 'Option A' then 'First Option'
                      when 'Option B' then 'Second Option'
                      else 'No Option' END as MyOption 
go 

declare @myOption as varchar (10) = 'Option A'

select case when @myOption = 'Option A' then 'First Option'
when @myOption = 'Option B' then convert (varchar(10),2)
else 'No Option' END as MyOption 
go

SELECT TOP (1000) [EmployeeNumber]
      ,[EmployeeFirstName]
      ,[EmployeeMiddleName]
      ,[EmployeeLastName]
      ,[EmployeeGovernmentID]
      ,[DateOfBirth]
      ,[Department],
case when left (EmployeeGovernmentID,1) = 'A' then 'Letter A'
when  EmployeeNumber <200 then 'Less than 200'
else 'Neither Letter' End + '.' as myCol
  FROM [70-461].[dbo].[tblEmployee]

--ISNULL AND COALESCE

select * from tblEmployee where EmployeeMiddleName is null 

declare @myOption as varchar (10)= 'Option B'
select isnull (@myOption, 'No Option') as MyOptions
go

declare @myFirstOption as varchar (10)= 'Option A'
declare @mySecondOption as varchar (10)= 'Option B'

select coalesce (@myFirstOption, @mySecondOption, 'No Option') as MyOptions
go

select isnull ('ABC',1) as MyAnswer
select coalesce ('ABC',1) as MyOtherAnswer
go


create table tblExample 
(myOption nvarchar (10) null)
go 
insert into tblExample (myOption)
values ('Option A')

Select coalesce (myOption, 'No Option') as MyOptions
into tblIsCoalesce
from tblExample
go 

select isnull(myOption, 'No Option') as MyOptions
into tblIsNull
from tblExample
go 

drop table tblExample
drop table tblIsCoalesce
drop table tblIsNull

SELECT ISNULL([EmployeeMiddleName],'Blank') FROM [dbo].[tblEmployee] 
WHERE [EmployeeMiddleName] IS NULL

declare @myValue1 as nvarchar(4)
declare @myValue2 as int = 3
select COALESCE(@myValue1, @myValue2)


--MERGE STATEMENT 

MERGE into tblTransaction as T
using tble