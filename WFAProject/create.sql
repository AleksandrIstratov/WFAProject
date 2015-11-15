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

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

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
SET ANSI_PADDING ON
GO

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
