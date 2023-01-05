-- All Foreign keys
select schema_name(fk_tab.schema_id) + '.' + fk_tab.name as foreign_table,
    '->' as rel,
    schema_name(pk_tab.schema_id) + '.' + pk_tab.name as primary_table,
    substring(column_names, 1, len(column_names)-1) as [fk_columns],
    fk.name as fk_constraint_name,
    schema_name(fk_tab.schema_id) + '.' + fk_tab.name +'.'+substring(column_names, 1, len(column_names)-1)+
    ' -> ' + schema_name(pk_tab.schema_id) + '.' + pk_tab.name--+ '.' + substring(column_names, 1, len(column_names)-1)
from sys.foreign_keys fk
    inner join sys.tables fk_tab
        on fk_tab.object_id = fk.parent_object_id
    inner join sys.tables pk_tab
        on pk_tab.object_id = fk.referenced_object_id
    cross apply (select col.[name] + ', '
                    from sys.foreign_key_columns fk_c
                        inner join sys.columns col
                            on fk_c.parent_object_id = col.object_id
                            and fk_c.parent_column_id = col.column_id
                    where fk_c.parent_object_id = fk_tab.object_id
                      and fk_c.constraint_object_id = fk.object_id
                            order by col.column_id
                            for xml path ('') ) D (column_names)
order by schema_name(fk_tab.schema_id) + '.' + fk_tab.name,
    schema_name(pk_tab.schema_id) + '.' + pk_tab.name

-- Database space
EXEC sp_spaceused @oneresultset = 1;

-- get all functions
SELECT name, definition, type_desc
  FROM sys.sql_modules m
INNER JOIN sys.objects o
        ON m.object_id=o.object_id
WHERE type_desc like '%function%'

-- get stored procedures
SELECT *
  FROM StarAirlines3.INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE'

-- get all stored procedures
SELECT *
  FROM INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE'

SELECT *
  FROM INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE'
    AND ROUTINES.ROUTINE_NAME LIKE 'sp%';

-- users in database
Select
  [name]
From
  sysusers
Where
  issqlrole = 1

-- get permisions of all roles
select  princ.name
,       princ.type_desc
,       perm.permission_name
,       perm.state_desc
,       perm.class_desc
,       object_name(perm.major_id)
from    sys.database_principals princ
left join
        sys.database_permissions perm
on      perm.grantee_principal_id = princ.principal_id

-- query history
SELECT t.[text]
FROM sys.dm_exec_cached_plans AS p
CROSS APPLY sys.dm_exec_sql_text(p.plan_handle) AS t
WHERE t.[text] LIKE N'%something unique about your query%';