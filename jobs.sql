/*
Database backups
*/
DROP PROCEDURE IF EXISTS dbo.spWeeklyFullDataseBackup
GO
CREATE PROCEDURE dbo.spWeeklyFullDataseBackup
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    DECLARE @Location nvarchar(100);
    SELECT @Location = CONCAT('C:\SQL Server Backups\StarAirlinesFull', CONVERT(date, GETDATE()), '.bak')
    BACKUP DATABASE StarAirlines3
    TO DISK = @Location
       WITH FORMAT,
          MEDIANAME = 'SQLServerBackups',
          NAME = 'Full Backup of Star Airlines';
END;
GO

-- 28 days of retention
DROP PROCEDURE IF EXISTS dbo.spDeleteOldDataseBackup
GO
CREATE PROCEDURE dbo.spDeleteOldDataseBackup
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;

    DECLARE @DeleteDate DATETIME;
    SET @DeleteDate = DateAdd(d,-28, GetDate());

    DECLARE @Location nvarchar(100);
    SELECT @Location = 'C:\SQL Server Backups\'

    /*
    Erase all backups exists before delete date.
    The backups are saved by 28 days, afther that they will be erase
    */
    EXECUTE master.dbo.xp_delete_file 0, @Location, 'bak', @DeleteDate, 0;
END;
GO

DROP PROCEDURE IF EXISTS dbo.spDailyDiferentialDataseBackup
GO
CREATE PROCEDURE dbo.spDailyDiferentialDataseBackup
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    DECLARE @Location nvarchar(100);
    SELECT @Location = CONCAT('C:\SQL Server Backups\StarAirlinesDiferential', CONVERT(date, GETDATE()), '.bak')
    BACKUP DATABASE StarAirlines3
       TO DISK = @Location
       WITH DIFFERENTIAL
END;
GO

DROP PROCEDURE IF EXISTS dbo.spLogDataseBackup
GO
CREATE PROCEDURE dbo.spLogDataseBackup
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER OFF;
    DECLARE @Location nvarchar(100);
    SELECT @Location = CONCAT('C:\SQL Server Backups\StarAirlinesLog', CONVERT(date, GETDATE()), 'T', REPLACE(Convert(Time(0), GetDate()),':','-'),'.bak');;
    BACKUP LOG StarAirlines3
        TO DISK =  @Location
END;
GO

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
EXEC msdb.dbo.sp_add_job
    @job_name = N'Weekly Star Airlines Data Backup' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Star Airlines Data Backup',
    @step_name = N'Set database to read only',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_ONLY',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Star Airlines Data Backup',
    @step_name = N'Full Database backup',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spWeeklyFullDataseBackup',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Star Airlines Data Backup',
    @step_name = N'Delete old database backups',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spDeleteOldDataseBackup',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Weekly Star Airlines Data Backup',
    @step_name = N'Set database to read write',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_WRITE',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'RunWeekly',
    @freq_type = 8, -- semanal
    @freq_interval = 2, -- lunes
     @freq_recurrence_factor = 1,
    @active_start_time = 000000 ; -- 12PM
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
EXEC msdb.dbo.sp_add_job
    @job_name = N'Nightly StarAirlines Diferential Data Backup' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Nightly StarAirlines Diferential Data Backup',
    @step_name = N'Set database to read only',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_ONLY',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Nightly StarAirlines Diferential Data Backup',
    @step_name = N'Do Diferential backup',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spDailyDiferentialDataseBackup',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Nightly StarAirlines Diferential Data Backup',
    @step_name = N'Set database to read write mode',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_WRITE',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'RunDaily',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 000000 ;
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
EXEC msdb.dbo.sp_add_job
    @job_name = N'Star Airlines Log Backup' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Star Airlines Log Backup',
    @step_name = N'Set database to read only',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_ONLY',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Star Airlines Log Backup',
    @step_name = N'Do log backup',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spLogDataseBackup',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Star Airlines Log Backup',
    @step_name = N'Set database to read write only',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE StarAirlines3 SET READ_WRITE',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'RunEvery15Minutes',
    @freq_type = 4, -- on daily basis
    @freq_interval = 1, -- don't use this one
    @freq_subday_type = 4,  -- units between each exec: minutes
    @freq_subday_interval = 15,  -- number of units between each exec
    @active_start_time = 000000 ;
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Star Airlines Log Backup',
   @schedule_name = N'RunEvery15Minutes';
GO
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Star Airlines Log Backup' ;
GO

/*
Index, rebuild index
*/

/*
Statidictis
*/
-- auto create
-- auto update

/*
check database integrity
*/

/*
History cleanup
*/
EXEC msdb.dbo.sp_add_job
    @job_name = N'History Cleanup' ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Backups History Cleanup',
    @step_name = N'Clear database backups history',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spMaintanceCleanBackpupHistory',
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Jobs History Cleanup',
    @step_name = N'Clear jobs history',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.spMaintanceCleanJobHistory',
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