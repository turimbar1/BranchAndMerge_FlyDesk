CREATE TABLE [dbo].[Product]
(
[Code] [int] NOT NULL,
[productName] [nvarchar] (150) NULL,
[productDescription] [nvarchar] (max) NULL,
[qtyInStock] [int] NULL,
[unitPrice] [decimal] (19, 2) NULL,
[Colour] [nvarchar] (15) NULL
)
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK__Product__A25C5AA63B1C5ADE] PRIMARY KEY CLUSTERED ([Code])
GO
