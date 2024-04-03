--SECTION 17 CREATEING AN AFTER TRIGGER 

CREATE TRIGGER TriggerName
    ON [dbo].[TableName]
    AFTER DELETE, INSERT, UPDATE
    AS
    BEGIN
	 Select * from inserted 
	 Select * from Deleted 
    SET NOCOUNT ON
    END

	   SET NOCOUNT ON
	SELECT * FROM tblDepartment
	   SET NOCOUNT off



CREATE TRIGGER TR_tblTransaction 
On tblTransaction 
after delete , insert, update
as
begin 
select * from inserted
select * from deleted
end 
go 

begin Tran 
insert into tblTransaction(Amount,DateofTransaction,EmployeeNumber)
values (123, '2015-07-10', 123)
rollback tran 
go


--Creating an INSTEAD OF TRIGGER 
create trigger NameOfTrigger ON NameOfTable 
instead of delete, insert 
as 
begin 
set nocount on
end 

-- 
create trigger tr_ViewByDepartment 
on dbo.ViewByDepartment 
instead of delete 
as 
begin 
  select *, 'ViewByDepartment' from deleted
  end 

begin tran 
select * from ViewByDepartment where totalAmount = 2.77 and employeeNumber = 132
delete from ViewByDepartment
where totalAmount = 2.77 and EmployeeNumber = 132
select * from ViewByDepartment where totalAmount = 2.77 and EmployeeNumber = 132 
rollback tran 

alter trigger tr_ViewByDepartment
on dbo.ViewByDepartment
instead of delete 
as 
begin 


declare @EmployeeNumber as int 
declare @DateOfTransaction as Smalldatetime 
declare @Amount as smallmoney 
select @EmployeeNumber = EmployeeNumber, @DateOfTransaction = DateOfTransaction, @Amount = TotalAmount 
from Deleted 

--select * from Deleted 
delete tblTransaction
from tblTransaction as T 
where T.EmployeeNumber = @EmployeeNumber
and T.DateofTransaction = @DateOfTransaction
and T.Amount = @Amount
end 


begin tran 
--select * from ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
delete from ViewByDepartment
where totalAmount = -2.77 and EmployeeNumber = 132
select * from ViewByDepartment where totalAmount = -2.77 and EmployeeNumber = 132
rollback tran 



--Nested Trigger 

ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
    if @@NESTLEVEL = 1
	begin
		select *,'TABLEINSERT' from Inserted
		select *, 'TABLEDELETE' from Deleted
	end
END
GO

BEGIN TRAN
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-10', 123)
ROLLBACK TRAN

begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

EXEC sp_configure 'nested triggers';

EXEC sp_configure 'nested triggers',0;
RECONFIGURE
GO
