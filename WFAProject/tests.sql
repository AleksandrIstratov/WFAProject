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

DECLARE @val UNIQUEIDENTIFIER
SET @val = (SELECT TOP 1 Id_Item FROM TItems WHERE Name = '1.1')
select @val
EXEC GetChildrenItems @val
GO

DECLARE @val UNIQUEIDENTIFIER
SET @val = (SELECT TOP 1 Id_Element FROM TElements WHERE Name = 'First')
select @val
EXEC GetChildrenElements @val
GO

EXEC GetNullParentsItems