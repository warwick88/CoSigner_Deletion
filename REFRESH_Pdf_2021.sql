use ProdSmartCare

DECLARE @DocumentId INT
DECLARE @DocumentVersionId INT

SET @DocumentId = 

select * from Documentversions
where DocumentId = @DocumentId

insert into DocumentPDFGenerationQueue (Createdby,Createddate,Modifiedby,Modifieddate,DocumentversionId)
VALUES ('Wbarlow',getdate(),'Wbarlow',getdate(),'Documentversionid')

exec ssp_processPDF

select * from documents
where documentid = 

select * from documentversions
where documentId = 

--So you are going to need to insert the DocumentVersionID you want to refresh into this table
insert into DocumentPDFGenerationQueue (Createdby,Createddate,Modifiedby,Modifieddate,DocumentversionId)
VALUES ('Wbarlow',getdate(),'Wbarlow',getdate(),'3011243')

exec ssp_processPDF


DECLARE @ServiceId INT;
SET @ServiceId = 957350

update DocumentVersions
SET RefreshView='Y'
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId



GO

select * from documentversions
where documentid=2787378

select * from documents
where serviceid=957350

select * from documentversions
where documentid=2897469

select * from DocumentPDFGenerationQueue

insert into DocumentPDFGenerationQueue (Createdby,Createddate,Modifiedby,Modifieddate,DocumentversionId)
VALUES ('Wbarlow',getdate(),'Wbarlow',getdate(),'3011243')

use ProdSmartCare


DECLARE @ServiceId INT;
SET @ServiceId = 957350

update DocumentVersions
SET RefreshView='Y'
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId