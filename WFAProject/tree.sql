USE DBProject
GO

IF OBJECT_ID('CopyElementsToItems', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[CopyElementsToItems] AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE [dbo].[CopyElementsToItems]
	@Id_what uniqueidentifier,
	@Id_where uniqueidentifier = NULL
AS 
BEGIN
DECLARE @TT TABLE 
(
	[Id_Item] [uniqueidentifier],
	[Name] [varchar](64) NOT NULL,
	[Element_Id] [uniqueidentifier], 
	[Parent_Id] [uniqueidentifier]
)

DECLARE @T TABLE
(
	[Id_Element] [uniqueidentifier], 
	[Parent_Id] [uniqueidentifier],
	[Name] [varchar](64) NOT NULL
)

INSERT INTO @T EXEC GetChildrenElements @Id_what

INSERT INTO @TT (Id_Item, Name, Element_Id) SELECT NewID(), Name, Id_Element FROM @T


INSERT INTO TItems (Id_Item, Name, Element_Id, Parent_Id)
SELECT tab1.Id_Item, tab1.Name, tab1.Element_Id, IsNull(tab2.Id_Item, @Id_where) as Parent_Id
FROM @TT tab1 LEFT JOIN (SELECT tab.Id_Item, tmptab.Id_Element
							FROM @TT tab, @T tmptab
							WHERE tmptab.Parent_ID = tab.Element_Id) tab2
							ON tab1.Element_Id = tab2.Id_Element

END;

