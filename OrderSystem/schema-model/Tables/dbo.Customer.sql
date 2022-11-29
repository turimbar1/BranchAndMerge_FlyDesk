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
[creditLimit] [decimal] (19, 2) NULL,
[RG_ID] [nvarchar] (30) NULL
)
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK__Customer__3214EC27ADB4BCE0] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Names] ON [dbo].[Customer] ([firstName], [lastName], [fullName])
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Name_Email] ON [dbo].[Customer] ([lastName], [Email])
GO
CREATE NONCLUSTERED INDEX [IX_Customer_Address] ON [dbo].[Customer] ([streetAddress], [City], [postalZipCode])
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_Customer_SalesRep] FOREIGN KEY ([owningSalesRepID]) REFERENCES [dbo].[Employee] ([ID])
GO
