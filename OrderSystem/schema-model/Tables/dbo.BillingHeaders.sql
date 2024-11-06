CREATE TABLE [dbo].[BillingHeaders]
(
[BillingHeaderId] [uniqueidentifier] NOT NULL,
[Agency] [nvarchar] (100) NULL,
[AuditInfo_CreatedOn] [datetime] NOT NULL,
[AuditInfo_LastModifiedOn] [datetime] NOT NULL,
[AuditInfo_CreatedBy] [nvarchar] (150) NOT NULL,
[AuditInfo_LastModifiedBy] [nvarchar] (150) NOT NULL,
[BillingAddress_StreetAddress1] [nvarchar] (1000) NULL,
[BillingAddress_StreetAddress2] [nvarchar] (1000) NULL,
[BillingAddress_City] [nvarchar] (1000) NULL,
[BillingAddress_RegionCode] [nvarchar] (100) NULL,
[BillingAddress_PostalCode] [nvarchar] (100) NULL,
[BillingAddress_County] [nvarchar] (400) NULL,
[BillingAddress_Country] [nvarchar] (400) NULL,
[BillingContact_Name] [nvarchar] (400) NULL,
[BillingContact_JobTitle] [nvarchar] (400) NULL,
[BillingContact_EmailAddress] [nvarchar] (1000) NULL,
[BillingContact_BusinessPhone] [nvarchar] (100) NULL,
[BillingCurrency] [nvarchar] (100) NULL,
[BillingDescription] [nvarchar] (max) NULL,
[BillingEffectiveDate] [datetime] NOT NULL,
[BillingPremium] [decimal] (18, 2) NOT NULL,
[Branch] [nvarchar] (100) NULL,
[Department] [nvarchar] (100) NULL,
[FilingRegionCode] [nvarchar] (50) NULL,
[GrossCommissionRate] [decimal] (18, 10) NOT NULL,
[CommissionType] [nvarchar] (50) NOT NULL,
[Insured_Id] [uniqueidentifier] NOT NULL,
[IsBilled] [bit] NOT NULL,
[PayerPayee_Id] [uniqueidentifier] NOT NULL,
[ReferenceNumber] [nvarchar] (100) NOT NULL,
[Timestamp] [timestamp] NOT NULL,
[TransactionType] [nvarchar] (max) NULL,
[PolicyId] [nvarchar] (100) NULL,
[LineOfBusiness] [nvarchar] (100) NULL,
[PolicyEffectiveDate] [datetime] NULL,
[PolicyExpirationDate] [datetime] NULL,
[InsuringCompany_Id] [uniqueidentifier] NULL,
[SystemOfRecordXRefId] [nvarchar] (100) NULL,
[Discriminator] [nvarchar] (128) NOT NULL,
[DirectBillStatement_DirectBillStatementId] [uniqueidentifier] NULL,
[Comments] [nvarchar] (max) NULL,
[AssignedToInfo_UserID] [nvarchar] (400) NULL,
[AssignedToInfo_UserName] [nvarchar] (100) NULL,
[AssignedToInfo_OrgID] [nvarchar] (400) NULL,
[AssignedToInfo_OrgName] [nvarchar] (100) NULL,
[InvoiceMemo] [nvarchar] (500) NULL,
[sequenceNo] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyMasterId] [int] NOT NULL CONSTRAINT [DF_BillingHeaders_PolicyMasterId] DEFAULT ((0)),
[PolicyCommissionId_UKHelper] AS (case  when [PolicyCommissionId] IS NULL then CONVERT([varchar](100),[BillingHeaderId],(0)) else CONVERT([varchar](100),[PolicyCommissionId],(0)) end) PERSISTED,
[CommissionStatementId] [int] NULL,
[PolicyCommissionId] [int] NULL,
[OrganizationID] [int] NOT NULL,
[RootOrganizationId] [int] NOT NULL,
[InvoiceType] [nvarchar] (20) NULL,
[PremiumFinancePaidTo] [nvarchar] (15) NULL,
[PremiumFinancePayee_Id] [uniqueidentifier] NULL,
[InstallmentsCount] [int] NULL,
[InstallmentsFrequency] [nvarchar] (15) NULL,
[InstallmentsEqual] [bit] NULL CONSTRAINT [DF_BillingHeaders_InstallmentsEqual] DEFAULT ((0)),
[InstallmentsPercentDown] [decimal] (5, 2) NULL,
[InvoiceDueDate] [datetime] NULL,
[DepartmentId] [int] NULL,
[Insured_Name] [nvarchar] (350) NULL,
[PayerPayee_Name] [nvarchar] (350) NULL,
[InsuringCompany_Name] [nvarchar] (350) NULL,
[PremiumFinancePayee_Name] [nvarchar] (350) NULL
)
GO
ALTER TABLE [dbo].[BillingHeaders] ADD CONSTRAINT [PK_dbo.BillingHeaders] PRIMARY KEY CLUSTERED ([BillingHeaderId])
GO
CREATE NONCLUSTERED INDEX [IX_DirectBillStatement_DirectBillStatementId] ON [dbo].[BillingHeaders] ([DirectBillStatement_DirectBillStatementId]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_DirectBillStatementId_RootOrganizationId_Discriminator_PolicyCommissionId] ON [dbo].[BillingHeaders] ([DirectBillStatement_DirectBillStatementId], [RootOrganizationId], [Discriminator], [PolicyCommissionId])
GO
CREATE NONCLUSTERED INDEX [AltIdx_Discriminator] ON [dbo].[BillingHeaders] ([Discriminator]) INCLUDE ([Insured_Id])
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_Insured_Id] ON [dbo].[BillingHeaders] ([Insured_Id])
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_InsuringCompany_Id] ON [dbo].[BillingHeaders] ([InsuringCompany_Id])
GO
CREATE NONCLUSTERED INDEX [IX_OrganizationId] ON [dbo].[BillingHeaders] ([OrganizationID])
GO
CREATE NONCLUSTERED INDEX [IX_BillingHeaders__Organization_Insure_Discri] ON [dbo].[BillingHeaders] ([OrganizationID], [Insured_Id], [Discriminator])
GO
CREATE NONCLUSTERED INDEX [IX_BillingHeaders__Organization_Insure_IsBill] ON [dbo].[BillingHeaders] ([OrganizationID], [Insured_Id], [IsBilled])
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_PayerPayee_Id] ON [dbo].[BillingHeaders] ([PayerPayee_Id])
GO
CREATE UNIQUE NONCLUSTERED INDEX [BillingHeaders_UK_PolicyCommissionId_UKHelper] ON [dbo].[BillingHeaders] ([PolicyCommissionId_UKHelper])
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_PremiumFinancePayee_Id] ON [dbo].[BillingHeaders] ([PremiumFinancePayee_Id])
GO
CREATE NONCLUSTERED INDEX [BillingHeaders_IX_RootOrganizationId_OrganizationId] ON [dbo].[BillingHeaders] ([RootOrganizationId], [OrganizationID])
GO
CREATE NONCLUSTERED INDEX [IX_BillingHeaders_SequenceNo] ON [dbo].[BillingHeaders] ([sequenceNo])
GO
