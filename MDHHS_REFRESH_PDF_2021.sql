


select * from documents
where createdby like 'Wbarlow'
order by createddate desc

select * from documents
where documentid=2986489

select * from documentversions
where documentid=2986489

select * from documentsignatures
where documentid=2986489



select * from documents
where documentcodeid = 60039
and createddate > '2021-08-01'
order by createddate desc

DROP TABLE #TEMP1

select * INTO #TEMP1 from documents
where documentcodeid = 60039
and createddate > '2021-08-01'
order by createddate desc

SELECT * FROM #TEMP1
DROP TABLE #TEMP2

SELECT DOCUMENTVERSIONID INTO #TEMP2 FROM DOCUMENTVERSIONS
WHERE DOCUMENTID IN (SELECT DOCUMENTID FROM #TEMP1)

SELECT * FROM #TEMP2

select 
	'Wbarlow' AS CreatedBy,
	getdate() AS CreatedDate,
	DocumentVersionId AS DocumentVersionId INTO #TEMP3
FROM
	#TEMP2

	SELECT * FROM #TEMP3

	
--Final step, this inserts all the versions to fix.
insert into DocumentPDFGenerationQueue (CreatedBy, CreatedDate, DocumentVersionId)
select #TEMP3.CreatedBy,#TEMP3.CreatedDate,#TEMP3.DocumentVersionId FROM #TEMP3

select * from DocumentPDFGenerationQueue





exec ssp_processPDF
drop table #Temp1
drop table #TEMP2
DROP TABLE #TEMP3




