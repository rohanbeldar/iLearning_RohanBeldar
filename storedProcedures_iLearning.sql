Alter table eLibrary ADD balance int, due_date DATETIME;

Alter table eLibrary
Alter column balance float;

CREATE PROCEDURE SelectAllBalance @balance float
AS
SELECT studentID from eLibrary where balance = @balance
GO;
EXEC SelectAllBalance @balance = 0


Alter table Grades ADD overallPercent int;

Create Procedure FailedStudent @overallPercent int   As   Select * From Grades where overallPercent < @overallPercent   Go;
   EXEC FailedStudent @overallPercent = 55


Alter table Attendance ADD attendanceStatus int;

create Procedure AttendanceReport @attendanceStatus int
As
select * from Attendance where attendanceStatus < @attendanceStatus
GO
EXEC AttendanceReport @attendanceStatus = 75


Alter table Fees ADD due_date DATETIME, fees_balance float;

Alter table Fees
Alter column due_date nvarchar;

Create Procedure FeeDueDate @due_date nvarchar
AS
select *from Fees where due_date < @due_date
EXEC FeeDueDate @due_date = DATENAME


Alter table Feedback ADD feedbackRating int;

Create Procedure FeedbackRatings @feedbackRating intAsSelect * From Feedback where feedbackRating <= @feedbackRatingEXEC FeedbackRatings @feedbackRating =3

Alter table Course ADD fees_balance float;

Create Procedure courseName @course_Name varchar(255)AsSelect fees_balance From Course where course_Name = @course_NameEXEC courseName @course_Name = "MSD";create procedure gradeDesc @grade varcharasselect * from Grades where Grade = @grade
EXEC gradeDesc @grade = A;


Create procedure getSubjectDescription @subjectID intAsSelect Subject.subjectID, subject_Descfrom Subjectinner join subjectDescription ON Subject.subjectID = SubjectDescription.subjectIDEXEC getSubjectDescription @subjectID = 1;

Create Procedure instructorOfASubject @subjectName varchar(255)AsSelect subject_Name, instructor_name from subjectwhere subject_Name = @subjectName
EXEC instructorOfASubject @subjectName = "Math"


Alter table Assignment
Alter column Due_Date nvarchar;

Create Procedure AssignmentDueDate @due_date nvarchar
AS
select subjectID from Assignment where due_date < @due_date
EXEC AssignmentDueDate @due_date = DATENAME


Create Procedure getGrade @grade varchar(255)
AS
select *from Grades where Grade = @grade
EXEC getGrade @grade = "A+";


Create Procedure contactNum @contactnum nvarchar
AS
select *from Registration where student_ContactNo = @contactnum
EXEC contactNum @contactnum = "'(' + SUBSTRING(@PhoneNumber, 1, 3) + ') ' + SUBSTRING(@PhoneNumber, 4, 3) + '-' + SUBSTRING(@PhoneNumber, 7, 4)";


Create Procedure getPercentage @percentage int
AS
select *from Grades where Percentage < @percentage
EXEC getPercentage @percentage = 55;

Create procedure getBook @bookName varchar(255)AsSelect StudentCard.student_Emailfrom StudentCardinner join eLibrary ON StudentCard.student_Email = eLibrary.book_NameEXEC getBook @bookName = "abc";
Create procedure getGradeMarks @gradeMarks varchar(255)AsSelect Instructor.instructor_Namefrom Instructorinner join Grades ON Instructor.instructor_Name = Grades.PercentageWhere Grades.Grade <= @gradeMarksEXEC getGradeMarks @gradeMarks = "55";


Alter table eLibrary
Alter column due_date nvarchar;

Create procedure getNotification @dueDateNotification nvarcharAsSelect eLibrary.due_datefrom eLibraryinner join Notification ON eLibrary.due_date = Notification.studentIDWhere eLibrary.due_date < @dueDateNotificationEXEC getNotification @dueDateNotification = DATENAME;
