select * from systemdatabases
--update systemdatabases set OrganizationName='KCMHSAS PreProd',
--ConnectionString='Data Source=SLNONPROD-DB;Initial Catalog=SmartcarePreProd;Trusted_Connection=yes;'
--where systemdatabaseid=2

==========================================

Select OrganizationName,ReportURL,ReportFolderName,ReportServerDomain,ReportServerUserName,ReportServerPassword,ReportServerConnection from systemconfigurations
--update systemconfigurations set 
--OrganizationName='Kalamazoo PreProd | 07/09/2021',
--ReportURL='http://slnonprod-db/Reportserver_SLNONPROD',
--ReportFolderName='PREPROD/SCDocuments',
--ReportServerDomain='KCMHSAS',
--ReportServerUserName='streamline',
--ReportServerPassword='jun09sat',
--ReportServerConnection='Data Source=SLNONPROD-DB;Initial Catalog=SmartcarePreProd;Trusted_Connection=yes;'

==========================================

select * from systemreports 
--update systemreports set reporturl=replace(reporturl,'http://kcmh-db1/ReportServer?/ProdSCDocuments/','http://slnonprod-db/Reportserver_SLNONPROD?/PREPROD/SCDocuments/')
--update systemreports set reporturl=replace(reporturl,'http://kcmh-db1/ReportServer?/ProdSCReports/','http://slnonprod-db/Reportserver_SLNONPROD?/PREPROD/SCReports/')

==========================================

select * from reportservers
--update reportservers set 
--Name='KCMHSAS PreProd Report Server',
--URL='http://slnonprod-db/Reportserver_SLNONPROD',
--ConnectionString='Data Source=SLNONPROD-DB;Initial Catalog=ReportServer;Trusted_Connection=yes;',
--DomainName='KCMHSAS',
--UserName='streamline',
--Password='jun09sat'

==========================================

select * from ImageServers
--update ImageServers set 
--ImageServerName='KCMHSAS PreProd ImageServer',
--ImageServerURL='http://localhost/SmartCarePreProdImageService/ImageServerWebService.asmx',
--ImageViewReportPath='/PREPROD/SCDocuments/ScannedViewDocReport'

==========================================

select * from reports
--update reports set reportserverpath=replace(reportserverpath,'/ProdSCReports/','/PREPROD/SCReports/')
--update reports set reportserverpath=replace(reportserverpath,'/ProdDWReports/','/PREPROD/DWReports/')
--update reports set reportserverpath=replace(reportserverpath,'/StreamlineStandardReportsPROD/','/PREPROD/StreamlineStandardReportsPREPROD/')
--update reports set reportserverpath=replace(reportserverpath,'/ProdSCDocuments/','/PREPROD/SCDocuments/')
--update reports set reportserverpath=replace(reportserverpath,'/prodcmdocuments/','/PREPROD/CMDocuments/')
--update reports set reportserverpath=replace(reportserverpath,'/ProdCMReports/','/PREPROD/CMReports/')
--update reports set reportserverpath=replace(reportserverpath,'/RDWCoreReports/','/PREPROD/RDWCoreReports/')
--update reports set reportserverpath=replace(reportserverpath,'/DCH/TEDS/','/PREPROD/DCH/TEDS/')
--update reports set reportserverpath=replace(reportserverpath,'/SWMBH/','/PREPROD/SWMBH/')

==========================================

Select * from SystemConfigurationKeys where [key] like '%adhoc%'

--update SystemConfigurationKeys set Value='https://slnonprod.iskzoo.org/SCAdhocreportingPreProd/ValidateToken.aspx?StaffId=' where [key] = 'AdhocLoginURL'

==========================================

select * from catalogs

--update catalogs set connectionstring='Data Source=SLNONPROD-DB;Initial Catalog=SmartcarePreProd;Trusted_Connection=yes;'

==========================================

select * from webfarmnodes

--Truncate Table webfarmnodes

==========================================
--"Disable and enable  the Triggers of target database [SC] using query"

DECLARE @string VARCHAR(8000)
DECLARE @tableName NVARCHAR(500)
DECLARE cur CURSOR
FOR SELECT name AS tbname FROM sysobjects WHERE id IN(SELECT parent_obj FROM sysobjects WHERE xtype='tr')
OPEN cur
FETCH next FROM cur INTO @tableName
WHILE @@fetch_status = 0
BEGIN
print @tableName
SET @string ='Alter table '+ @tableName + ' Disable trigger all'
EXEC (@string)
FETCH next FROM cur INTO @tableName
END
CLOSE cur
DEALLOCATE cur

==========================================

--"Enable  the Triggers of target database [SC] using query

DECLARE @string VARCHAR(8000)
DECLARE @tableName NVARCHAR(500)
DECLARE cur CURSOR
FOR SELECT name AS tbname FROM sysobjects WHERE id IN(SELECT parent_obj FROM sysobjects WHERE xtype='tr')
OPEN cur
FETCH next FROM cur INTO @tableName
WHILE @@fetch_status = 0
BEGIN
print @tableName
SET @string ='Alter table '+ @tableName + ' Enable trigger all'
EXEC (@string)
FETCH next FROM cur INTO @tableName
END
CLOSE cur
DEALLOCATE cur

==========================================
--Please set set the database to recovery model to simple for NON-PROD
==========================================

--synonyms 

==========================================

select * from systemconfigurationkeys WHERE [Key]='SETAPPLICATIONHEADERCOLOR'
--update systemconfigurationkeys set Value='BLUE' WHERE [Key]='SETAPPLICATIONHEADERCOLOR'"

==========================================

--"After Restore of any Databases for TRAIN/TEST/QA/PreProd ---Execute the below scripts

Script1:
DECLARE @DBname NVARCHAR(50)
SELECT @DBname = DB_NAME()
EXEC ('ALTER DATABASE ' +'['+ @DBname +']'+ ' SET TRUSTWORTHY ON')
EXEC ('ALTER AUTHORIZATION on DATABASE::' +'['+ @DBname +']'+ ' to sa')

Script2:
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

==========================================

Select PMPWebServiceURL, * from PMPWebServiceConfigurations 
--update PMPWebServiceConfigurations set PMPWebServiceURL='https://scriptstaging.streamlinehealthcare.com/SSService/rx/PMPRequest'