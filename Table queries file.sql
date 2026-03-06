-- Database
create database LeaveManagementSystem;

use LeaveManagementSystem;

-- 1 Roles Table
create table Roles (
	RoleId int identity(1,1) primary key,
	RoleName varchar(50) not null unique,
	Description varchar(255) null,
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime null,
	UpdatedBy int null
);

insert into Roles(RoleName) values
('Admin'), --id will be 1
('HR'), -- id will be 2
('Manager'), -- id will be 3
('Employee'); -- id will be 4 

select * from Roles;

-- DEPARTMENTS TABLE--
create table Departments (
	DepartmentId int identity(1,1) primary key,
	DepartmentName varchar(50) not null unique,
	Description varchar(255) null,
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime null,
	UpdatedBy int null
);

-- EXEC sp_rename 'departments', 'Departments';

Insert into Departments (DepartmentName) values
('IT'),
('HR'),
('Finance');

select * from Departments;

-- Users Table
create table Users
(
	UserId int identity(1,1) primary key,
	Username varchar(50) not null unique,
	PasswordHash varchar(255) not null,
	Email varchar(50) not null unique,
	RoleId int not null,
	IsActive bit not null default 1,
	IsFirstLogin bit not null default 1,
	LastLoginDate datetime null,
	Createddate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime null,
	UpdatedBy int null,

	constraint FK_Users_Roles
		foreign key (RoleId) references Roles(RoleId)
);

insert into Users
(Username, PasswordHash, Email, RoleId, IsFirstLogin)
values 
('Admin','240be518fabd2724ddb6f04eeb2d7e9f9c5f6a3c4c3f8b0e4e5a7a6e8d3b0e9c','chaitalipednekar2002@gmail.com',1,0);

insert into Users
(Username, PasswordHash, Email, RoleId, IsFirstLogin)
values 
('Admin1','240be518fabd2724ddb6f04eeb2d7e9f9c5f6a3c4c3f8b0e4e5a7a6e8d3b0e9c','chaitalip785@gmail.com',1,0);

insert into Users
(Username, PasswordHash, Email, RoleId, IsFirstLogin)
values 
('Manager','240be518fabd2724ddb6f04eeb2d7e9f9c5f6a3c4c3f8b0e4e5a7a6e8d3b0e9c','chaitali@gmail.com',2,0);
update Users set RoleId=3 where Email='chaitali@gmail.com';

--password: Admin@123

SELECT Email, PasswordHash FROM Users
UPDATE Users
SET PasswordHash = '$2a$11$U/zOG5nWTHqIyEhnEG5LPuRbI.wYElK97qk2dVjTOYRvFGR24FgdS' --Manager@123
WHERE Email = 'chaitalip785@gmail.com';


ALTER TABLE Users
ALTER COLUMN PasswordHash varchar(255) NULL;
select * from Users;

ALTER TABLE Users
ADD PasswordSetupToken varchar(100) NULL,
TokenExpiry datetime NULL;

-- Employees Table 
create table Employees(
	EmployeeId int Identity(1,1) primary key,
	UserId int not null unique,
	DepartmentId int not null,
	ManagerId int null,
	EmployeeCode varchar(20) not null unique,
	FirstName varchar(40) not null,
	LastName varchar(50) not null,
	Gender varchar(10) not null,
	DateOfBirth date not null,
	DateOfJoining date not null,
	PhoneNumber varchar(15) not null,
	Address varchar(255) not null,
	State varchar(50) not null,
	City varchar(50) not null,
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime null,
	UpdatedBy int null,

	constraint FK_Employees_Users
		foreign key (UserId) references Users(UserId),

	constraint FK_Employees_Departments
		foreign key (DepartmentId) references Departments(DepartmentId),

	constraint EK_Employees_Manager
		foreign key (ManagerId) references Employees(EmployeeId)
);

insert into Employees
(UserId, DepartmentId, EmployeeCode, FirstName, LastName,
Gender, DateOfBirth, DateOfJoining,	PhoneNumber,Address,
State, City)
values
(1,1,'EMP001','System','Admin',
'Female','2002-11-22',getdate(),'7020337713','Parmart Apt., Virar-East',
'Maharashtra','Mumbai');

alter table Employees 
add 
	ProfileImagePath varchar(255) null,
	AadharNumber varchar(12) null,
	AadharImagePath varchar(255) null;

select * from Employees;

--------------------------------------------------------------------------
update Roles set Description = 'System Administrator'
where RoleName = 'Admin';

update Roles set Description = 'Human Resource Department'
where RoleName = 'HR';

update Roles set Description = 'Department Manager'
where RoleName = 'Manager';

update Roles set Description = 'Regular Employee'
where RoleName = 'Employee';
---------------------------------------------------------------------------

update Departments set Description = 'Information Technology'
where DepartmentName = 'IT';

update Departments set Description = 'Human Resource'
where DepartmentName = 'HR';

update Departments set Description = 'Finance Department'
where DepartmentName = 'Finance';

select * from Departments;
____________________________________

--Leave Types Table--
create table LeaveTypes(
	LeaveTypeId int identity(1,1) primary key,
	LeaveTypeName varchar(50) not null unique,
	DefaultDays int not null check(DefaultDays>=0),
	Description varchar(255),
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime null,
	UpdatedBy int null
); 

-- Holidays Table--
create table Holidays(
	HolidayId int identity(1,1) primary key,
	HolidayDate date not null unique,
	HolidayName varchar(100) not null,
	Description varchar(255) null,
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime not null default getdate(),
	UpdatedBy int null
);

create table LeaveBalance(
	LeaveBalanceId int identity(1,1) primary key,
	EmployeeId int not null,
	LeaveTypeId int not null,
	AllocatedDays int not null check(AllocatedDays>=0),
	UsedDays int not null Default 0 Check(UsedDays>=0),
	RemainingDays AS (AllocatedDays-UsedDays) persisted,
	IsActive bit not null default 1,
	CreatedDate datetime not null default getdate(),
	CreatedBy int null,
	UpdatedDate datetime not null default getdate(),
	UpdatedBy int null

	Constraint FK_LeaveBalances_Employees
		foreign key (EmployeeId) references Employees(EmployeeId),
	
	Constraint FK_LeaveBalances_LeaveTypes
		foreign key (LeaveTypeId) references LeaveTypes(LeaveTypeId),

	Constraint UQ_Employee_LeaveType UNIQUE (EmployeeId,LeaveTypeId)
);

-- Leave Applications table--
create table LeaveApplications (
	LeaveApplicationId int identity(1,1) primary key,
	EmployeeId int not null,
	LeaveTypeId int not null,
	FromDate date not null,
	ToDate date not null,
	TotalDays int not null Check (TotalDays>0),
	Reason varchar(300) not null,
	Status varchar(30) not null default 'Pending_Manager',
	ManagerId int null,
	ManagerRemarks varchar(255) null,
	ManagerActiondate datetime null,
	HRId int null,
	HRRemarks varchar(255) null,
	HRActionDate datetime null,
	AppliedDate datetime not null default getdate(),
	LastUpdatedDate datetime null,
	CreatedBy int null,
	UpdatedBy int null,
	PublicId uniqueidentifier NOT NULL DEFAULT NEWID()

	Constraint FK_LeaveApplications_Employees
		foreign key (EmployeeId) references Employees(EmployeeId),

	Constraint FK_LeaveApplications_LeaveTypes
		foreign key (LeaveTypeId) references LeaveTypes(LeaveTypeid),

	Constraint FK_LeaveApplications_Manager
		foreign key (ManagerId) references Employees(EmployeeId),

	Constraint FK_LeaveApplications_HR
		foreign key (HRId) references Employees(EmployeeId),
	
	Constraint CHK_Leavedates check (FromDate <= ToDate),

	Constraint CHK_LeaveStatus Check (Status in 
	('Pending_Manager','Pending_HR','Approved','Rejected','Cancelled'))
);

-- Audit Logs Table--
create table AuditLogs(
	AuditLogId int identity(1,1) primary key,
	UserId int not null,
	ActionType varchar(50) not null,
	ModuleName varchar(50) not null,
	RecordId int null,
	Description varchar(255) null,
	ActionDateTime datetime not null default getdate(),

	constraint FK_AuditLogs_Users
		foreign key (UserId) references Users(UserId)
);

------GUID Added------
alter table Users
add PublicId uniqueidentifier not null default NEWID();

alter table Users
add constraint UQ_Users_PublicId unique (PublicId);
_____ Employees____________

alter table Employees 
add PublicId uniqueidentifier not null default NEWID();

alter table Employees
add constraint UQ_Employees_PublicId unique (publicId);

--Departments--
alter table Departments 
Add PublicId UniqueIdentifier not null default NEWID();

alter table Departments 
add constraint UQ_Departments_PublicId unique (PublicId);


select * from Roles;
select * from Users;
select * from Departments;
select * from Employees;
select * from LeaveTypes;
select * from Holidays;
select * from LeaveBalance;
select * from LeaveApplications;
select * from AuditLogs;