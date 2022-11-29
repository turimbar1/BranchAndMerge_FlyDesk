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
PRINT N'Dropping types'
GO
DROP TYPE [dbo].[LessonType]
GO
PRINT N'Creating types'
GO
CREATE TYPE [dbo].[LessonType] AS TABLE
(
[LessonId] [int] NULL,
[LessonName] [varchar] (50) NULL
)
GO
PRINT N'Creating [dbo].[Usp_InsertLesson]'
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson] 
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO
PRINT N'Creating [dbo].[Usp_InsertLesson1]'
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson1] 
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO
PRINT N'Creating [dbo].[Usp_InsertLesson2]'
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson2] 
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO
PRINT N'Creating [dbo].[Usp_InsertLesson3]'
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson3]
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO
PRINT N'Creating [dbo].[Usp_InsertLesson4]'
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson4]
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO
PRINT N'Creating primary key [PK__Lesson__3214EC07837E2574] on [dbo].[Lesson]'
GO
ALTER TABLE [dbo].[Lesson] ADD CONSTRAINT [PK__Lesson__3214EC07837E2574] PRIMARY KEY CLUSTERED ([Id])
GO
