USE DBProject
GO

IF OBJECT_ID('GetChildrenItems', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[GetChildrenItems] AS BEGIN SET NOCOUNT ON; END')
GO

IF OBJECT_ID('GetChildrenElements', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[GetChildrenElements] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROCEDURE [dbo].[GetChildrenItems]
	@startPos UNIQUEIDENTIFIER,
	@withParent BIT = 1 
AS
BEGIN
WITH DirectReports(Id_Item, Parent_Id, Name) AS 
(
    SELECT Id_Item, Parent_Id, Name
    FROM TItems
    WHERE Id_Item = @startPos
    UNION ALL
    SELECT e.Id_Item, e.Parent_id, e.Name
    FROM TItems e
        INNER JOIN DirectReports d
        ON e.Parent_Id= d.Id_Item
)
SELECT Id_Item, Parent_Id, Name
INTO #T
FROM DirectReports

IF @withParent = 0
BEGIN
DELETE
FROM #T
WHERE Id_Item=@startPos
END
SELECT *
FROM #T
/*DROP TABLE #T*/
END

GO

ALTER PROCEDURE [dbo].[GetChildrenElements]
	@startPos UNIQUEIDENTIFIER,
	@withParent BIT = 1 
AS
BEGIN
WITH DirectReports(Id_Element, Parent_ID, Name) AS 
(
    SELECT Id_Element, Parent_Id, Name
    FROM TElements
    WHERE Id_Element = @startPos
    UNION ALL
    SELECT e.Id_Element, e.Parent_id, e.Name
    FROM TElements e
        INNER JOIN DirectReports d
        ON e.Parent_ID= d.Id_Element
)
SELECT Id_Element, Parent_ID, Name
INTO #T
FROM DirectReports

IF @withParent = 0
BEGIN
DELETE
FROM #T
WHERE Id_Element=@startPos
END
SELECT *
FROM #T
/*DROP TABLE #T*/
END
GO

