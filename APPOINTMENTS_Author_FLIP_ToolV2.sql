use ProdSmartCare
select * from Services

/*
	FULL SOLUTION:
	1. Services (ServiceID)
	2. Appointments (ServiceID)
	3. Documents (ServiceID) (We need Document ID here for the Version portion)
	4. DocumentVersions (DocumentID) (Need D.DocumentID)
	5. DocumentSignatures (DocumentID) (Need D.DocumentID)
*/

--Here are the services you want to target, most important range and clinician ID.
SELECT * FROM SERVICES
where clinicianid=38695
and dateofservice > '2021-08-29'
and dateofservice < '2021-09-25'

select distinct(Locationid) from Services	
where ProcedureCodeId=846

select * from locations
where locationid in (29,
219,
228,
225,
223,
217
)

--Pull into a temp table so you can use them easily. was 223 needs to be 228
select ServiceId into #Temp1 FROM SERVICES
where clinicianid=693
and dateofservice > '2021-08-29'
and dateofservice < '2021-09-25'



--Target appropriate appointments for calendar
SELECT * FROM Appointments
WHERE ServiceId in (select Serviceid from #temp1)

select * from documents
WHERE ServiceId in (select Serviceid from #temp1)

select DocumentID into #Temp2 from Documents
WHERE ServiceId in (select Serviceid from #temp1)


select * from documentversions
where DocumentId in (Select DocumentId from #Temp2)

--so the WRONG clinician is 693

select * from staff
where lastname like '%obasi%'

--new staffid = 38695


--WAS STAFFID = 693 flipping it to new 38695
begin tran
UPDATE SERVICES
SET ClinicianId=38695, ModifiedBy='Wbarlow',ModifiedDate=getdate(),AttendingId=NULL,LocationId=228
WHERE ServiceId in (select Serviceid from #temp1)
commit tran

begin tran
UPDATE Appointments
SET StaffId=38695, ModifiedBy='Wbarlow',ModifiedDate=getdate(),LocationId=228
WHERE ServiceId in (select Serviceid from #temp1)
commit tran

begin tran
UPDATE documents
SET AuthorId=38695, ModifiedBy='Wbarlow',ModifiedDate=getdate()
WHERE ServiceId in (select Serviceid from #temp1)
commit tran

--WE CAN JUST BLANKET TARGET ALL THE SERVICES WE FIND ON THE LIST PAGE. NO BIGGIE.
begin tran
UPDATE documentversions
SET AuthorId=38695, ModifiedBy='Wbarlow',ModifiedDate=getdate()
where DocumentId in (Select DocumentId from #Temp2)
commit tran

begin tran
UPDATE DOCUMENTSIGNATURES
SET StaffId=38695
where DocumentId in (Select DocumentId from #Temp2)
commit tran

commit tran




















SELECT * FROM SERVICES
WHERE SERVICEID=986253

SELECT * FROM Appointments
WHERE ServiceId=986253

select * from documents
where serviceid=986253

select * from documentversions
where documentid=2966207

SELECT * FROM DOCUMENTSIGNATURES
where documentid=2966207
