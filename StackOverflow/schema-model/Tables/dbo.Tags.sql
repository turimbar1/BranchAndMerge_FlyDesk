CREATE TABLE [dbo].[Tags]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TagName] [nvarchar] (150) NOT NULL,
[Count] [int] NOT NULL,
[ExcerptPostId] [int] NOT NULL,
[WikiPostId] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[Tags] ADD CONSTRAINT [PK_Tags__Id] PRIMARY KEY CLUSTERED ([Id])
GO
