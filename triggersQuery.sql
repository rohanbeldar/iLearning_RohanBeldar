alter table Assignment
add gradeStatus varchar(50);

alter table Assignment
add gradationDate datetime;

insert into Instructor
values(10,'Jomis John','jj@gmail.com',9545968989);

insert into Subject
values(03,'DBA assignment',10,'Jomis John');

insert into Assignment
values(01,'DBA assignment',03,'Programming database design',GETDATE(),'not graded',2021-10-14);
select * from Assignment

-- ROHAN BELDAR query number 21------------------------------------------------------

create trigger GradeUpdated_trigger on Assignment after insert, update
as begin
set nocount on;
update Assignment set gradationDate = getdate()
from Assignment Assign
inner join inserted iAssign
on Assign.subject_ID = iAssign.subject_ID
and iAssign.gradeStatus = 'graded'
end
go

update Assignment set gradeStatus = 'graded' 
where subject_ID = 03;


create table FeesStatus(studentID int, feesStatus varchar(55));
insert into College values(801,'conestoga','conestoga@gmail.com',013456);
insert into Course values(501,'MSD',801,'full time');
insert into Student values(701,'rohan','rohan@gmail.com',9545968989,'1997-10-30');
select * from Student
delete from Student where student_ID = 701;

alter table Fees add feesBalance int, dueDate datetime;

insert into Fees values(601,501,701,'MSD','rohan',2500,getdate());
delete from Fees where student_ID = 701;
select * from Fees

-- ROHAN BELDAR query number 22------------------------------------------------------

create table FeesStatus(studentID int, feesStatus varchar(55));

create trigger StudentFeesStatus_trigger1  
on Fees
for insert
--for each row 
as
begin

declare @student_ID int, @feesStatus varchar(50), @feesBalance int
select @feesBalance = feesBalance from inserted

if (@feesBalance > 0)  
begin
insert into FeesStatus(studentID,feesStatus) values (@student_ID,'fees overdue')
end
else if @feesBalance = 0 
begin
insert into FeesStatus(studentID,feesStatus) values (@student_ID,'fees paid')
end
else
begin
insert into FeesStatus(studentID,feesStatus) values (@student_ID,'fees balance negative');
end
end;

drop trigger StudentFeesStatus;

select * from Student;
select * from Instructor;
--------------------------------------------------------------------------------------------------
-- Aditya Pathak's query 17----------------------------------------------------------------

alter table notification
ADD send_welcome_message varchar(20);

CREATE TRIGGER welcome_msg
on [dbo].[Student]
for insert
as begin 
insert into notification(notification_ID, send_welcome_message) values ('10', 'true')
select * from [dbo].[Notification]
End

--insert into Student(student_ID, contactNo, DOB, student_email, student_name) values (10, 10, GETDATE(), 'aditya10', 'aditya');

--Aditya pathak's query 18
alter table Fees
ADD fees_reminder varchar(255);

CREATE TRIGGER fees_reminderr
on Fees
for insert
as begin 
insert into Fees(receipt_ID, fees_reminder) values ('100', 'true')
select * from Fees 
where feesBalance>0
End
drop trigger fees_reminderr

insert into Fees(receipt_ID) values (120);


-------------------------------------------------------------------------------------------------------------------------------------

--Aditya pathak's query 19
alter table Attendance add attendanceStatus varchar(50);

alter table attendance add low_attendance_reminder varchar(20);

CREATE TRIGGER low_attendance
on Attendance
for insert
as begin 
insert into Attendance(student_ID, low_attendance_reminder) values (400, 'true')
select * from Attendance 
where attendanceStatus !='satisfactory'
End

delete from Attendance where student_ID = 400
insert into Attendance values(701,'2021-10-20',03,'DBA assignment','present','true')

drop trigger low_attendance

--Pathak's query 20
alter table Assignment add assignment_due_notification varchar(20)

CREATE TRIGGER assignment_due_notification
on Assignment
for insert
as begin 
insert into Assignment(assignment_ID,subject_name, assignment_due_notification,due_date) values ('03','ABD', 'true',getdate())
select * from Assignment
where DATEDIFF(hour, due_date, getdate()) < 24;
End

drop trigger assignment_due_notification
select * from Assignment

insert into Assignment(assignment_ID,subject_name,due_date) values (02,'DBAA', '2021/11/18 13:00')

-- PAYAL PATEL Trigger number 5----------------------------------------------------------
create TRIGGER createTable on database
for create_table 
as
print 'Table created';


create table test (column1 int, column2 int);


-- PAYAL PATEL Trigger number 6-----------------------------------------------------------------
CREATE TRIGGER safety   
ON DATABASE   
FOR DROP_TABLE   
AS   
   PRINT 'You must disable Trigger "safety" to drop or alter tables!'   
   ROLLBACK;

create table test2(c1 int,c2 int);

-- PAYAL PATEL Trigger number 7-----------------------------------------------------------------------------------------------------------

CREATE TRIGGER gradeFromPercentage ON Grades
    FOR INSERT
AS
    DECLARE @percentage int
	select @percentage = percentage_scored from inserted
	if(@percentage<= 55)
	begin
	update Grades set grade = 'F' from Grades G inner join inserted i on G.student_ID = i.student_ID
	end
	else if(@percentage <65 AND @percentage > 55)
	begin
	update Grades set grade = 'C' from Grades G inner join inserted i on G.student_ID = i.student_ID
	end
	else if(@percentage <75 AND @percentage > 65)
	begin
	update Grades set grade = 'B' from Grades G inner join inserted i on G.student_ID = i.student_ID
	end
	else if(@percentage <85 AND @percentage > 75)
	begin
	update Grades set grade = 'A' from Grades G inner join inserted i on G.student_ID = i.student_ID
	end

drop trigger gradeFromPercentage
delete from Grades where  student_ID = 701

insert into Grades values(701,65,'','PayalP',3,10,'Jomis')

	insert into Grades values(701,45,'','PayalP',3,10,'Jomis');
	select * from Subject
	select * from Grades
----------------------------------------------------------------------------------------------------------	
disable trigger safety on database;
alter table E_library add dueDate datetime;


-- PAYAL PATEL Trigger number 8---------------------------------------------------------------------------------
CREATE TRIGGER dueDatefromIssueDate ON E_library
    after INSERT, UPDATE
As begin
    set nocount on;
	update E_library set dueDate = DATEADD(DD, 10, getdate())
	from E_library E inner join inserted i on E.student_ID = i.student_ID
	and i.issue_date = getdate();
	end


drop trigger dueDatefromIssueDate
	
	insert into E_library values(501,701,99,'DBAbook',getdate(),getdate());

	
update E_library set issue_date = getdate()
where course_ID = 501;
	select * from E_library	
--------------------------------------------------------------------------------------------


--Aditya singh's Query number 1-------------------------------------------------

create TRIGGER dropTableTrigger on database
for drop_table 
as
print 'Table deleted';

create table testA (C1 int, C2 int);
drop table testA

--Aditya singh's Query number 2-------------------------------------------------------

create TRIGGER alterTableTrigger on database
for alter_table 
as
print 'Table modified';

alter table testA add C3 int;

--Aditya singh's Query number 3-------------------------------------------

CREATE TRIGGER before_percentage_insert
ON Grades
after INSERT as 
begin 
    DECLARE @percent int
	select @percent = percentage_scored from inserted
     UPDATE Grades
      SET percentage_scored = @percent + 10
end

drop trigger before_percentage_insert

delete from Grades where student_ID = 701;
insert into Grades values(701,45,'','PayalP',3,10,'Jomis');
select * from Grades

----ADITYA SINGH'S Query number 4---------------------------------------------


CREATE TRIGGER feesIncrease
ON Fees
after INSERT as 
begin 
    DECLARE @SemesterFees int
	select @SemesterFees = SemesterFees from inserted
     UPDATE Fees
      SET SemesterFees = @SemesterFees - 1000
end

	drop trigger feesIncreaseThnDueIncrease

	delete from Fees where student_ID = 701
	select * from Fees
----------------------------------------------------------------------------------------------

--KESHA PANDYA trigger number 14

disable trigger createTable on database
drop table Announcement_Trigger
CREATE TABLE Announcement_Trigger
( 
col1 varchar(255)
);


CREATE TRIGGER announcement_added
on 
Announcement 
for insert
as
insert into Announcement_Trigger
(col1)
values
('New Announcement Added');

select * from Announcement

Insert into Announcement(announcement_ID,announcement,instructor_ID,instructor_name)
Values(2,'announcement2',10,'Jomis John');
select * from Announcement_Trigger

--------------------------------------------------------------------------------------------------------
-- KESHA PANDYA trigger number 15

CREATE TABLE update_student_contactNos
( 
updateContactNo bigint, updateMsg varchar(50)
);
drop table update_student_contactNos
Select * From update_student_contactNos;

CREATE TRIGGER updateStudent_contactNo
on 
StudentCard
after update
as
insert into update_student_contactNos
(updateContactNo,updateMsg)
values
(1,'Update 1');
drop trigger  updateStudent_contactNo

Insert into StudentCard(student_ID,student_name,student_email,DOB,contactNo)
Values(701,'KeshaPandya','keshapandya@gmail.com',GETDATE(),1234567899);
Select * From StudentCard;

update StudentCard
set contactNo = 1234555556
where student_ID = 701; 
select * from update_student_contactNos

----------------------------------------------------------------------------------------------------------

