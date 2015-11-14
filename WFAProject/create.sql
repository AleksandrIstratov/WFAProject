USE master
GO
if not exists(select * from sys.databases where name = 'DBProject')
	create database DBProject
GO

USE DBProject
GO

IF OBJECT_ID('dbo.TElements', 'U') IS NOT NULL
  DROP TABLE [dbo].[TElements]; 
GO

IF OBJECT_ID('dbo.TItems', 'U') IS NOT NULL
  DROP TABLE [dbo].[TItems]; 
GO


/********** CREATE TElements TABLE ->**********/
CREATE TABLE [dbo].[TElements](
	[Id_Element] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[Parent_Id] [uniqueidentifier], 
 CONSTRAINT [PK_TElements] PRIMARY KEY CLUSTERED 
(
	[Id_Element] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TElements] ADD  CONSTRAINT [DF_TElements_Id_Element]  DEFAULT (newid()) FOR [Id_Element]
GO
/**********<- CREATE TElements TABLE **********/

/********** CREATE TItems TABLE -> **********/
CREATE TABLE [dbo].[TItems](
	[Id_Item] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[Element_Id] [uniqueidentifier], 
	[Parent_Id] [uniqueidentifier], 
 CONSTRAINT [PK_TItems] PRIMARY KEY CLUSTERED 
(
	[Id_Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TItems] ADD  CONSTRAINT [DF_TItems_Id_Item]  DEFAULT (newid()) FOR [Id_Item]
GO
/**********<- CREATE TElements TABLE **********/








INSERT INTO [dbo].[TElements] (Name) VALUES ('First')
INSERT INTO [dbo].[TElements] (Name) VALUES ('Second')
INSERT INTO [dbo].[TElements] (Name, Parent_id) VALUES ('1.1',(SELECT Id_Element FROM TElements WHERE Name = 'First'))
INSERT INTO [dbo].[TElements] (Name, Parent_id) VALUES ('1.2',(SELECT Id_Element FROM TElements WHERE Name = 'First'))
INSERT INTO [dbo].[TElements] (Name, Parent_id) VALUES ('1.2.1',(SELECT Id_Element FROM TElements WHERE Name = '1.2'))
GO

DECLARE @val UNIQUEIDENTIFIER
SET @val = (SELECT TOP 1 Id_Element FROM TElements WHERE Name = 'First')
EXEC CopyElementsToItems @val;
GO

DECLARE @val UNIQUEIDENTIFIER
SET @val = (SELECT TOP 1 Id_Element FROM TElements WHERE Name = '1.2.1')
DECLARE @val1 UNIQUEIDENTIFIER
SET @val1 = (SELECT TOP 1 Id_Item FROM TItems WHERE Name = '1.1')
EXEC CopyElementsToItems @val, @val1;
GO