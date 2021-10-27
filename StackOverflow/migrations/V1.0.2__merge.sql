SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[Comments]'
GO
ALTER TABLE [dbo].[Comments] ADD
[Length] [int] NULL
GO
PRINT N'Altering [dbo].[Posts]'
GO
ALTER TABLE [dbo].[Posts] DROP
COLUMN [twitter_id]
GO
PRINT N'Altering [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD
[TikTokId] [nvarchar] (50) NULL
GO
