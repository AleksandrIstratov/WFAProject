use DBProject
GO


IF OBJECT_ID('dbo.TProducers', 'U') IS NOT NULL
  DROP TABLE [dbo].[TProducers]; 
GO

/********** CREATE TPRODUCERS TABLE ->**********/

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TProducers](
	[Id_Producer] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](64) NOT NULL,	
 CONSTRAINT [PK_TProducers] PRIMARY KEY CLUSTERED 
(
	[Id_Producer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TProducers] ADD  CONSTRAINT [DF_TProducers_Id_Producer]  DEFAULT (newid()) FOR [Id_Producer]
GO
/**********<- CREATE TPRODUCERS TABLE **********/




IF OBJECT_ID('dbo.TTemplates', 'U') IS NOT NULL
  DROP TABLE [dbo].[TTemplates]; 
GO

/********** CREATE TTEMPLATES TABLE ->**********/

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TTemplates](
	[Id_Template] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[Producer_Id] [uniqueidentifier],	
 CONSTRAINT [PK_TTemplates] PRIMARY KEY CLUSTERED  
(
	[Id_Template] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TTemplates] ADD  CONSTRAINT [DF_TTemplates_Id_Template]  DEFAULT (newid()) FOR [Id_Template]
GO
/**********<- CREATE TPRODUCERS TABLE **********/



IF OBJECT_ID('dbo.TTemplatesItems', 'U') IS NOT NULL
  DROP TABLE [dbo].[TTemplatesItems]; 
GO


/********** CREATE TTEMPLATES TABLE ->**********/

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TTemplatesItems](
	[Id_TemplatesItem] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Template_Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[Prefix] [varchar] (10),	
 CONSTRAINT [PK_TTemplatesItems] PRIMARY KEY CLUSTERED  
(
	[Id_TemplatesItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TTemplatesItems] ADD  CONSTRAINT [DF_TTemplatesItems_Id_TemplatesItem]  DEFAULT (newid()) FOR [Id_TemplatesItem]
GO
/**********<- CREATE TPRODUCERS TABLE **********/


IF OBJECT_ID('dbo.TStructures', 'U') IS NOT NULL
  DROP TABLE [dbo].[TStructures]; 
GO


/********** CREATE TStructures TABLE ->**********/

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TStructures](
	[Id_Structure] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Element_Id] [uniqueidentifier] NOT NULL,
	[Template_Id] [uniqueidentifier] NOT NULL,
	[Position] [int] NOT NULL,
 CONSTRAINT [PK_TStructures] PRIMARY KEY CLUSTERED  
(
	[Id_Structure] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TStructures] ADD  CONSTRAINT [DF_TStructures_Id_Structure]  DEFAULT (newid()) FOR [Id_Structure]
GO
/**********<- CREATE TStructures TABLE **********/




/*FILL THE TPRODUCERS TABLE*/

INSERT [dbo].[TProducers](Name) VALUES
('SIEMENS'),
('APLISENS'),
('IFM')
GO

DECLARE @val UNIQUEIDENTIFIER
EXEC AddTemplate 'Color', @Id_Template = @val OUTPUT
INSERT [dbo].[TTemplatesItems] (Template_Id, Name, Prefix) VALUES
(@val, 'Red',		'RD'),
(@val, 'Blue',		'BL'),
(@val, 'White',		'WH'),
(@val, 'Yellow',	'YL'),
(@val, 'Black',		'BK'),
(@val, 'Green',		'GR'),
(@val, 'Brown',		'BR')
GO

DECLARE @val UNIQUEIDENTIFIER
EXEC AddTemplate 'Sex', @Id_Template = @val OUTPUT
INSERT [dbo].[TTemplatesItems] (Template_Id, Name, Prefix) VALUES
(@val, 'Male',		'M'),
(@val, 'Female',	'F')
GO

DECLARE @element_id UNIQUEIDENTIFIER
EXEC AddElement 'SITRANS F M MAG 1100 F', @id_element = @element_id OUTPUT
DECLARE @val1 UNIQUEIDENTIFIER
EXEC AddTemplate 'Diametr', @Id_Template = @val1 OUTPUT
INSERT [dbo].[TTemplatesItems] (Template_Id, Name, Prefix) VALUES
(@val1, 'DN 10 (3/8")',		'1R'),
(@val1, 'DN 15 (1/2")',		'1V'),
(@val1, 'DN 25 (1 1/2")',	'2D'),
(@val1, 'DN 40 (1 1/2")',	'2R'),
(@val1, 'DN 50 (2")',		'2Y'),
(@val1, 'DN 65 (2 1/2")',	'3F'),
(@val1, 'DN 80 (3")',		'3M'),
(@val1, 'DN 100 (4")',		'3T')
INSERT [dbo].[TStructures] (Element_Id, Template_Id, Position) VALUES
(@element_id, @val1, 1)
DECLARE @val2 UNIQUEIDENTIFIER
EXEC AddTemplate 'Process connection', @Id_Template = @val2 OUTPUT
INSERT [dbo].[TTemplatesItems] (Template_Id, Name, Prefix) VALUES
(@val2, 'No adaptors',						'A'),
(@val2, 'Weld in DIN 11850',				'B'),
(@val2, 'Weld in ISO 2037 (SMS3008)',		'C'),
(@val2, 'Weld in BS 4825-1',				'D'),
(@val2, 'Weld in Tri-Clamp',				'E'),
(@val2, 'Clamp type DIN 32676',				'G'),
(@val2, 'Clamp type ISO 2852 (SMS 3016)',	'H'),
(@val2, 'Clamp type BS 4825-3',				'J'),
(@val2, 'Clamp type Tri-Clamp',				'K'),
(@val2, 'Threaded type DIN 11851',			'L'),
(@val2, 'Threaded type SMS 1145',			'M')
INSERT [dbo].[TStructures] (Element_Id, Template_Id, Position) VALUES
(@element_id, @val1, 2)
GO
