/*
Database backups
*/
use StarAirlines;
DROP PROCEDURE IF EXISTS dbo.spMaintanceCleanBackpupHistory
GO
CREATE PROCEDURE dbo.spMaintanceCleanBackpupHistory
AS
BEGIN
    DECLARE @Date datetime = DATEADD(dd, -28, GETDATE());
    EXEC msdb.dbo.sp_delete_backuphistory @oldest_date = @Date;
END;
GO

DROP PROCEDURE IF EXISTS dbo.spMaintanceCleanJobHistory
GO
CREATE PROCEDURE dbo.spMaintanceCleanJobHistory
AS
BEGIN
    EXEC msdb.dbo.sp_purge_jobhistory;
END;
GO
/*
Full Backup Job
*/
DECLARE @jobId binary(16)
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'Weekly Star Airlines Data Backup')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'Weekly Star Airlines Data Backup' ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Weekly Star Airlines Data Backup',
--     @step_name = N'Set database to read only',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_ONLY',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Star Airlines Data Backup',
    @step_name = N'Full Database backup',
    @subsystem = N'TSQL',
    @command = N'Execute dbo.DatabaseBackup @Databases = ''StarAirlines'',
    @Directory = ''C:\SQL Server Backups'', @BackupType = ''FULL'', @CleanupMode = ''AFTER_BACKUP'',
    @DirectoryStructure = ''{DatabaseName}-{BackupType}'',
    @FileName = ''{DatabaseName}_{BackupType}_{Year}{Month}{Day}-T{Hour}{Minute}{Second}.{FileExtension}''',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Weekly Star Airlines Data Backup',
--     @step_name = N'Set database to read write',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_WRITE',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
IF ( NOT EXISTS(SELECT * FROM msdb.dbo.sysschedules WHERE name = 'RunWeekly'))
    BEGIN EXEC('EXEC msdb.dbo.sp_add_schedule
        @schedule_name = N''RunWeekly'',
        @freq_type = 8, -- semanal
        @freq_interval = 2, -- lunes
         @freq_recurrence_factor = 1,
        @active_start_time = 000000 ; -- 12PM')
END
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Weekly Star Airlines Data Backup',
   @schedule_name = N'RunWeekly';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Weekly Star Airlines Data Backup';
GO

/*
Diferential Backup Job
*/
DECLARE @jobId binary(16)

SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'Nightly StarAirlines Diferential Data Backup')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'Nightly StarAirlines Diferential Data Backup' ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Nightly StarAirlines Diferential Data Backup',
--     @step_name = N'Set database to read only',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_ONLY',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Nightly StarAirlines Diferential Data Backup',
    @step_name = N'Do Diferential backup',
    @subsystem = N'TSQL',
    @command = N'Execute dbo.DatabaseBackup @Databases = ''StarAirlines'',
    @Directory = ''C:\SQL Server Backups'', @BackupType = ''DIFF'', @CleanupMode = ''AFTER_BACKUP'',
    @DirectoryStructure = ''{DatabaseName}-{BackupType}'',
    @FileName = ''{DatabaseName}_{BackupType}_{Year}{Month}{Day}-T{Hour}{Minute}{Second}.{FileExtension}''',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Nightly StarAirlines Diferential Data Backup',
--     @step_name = N'Set database to read write mode',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_WRITE',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
IF ( NOT EXISTS(SELECT * FROM msdb.dbo.sysschedules WHERE name = 'RunDaily'))
    BEGIN EXEC('EXEC msdb.dbo.sp_add_schedule
        @schedule_name = N''RunDaily'',
        @freq_type = 4,
        @freq_interval = 1,
        @active_start_time = 000000 ;')
END
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Nightly StarAirlines Diferential Data Backup',
   @schedule_name = N'RunDaily';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Nightly StarAirlines Diferential Data Backup';
GO

/*
Log Backup Job
*/
DECLARE @jobId binary(16)
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'Star Airlines Log Backup')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'Star Airlines Log Backup' ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Star Airlines Log Backup',
--     @step_name = N'Set database to read only',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_ONLY',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Star Airlines Log Backup',
    @step_name = N'Do log backup',
    @subsystem = N'TSQL',
    @command = N'Execute dbo.DatabaseBackup @Databases = ''StarAirlines'',
    @Directory = ''C:\SQL Server Backups'', @BackupType = ''LOG'', @CleanupMode = ''AFTER_BACKUP'',
    @DirectoryStructure = ''{DatabaseName}-{BackupType}'',
    @FileName = ''{DatabaseName}_{BackupType}_{Year}{Month}{Day}-T{Hour}{Minute}{Second}.{FileExtension}''',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
-- EXEC msdb.dbo.sp_add_jobstep
--     @job_name = N'Star Airlines Log Backup',
--     @step_name = N'Set database to read write only',
--     @subsystem = N'TSQL',
--     @command = N'ALTER DATABASE StarAirlines SET READ_WRITE',
--     @retry_attempts = 5,
--     @retry_interval = 5 ;
-- GO
IF ( NOT EXISTS(SELECT * FROM msdb.dbo.sysschedules WHERE name = 'RunEvery15Minutes'))
    BEGIN EXEC('EXEC msdb.dbo.sp_add_schedule
        @schedule_name = N''RunEvery15Minutes'',
        @freq_type = 4, -- on daily basis
        @freq_interval = 1, -- don''t use this one
        @freq_subday_type = 4,  -- units between each exec: minutes
        @freq_subday_interval = 15,  -- number of units between each exec
        @active_start_time = 000000 ;')
END
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Star Airlines Log Backup',
   @schedule_name = N'RunEvery15Minutes';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Star Airlines Log Backup' ;
GO

/*
Index, rebuild index and stadistics
-- auto create
*/
DECLARE @jobId binary(16)
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'Weekly Maintance of Indexes')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'Weekly Maintance of Indexes' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Maintance of Indexes' ,
    @step_name = N'Rebuild indexes',
    @subsystem = N'TSQL',
    @command = N'EXECUTE dbo.IndexOptimize @Databases = ''StarAirlines'',
    @FragmentationLow = ''INDEX_REORGANIZE'', @FragmentationMedium =''INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
    @FragmentationHigh = ''INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
    @UpdateStatistics = ''ALL'',
    @OnlyModifiedStatistics = ''Y'';',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Weekly Maintance of Indexes' ,
   @schedule_name = N'RunWeekly';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Weekly Maintance of Indexes';
GO
/*
check database integrity
*/
DECLARE @jobId binary(16)
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'Weekly Database Integrity Revision')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'Weekly Database Integrity Revision' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Database Integrity Revision',
    @step_name = N'Check database integrity',
    @subsystem = N'TSQL',
    @command = N'EXECUTE dbo.DatabaseIntegrityCheck
    @Databases = ''StarAirlines'',
    @CheckCommands = ''CHECKDB'';',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Weekly Database Integrity Revision',
   @schedule_name = N'RunWeekly';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Weekly Database Integrity Revision' ;
GO

/*
History cleanup
*/
DECLARE @jobId binary(16)
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'History Cleanup')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
EXEC msdb.dbo.sp_add_job
    @job_name = N'History Cleanup' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'History Cleanup',
    @step_name = N'Clear database backups history',
    @subsystem = N'TSQL',
    @command = N'EXEC StarAirlines.dbo.spMaintanceCleanBackpupHistory',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'History Cleanup',
    @step_name = N'Clear jobs history',
    @subsystem = N'TSQL',
    @command = N'EXEC StarAirlines.dbo.spMaintanceCleanJobHistory',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'History Cleanup',
   @schedule_name = N'RunWeekly';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'History Cleanup';
GO

