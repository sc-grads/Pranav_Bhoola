SELECT * FROM [dbo].[Student]
go

select * from [dbo].[Course]

select s.rollno,s.studentname,c.courseid from student s
inner join course c
on s.RollNO = c.RollNO
-----------------

select s.rollno,s.studentname,c.courseid from student s
left join course c
on s.RollNO = c.RollNO
--------------------

select s.rollno,s.studentname,c.courseid from student s
right join course c
on s.RollNO = c.RollNO
-------------------------------

select s.rollno,s.studentname,c.courseid from student s
full join course c
on s.RollNO = c.RollNO
------------------------------