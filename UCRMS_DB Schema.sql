CREATE DATABASE UCRMS_DB

USE UCRMS_DB;
CREATE TABLE Department(
	Id INT IDENTITY(1,1) NOT NULL,
	Code VARCHAR(7) NOT NULL UNIQUE,
	Name VARCHAR(60) NOT NULL UNIQUE,
	PRIMARY KEY(Id)
)

/*Semester name always unique, we know that*/
USE UCRMS_DB;
CREATE TABLE Semester(
	Id INT IDENTITY(1,1) NOT NULL,
	Code VARCHAR(15) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY(Id)
)

/*Designation name always unique, we know that*/
USE UCRMS_DB;
CREATE TABLE Designation(
	Id INT IDENTITY(1,1) NOT NULL,
	Code VARCHAR(15) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY(Id)
)

/*Designation name always unique, we know that*/
USE UCRMS_DB;
CREATE TABLE Room(
	Id INT IDENTITY(1,1) NOT NULL,
	Code VARCHAR(15) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL UNIQUE,
	Allocated TINYINT NOT NULL,
	PRIMARY KEY(Id)
)

USE UCRMS_DB;
CREATE TABLE Course(
	Id INT IDENTITY(1,1) NOT NULL,
	Code VARCHAR(15) NOT NULL UNIQUE,
	Name VARCHAR(100) NOT NULL UNIQUE,
	Credit DECIMAL(18,2) NOT NULL,
	Description VARCHAR(MAX) NOT NULL,
	DepartmentId INT NOT NULL,
	SemesterId INT NOT NULL,
	Assigned TINYINT NOT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT Fk_Course_Department FOREIGN KEY(DepartmentId) REFERENCES Department(Id),
	CONSTRAINT Fk_Course_Semester FOREIGN KEY(SemesterId) REFERENCES Semester(Id)
)

USE UCRMS_DB;
CREATE TABLE Teacher(
	Id INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(MAX) NOT NULL,  
	Email VARCHAR(100) NOT NULL UNIQUE,  
	ContactNo VARCHAR(20) NOT NULL,  
	DesignationId INT NOT NULL,
	DepartmentId INT NOT NULL,
	CreditToBeTaken DECIMAL(18,2) NOT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT Fk_Teacher_Designation FOREIGN KEY(DesignationId) REFERENCES Designation(Id),
	CONSTRAINT Fk_Teacher_Department FOREIGN KEY(DepartmentId) REFERENCES Department(Id)
)

USE UCRMS_DB;
CREATE TABLE TeacherCourse(
	Id INT IDENTITY(1,1) NOT NULL,
	DepartmentId INT NOT NULL,
	TeacherId INT NOT NULL,
	RemainingCredit DECIMAL(18,2) NOT NULL,
	CourseId INT NOT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT Fk_TeacherCourse_Department FOREIGN KEY(DepartmentId) REFERENCES Department(Id),
	CONSTRAINT Fk_TeacherCourse_Teacher FOREIGN KEY(TeacherId) REFERENCES Teacher(Id),
	CONSTRAINT Fk_TeacherCourse_Course FOREIGN KEY(CourseId) REFERENCES Course(Id),
)

USE UCRMS_DB;
CREATE TABLE Student(
	Id INT IDENTITY(1,1) NOT NULL UNIQUE,
	RegNo VARCHAR(15) NOT NULL,
	Name VARCHAR(50) NOT NULL, 
	Email VARCHAR(100) NOT NULL UNIQUE,
	ContactNo VARCHAR(20) NOT NULL,
	RegDate DATETIME NOT NULL,
	Address VARCHAR(MAX) NOT NULL,
	DepartmentId INT NOT NULL,
	PRIMARY KEY(RegNo),
	CONSTRAINT Fk_Student_Department FOREIGN KEY(DepartmentId) REFERENCES Department(Id)
)

USE UCRMS_DB;
CREATE TABLE StudentCourse(
	Id INT IDENTITY(1,1) NOT NULL,
	StudentRegNo VARCHAR(15) NOT NULL,
	CourseId INT NOT NULL,
	EnrollDate DATETIME NOT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT Fk_StudentCourse_Student FOREIGN KEY(StudentRegNo) REFERENCES Student(RegNo),
	CONSTRAINT Fk_StudentCourse_Course FOREIGN KEY(CourseId) REFERENCES Course(Id)
)

USE UCRMS_DB;
CREATE TABLE StudentResult(
	Id INT IDENTITY(1,1) NOT NULL,
	StudentRegNo VARCHAR(15) NOT NULL,
	CourseId INT NOT NULL,
	GradeLetter VARCHAR(2) NOT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT Fk_StudentResult_Student FOREIGN KEY(StudentRegNo) REFERENCES Student(RegNo),
	CONSTRAINT Fk_StudentResult_Course FOREIGN KEY(CourseId) REFERENCES Course(Id)
)

USE UCRMS_DB;
CREATE TABLE AllocatedClassRoom(
	Id INT IDENTITY(1,1) NOT NULL,
	DepartmentId INT NOT NULL,
	CourseId INT NOT NULL,
	RoomId INT NOT NULL,
	DayId INT NOT NULL,
	StartFrom TIME NOT NULL,
	EndTo TIME NOT NULL, 
	PRIMARY KEY(Id),
	CONSTRAINT Fk_AllocatedClassRoom_Department FOREIGN KEY(DepartmentId) REFERENCES Department(Id),
	CONSTRAINT Fk_AllocatedClassRoom_Course FOREIGN KEY(CourseId) REFERENCES Course(Id),
	CONSTRAINT Fk_AllocatedClassRoom_Room FOREIGN KEY(RoomId) REFERENCES Room(Id)
)