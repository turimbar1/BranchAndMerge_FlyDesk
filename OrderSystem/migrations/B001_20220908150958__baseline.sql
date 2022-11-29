SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Employee]'
GO
CREATE TABLE [dbo].[Employee]
(
[ID] [int] NOT NULL,
[officeCode] [int] NOT NULL,
[reportsTo] [int] NULL,
[jobTitle] [nvarchar] (60) NULL,
[firstName] [nvarchar] (100) NULL,
[lastName] [nvarchar] (100) NULL,
[Extension] [nvarchar] (8) NULL,
[Email] [nvarchar] (80) NULL
)
GO
PRINT N'Creating primary key [PK__Employee__3214EC273FADE631] on [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK__Employee__3214EC273FADE631] PRIMARY KEY CLUSTERED ([ID])
GO
PRINT N'Creating [dbo].[Customer]'
GO
CREATE TABLE [dbo].[Customer]
(
[ID] [int] NOT NULL,
[owningSalesRepID] [int] NULL,
[Title] [nvarchar] (20) NULL,
[firstName] [nvarchar] (100) NULL,
[lastName] [nvarchar] (100) NULL,
[fullName] [nvarchar] (150) NULL,
[dateOfBirth] [datetime] NULL,
[Email] [nvarchar] (80) NULL,
[Phone] [nvarchar] (15) NULL,
[streetAddress] [nvarchar] (100) NULL,
[City] [nvarchar] (70) NULL,
[postalZipCode] [nvarchar] (10) NULL,
[creditLimit] [decimal] (19, 2) NULL
)
GO
PRINT N'Creating primary key [PK__Customer__3214EC27ADB4BCE0] on [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK__Customer__3214EC27ADB4BCE0] PRIMARY KEY CLUSTERED ([ID])
GO
PRINT N'Creating index [IX_Customer_Names] on [dbo].[Customer]'
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Names] ON [dbo].[Customer] ([firstName], [lastName], [fullName])
GO
PRINT N'Creating index [IX_Customer_Name_Email] on [dbo].[Customer]'
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Name_Email] ON [dbo].[Customer] ([lastName], [Email])
GO
PRINT N'Creating index [IX_Customer_Address] on [dbo].[Customer]'
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Address] ON [dbo].[Customer] ([streetAddress], [City], [postalZipCode])
GO
PRINT N'Creating [dbo].[Office]'
GO
CREATE TABLE [dbo].[Office]
(
[Code] [int] NOT NULL,
[fullName] [nvarchar] (150) NOT NULL,
[Address1] [nvarchar] (150) NULL,
[Address2] [nvarchar] (100) NULL,
[City] [nvarchar] (100) NULL,
[State] [nvarchar] (100) NULL,
[postalZipCode] [nvarchar] (10) NULL
)
GO
PRINT N'Creating primary key [PK__Office__A25C5AA64BD6A4EC] on [dbo].[Office]'
GO
ALTER TABLE [dbo].[Office] ADD CONSTRAINT [PK__Office__A25C5AA64BD6A4EC] PRIMARY KEY CLUSTERED ([Code])
GO
PRINT N'Creating [dbo].[Order]'
GO
CREATE TABLE [dbo].[Order]
(
[ID] [int] NOT NULL,
[custID] [int] NULL,
[custFullName] [nvarchar] (150) NULL,
[custPostalZipCode] [nvarchar] (10) NULL,
[orderAmt] [decimal] (19, 2) NULL,
[orderDate] [datetime] NULL,
[shippedDate] [datetime] NULL,
[Status] [nvarchar] (5) NULL,
[Comments] [nvarchar] (max) NULL
)
GO
PRINT N'Creating primary key [PK__Order__3214EC277989010E] on [dbo].[Order]'
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK__Order__3214EC277989010E] PRIMARY KEY CLUSTERED ([ID])
GO
PRINT N'Creating index [IX_Order_ZipCode] on [dbo].[Order]'
GO
CREATE NONCLUSTERED INDEX [IX_Order_ZipCode] ON [dbo].[Order] ([custID], [custPostalZipCode])
GO
PRINT N'Creating index [IX_Order_Date] on [dbo].[Order]'
GO
CREATE NONCLUSTERED INDEX [IX_Order_Date] ON [dbo].[Order] ([custID], [orderDate])
GO
PRINT N'Creating [dbo].[OrderIssue]'
GO
CREATE TABLE [dbo].[OrderIssue]
(
[ID] [int] NOT NULL,
[orderID] [int] NULL,
[issueFromCourier] [xml] NULL
)
GO
PRINT N'Creating primary key [PK__OrderIss__3214EC27B0C4955F] on [dbo].[OrderIssue]'
GO
ALTER TABLE [dbo].[OrderIssue] ADD CONSTRAINT [PK__OrderIss__3214EC27B0C4955F] PRIMARY KEY CLUSTERED ([ID])
GO
PRINT N'Creating [dbo].[__MigrationLog]'
GO
CREATE TABLE [dbo].[__MigrationLog]
(
[migration_id] [uniqueidentifier] NOT NULL,
[script_checksum] [nvarchar] (64) NOT NULL,
[script_filename] [nvarchar] (255) NOT NULL,
[complete_dt] [datetime2] NOT NULL,
[applied_by] [nvarchar] (100) NOT NULL,
[deployed] [tinyint] NOT NULL CONSTRAINT [DF___MigrationLog_deployed] DEFAULT ((1)),
[version] [varchar] (255) NULL,
[package_version] [varchar] (255) NULL,
[release_version] [varchar] (255) NULL,
[sequence_no] [int] NOT NULL IDENTITY(1, 1)
)
GO
PRINT N'Creating primary key [PK___MigrationLog] on [dbo].[__MigrationLog]'
GO
ALTER TABLE [dbo].[__MigrationLog] ADD CONSTRAINT [PK___MigrationLog] PRIMARY KEY CLUSTERED ([migration_id], [complete_dt], [script_checksum])
GO
PRINT N'Creating index [IX___MigrationLog_CompleteDt] on [dbo].[__MigrationLog]'
GO
CREATE NONCLUSTERED INDEX [IX___MigrationLog_CompleteDt] ON [dbo].[__MigrationLog] ([complete_dt])
GO
PRINT N'Creating index [UX___MigrationLog_SequenceNo] on [dbo].[__MigrationLog]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX___MigrationLog_SequenceNo] ON [dbo].[__MigrationLog] ([sequence_no])
GO
PRINT N'Creating index [IX___MigrationLog_Version] on [dbo].[__MigrationLog]'
GO
CREATE NONCLUSTERED INDEX [IX___MigrationLog_Version] ON [dbo].[__MigrationLog] ([version])
GO
PRINT N'Creating [dbo].[__MigrationLogCurrent]'
GO

	CREATE VIEW [dbo].[__MigrationLogCurrent]
			AS
			WITH currentMigration AS
			(
			  SELECT
				 migration_id, script_checksum, script_filename, complete_dt, applied_by, deployed, ROW_NUMBER() OVER(PARTITION BY migration_id ORDER BY sequence_no DESC) AS RowNumber
			  FROM [dbo].[__MigrationLog]
			)
			SELECT  migration_id, script_checksum, script_filename, complete_dt, applied_by, deployed
			FROM currentMigration
			WHERE RowNumber = 1
	
GO
PRINT N'Creating [dbo].[Employee2]'
GO
CREATE TABLE [dbo].[Employee2]
(
[ID] [int] NOT NULL,
[officeCode] [int] NOT NULL,
[reportsTo] [int] NULL,
[jobTitle] [nvarchar] (60) NULL,
[firstName] [nvarchar] (100) NULL,
[lastName] [nvarchar] (100) NULL,
[Extension] [nvarchar] (8) NULL,
[Email] [nvarchar] (80) NULL
)
GO
PRINT N'Creating primary key [PK__Employee__3214EC273FA4040A] on [dbo].[Employee2]'
GO
ALTER TABLE [dbo].[Employee2] ADD CONSTRAINT [PK__Employee__3214EC273FA4040A] PRIMARY KEY CLUSTERED ([ID])
GO
PRINT N'Creating [dbo].[GetEmployee2]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetEmployee2]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM [dbo].[Employee2] AS [e2]
END
GO
PRINT N'Creating [dbo].[EmployeeSuite]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[EmployeeSuite]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM [dbo].[Employee2] AS [e2]
END
GO
PRINT N'Creating [dbo].[EmployeeBy]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[EmployeeBy]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM [dbo].[Employee2] AS [e2]
END
GO
PRINT N'Creating [dbo].[CountryCode]'
GO
CREATE TABLE [dbo].[CountryCode]
(
[Code] [nvarchar] (2) NOT NULL,
[countryName] [nvarchar] (100) NULL
)
GO
PRINT N'Creating primary key [PK__CountryC__A25C5AA6388137C3] on [dbo].[CountryCode]'
GO
ALTER TABLE [dbo].[CountryCode] ADD CONSTRAINT [PK__CountryC__A25C5AA6388137C3] PRIMARY KEY CLUSTERED ([Code])
GO
PRINT N'Creating [dbo].[DMSSTAT_RSTATS]'
GO
CREATE TABLE [dbo].[DMSSTAT_RSTATS]
(
[runid] [varchar] (250) NOT NULL,
[ruleid] [varchar] (50) NOT NULL,
[ruleblock] [int] NOT NULL,
[rulenum] [int] NOT NULL,
[rulesubscript] [int] NOT NULL,
[ruletype] [varchar] (50) NOT NULL,
[rulecreated] [datetime] NOT NULL,
[ruleupdated] [datetime] NOT NULL,
[secondsactive] [int] NOT NULL,
[rulestatus] [char] (1) NOT NULL,
[rulesource] [varchar] (250) NULL,
[ruletarget] [varchar] (250) NULL,
[rowoperations] [bigint] NULL,
[coloperations] [bigint] NULL,
[rulePrevRPN] [int] NULL,
[ruleRPN] [int] NULL
)
GO
PRINT N'Creating index [IX_DMSSTAT_RSTATS] on [dbo].[DMSSTAT_RSTATS]'
GO
CREATE NONCLUSTERED INDEX [IX_DMSSTAT_RSTATS] ON [dbo].[DMSSTAT_RSTATS] ([runid], [ruleid])
GO
PRINT N'Creating [dbo].[DMSSTAT_TSTATS]'
GO
CREATE TABLE [dbo].[DMSSTAT_TSTATS]
(
[runid] [varchar] (250) NOT NULL,
[ruleid] [varchar] (50) NOT NULL,
[statscreated] [datetime] NOT NULL,
[statsupdated] [datetime] NOT NULL,
[ruletype] [varchar] (50) NOT NULL,
[ruleblock] [int] NOT NULL,
[rulenum] [int] NOT NULL,
[rulesubscript] [int] NOT NULL,
[controllerid] [varchar] (50) NULL,
[tabledatabase] [varchar] (250) NOT NULL,
[tableschema] [varchar] (250) NOT NULL,
[tablename] [varchar] (250) NOT NULL,
[tablecolumn] [varchar] (250) NULL,
[rowoperations] [bigint] NULL,
[coloperations] [bigint] NULL
)
GO
PRINT N'Creating index [IX_DMSSTAT_TSTATS_A] on [dbo].[DMSSTAT_TSTATS]'
GO
CREATE NONCLUSTERED INDEX [IX_DMSSTAT_TSTATS_A] ON [dbo].[DMSSTAT_TSTATS] ([runid], [ruleid])
GO
PRINT N'Creating [dbo].[Product]'
GO
CREATE TABLE [dbo].[Product]
(
[Code] [int] NOT NULL,
[productName] [nvarchar] (150) NULL,
[productDescription] [nvarchar] (max) NULL,
[qtyInStock] [int] NULL,
[unitPrice] [decimal] (19, 2) NULL,
[Colour] [nvarchar] (15) NULL
)
GO
PRINT N'Creating primary key [PK__Product__A25C5AA63B1C5ADE] on [dbo].[Product]'
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK__Product__A25C5AA63B1C5ADE] PRIMARY KEY CLUSTERED ([Code])
GO
PRINT N'Creating [dbo].[__SchemaSnapshot]'
GO
CREATE TABLE [dbo].[__SchemaSnapshot]
(
[Snapshot] [varbinary] (max) NULL,
[LastUpdateDate] [datetime2] NULL CONSTRAINT [__SchemaSnapshotDateDefault] DEFAULT (sysdatetime())
)
GO
PRINT N'Creating [dbo].[ARP_Employee]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[ARP_Employee]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM [ARP].[dbo].[Employee] AS [e]
END
GO
PRINT N'Adding foreign keys to [dbo].[Order]'
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK_Order_CustomerID] FOREIGN KEY ([custID]) REFERENCES [dbo].[Customer] ([ID])
GO
PRINT N'Adding foreign keys to [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_Customer_SalesRep] FOREIGN KEY ([owningSalesRepID]) REFERENCES [dbo].[Employee] ([ID])
GO
PRINT N'Adding foreign keys to [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_ReportsTo] FOREIGN KEY ([reportsTo]) REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_ReportsTo2] FOREIGN KEY ([reportsTo]) REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_OfficeCode] FOREIGN KEY ([officeCode]) REFERENCES [dbo].[Office] ([Code])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_OfficeCode2] FOREIGN KEY ([officeCode]) REFERENCES [dbo].[Office] ([Code])
GO
PRINT N'Adding foreign keys to [dbo].[OrderIssue]'
GO
ALTER TABLE [dbo].[OrderIssue] ADD CONSTRAINT [FK_OrderIssue_OrderID] FOREIGN KEY ([orderID]) REFERENCES [dbo].[Order] ([ID])
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is required by SQL Change Automation projects to keep track of which migrations have been executed during deployment. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The executing user at the time of deployment (populated using the SYSTEM_USER function).', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'applied_by'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date/time that the migration finished executing. This value is populated using the SYSDATETIME function.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'complete_dt'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column contains a number of potential states:

0 - Marked As Deployed: The migration was not executed.
1- Deployed: The migration was executed successfully.
2- Imported: The migration was generated by importing from this DB.

"Marked As Deployed" and "Imported" are similar in that the migration was not executed on this database; it was was only marked as such to prevent it from executing during subsequent deployments.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'deployed'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique identifier of a migration script file. This value is stored within the <Migration /> Xml fragment within the header of the file itself.

Note that it is possible for this value to repeat in the [__MigrationLog] table. In the case of programmable object scripts, a record will be inserted with a particular ID each time a change is made to the source file and subsequently deployed.

In the case of a migration, you may see the same [migration_id] repeated, but only in the scenario where the "Mark As Deployed" button/command has been run.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'migration_id'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If you have enabled SQLCMD Packaging in your SQL Change Automation project, or if you are using Octopus Deploy, this will be the version number that your database package was stamped with at build-time.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'package_version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If you are using Octopus Deploy, you can use the value in this column to look-up which release was responsible for deploying this migration.
If deploying via PowerShell, set the $ReleaseVersion variable to populate this column.
If deploying via Visual Studio, this column will always be NULL.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'release_version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A SHA256 representation of the migration script file at the time of build.  This value is used to determine whether a migration has been changed since it was deployed. In the case of a programmable object script, a different checksum will cause the migration to be redeployed.
Note: if any variables have been specified as part of a deployment, this will not affect the checksum value.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'script_checksum'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the migration script file on disk, at the time of build.
If Semantic Versioning has been enabled, then this value will contain the full relative path from the root of the project folder. If it is not enabled, then it will simply contain the filename itself.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'script_filename'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An auto-seeded numeric identifier that can be used to determine the order in which migrations were deployed.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'sequence_no'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The semantic version that this migration was created under. In SQL Change Automation projects, a folder can be given a version number, e.g. 1.0.0, and one or more migration scripts can be stored within that folder to provide logical grouping of related database changes.', 'SCHEMA', N'dbo', 'TABLE', N'__MigrationLog', 'COLUMN', N'version'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used by SQL Change Automation projects to store a snapshot of the schema at the time of the last deployment. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'TABLE', N'__SchemaSnapshot', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This view is required by SQL Change Automation projects to determine whether a migration should be executed during a deployment. The view lists the most recent [__MigrationLog] entry for a given [migration_id], which is needed to determine whether a particular programmable object script needs to be (re)executed: a non-matching checksum on the current [__MigrationLog] entry will trigger the execution of a programmable object script. Please do not alter or remove this table from the database.', 'SCHEMA', N'dbo', 'VIEW', N'__MigrationLogCurrent', NULL, NULL
GO
