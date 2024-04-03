--SECTION 10
--SUMMARISING AND ORDERING DATA

select * from [dbo].[tblEmployee]
where DateofBirth between '19760101' and '19861231'

select * from [dbo].[tblEmployee]
where dateofbirth >= '19760101' and dateofbirth < '19870101'

select * from [dbo].[tblEmployee]
where year (dateofbirth) between 1976 and 1986 

select YEAR(dateofbirth) as YearofDateofBirth, count (*) as NumberBorn
from tblEmployee
Group by YEAR(dateofbirth)

select * from tblEmployee 
where year (dateofbirth) = 1967

select YEAR(dateofbirth) as YearofDateofBirth, count (*) as NumberBorn
from tblEmployee
where 1=1
Group by YEAR(dateofbirth)

select YEAR(dateofbirth) as YearofDateofBirth, count (*) as NumberBorn
from tblEmployee
Group by YEAR(dateofbirth)
Order by YEAR(dateofbirth) asc


select YEAR(dateofbirth) as YearofDateofBirth, count (*) as NumberBorn
from tblEmployee
Group by YEAR(dateofbirth)
Order by YEAR(dateofbirth) desc


--CRITERIA OF SUMMARISED DATA

select left (EmployeeLastName,1) as Initial from tblEmployee

select left (EmployeeLastName,1) as Initial, count (*) as CountofInitial 
from tblEmployee
group by left (EmployeeLastName,1)
order by left (EmployeeLastName,1)

select left (EmployeeLastName,1) as Initial, count (*) as CountofInitial 
from tblEmployee
group by left (EmployeeLastName,1)
order by count (*) desc 


select top (5) left (EmployeeLastName,1) as Initial, count (*) as CountofInitial 
from tblEmployee
group by left (EmployeeLastName,1)
order by count (*) desc 


select left (EmployeeLastName,1) as Initial, count (*) as CountofInitial 
from tblEmployee
group by left (EmployeeLastName,1)
having count (*) >=50
order by count (*) desc 

select left (EmployeeLastName,1) as Initial, count (*) as CountofInitial 
from tblEmployee
where dateofbirth > '19860101'
group by left (EmployeeLastName,1)
having count (*) >=20
order by count (*) desc 

--This will change blank Middle Names to NULL Middle names.
Update tblEmployee
Set EmployeeMiddleName = NULL
Where EmployeeMiddleName = ''


--order 
--select 
--from 
--where 
--group by 
--having 
--order by 


select datename(month, DateofBirth) as MonthName, count (*) as NumberofEmployess,
count(EmployeeMiddleName) as NumberofMiddleNames,
count(*)-count (EmployeeMiddleName) as NoMiddleName,
min(DateofBirth) as EmployeeMiddleName,
max (DateOfBirth) as LatestDateofBirth
from tblEmployee 
Group by datename (month, DateofBirth), datepart(month, DateofBirth)
Order by datepart (month, DateofBirth)