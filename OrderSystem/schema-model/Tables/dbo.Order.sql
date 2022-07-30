CREATE TABLE [dbo].[Order]
(
[ID] [int] NOT NULL,
[custID] [int] NULL,
[custFullName] [nvarchar] (150) NULL,
[custPostalZipCode] [nvarchar] (10) NULL,
[orderAmt] [decimal] (19, 2) NULL,
[orderDate] [datetime] NULL,
[shippedDate] [datetime] NULL,
[Status] [nvarchar] (5) NULL,
[Comments] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK__Order__3214EC277989010E] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE NONCLUSTERED INDEX [IX_Order_ZipCode] ON [dbo].[Order] ([custID], [custPostalZipCode])
GO
CREATE NONCLUSTERED INDEX [IX_Order_Date] ON [dbo].[Order] ([custID], [orderDate])
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK_Order_CustomerID] FOREIGN KEY ([custID]) REFERENCES [dbo].[Customer] ([ID])
GO
