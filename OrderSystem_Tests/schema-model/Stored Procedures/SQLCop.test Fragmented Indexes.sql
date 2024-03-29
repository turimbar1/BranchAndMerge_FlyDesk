SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [SQLCop].[test Fragmented Indexes]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    Create Table #Result (ProblemItem VarChar(1000))

    If Exists(Select compatibility_level from sys.databases Where database_id = db_ID() And compatibility_level > 80)
        If Exists(Select 1 From fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'VIEW DATABASE STATE')
            Begin
                Insert Into #Result(ProblemItem)
                Exec('
                        SELECT  OBJECT_NAME(OBJECT_ID) + ''.'' + s.name As ProblemItem
                        FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, N''LIMITED'') d
                                join sysindexes s
                                    ON  d.OBJECT_ID = s.id
                                    and d.index_id = s.indid
                        Where   avg_fragmentation_in_percent >= 30
                                And OBJECT_NAME(OBJECT_ID) + ''.'' + s.name > ''''
                                And page_count > 1000
                                Order By Object_Name(OBJECT_ID), s.name')
            End
        Else
            Set @Output = 'You do not have VIEW DATABASE STATE permissions within this database'
        Else
            Set @Output = 'Unable to check index fragmentation when compatibility is set to 80 or below'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Fragmented-indexes'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
