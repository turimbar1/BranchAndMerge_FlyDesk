SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [SQLCop].[test Max degree of parallelism]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max), @Warning VarChar(max)
    Set @Output = ''
    Set @Warning = 'Warning: Max degree of parallelism is setup to use all cores'

    IF (SERVERPROPERTY('EngineEdition') = 5 OR SERVERPROPERTY('EngineEdition') = 8)
        BEGIN
            select @Output = @Warning
            from   sys.database_scoped_configurations
            where  name = 'MAXDOP'
                and value = 0
        END
    ELSE
        BEGIN
            select @Output = @Warning
            from   sys.configurations
            where  name = 'max degree of parallelism'
                and value_in_use = 0
        END

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Max-degree-of-parallelism'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
