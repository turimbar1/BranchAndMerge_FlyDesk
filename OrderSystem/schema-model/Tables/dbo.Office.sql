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
ALTER TABLE [dbo].[Office] ADD CONSTRAINT [PK__Office__A25C5AA64BD6A4EC] PRIMARY KEY CLUSTERED ([Code])
GO
