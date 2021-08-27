DECLARE @ServiceId INT;
SET @ServiceId = 967293

select DV.documentversionid Into #Temp1 
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId

SELECT * FROM #TEMP1


select * from DocumentPDFGenerationQueue

insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
values ('Wbarlow', getdate(),'3035149')

exec ssp_processPDF