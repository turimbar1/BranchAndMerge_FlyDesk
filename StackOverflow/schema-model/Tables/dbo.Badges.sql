CREATE TABLE [dbo].[Badges]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (40) NOT NULL,
[UserId] [int] NOT NULL,
[Date] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[Badges] ADD CONSTRAINT [PK_Badges__Id] PRIMARY KEY CLUSTERED ([Id])
GO
