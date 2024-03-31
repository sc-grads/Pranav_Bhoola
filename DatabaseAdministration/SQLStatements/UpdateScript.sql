-- Create the StudentDatabase
CREATE DATABASE StudentDatabase;
GO

-- Use the StudentDatabase
USE StudentDatabase;
GO

-- Create the StudentInformation table
CREATE TABLE StudentInformation (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Subject NVARCHAR(50),
    Grade VARCHAR(5)
);
GO

-- Insert sample data into the StudentInformation table
INSERT INTO StudentInformation (StudentID, FirstName, LastName, Subject, Grade)
VALUES
    (1, 'John', 'Smith', 'Math', 'A');
    
GO

-- Create the SubjectInformation table
CREATE TABLE SubjectInformation (
    SubjectID INT,
    SubjectName NVARCHAR(50),
    Teacher NVARCHAR(50),
);

GO

-- Insert sample data into the SubjectInformation table
INSERT INTO SubjectInformation (SubjectID, SubjectName, Teacher)
VALUES
    (1, 'Math', 'Mr. Johnson');
    
GO

-- Create the InsertStudent stored procedure
CREATE PROCEDURE InsertStudent
    @StudentID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Subject NVARCHAR(50),
    @Grade VARCHAR(5)
AS
BEGIN
    INSERT INTO StudentInformation (StudentID, FirstName, LastName, Subject, Grade)
    VALUES (@StudentID, @FirstName, @LastName, @Subject, @Grade);
END;
GO

-- Create the InsertSubject stored procedure
CREATE PROCEDURE InsertSubject
    @SubjectID INT,
    @SubjectName NVARCHAR(50),
    @Teacher NVARCHAR(50)
AS
BEGIN
    INSERT INTO SubjectInformation (SubjectID, SubjectName, Teacher)
    VALUES (@SubjectID, @SubjectName, @Teacher);
END;
GO

-- Insert data using the InsertSubject stored procedure
EXEC InsertSubject
    @SubjectID = 2,
    @SubjectName = 'Science',
    @Teacher = 'Ms. Parker'; 

-- Insert data using the InsertStudent stored procedure 
EXEC InsertStudent
    @StudentID = 2,
    @FirstName = 'Pranav',
    @LastName = 'Bhoola',
    @Subject = 'Science',
    @Grade = 'A'; 