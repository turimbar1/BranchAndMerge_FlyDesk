CREATE TABLE [dbo].[CountryCode]
(
[Code] [nvarchar] (2) NOT NULL,
[countryName] [nvarchar] (100) NULL
)
GO
ALTER TABLE [dbo].[CountryCode] ADD CONSTRAINT [PK__CountryC__A25C5AA6388137C3] PRIMARY KEY CLUSTERED ([Code])
GO
