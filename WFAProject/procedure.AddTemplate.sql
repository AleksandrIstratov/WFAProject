USE DBProject
GO

IF OBJECT_ID('AddTemplate', 'P') IS NULL
	exec('CREATE PROCEDURE [dbo].[AddTemplate] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROCEDURE [dbo].[AddTemplate]
	@name varchar(64),
	@Id_Template UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
SET @Id_Template = newid()
INSERT [dbo].[TTemplates](Id_Template, Name) VALUES (@Id_Template, @name)
END

GO
