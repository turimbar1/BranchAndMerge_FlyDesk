SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[Lesson]'
GO
ALTER TABLE [dbo].[Lesson] DROP CONSTRAINT [PK__Lesson__3214EC07B887F943]
GO
PRINT N'Dropping [dbo].[Usp_InsertLesson4]'
GO
DROP PROCEDURE [dbo].[Usp_InsertLesson4]
GO
PRINT N'Dropping [dbo].[Usp_InsertLesson2]'
GO
DROP PROCEDURE [dbo].[Usp_InsertLesson2]
GO
PRINT N'Dropping [dbo].[Usp_InsertLesson1]'
GO
DROP PROCEDURE [dbo].[Usp_InsertLesson1]
GO
PRINT N'Dropping [dbo].[Usp_InsertLesson]'
GO
DROP PROCEDURE [dbo].[Usp_InsertLesson]
GO
PRINT N'Dropping [dbo].[Lesson]'
GO
DROP TABLE [dbo].[Lesson]
GO
PRINT N'Dropping types'
GO
DROP TYPE [dbo].[LessonType]
GO
