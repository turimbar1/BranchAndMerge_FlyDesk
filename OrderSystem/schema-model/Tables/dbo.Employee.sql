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
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK__Employee__3214EC273FADE631] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_OfficeCode] FOREIGN KEY ([officeCode]) REFERENCES [dbo].[Office] ([Code])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_OfficeCode2] FOREIGN KEY ([officeCode]) REFERENCES [dbo].[Office] ([Code])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_ReportsTo] FOREIGN KEY ([reportsTo]) REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_ReportsTo2] FOREIGN KEY ([reportsTo]) REFERENCES [dbo].[Employee] ([ID])
GO
