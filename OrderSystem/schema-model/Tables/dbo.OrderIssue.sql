CREATE TABLE [dbo].[OrderIssue]
(
[ID] [int] NOT NULL,
[orderID] [int] NULL,
[issueFromCourier] [xml] NULL
)
GO
ALTER TABLE [dbo].[OrderIssue] ADD CONSTRAINT [PK__OrderIss__3214EC27B0C4955F] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OrderIssue] ADD CONSTRAINT [FK_OrderIssue_OrderID] FOREIGN KEY ([orderID]) REFERENCES [dbo].[Order] ([ID])
GO
