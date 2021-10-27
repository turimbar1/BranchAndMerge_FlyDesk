CREATE TABLE [dbo].[PostHistoryTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [nvarchar] (50) NOT NULL
)
GO
ALTER TABLE [dbo].[PostHistoryTypes] ADD CONSTRAINT [PK_PostHistoryTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
