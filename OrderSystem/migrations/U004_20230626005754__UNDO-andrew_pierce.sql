SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_dbo.BillingHeaders]', 'PK') AND parent_object_id = OBJECT_ID(N'[dbo].[BillingHeaders]', 'U'))
ALTER TABLE [dbo].[BillingHeaders] DROP CONSTRAINT [PK_dbo.BillingHeaders]
GO
PRINT N'Dropping constraints from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.columns WHERE name = N'PolicyMasterId' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]', 'U') AND default_object_id = OBJECT_ID(N'[dbo].[DF_BillingHeaders_PolicyMasterId]', 'D'))
ALTER TABLE [dbo].[BillingHeaders] DROP CONSTRAINT [DF_BillingHeaders_PolicyMasterId]
GO
PRINT N'Dropping constraints from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.columns WHERE name = N'InstallmentsEqual' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]', 'U') AND default_object_id = OBJECT_ID(N'[dbo].[DF_BillingHeaders_InstallmentsEqual]', 'D'))
ALTER TABLE [dbo].[BillingHeaders] DROP CONSTRAINT [DF_BillingHeaders_InstallmentsEqual]
GO
PRINT N'Dropping index [AltIdx_Discriminator] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'AltIdx_Discriminator' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [AltIdx_Discriminator] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_Insured_Id] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_Insured_Id' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_Insured_Id] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [IX_BillingHeaders__Organization_Insure_Discri] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_BillingHeaders__Organization_Insure_Discri' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [IX_BillingHeaders__Organization_Insure_Discri] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [IX_BillingHeaders__Organization_Insure_IsBill] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_BillingHeaders__Organization_Insure_IsBill' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [IX_BillingHeaders__Organization_Insure_IsBill] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_PayerPayee_Id] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_PayerPayee_Id' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_PayerPayee_Id] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_InsuringCompany_Id] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_InsuringCompany_Id' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_InsuringCompany_Id] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_DirectBillStatementId_RootOrganizationId_Discriminator_PolicyCommissionId] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_DirectBillStatementId_RootOrganizationId_Discriminator_PolicyCommissionId' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_DirectBillStatementId_RootOrganizationId_Discriminator_PolicyCommissionId] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [IX_DirectBillStatement_DirectBillStatementId] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DirectBillStatement_DirectBillStatementId' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [IX_DirectBillStatement_DirectBillStatementId] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [IX_BillingHeaders_SequenceNo] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_BillingHeaders_SequenceNo' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [IX_BillingHeaders_SequenceNo] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_UK_PolicyCommissionId_UKHelper] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_UK_PolicyCommissionId_UKHelper' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_UK_PolicyCommissionId_UKHelper] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [IX_OrganizationId] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_OrganizationId' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [IX_OrganizationId] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_RootOrganizationId_OrganizationId] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_RootOrganizationId_OrganizationId' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_RootOrganizationId_OrganizationId] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping index [BillingHeaders_IX_PremiumFinancePayee_Id] from [dbo].[BillingHeaders]'
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'BillingHeaders_IX_PremiumFinancePayee_Id' AND object_id = OBJECT_ID(N'[dbo].[BillingHeaders]'))
DROP INDEX [BillingHeaders_IX_PremiumFinancePayee_Id] ON [dbo].[BillingHeaders]
GO
PRINT N'Dropping [dbo].[BillingHeaders]'
GO
IF OBJECT_ID(N'[dbo].[BillingHeaders]', 'U') IS NOT NULL
DROP TABLE [dbo].[BillingHeaders]
GO

