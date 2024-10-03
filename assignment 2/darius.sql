--create user
CREATE USER C##da_plsqlauca IDENTIFIED BY auca;
GRANT ALL PRIVILEGES TO C##da_plsqlauca;

----create pdb
SHOW con_name;
ALTER SESSION SET container = CDB$ROOT;
CREATE PLUGGABLE DATABASE da_to_delete_pdb
ADMIN USER da_plsqlauca IDENTIFIED BY auca
FILE_NAME_CONVERT = ('C:\ORACLE\ORADATA\ORCL\PDBSEED\', 'C:\Oracle\HOME\da_to_delete_pdb\');

--after creation this is how you connecto to pdb
ALTER SESSION SET CONTAINER = CDB$ROOT;
CONNECT SYS/darius123 AS SYSDBA;
ALTER PLUGGABLE DATABASE da_to_delete_pdb OPEN;
ALTER SESSION SET CONTAINER = da_to_delete_pdb;
ALTER SESSION SET CONTAINER = da_to_delete_pdb;

----delete pdb
CONNECT SYS/darius123 AS SYSDBA;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER PLUGGABLE DATABASE da_to_delete_pdb CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE da_to_delete_pdb INCLUDING DATAFILES;
SELECT con_id, name, open_mode FROM v$containers;




