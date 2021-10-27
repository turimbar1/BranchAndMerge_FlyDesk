CREATE TABLE [dbo].[LinkTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [varchar] (50) NOT NULL
)
GO
ALTER TABLE [dbo].[LinkTypes] ADD CONSTRAINT [PK_LinkTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
