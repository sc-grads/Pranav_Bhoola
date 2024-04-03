--SECTION 33 WITH STATEMENTS 

-- WITH STATEMENT

with tblWithRanking as
(select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
       rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
 from tblDepartment as D 
 join tblEmployee as E on D.Department = E.Department

select * from tblWithRanking 
where TheRank <= 5
order by Department, EmployeeNumber

with tblWithRanking as
(select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
       rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
 from tblDepartment as D 
 join tblEmployee as E on D.Department = E.Department),
Transaction2014 as
(select * from tblTransaction where DateOfTransaction < '2015-01-01')

select * from tblWithRanking 
left join Transaction2014 on tblWithRanking.EmployeeNumber = Transaction2014.EmployeeNumber
where TheRank <= 5
order by Department, tblWithRanking.EmployeeNumber


--GENETATIONG A LIST OF NUMBERS 

select E.EmployeeNumber from tblEmployee as E 
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber IS NULL
order by E.EmployeeNumber

select max(EmployeeNumber) from tblTransaction;

with Numbers as (
select top(select max(EmployeeNumber) from tblTransaction) row_Number() over(order by (select null)) as RowNumber
from tblTransaction as U)

select U.RowNumber from Numbers as U
left join tblTransaction as T
on U.RowNumber = T.EmployeeNumber
where T.EmployeeNumber is null
order by U.RowNumber

select row_number() over(order by(select null)) from sys.objects O cross join sys.objects P



--GROUPING NUMBERS 

with Numbers as (
select top(select max(EmployeeNumber) from tblTransaction) row_Number() over(order by (select null)) as RowNumber
from tblTransaction as U),
Transactions2014 as (
select * from tblTransaction where DateOfTransaction>='2014-01-01' and DateOfTransaction < '2015-01-01'),
tblGap as (
select U.RowNumber, 
       RowNumber - LAG(RowNumber) over(order by RowNumber) as PreviousRowNumber, 
	   LEAD(RowNumber) over(order by RowNumber) - RowNumber as NextRowNumber,
	   case when RowNumber - LAG(RowNumber) over(order by RowNumber) = 1 then 0 else 1 end as GroupGap
from Numbers as U
left join Transactions2014 as T
on U.RowNumber = T.EmployeeNumber
where T.EmployeeNumber is null),
tblGroup as (
select *, sum(GroupGap) over (ORDER BY RowNumber) as TheGroup
from tblGap)
select Min(RowNumber) as StartingEmployeeNumber, Max(RowNumber) as EndingEmployeeNumber,
       Max(RowNumber) - Min(RowNumber) + 1 as NumberEmployees
from tblGroup
group by TheGroup
order by TheGroup



