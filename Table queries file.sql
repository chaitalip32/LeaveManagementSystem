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

-- DEPARTMENTS TABLE
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

select * from Users;

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

select * from Roles;
select * from Users;
select * from Departments;
select * from Employees;



