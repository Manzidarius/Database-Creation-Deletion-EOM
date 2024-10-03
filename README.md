# Database Creation, Deletion & EOM

### Introduction

The Pluggable Database (PDB) Management System is designed to facilitate the creation, management, and deletion of Pluggable Databases within an Oracle multitenant architecture. This project aims to provide a comprehensive understanding of Oracle's multitenant features, particularly focusing on the PDBs, which allow for greater flexibility and resource efficiency in database management.

### 1. Creating a User

```sql
CREATE USER C##da_plsqlauca IDENTIFIED BY auca;
GRANT ALL PRIVILEGES TO C##da_plsqlauca;
```

.This creates a user with a specific username that follows the convention for Oracle's CDB/PDB architecture. The prefix C## is required for case-sensitive names in a CDB.

### 2. Creating a Pluggable Database

```sql
SHOW con_name;
ALTER SESSION SET container = CDB$ROOT;
CREATE PLUGGABLE DATABASE da_to_delete_pdb
ADMIN USER da_plsqlauca IDENTIFIED BY auca
FILE_NAME_CONVERT = ('C:\ORACLE\ORADATA\ORCL\PDBSEED\', 'C:\Oracle\HOME\da_to_delete_pdb\');
```

.The SHOW con_name; command is useful to confirm your current container.

.When you create the PDB, ensure that the path provided in FILE_NAME_CONVERT points to the correct directory where the data files will be created.

.Ensure that the specified path has the necessary permissions for the Oracle user.

### 3. Connecting to the PDB

```sql
ALTER SESSION SET CONTAINER = CDB$ROOT;
CONNECT SYS/darius123 AS SYSDBA;
ALTER PLUGGABLE DATABASE da_to_delete_pdb OPEN;
ALTER SESSION SET CONTAINER = da_to_delete_pdb;
```

.You only need to switch to the root once and connect to the PDB. After opening the PDB, you can directly execute queries in the context of the PDB.

### 4. Deleting the PDB

```sql
CONNECT SYS/darius123 AS SYSDBA;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER PLUGGABLE DATABASE da_to_delete_pdb CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE da_to_delete_pdb INCLUDING DATAFILES;
SELECT con_id, name, open_mode FROM v$containers;
```

.The command CLOSE IMMEDIATE will close the PDB without waiting for current transactions to finish, which is generally safe for dropping it.

.The DROP PLUGGABLE DATABASE command with INCLUDING DATAFILES will delete the PDB along with all associated data files, so ensure you have backups if necessary.
