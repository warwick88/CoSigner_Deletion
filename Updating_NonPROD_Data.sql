 /**********************************************************************************************
  run these commands from SLNONPROD-DB server's sql management studio
**********************************************************************************************/
  
/**********************************************************************************************
  XP_CMDSHELL is how to get SQL server to run Operating system commands

  may need to enable it - I did - I think it's a universal setting

  simple test - run the DIR command
EXEC XP_CMDSHELL 'DIR'

connect as kcmhsas\streamline and map the z: drive of SLNONPROD-DB to the e:\ drive of KCMH-DB1
**********************************************************************************************/
EXEC XP_CMDSHELL 'net use z: \\kcmh-db1\e$ jun09sat /user:kcmhsas\streamline'


/**********************************************************************************************
restore from the z:\SQLBACKUP folder ProdSmartCare.bak file - to very carefully chosen spaces

notice the naming conventions

this will probably take a couple hours, you'll get status updates every 5% of progress
**********************************************************************************************/
USE [master]
RESTORE DATABASE [PreProdSmartCare] 
  FROM  DISK = N'Z:\SQLBACKUP\ProdSmartCare.bak' WITH  FILE = 1,  
        MOVE N'KalamazooStreamline_Data' TO N'F:\mdf\PreProdSmartCare20210708.mdf',  
        MOVE N'KalamazooStreamline_Log' TO N'G:\ldf\PreProdSmartCare20210708.LDF',  NOUNLOAD,  STATS = 5


/**********************************************************************************************
Post restore cleanup
**********************************************************************************************/
update PreProdSmartCare..SystemConfigurations set OrganizationName='PreProd 20210708'
EXEC PreProdSmartCare..sp_changedbowner 'sa'
ALTER DATABASE PreProdSmartCare SET TRUSTWORTHY ON

update PreProdSmartCare..reportservers set URL='http://slnonprod-db/Reportserver_SLNONPROD', ConnectionString='Data Source=SLNONPROD-DB;Initial Catalog=ReportServer;Trusted_Connection=yes;'


/**********************************************************************************************
not sure if this is needed - setting might come over in restore
**********************************************************************************************/
EXEC PreProdSmartCare..sp_configure 'clr enabled', 1;



/**********************************************************************************************
Not sure if this is how streamline does this
**********************************************************************************************/
exec PreProdSmartCare..csp_DropAndCreateSynonyms @ServerName ='SLNONPROD-DB', @DatabaseName ='ProdSmartCare', @SynonymPrefix=''


/**********************************************************************************************
assuming we re-deploy all reports
**********************************************************************************************/
UPDATE SmartCarePreProd..REPORTS SET ReportServerPath='/PreProd'+ReportServerPath
s

update SystemDatabases set ConnectionString='Data Source=SLNONPROD-DB;Initial Catalog=PreProdSmartCare;uid=streamline-dbo;pwd=Apr1l-2012;' where SystemDatabaseId=2
