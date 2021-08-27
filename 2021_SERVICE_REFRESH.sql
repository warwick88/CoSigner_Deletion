DECLARE @ServiceId INT;
SET @ServiceId = 991245

select DV.documentversionid Into #Temp1 
FROM DocumentVersions DV
JOIN Documents D ON DV.DocumentId = D.DocumentId
JOIN Services S on D.ServiceId = S.ServiceId
WHERE S.ServiceId = @ServiceId

--Just to show your results, and let you quickly drop table if needed.
SELECT * FROM #TEMP1
DROP TABLE #TEMP1


--Important, this is how we target all our DocumentVersions at Once instead of 1 by 1.
select 
	'Wbarlow' AS CreatedBy,
	getdate() AS CreatedDate,
	DocumentVersionId AS DocumentVersionId INTO #TEMP2
FROM
	#TEMP1


--Just if you want to see what will be fixed
SELECT * FROM #TEMP2


--Final step, this inserts all the versions to fix.
insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
select #TEMP2.CreatedBy,#TEMP2.CreatedDate,#TEMP2.DocumentVersionId FROM #TEMP2

select * from DocumentPDFGenerationQueue


--When you want to manually feed the DocumentVersionID
insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
values ('Wbarlow', getdate(),'3093581')

exec ssp_processPDF
DROP TABLE #TEMP1

select * from DocumentPDFGenerationQueue

DELETE FROM DocumentPDFGenerationQueue
WHERE DOCUMENTpdfgenerationqueueid=148









select * from services
where serviceid=991751

SELECT * FROM PROCEDURECODES
WHERE PROCEDURECODEID=752

SELECT DISTINCT(LOCATIONID) FROM SERVICES
WHERE PROCEDURECODEID=752
AND DATEOFSERVICE > '2021-01-01'
AND STATUS=75
ORDER BY CREATEDDATE DESC

SELECT * FROM LOCATIONS
WHERE LOCATIONID IN (
8,
9,
12,
15,
21,
166,
212,
213,
214,
215,
219,
225
)