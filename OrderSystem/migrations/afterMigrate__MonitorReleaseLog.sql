-- ---------------------------------------------------------------------
-- Annotate this release on Redgate SQL Monitor 
-- ---------------------------------------------------------------------
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048), @versions AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @versions = '1.0.5' --SELECT string_agg([version], ', ') FROM	[dbo].[flyway_schema_history] AS [fsh] WHERE DATEDIFF(MINUTE,[fsh].[installed_on],CURRENT_TIMESTAMP) <= 1)  
    SET @eventMessage = N'Redgate Flyway: { "deployment": { "description": "Flyway deployed script versions '+ @versions + N' to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO