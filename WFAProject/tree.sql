USE DBProject
GO
DECLARE @Id_Filtr uniqueidentifier;
DECLARE @Id_Parent uniqueidentifier;

SET @Id_Filtr = (SELECT TOP 1 Id_Element FROM TElements WHERE Name = 'First');

WITH DirectReports(Id_Element, Parent_ID, Name) AS 
(
    SELECT Id_Element, Parent_Id, Name
    FROM TElements
    WHERE Id_Element = @Id_Filtr
    UNION ALL
    SELECT e.Id_Element, e.Parent_id, e.Name
    FROM TElements e
        INNER JOIN DirectReports d
        ON e.Parent_ID= d.Id_Element
)
SELECT Id_Element, Parent_ID, Name
INTO #T
FROM DirectReports 

SELECT *
FROM #T

DECLARE @TT TABLE (
	[Id_Item] [uniqueidentifier],
	[Name] [varchar](64) NOT NULL,
	[Element_Id] [uniqueidentifier], 
	[Parent_Id] [uniqueidentifier]
)

INSERT INTO @TT (Id_Item, Name, Element_Id) SELECT NewID(), Name, Id_Element FROM #T

SELECT *
FROM @TT

SELECT tab1.Id_Item, tab1.Name, tab1.Element_Id, tab2.Id_Item as Parent_Id
FROM @TT tab1 LEFT JOIN (SELECT tab.Id_Item, #T.Id_Element
							FROM @TT tab, #T
							WHERE #T.Parent_ID = tab.Element_Id) tab2
							ON tab1.Element_Id = tab2.Id_Element

DROP TABLE #T