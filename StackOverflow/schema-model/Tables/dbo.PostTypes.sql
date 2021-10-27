CREATE TABLE [dbo].[PostTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [nvarchar] (50) NOT NULL
)
GO
ALTER TABLE [dbo].[PostTypes] ADD CONSTRAINT [PK_PostTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
