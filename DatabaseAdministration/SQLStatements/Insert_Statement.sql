create table salesstaff
(
  staffid int not null primary key,
  fname nvarchar(30) not null,
  lname nvarchar(30) not null,
  )

  insert into salesstaff (staffid,fname,lname) values (200,'abbas','mehmood')

  select * from salesstaff

  insert into salesstaff (staffid,fname,lname) values (300,'imran','afzal'), (325,'john','wick'), (314,'jomes','dino')


  create table salesstaffNew
(
ID int not null IDENTITY primary key,
  staffid int not null ,
  fname nvarchar(30) ,
  lname nvarchar(30) ,
  )


   insert into salesstaffNew (staffid,fname,lname) values (200,'abbas','mehmood')


   select * from salesstaffNew

   insert into salesstaffNew (staffid,fname,lname) values (300,'imran','afzal'), (325,'john','wick'), (314,'jomes','dino')


   create table nameOnlyTable
(

  fname nvarchar(30) ,
  lname nvarchar(30) ,
  )

  select * from nameOnlyTable

  insert nameOnlyTable (fname,lname)
  select fname,lname from salesstaffNew where id>= 3

  select * into salesstaffNew_bkp from salesstaffNew 

  select * from salesstaffNew_bkp 