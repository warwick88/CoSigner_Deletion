use ProdSmartCare


select * from staff
where lastname like '%Obasi%'

--SO HERE IS THE SERVICE WITH MIKE.
SELECT * FROM SERVICES
WHERE SERVICEID=993948



select * from staff where staffid =31013
--THIS IS MIKE
SELECT * FROM Staff
WHERE StaffId=32111
--STAFF ID ON THE APPOINTMENT IS 32111
SELECT * FROM Appointments
WHERE ServiceId=993948

select * from documents
where serviceid=993948

select * from documentversions
where documentid=993948


/*
	FULL SOLUTION:
	1. Services (ServiceID)
	2. Appointments (ServiceID)
	3. Documents (ServiceID) (We need Document ID here for the Version portion)
	4. DocumentVersions (DocumentID) (Need D.DocumentID)
*/
SELECT * FROM SERVICES
WHERE SERVICEID=993948

SELECT * FROM Appointments
WHERE ServiceId=993948

select * from documents
where serviceid=993948

select * from documentversions
where documentid=2983804

UPDATE SERVICES
SET ClinicianId=32111, ModifiedBy='Wbarlow',ModifiedDate=getdate()
WHERE SERVICEID=993948

UPDATE Appointments
SET ClinicianId=32111, ModifiedBy='Wbarlow',ModifiedDate=getdate()
WHERE ServiceId=993948

UPDATE documents
SET ClinicianId=32111, ModifiedBy='Wbarlow',ModifiedDate=getdate()
where serviceid=993948

UPDATE documentversions
SET ClinicianId=32111, ModifiedBy='Wbarlow',ModifiedDate=getdate()
where documentid=2983804

