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
ALTER TABLE [dbo].[Employee2] ADD CONSTRAINT [PK__Employee__3214EC273FA4040A] PRIMARY KEY CLUSTERED ([ID])
GO
