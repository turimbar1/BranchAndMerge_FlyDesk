CREATE TABLE [dbo].[Badges]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (40) NOT NULL,
[UserId] [int] NOT NULL,
[Date] [datetime] NOT NULL,
[We_dont_need_no_stinking_badges] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[Badges] ADD CONSTRAINT [PK_Badges__Id] PRIMARY KEY CLUSTERED ([Id])
GO
