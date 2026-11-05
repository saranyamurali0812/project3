CREATE DATABASE Customer360DB;

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Str0ng!Passw0rd#2026';
GO

CREATE DATABASE SCOPED CREDENTIAL WorkspaceIdentity
WITH IDENTITY = 'Managed Identity';

CREATE EXTERNAL DATA SOURCE customer360_ds
WITH (LOCATION = 'https://adls360demo01.dfs.core.windows.net/customer360',
      CREDENTIAL = WorkspaceIdentity);


CREATE VIEW dbo.vw_YellowTaxi AS
SELECT *
FROM OPENROWSET(
        BULK 'Taxi_yellow_delta/',
        DATA_SOURCE = 'customer360_ds',
        FORMAT = 'DELTA'
     ) AS t;
GO

SELECT count(*)
FROM dbo.vw_YellowTaxi;


SELECT name, type_desc
FROM sys.database_principals
WHERE name =
'saranyafabric@saranyamurali0601gmail.onmicrosoft.com';

CREATE USER
[saranyafabric@saranyamurali0601gmail.onmicrosoft.com]
FROM EXTERNAL PROVIDER;

GRANT CONNECT TO
[saranyafabric@saranyamurali0601gmail.onmicrosoft.com];

GRANT SELECT ON OBJECT::dbo.vw_YellowTaxi
TO [saranyafabric@saranyamurali0601gmail.onmicrosoft.com];



