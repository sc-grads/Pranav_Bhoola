--DATE DATA TYPES 

declare @mydate as datetime = '2015-06-24 12:34:56.124'
select @mydate as MyDate

declare @mydate2 as datetime2(3) = '20150624 12:34:56.124'
select @mydate2 as MyDate


select DATEFROMPARTS(2024,03,12) as ThisDate 

select year(@mydate) as myYear, month(@mydate) as myMonth, day (@mydate) as myDay

DECLARE @mydate AS datetime2


--TODAYS DATE, AND MORE DATE FUNCTIONS 
--3 ways 

select CURRENT_TIMESTAMP as rightnow 
select GETDATE() as rightnow 
select SYSDATETIME() as rightnow 

select dateadd(year,1,'2024-03-12 11:05:05')as myYear
select datepart (hour, '2015-01-02 11:05:05') as myHour
select DATENAME(WEEKDAY, GETDATE())as myAnswer
select DATEDIFF(SECOND, '2015-01-02 03:04:05',getdate()) as SecondElapsed

select DATEDIFF(month,'2015-01-02 03:04:05',getdate()) as MonthElapsed


--DATE OFFSET

declare @myDateOffset as datetimeoffset = '2015-06-25 01:02:03.456 +05:30'
select @myDateOffset as MyDateoffSet
go

declare @myDate as datetime2 = '2015-06-25 01:02:03.456'
select TODATETIMEOFFSET(@myDate, '+05:03') as MyDateOffset

declare @myDateOffset as datetimeoffset = '2015-06-25 01:02:03.456 +05:30'
select SWITCHOFFSET (@myDateOffset,'-05:00') as MyDateOffsetTexas
go

--CONVERTING FROM DATE TO STRING	

declare @mydate as datetime = '2015-06-25 01:02:03.456'
select convert (nvarchar(20),@mydate) as MyConvertedDate

declare @mydate as datetime = '2024-03-12 01:02:03.456'
select CAST(@mydate as nvarchar(20)) as MyCostDate 

select parse ('Jueves, 25 de junio de 2015' as date using 'es-ES') as MySpanishParsedDate

select FORMAT(cast('2015-06-25 01:02:03.456' as datetime),'D') as MyFormattedLongDate
select FORMAT(cast('2015-06-25 01:02:03.456' as datetime),'d')as MyFormattedShortDate



