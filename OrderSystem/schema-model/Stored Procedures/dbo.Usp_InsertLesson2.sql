SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Usp_InsertLesson2] 
@ParLessonType LessonType READONLY
AS
INSERT INTO Lesson
SELECT * FROM @ParLessonType
GO