use ProdSmartCare


DECLARE @ServiceId INT;
SET @ServiceId = 911266

update DocumentVersions
SET RefreshView='Y'
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId

DECLARE @ServiceId INT;
SET @ServiceId = 991745

select DV.documentversionid Into #Temp1 
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId

DROP TABLE #TEMP1

SELECT * FROM #TEMP1

ALTER TABLE #TEMP1 ADD COLUMN

select * from DocumentPDFGenerationQueue

insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
values ('Wbarlow', getdate(),3099766 )




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


