
/* Create's a Table (Staff_Hire) In Database (Form) */

CREATE TABLE  [Forms].[StaffHire]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[UniqueID] varchar(125) NOT NULL,
	[Name] varchar(50) NOT NULL,
	[Midlename] varchar(50),
	[Surname] varchar(45) NOT NULL,
	[DateOfBirth] varchar(50) NOT NULL,
	[Sex] varchar(50) NOT NULL,
	[Position] varchar(50) NOT NULL,
	[Starting Salary] INT(45) NOT NULL,
	[Contract Period] varchar(50) NOT NULL,
	[Assigned Supervisor] varchar(50)
);
