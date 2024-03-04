create table salesstaff
(
StaffID int not null primary key,
firstname nvarchar (50) not null,
lastname nvarchar (50) not null,
countryregion nvarchar (50) not null
)

drop table salesstaff

select * from salesstaff 

insert into salesstaff 
select businessentityid, firstname, lastname, CountryRegionName from sales.vSalesPerson;

delete salesstaff;

delete from salesstaff;

delete from salesstaff where CountryRegion = 'united states';