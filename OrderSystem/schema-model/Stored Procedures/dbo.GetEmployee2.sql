SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetEmployee2]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [e2].[ID],
           [e2].[officeCode],
           [e2].[reportsTo],
           [e2].[jobTitle],
           [e2].[firstName],
           [e2].[lastName],
           [e2].[Extension],
           [e2].[Email] FROM [dbo].[Employee2] AS [e2]
END
GO
