
GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Forms"
:setvar DefaultFilePrefix "Forms"
:setvar DefaultDataPath "C:\Users\tannie\Desktop\Database\"
:setvar DefaultLogPath "C:\Users\tannie\Desktop\Database\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO

IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
BEGIN TRANSACTION
GO
PRINT N'Creating Table [dbo].[StaffHire]...';


GO
CREATE TABLE [dbo].[StaffHire] (
    [Id]                  INT           NOT NULL,
    [UniqueID]            VARCHAR (125) NOT NULL,
    [Name]                VARCHAR (50)  NOT NULL,
    [Midlename]           VARCHAR (50)  NULL,
    [Surname]             VARCHAR (45)  NOT NULL,
    [DateOfBirth]         VARCHAR (50)  NOT NULL,
    [Sex]                 VARCHAR (50)  NOT NULL,
    [Position]            VARCHAR (50)  NOT NULL,
    [Starting Salary]     INT           NOT NULL,
    [Contract Period]     VARCHAR (50)  NOT NULL,
    [Assigned Supervisor] VARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF OBJECT_ID(N'tempdb..#tmpErrors') IS NULL
    CREATE TABLE [#tmpErrors] (
        Error INT
    );

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO
PRINT N'Creating Index [dbo].[StaffHire].[Core]...';


GO
CREATE NONCLUSTERED INDEX [Core]
    ON [dbo].[StaffHire]([UniqueID] ASC);


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF OBJECT_ID(N'tempdb..#tmpErrors') IS NULL
    CREATE TABLE [#tmpErrors] (
        Error INT
    );

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT N'The transacted portion of the database update succeeded.'
COMMIT TRANSACTION
END
ELSE PRINT N'The transacted portion of the database update failed.'
GO
IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
GO
PRINT N'Update complete.';


GO
