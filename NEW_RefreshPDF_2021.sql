use ProdSmartCare

select * from Documents
where serviceid=

select * from DocumentVersions
where DocumentId=

select * from DocumentPDFGenerationQueue

insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
values ('Mvenner', getdate(), )


/* this is the SP to execute */

USE [ProdSmartCare]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[ssp_processPDF]

SELECT	'Return Value' = @return_value

GO