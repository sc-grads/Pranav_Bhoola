--SECTION 15

insert into tblEmployee
values (2001, 'FirstName', 'M', 'LastName', 'AB123456C', '1994-01-01', 'Commericial')
insert into tblEmployee
values (null, 'AnotherFirstName' , 'N' , 'AnotherLastName' , 'AB123457C' ,'1994-01-02', 'Finance')

select * from tblEmployee where EmployeeNumber = 2001

Delete from tblEmployee 
where EmployeeNumber > 2000 

--Unique Constraints in Action 

alter table tblEmployee
add constraint unqGovernmentID unique (EmployeeGovernmentID);

select EmployeeGovernmentID, count (EmployeeGovernmentID) as mycount from tblEmployee
group by EmployeeGovernmentID
having count (EmployeeGovernmentID) > 1

select * from tblEmployee where EmployeeGovernmentID in ('HN13777D','TX593671R')

begin tran 
delete from tblEmployee  -- dont execute 
where EmployeeNumber < 3

Delete top (2) from tblEmployee  --dont execute 
where EmployeeNumber in (131,132)


--adding constrain to multiple columns 

alter table [dbo].[tblTransaction]
add constraint unqTransaction unique (Amount, DateOfTransaction, EmployeeNumber)

delete from tblEmployee
where EmployeeNumber =131

insert into tblTransaction2
values (1,'2015-01-01',131)
insert into tblTransaction
values (1,'2015-01-01',131)

alter table tblTransaction
drop constraint unqTransaction 


create table tblTransaction2
(Amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
Constraint unqTransaction2 unique (Amount, DateOfTransaction, EmployeeNumber)
)

drop table tblTransaction2


--Default Constraints in Action 

alter table tblTransaction 
add DateOfEntry datetime 

alter table tblTransaction 
add constraint defDateOfEntry default getdate() for DateOfEntry;

delete from tblTransaction where EmployeeNumber < 3

insert into tblTransaction (Amount, DateOfTransaction, EmployeeNumber)
values (1,'2014-01-01',1)

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values (2,'2014-01-02',1, '2013-01-01') 

select * from tblTransaction where EmployeeNumber < 3 

create table tblTransaction2
(Amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
DateOfEntry datetime null constraint tblTransaction2_defDateOfEntry default getdate())

insert into tblTransaction2 (Amount, DateOfTransaction, EmployeeNumber)
Values(1,'2014-01-01',1)
insert into tblTransaction2 (Amount,DateOfTransaction,EmployeeNumber,DateOfEntry)
values (2,'2014-01-01',1,'2013-01-01')

select * from tblTransaction2 where EmployeeNumber < 3

drop table tblTransaction2

alter table tblTransaction 
drop column DateOfEntry

alter table tblTransaction 
drop constraint defDateOfEntry 


--Check Constraints

alter table tblTransaction 
add constraint chkAmount check (Amount >-1000 and Amount < 1000)


insert into tblTransaction
values (-110, '2014-01-01',1)

alter table tblEmployee
add constraint chkMiddleName check
(replace (EmployeeMiddleName, '.','')=EmployeeMiddleName or EmployeeMiddleName is null)

alter table tblEmployee with nocheck 
add constraint chkMiddleName check
(replace (EmployeeMiddleName, '.','')=EmployeeMiddleName or EmployeeMiddleName is null)

alter table tblEmployee
drop constraint chkMiddleName

begin tran 
insert into tblEmployee
values (2003, 'A','B.','C','D','2014-01-01', 'Accounts')
select * from tblEmployee where EmployeeNumber = 2003
rollback tran

alter table tblEmployee with nocheck
add constraint chkDateOfBirth check (DateOfBirth between '1900-01-01' and getdate())

begin tran 
insert into tblEmployee
values (2003, 'A','B','C','D','1915-01-01', 'Accounts')
select * from tblEmployee where EmployeeNumber = 2003
rollback tran


create table tblEmployee2
(EmployeeMiddleName varchar (50) null, constraint CK_EmployeeMiddleName check 
(replace (EmployeeMiddleName, '.','')=EmployeeMiddleName or EmployeeMiddleName is null))

drop table tblEmployee2

alter table tblEmployee
drop chkDateOfBirth 
alter table tblEmployee
drop chkMiddleName
alter table tblTransaction
drop chkAmount 


--Primary Key 
alter table tblEmployee
add constraint PK_tblEmployee PRIMARY KEY (EmployeeNumber)

insert into tblEmployee(EmployeeNumber,EmployeeFirstName,EmployeeMiddleName,EmployeeLastName,
EmployeeGovernmentID,DateofBirth,Department)
values (2004,'FirstName', 'MiddleName','LastName','AB12345FH', '2014-01-01', 'Accounts')

delete from tblEmployee
where EmployeeNumber = 132

alter table tblEmployee
drop constraint PK_tblEmployee

create table tblEmployee2
(EmployeeNumber int constraint PK_tblEmployee2 Primary Key Identity(1,1),
EmployeeName nvarchar (20))

insert into tblEmployee2
values ('My Name'),
('My Name')

select * from tblEmployee2

delete from tblEmployee2

truncate table tblEmployee2

insert into tblEmployee2 (EmployeeNumber, EmployeeName)
values (3, 'My Name'), (4,'My Name')

set identity_insert tblEmployee2 on 

insert into tblEmployee2 (EmployeeNumber, EmployeeName)
values (38, 'My Name'), (39,'My Name')

set identity_insert tblEmployee2 off 


drop table tblEmployee2

select @@IDENTITY
select SCOPE_IDENTITY()

create table tblEmployee3
(EmployeeNumber int constraint PK_tblEmployee3 Primary Key Identity(1,1),
EmployeeName nvarchar (20))

insert into tblEmployee3 
values ('My Name'),
('My Name')

select IDENT_CURRENT ('dbo.tblEmployee')

--Foreign Key 

ALTER TABLE tblTransaction with nocheck
add constraint FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber)
REFERENCES tblEmployee(EmployeeNumber)


begin tran 
alter table tblTransaction alter column EmployeeNumber int null
alter table tblTransaction ADD constraint DF_tblTransaction default 124 for EmployeeNumber
Alter table tblTransaction with nocheck
add constraint FK_tblTransaction_EmployeeNumber foreign key (EmployeeNumber)
references tblTransaction (EmployeeNumber)

on update  set default





update tblEmployee set EmployeeNumber =9123 where EmployeeNumber =123
--delete tblEmployee where EmployeeNumber = 123


select E.EmployeeNumber, T.*
FROM tblEmployee as E
Right Join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber 
WHERE T.Amount IN (-179.47, 786.22,-967.36,957.03)

ROLLBACK TRAN 
