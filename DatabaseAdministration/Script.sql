- Create the StudentDatabase
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
    (1, 'John', 'Doe', 'Math', 'A'),
    (2, 'Jane', 'Smith', 'English', 'B'),
    (3, 'Bob', 'Johnson', 'Science', 'C'),
    (4, 'Alice', 'Williams', 'History', 'A');
GO
