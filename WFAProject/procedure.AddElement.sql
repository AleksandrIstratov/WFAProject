USE DBProject
GO

IF OBJECT_ID('AddElement', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[AddElement] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROCEDURE [dbo].[AddElement]
	@name varchar(64),
	@Id_Element UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
SET @Id_Element = newid()
INSERT [dbo].[TElements](Id_Element, Name) VALUES (@Id_Element, @name)
END

GO
