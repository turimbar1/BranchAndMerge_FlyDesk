SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [SQLCop].[DmOsPerformanceCountersPermissionErrors]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[SQLCop].[DmOsPerformanceCountersPermissionErrors]') AND (type = 'IF' OR type = 'FN' OR type = 'TF' OR type = 'FT' OR type = 'FS'))
EXEC sp_executesql N'CREATE FUNCTION [SQLCop].[DmOsPerformanceCountersPermissionErrors]()
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @Result VARCHAR(MAX)
    SET @Result = ''''

    IF (SERVERPROPERTY(''EngineEdition'') = 5)
        BEGIN
            IF (DATABASEPROPERTYEX(DB_NAME(), ''Edition'') = ''Premium'')
                BEGIN
                    IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions(NULL, ''DATABASE'') WHERE permission_name = ''VIEW DATABASE STATE'')
                        SET @Result = ''You do not have VIEW DATABASE STATE permissions for this database.''
                END
            ELSE
                BEGIN
                    IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions(''sys.dm_os_performance_counters'', ''OBJECT'') WHERE permission_name = ''EXECUTE'')
                        SET @Result = ''You do not have server admin or Azure active directory admin permissions.''
                END
        END
    ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions(NULL, ''SERVER'') WHERE permission_name = ''VIEW SERVER STATE'')
                SET @Result = ''You do not have VIEW SERVER STATE permissions within this instance.''
        END
    RETURN @Result
END
'
GO
PRINT N'Creating [tSQLt].[ApplyConstraint]'
GO
IF OBJECT_ID(N'[tSQLt].[ApplyConstraint]', 'P') IS NULL
EXEC sp_executesql N'CREATE PROCEDURE [tSQLt].[ApplyConstraint]
       @TableName NVARCHAR(MAX),
       @ConstraintName NVARCHAR(MAX),
       @SchemaName NVARCHAR(MAX) = NULL, --parameter preserved for backward compatibility. Do not use. Will be removed soon.
       @NoCascade BIT = 0
AS
BEGIN
  DECLARE @ConstraintType NVARCHAR(MAX);
  DECLARE @ConstraintObjectId INT;
  
  SELECT @ConstraintType = ConstraintType, @ConstraintObjectId = ConstraintObjectId
    FROM tSQLt.Private_ResolveApplyConstraintParameters (@TableName, @ConstraintName, @SchemaName);

  IF @ConstraintType = ''CHECK_CONSTRAINT''
  BEGIN
    EXEC tSQLt.Private_ApplyCheckConstraint @ConstraintObjectId;
    RETURN 0;
  END

  IF @ConstraintType = ''FOREIGN_KEY_CONSTRAINT''
  BEGIN
    EXEC tSQLt.Private_ApplyForeignKeyConstraint @ConstraintObjectId, @NoCascade;
    RETURN 0;
  END;  
   
  IF @ConstraintType IN(''UNIQUE_CONSTRAINT'', ''PRIMARY_KEY_CONSTRAINT'')
  BEGIN
    EXEC tSQLt.Private_ApplyUniqueConstraint @ConstraintObjectId;
    RETURN 0;
  END;  
   
  RAISERROR (''ApplyConstraint could not resolve the object names, ''''%s'''', ''''%s''''. Be sure to call ApplyConstraint and pass in two parameters, such as: EXEC tSQLt.ApplyConstraint ''''MySchema.MyTable'''', ''''MyConstraint'''''', 
             16, 10, @TableName, @ConstraintName);
  RETURN 0;
END;
'
GO
PRINT N'Creating [tSQLt].[ApplyTrigger]'
GO
IF OBJECT_ID(N'[tSQLt].[ApplyTrigger]', 'P') IS NULL
EXEC sp_executesql N'CREATE PROCEDURE [tSQLt].[ApplyTrigger]
  @TableName NVARCHAR(MAX),
  @TriggerName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @OrgTableObjectId INT;
  SELECT @OrgTableObjectId = OrgTableObjectId FROM tSQLt.Private_GetOriginalTableInfo(OBJECT_ID(@TableName)) orgTbl
  IF(@OrgTableObjectId IS NULL)
  BEGIN
    RAISERROR(''%s does not exist or was not faked by tSQLt.FakeTable.'', 16, 10, @TableName);
  END;
  
  DECLARE @FullTriggerName NVARCHAR(MAX);
  DECLARE @TriggerObjectId INT;
  SELECT @FullTriggerName = QUOTENAME(SCHEMA_NAME(schema_id))+''.''+QUOTENAME(name), @TriggerObjectId = object_id
  FROM sys.objects WHERE PARSENAME(@TriggerName,1) = name AND parent_object_id = @OrgTableObjectId;
  
  DECLARE @TriggerCode NVARCHAR(MAX);
  SELECT @TriggerCode = m.definition
    FROM sys.sql_modules m
   WHERE m.object_id = @TriggerObjectId;
  
  IF (@TriggerCode IS NULL)
  BEGIN
    RAISERROR(''%s is not a trigger on %s'', 16, 10, @TriggerName, @TableName);
  END;
 
  EXEC tSQLt.RemoveObject @FullTriggerName;
  
  EXEC(@TriggerCode);
END;
'
GO
PRINT N'Creating [tSQLt].[AssertEmptyTable]'
GO
IF OBJECT_ID(N'[tSQLt].[AssertEmptyTable]', 'P') IS NULL
EXEC sp_executesql N'CREATE PROCEDURE [tSQLt].[AssertEmptyTable]
  @TableName NVARCHAR(MAX),
  @Message NVARCHAR(MAX) = ''''
AS
BEGIN
  EXEC tSQLt.AssertObjectExists @TableName;

  DECLARE @FullName NVARCHAR(MAX);
  IF(OBJECT_ID(@TableName) IS NULL AND OBJECT_ID(''tempdb..''+@TableName) IS NOT NULL)
  BEGIN
    SET @FullName = CASE WHEN LEFT(@TableName,1) = ''['' THEN @TableName ELSE QUOTENAME(@TableName)END;
  END;
  ELSE
  BEGIN
    SET @FullName = tSQLt.Private_GetQuotedFullName(OBJECT_ID(@TableName));
  END;

  DECLARE @cmd NVARCHAR(MAX);
  DECLARE @exists INT;
  SET @cmd = ''SELECT @exists = CASE WHEN EXISTS(SELECT 1 FROM ''+@FullName+'') THEN 1 ELSE 0 END;''
  EXEC sp_executesql @cmd,N''@exists INT OUTPUT'', @exists OUTPUT;
  
  IF(@exists = 1)
  BEGIN
    DECLARE @TableToText NVARCHAR(MAX);
    EXEC tSQLt.TableToText @TableName = @FullName,@txt = @TableToText OUTPUT;
    DECLARE @Msg NVARCHAR(MAX);
    SET @Msg = @FullName + '' was not empty:'' + CHAR(13) + CHAR(10)+ @TableToText;
    EXEC tSQLt.Fail @Message,@Msg;
  END
END
'
GO
PRINT N'Creating [tSQLt].[AssertEqualsString]'
GO
IF OBJECT_ID(N'[tSQLt].[AssertEqualsString]', 'P') IS NULL
EXEC sp_executesql N'CREATE PROCEDURE [tSQLt].[AssertEqualsString]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''''
AS
BEGIN
    IF ((@Expected = @Actual) OR (@Actual IS NULL AND @Expected IS NULL))
      RETURN 0;

    DECLARE @Msg NVARCHAR(MAX);
    SELECT @Msg = CHAR(13)+CHAR(10)+
                  ''Expected: '' + ISNULL(''<''+@Expected+''>'', ''NULL'') +
                  CHAR(13)+CHAR(10)+
                  ''but was : '' + ISNULL(''<''+@Actual+''>'', ''NULL'');
    EXEC tSQLt.Fail @Message, @Msg;
END;
'
GO
