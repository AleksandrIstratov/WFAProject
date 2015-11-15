USE DBProject
GO

IF OBJECT_ID('GetNullParentsItems', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[GetNullParentsItems] AS BEGIN SET NOCOUNT ON; END')
GO

IF OBJECT_ID('GetNullParentsElements', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[GetNullParentsElements] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROCEDURE [dbo].[GetNullParentsElements]
AS
BEGIN
SELECT Id_Element, Name
FROM dbo.TElements
WHERE Parent_Id is NULL
END

GO

ALTER PROCEDURE [dbo].[GetNullParentsItems]
AS
BEGIN
SELECT Id_Item, Name, Element_Id
FROM dbo.TItems
WHERE Parent_Id is NULL
END

GO
