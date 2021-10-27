CREATE TABLE [dbo].[PostHistory]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PostHistoryTypeId] [int] NOT NULL,
[PostId] [int] NOT NULL,
[RevisionGUID] [uniqueidentifier] NULL,
[CreationDate] [datetime] NOT NULL,
[UserId] [int] NULL,
[UserDisplayName] [nvarchar] (40) NULL,
[Comment] [nvarchar] (max) NULL,
[Text] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[PostHistory] ADD CONSTRAINT [PK_PostHistory__Id] PRIMARY KEY CLUSTERED ([Id])
GO
