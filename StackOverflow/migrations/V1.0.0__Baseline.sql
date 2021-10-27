SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Badges]'
GO
CREATE TABLE [dbo].[Badges]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (40) NOT NULL,
[UserId] [int] NOT NULL,
[Date] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Badges__Id] on [dbo].[Badges]'
GO
ALTER TABLE [dbo].[Badges] ADD CONSTRAINT [PK_Badges__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Comments]'
GO
CREATE TABLE [dbo].[Comments]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CreationDate] [datetime] NOT NULL,
[PostId] [int] NOT NULL,
[Score] [int] NULL,
[Text] [nvarchar] (700) NOT NULL,
[UserId] [int] NULL
)
GO
PRINT N'Creating primary key [PK_Comments__Id] on [dbo].[Comments]'
GO
ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [PK_Comments__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[LinkTypes]'
GO
CREATE TABLE [dbo].[LinkTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [varchar] (50) NOT NULL
)
GO
PRINT N'Creating primary key [PK_LinkTypes__Id] on [dbo].[LinkTypes]'
GO
ALTER TABLE [dbo].[LinkTypes] ADD CONSTRAINT [PK_LinkTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[PostHistoryTypes]'
GO
CREATE TABLE [dbo].[PostHistoryTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [nvarchar] (50) NOT NULL
)
GO
PRINT N'Creating primary key [PK_PostHistoryTypes__Id] on [dbo].[PostHistoryTypes]'
GO
ALTER TABLE [dbo].[PostHistoryTypes] ADD CONSTRAINT [PK_PostHistoryTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[PostHistory]'
GO
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
PRINT N'Creating primary key [PK_PostHistory__Id] on [dbo].[PostHistory]'
GO
ALTER TABLE [dbo].[PostHistory] ADD CONSTRAINT [PK_PostHistory__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[PostLinks]'
GO
CREATE TABLE [dbo].[PostLinks]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CreationDate] [datetime] NOT NULL,
[PostId] [int] NOT NULL,
[RelatedPostId] [int] NOT NULL,
[LinkTypeId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_PostLinks__Id] on [dbo].[PostLinks]'
GO
ALTER TABLE [dbo].[PostLinks] ADD CONSTRAINT [PK_PostLinks__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[PostTypes]'
GO
CREATE TABLE [dbo].[PostTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [nvarchar] (50) NOT NULL
)
GO
PRINT N'Creating primary key [PK_PostTypes__Id] on [dbo].[PostTypes]'
GO
ALTER TABLE [dbo].[PostTypes] ADD CONSTRAINT [PK_PostTypes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Posts]'
GO
CREATE TABLE [dbo].[Posts]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AcceptedAnswerId] [int] NULL,
[AnswerCount] [int] NULL,
[Body] [nvarchar] (max) NOT NULL,
[ClosedDate] [datetime] NULL,
[CommentCount] [int] NULL,
[CommunityOwnedDate] [datetime] NULL,
[CreationDate] [datetime] NOT NULL,
[FavoriteCount] [int] NULL,
[LastActivityDate] [datetime] NOT NULL,
[LastEditDate] [datetime] NULL,
[LastEditorDisplayName] [nvarchar] (40) NULL,
[LastEditorUserId] [int] NULL,
[OwnerUserId] [int] NULL,
[ParentId] [int] NULL,
[PostTypeId] [int] NOT NULL,
[Score] [int] NOT NULL,
[Tags] [nvarchar] (150) NULL,
[Title] [nvarchar] (250) NULL,
[ViewCount] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Posts__Id] on [dbo].[Posts]'
GO
ALTER TABLE [dbo].[Posts] ADD CONSTRAINT [PK_Posts__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Tags]'
GO
CREATE TABLE [dbo].[Tags]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TagName] [nvarchar] (150) NOT NULL,
[Count] [int] NOT NULL,
[ExcerptPostId] [int] NOT NULL,
[WikiPostId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Tags__Id] on [dbo].[Tags]'
GO
ALTER TABLE [dbo].[Tags] ADD CONSTRAINT [PK_Tags__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Users]'
GO
CREATE TABLE [dbo].[Users]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AboutMe] [nvarchar] (max) NULL,
[Age] [int] NULL,
[CreationDate] [datetime] NOT NULL,
[DisplayName] [nvarchar] (40) NOT NULL,
[DownVotes] [int] NOT NULL,
[EmailHash] [nvarchar] (40) NULL,
[LastAccessDate] [datetime] NOT NULL,
[Location] [nvarchar] (100) NULL,
[Reputation] [int] NOT NULL,
[UpVotes] [int] NOT NULL,
[Views] [int] NOT NULL,
[WebsiteUrl] [nvarchar] (200) NULL,
[AccountId] [int] NULL
)
GO
PRINT N'Creating primary key [PK_Users_Id] on [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users_Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[VoteTypes]'
GO
CREATE TABLE [dbo].[VoteTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) NOT NULL
)
GO
PRINT N'Creating primary key [PK_VoteType__Id] on [dbo].[VoteTypes]'
GO
ALTER TABLE [dbo].[VoteTypes] ADD CONSTRAINT [PK_VoteType__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Votes]'
GO
CREATE TABLE [dbo].[Votes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PostId] [int] NOT NULL,
[UserId] [int] NULL,
[BountyAmount] [int] NULL,
[VoteTypeId] [int] NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Votes__Id] on [dbo].[Votes]'
GO
ALTER TABLE [dbo].[Votes] ADD CONSTRAINT [PK_Votes__Id] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[DropIndexes]'
GO
CREATE PROCEDURE [dbo].[DropIndexes] 
  @SchemaName NVARCHAR(255) = 'dbo', 
  @TableName NVARCHAR(255) = NULL, 
  @WhatToDrop VARCHAR(10) = 'Everything'
  AS
BEGIN
SET NOCOUNT ON;

CREATE TABLE #commands (ID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED, Command NVARCHAR(2000));

DECLARE @CurrentCommand NVARCHAR(2000);

IF ( UPPER(@WhatToDrop) LIKE 'C%' 
     OR UPPER(@WhatToDrop) LIKE 'E%' )
BEGIN
INSERT INTO #commands (Command)
SELECT   N'ALTER TABLE ' 
       + QUOTENAME(SCHEMA_NAME(o.schema_id))
       + N'.'
       + QUOTENAME(OBJECT_NAME(o.parent_object_id))
       + N' DROP CONSTRAINT '
       + QUOTENAME(o.name)
       + N';'
FROM sys.objects AS o
WHERE o.type IN ('C', 'F', 'UQ')
AND SCHEMA_NAME(o.schema_id) = COALESCE(@SchemaName, SCHEMA_NAME(o.schema_id))
AND OBJECT_NAME(o.parent_object_id) = COALESCE(@TableName,  OBJECT_NAME(o.parent_object_id))
END;

IF ( UPPER(@WhatToDrop) LIKE 'I%' 
     OR UPPER(@WhatToDrop) LIKE 'E%' )
BEGIN
INSERT INTO #commands (Command)
SELECT 'DROP INDEX ' 
       + QUOTENAME(i.name) 
       + ' ON ' 
       + QUOTENAME(SCHEMA_NAME(t.schema_id)) 
       + '.' 
       + t.name 
       + ';'
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
WHERE i.type = 2
AND SCHEMA_NAME(t.schema_id) = COALESCE(@SchemaName, SCHEMA_NAME(t.schema_id))
AND t.name = COALESCE(@TableName, t.name)

INSERT INTO #commands (Command)
SELECT 'DROP STATISTICS ' 
       + QUOTENAME(SCHEMA_NAME(t.schema_id)) 
       + '.'  
       + QUOTENAME(OBJECT_NAME(s.object_id)) 
       + '.' 
       + QUOTENAME(s.name)
       + ';'
FROM sys.stats AS s
INNER JOIN sys.tables AS t ON s.object_id = t.object_id
WHERE NOT EXISTS (SELECT * FROM sys.indexes AS i WHERE i.name = s.name) 
AND SCHEMA_NAME(t.schema_id) = COALESCE(@SchemaName, SCHEMA_NAME(t.schema_id))
AND t.name = COALESCE(@TableName, t.name)
AND OBJECT_NAME(s.object_id) NOT LIKE 'sys%';
END; 


DECLARE result_cursor CURSOR FOR
SELECT Command FROM #commands;

OPEN result_cursor;
FETCH NEXT FROM result_cursor INTO @CurrentCommand;
WHILE @@FETCH_STATUS = 0
BEGIN 
        
    PRINT @CurrentCommand;
	EXEC(@CurrentCommand);

FETCH NEXT FROM result_cursor INTO @CurrentCommand;
END;
--end loop

--clean up
CLOSE result_cursor;
DEALLOCATE result_cursor;
END;
GO
