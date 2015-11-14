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
/*WITH DirectReports(Id_Element, Parent_ID, Name) AS 
(
    SELECT Id_Element, Parent_Id, Name
    FROM TElements
    WHERE Id_Element = @Id_what
    UNION ALL
    SELECT e.Id_Element, e.Parent_id, e.Name
    FROM TElements e
        INNER JOIN DirectReports d
        ON e.Parent_ID= d.Id_Element
)
SELECT Id_Element, Parent_ID, Name
INTO #T
FROM DirectReports 
*/
DECLARE @TT TABLE (
	[Id_Item] [uniqueidentifier],
	[Name] [varchar](64) NOT NULL,
	[Element_Id] [uniqueidentifier], 
	[Parent_Id] [uniqueidentifier]
)

INSERT INTO #T EXEC GetChildrenElements @Id_what

INSERT INTO @TT (Id_Item, Name, Element_Id) SELECT NewID(), Name, Id_Element FROM #T


INSERT INTO TItems (Id_Item, Name, Element_Id, Parent_Id)
SELECT tab1.Id_Item, tab1.Name, tab1.Element_Id, IsNull(tab2.Id_Item, @Id_where) as Parent_Id
FROM @TT tab1 LEFT JOIN (SELECT tab.Id_Item, #T.Id_Element
							FROM @TT tab, #T
							WHERE #T.Parent_ID = tab.Element_Id) tab2
							ON tab1.Element_Id = tab2.Id_Element

DROP TABLE #T
END;