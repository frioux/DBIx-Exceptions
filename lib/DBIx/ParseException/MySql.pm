package DBIx::ParseException::Pg;

use Moose;
use DBIx::Exceptions;
with 'DBIx::ParseException';

$error_codes = {
=pod
1000 SQLSTATE: HY000 (ER_HASHCHK)
hashchk
1001 SQLSTATE: HY000 (ER_NISAMCHK)
isamchk
1002 SQLSTATE: HY000 (ER_NO)
NO
1003 SQLSTATE: HY000 (ER_YES)
YES
1004 SQLSTATE: HY000 (ER_CANT_CREATE_FILE)
Can't create file '%s' (errno: %d)
1005 SQLSTATE: HY000 (ER_CANT_CREATE_TABLE)
Can't create table '%s' (errno: %d)
1006 SQLSTATE: HY000 (ER_CANT_CREATE_DB)
Can't create database '%s' (errno: %d)
1007 SQLSTATE: HY000 (ER_DB_CREATE_EXISTS)
Can't create database '%s'; database exists
1008 SQLSTATE: HY000 (ER_DB_DROP_EXISTS)
Can't drop database '%s'; database doesn't exist
1009 SQLSTATE: HY000 (ER_DB_DROP_DELETE)
Error dropping database (can't delete '%s', errno: %d)
1010 SQLSTATE: HY000 (ER_DB_DROP_RMDIR)
Error dropping database (can't rmdir '%s', errno: %d)
1011 SQLSTATE: HY000 (ER_CANT_DELETE_FILE)
Error on delete of '%s' (errno: %d)
1012 SQLSTATE: HY000 (ER_CANT_FIND_SYSTEM_REC)
Can't read record in system table
1013 SQLSTATE: HY000 (ER_CANT_GET_STAT)
Can't get status of '%s' (errno: %d)
1014 SQLSTATE: HY000 (ER_CANT_GET_WD)
Can't get working directory (errno: %d)
1015 SQLSTATE: HY000 (ER_CANT_LOCK)
Can't lock file (errno: %d)
1016 SQLSTATE: HY000 (ER_CANT_OPEN_FILE)
Can't open file: '%s' (errno: %d)
1017 SQLSTATE: HY000 (ER_FILE_NOT_FOUND)
Can't find file: '%s' (errno: %d)
1018 SQLSTATE: HY000 (ER_CANT_READ_DIR)
Can't read dir of '%s' (errno: %d)
1019 SQLSTATE: HY000 (ER_CANT_SET_WD)
Can't change dir to '%s' (errno: %d)
1020 SQLSTATE: HY000 (ER_CHECKREAD)
Record has changed since last read in table '%s'
1021 SQLSTATE: HY000 (ER_DISK_FULL)
Disk full (%s); waiting for someone to free some space...
1022 SQLSTATE: 23000 (ER_DUP_KEY)
Can't write; duplicate key in table '%s'
1023 SQLSTATE: HY000 (ER_ERROR_ON_CLOSE)
Error on close of '%s' (errno: %d)
1024 SQLSTATE: HY000 (ER_ERROR_ON_READ)
Error reading file '%s' (errno: %d)
1025 SQLSTATE: HY000 (ER_ERROR_ON_RENAME)
Error on rename of '%s' to '%s' (errno: %d)
1026 SQLSTATE: HY000 (ER_ERROR_ON_WRITE)
Error writing file '%s' (errno: %d)
1027 SQLSTATE: HY000 (ER_FILE_USED)
'%s' is locked against change
1028 SQLSTATE: HY000 (ER_FILSORT_ABORT)
Sort aborted
1029 SQLSTATE: HY000 (ER_FORM_NOT_FOUND)
View '%s' doesn't exist for '%s'
1030 SQLSTATE: HY000 (ER_GET_ERRNO)
Got error %d from storage engine
1031 SQLSTATE: HY000 (ER_ILLEGAL_HA)
Table storage engine for '%s' doesn't have this option
1032 SQLSTATE: HY000 (ER_KEY_NOT_FOUND)
Can't find record in '%s'
1033 SQLSTATE: HY000 (ER_NOT_FORM_FILE)
Incorrect information in file: '%s'
1034 SQLSTATE: HY000 (ER_NOT_KEYFILE)
Incorrect key file for table '%s'; try to repair it
1035 SQLSTATE: HY000 (ER_OLD_KEYFILE)
Old key file for table '%s'; repair it!
1036 SQLSTATE: HY000 (ER_OPEN_AS_READONLY)
Table '%s' is read only
1037 SQLSTATE: HY001 (ER_OUTOFMEMORY)
Out of memory; restart server and try again (needed %d bytes)
1038 SQLSTATE: HY001 (ER_OUT_OF_SORTMEMORY)
Out of sort memory; increase server sort buffer size
1039 SQLSTATE: HY000 (ER_UNEXPECTED_EOF)
Unexpected EOF found when reading file '%s' (errno: %d)
1040 SQLSTATE: 08004 (ER_CON_COUNT_ERROR)
Too many connections
1041 SQLSTATE: HY000 (ER_OUT_OF_RESOURCES)
: 1042 SQLSTATE: 08S01 (ER_BAD_HOST_ERROR)
Can't get hostname for your address
1043 SQLSTATE: 08S01 (ER_HANDSHAKE_ERROR)
Bad handshake
1044 SQLSTATE: 42000 (ER_DBACCESS_DENIED_ERROR)
Access denied for user '%s'@'%s' to database '%s'
1045 SQLSTATE: 28000 (ER_ACCESS_DENIED_ERROR)
Access denied for user '%s'@'%s' (using password: %s)
1046 SQLSTATE: 3D000 (ER_NO_DB_ERROR)
No database selected
1047 SQLSTATE: 08S01 (ER_UNKNOWN_COM_ERROR)
Unknown command
1048 SQLSTATE: 23000 (ER_BAD_NULL_ERROR)
Column '%s' cannot be null
1049 SQLSTATE: 42000 (ER_BAD_DB_ERROR)
Unknown database '%s'
1050 SQLSTATE: 42S01 (ER_TABLE_EXISTS_ERROR)
Table '%s' already exists
1051 SQLSTATE: 42S02 (ER_BAD_TABLE_ERROR)
Unknown table '%s'
1052 SQLSTATE: 23000 (ER_NON_UNIQ_ERROR)
Column '%s' in %s is ambiguous
1053 SQLSTATE: 08S01 (ER_SERVER_SHUTDOWN)
Server shutdown in progress
1054 SQLSTATE: 42S22 (ER_BAD_FIELD_ERROR)
Unknown column '%s' in '%s'
1055 SQLSTATE: 42000 (ER_WRONG_FIELD_WITH_GROUP)
'%s' isn't in GROUP BY
1056 SQLSTATE: 42000 (ER_WRONG_GROUP_FIELD)
Can't group on '%s'
1057 SQLSTATE: 42000 (ER_WRONG_SUM_SELECT)
Statement has sum functions and columns in same statement
1058 SQLSTATE: 21S01 (ER_WRONG_VALUE_COUNT)
Column count doesn't match value count
1059 SQLSTATE: 42000 (ER_TOO_LONG_IDENT)
Identifier name '%s' is too long
1060 SQLSTATE: 42S21 (ER_DUP_FIELDNAME)
Duplicate column name '%s'
1061 SQLSTATE: 42000 (ER_DUP_KEYNAME)
Duplicate key name '%s'
1062 SQLSTATE: 23000 (ER_DUP_ENTRY)
Duplicate entry '%s' for key %d
1063 SQLSTATE: 42000 (ER_WRONG_FIELD_SPEC)
Incorrect column specifier for column '%s'
1064 SQLSTATE: 42000 (ER_PARSE_ERROR)
%s near '%s' at line %d
1065 SQLSTATE: 42000 (ER_EMPTY_QUERY)
Query was empty
1066 SQLSTATE: 42000 (ER_NONUNIQ_TABLE)
Not unique table/alias: '%s'
1067 SQLSTATE: 42000 (ER_INVALID_DEFAULT)
Invalid default value for '%s'
1068 SQLSTATE: 42000 (ER_MULTIPLE_PRI_KEY)
Multiple primary key defined
1069 SQLSTATE: 42000 (ER_TOO_MANY_KEYS)
Too many keys specified; max %d keys allowed
1070 SQLSTATE: 42000 (ER_TOO_MANY_KEY_PARTS)
Too many key parts specified; max %d parts allowed
1071 SQLSTATE: 42000 (ER_TOO_LONG_KEY)
Specified key was too long; max key length is %d bytes
1072 SQLSTATE: 42000 (ER_KEY_COLUMN_DOES_NOT_EXITS)
Key column '%s' doesn't exist in table
1073 SQLSTATE: 42000 (ER_BLOB_USED_AS_KEY)
BLOB column '%s' can't be used in key specification with the used table type
1074 SQLSTATE: 42000 (ER_TOO_BIG_FIELDLENGTH)
Column length too big for column '%s' (max = %lu); use BLOB or TEXT instead
1075 SQLSTATE: 42000 (ER_WRONG_AUTO_KEY)
Incorrect table definition; there can be only one auto column and it must be defined as a key
1076 SQLSTATE: HY000 (ER_READY)
%s: ready for connections. Version: '%s' socket: '%s' port: %d
1077 SQLSTATE: HY000 (ER_NORMAL_SHUTDOWN)
%s: Normal shutdown
1078 SQLSTATE: HY000 (ER_GOT_SIGNAL)
%s: Got signal %d. Aborting!
1079 SQLSTATE: HY000 (ER_SHUTDOWN_COMPLETE)
%s: Shutdown complete
1080 SQLSTATE: 08S01 (ER_FORCING_CLOSE)
%s: Forcing close of thread %ld user: '%s'
1081 SQLSTATE: 08S01 (ER_IPSOCK_ERROR)
Can't create IP socket
1082 SQLSTATE: 42S12 (ER_NO_SUCH_INDEX)
Table '%s' has no index like the one used in CREATE INDEX; recreate the table
1083 SQLSTATE: 42000 (ER_WRONG_FIELD_TERMINATORS)
Field separator argument is not what is expected; check the manual
1084 SQLSTATE: 42000 (ER_BLOBS_AND_NO_TERMINATED)
You can't use fixed rowlength with BLOBs; please use 'fields terminated by'
1085 SQLSTATE: HY000 (ER_TEXTFILE_NOT_READABLE)
The file '%s' must be in the database directory or be readable by all
1086 SQLSTATE: HY000 (ER_FILE_EXISTS_ERROR)
File '%s' already exists
1087 SQLSTATE: HY000 (ER_LOAD_INFO)
Records: %ld Deleted: %ld Skipped: %ld Warnings: %ld
1088 SQLSTATE: HY000 (ER_ALTER_INFO)
Records: %ld Duplicates: %ld
1089 SQLSTATE: HY000 (ER_WRONG_SUB_KEY)
Incorrect prefix key; the used key part isn't a string, the used length is longer than the key part, or the storage engine doesn't support unique prefix keys
1090 SQLSTATE: 42000 (ER_CANT_REMOVE_ALL_FIELDS)
You can't delete all columns with ALTER TABLE; use DROP TABLE instead
1091 SQLSTATE: 42000 (ER_CANT_DROP_FIELD_OR_KEY)
Can't DROP '%s'; check that column/key exists
1092 SQLSTATE: HY000 (ER_INSERT_INFO)
Records: %ld Duplicates: %ld Warnings: %ld
1093 SQLSTATE: HY000 (ER_UPDATE_TABLE_USED)
You can't specify target table '%s' for update in FROM clause
1094 SQLSTATE: HY000 (ER_NO_SUCH_THREAD)
Unknown thread id: %lu
1095 SQLSTATE: HY000 (ER_KILL_DENIED_ERROR)
You are not owner of thread %lu
1096 SQLSTATE: HY000 (ER_NO_TABLES_USED)
No tables used
1097 SQLSTATE: HY000 (ER_TOO_BIG_SET)
Too many strings for column %s and SET
1098 SQLSTATE: HY000 (ER_NO_UNIQUE_LOGFILE)
Can't generate a unique log-filename %s.(1-999)
1099 SQLSTATE: HY000 (ER_TABLE_NOT_LOCKED_FOR_WRITE)
Table '%s' was locked with a READ lock and can't be updated
1100 SQLSTATE: HY000 (ER_TABLE_NOT_LOCKED)
Table '%s' was not locked with LOCK TABLES
1101 SQLSTATE: 42000 (ER_BLOB_CANT_HAVE_DEFAULT)
BLOB/TEXT column '%s' can't have a default value
1102 SQLSTATE: 42000 (ER_WRONG_DB_NAME)
Incorrect database name '%s'
1103 SQLSTATE: 42000 (ER_WRONG_TABLE_NAME)
Incorrect table name '%s'
1104 SQLSTATE: 42000 (ER_TOO_BIG_SELECT)
The SELECT would examine more than MAX_JOIN_SIZE rows; check your WHERE and use SET SQL_BIG_SELECTS=1 or SET SQL_MAX_JOIN_SIZE=# if the SELECT is okay
1105 SQLSTATE: HY000 (ER_UNKNOWN_ERROR)
Unknown error
1106 SQLSTATE: 42000 (ER_UNKNOWN_PROCEDURE)
Unknown procedure '%s'
1107 SQLSTATE: 42000 (ER_WRONG_PARAMCOUNT_TO_PROCEDURE)
Incorrect parameter count to procedure '%s'
1108 SQLSTATE: HY000 (ER_WRONG_PARAMETERS_TO_PROCEDURE)
Incorrect parameters to procedure '%s'
1109 SQLSTATE: 42S02 (ER_UNKNOWN_TABLE)
Unknown table '%s' in %s
1110 SQLSTATE: 42000 (ER_FIELD_SPECIFIED_TWICE)
Column '%s' specified twice
1111 SQLSTATE: HY000 (ER_INVALID_GROUP_FUNC_USE)
Invalid use of group function
1112 SQLSTATE: 42000 (ER_UNSUPPORTED_EXTENSION)
Table '%s' uses an extension that doesn't exist in this MySQL version
1113 SQLSTATE: 42000 (ER_TABLE_MUST_HAVE_COLUMNS)
A table must have at least 1 column
1114 SQLSTATE: HY000 (ER_RECORD_FILE_FULL)
The table '%s' is full
1115 SQLSTATE: 42000 (ER_UNKNOWN_CHARACTER_SET)
Unknown character set: '%s'
1116 SQLSTATE: HY000 (ER_TOO_MANY_TABLES)
Too many tables; MySQL can only use %d tables in a join
1117 SQLSTATE: HY000 (ER_TOO_MANY_FIELDS)
Too many columns
1118 SQLSTATE: 42000 (ER_TOO_BIG_ROWSIZE)
Row size too large. The maximum row size for the used table type, not counting BLOBs, is %ld. You have to change some columns to TEXT or BLOBs
1119 SQLSTATE: HY000 (ER_STACK_OVERRUN)
Thread stack overrun: Used: %ld of a %ld stack. Use 'mysqld -O thread_stack=#' to specify a bigger stack if needed
1120 SQLSTATE: 42000 (ER_WRONG_OUTER_JOIN)
Cross dependency found in OUTER JOIN; examine your ON conditions
1121 SQLSTATE: 42000 (ER_NULL_COLUMN_IN_INDEX)
Table handler doesn't support NULL in given index. Please change column '%s' to be NOT NULL or use another handler
1122 SQLSTATE: HY000 (ER_CANT_FIND_UDF)
Can't load function '%s'
1123 SQLSTATE: HY000 (ER_CANT_INITIALIZE_UDF)
Can't initialize function '%s'; %s
1124 SQLSTATE: HY000 (ER_UDF_NO_PATHS)
No paths allowed for shared library
1125 SQLSTATE: HY000 (ER_UDF_EXISTS)
Function '%s' already exists
1126 SQLSTATE: HY000 (ER_CANT_OPEN_LIBRARY)
Can't open shared library '%s' (errno: %d %s)
1127 SQLSTATE: HY000 (ER_CANT_FIND_DL_ENTRY)
Can't find symbol '%s' in library
1128 SQLSTATE: HY000 (ER_FUNCTION_NOT_DEFINED)
Function '%s' is not defined
1129 SQLSTATE: HY000 (ER_HOST_IS_BLOCKED)
Host '%s' is blocked because of many connection errors; unblock with 'mysqladmin flush-hosts'
1130 SQLSTATE: HY000 (ER_HOST_NOT_PRIVILEGED)
Host '%s' is not allowed to connect to this MySQL server
1131 SQLSTATE: 42000 (ER_PASSWORD_ANONYMOUS_USER)
You are using MySQL as an anonymous user and anonymous users are not allowed to change passwords
1132 SQLSTATE: 42000 (ER_PASSWORD_NOT_ALLOWED)
You must have privileges to update tables in the mysql database to be able to change passwords for others
1133 SQLSTATE: 42000 (ER_PASSWORD_NO_MATCH)
Can't find any matching row in the user table
1134 SQLSTATE: HY000 (ER_UPDATE_INFO)
Rows matched: %ld Changed: %ld Warnings: %ld
1135 SQLSTATE: HY000 (ER_CANT_CREATE_THREAD)
Can't create a new thread (errno %d); if you are not out of available memory, you can consult the manual for a possible OS-dependent bug
1136 SQLSTATE: 21S01 (ER_WRONG_VALUE_COUNT_ON_ROW)
Column count doesn't match value count at row %ld
1137 SQLSTATE: HY000 (ER_CANT_REOPEN_TABLE)
Can't reopen table: '%s'
1138 SQLSTATE: 22004 (ER_INVALID_USE_OF_NULL)
Invalid use of NULL value
1139 SQLSTATE: 42000 (ER_REGEXP_ERROR)
Got error '%s' from regexp
1140 SQLSTATE: 42000 (ER_MIX_OF_GROUP_FUNC_AND_FIELDS)
Mixing of GROUP columns (MIN(),MAX(),COUNT(),...) with no GROUP columns is illegal if there is no GROUP BY clause
1141 SQLSTATE: 42000 (ER_NONEXISTING_GRANT)
There is no such grant defined for user '%s' on host '%s'
1142 SQLSTATE: 42000 (ER_TABLEACCESS_DENIED_ERROR)
%s command denied to user '%s'@'%s' for table '%s'
1143 SQLSTATE: 42000 (ER_COLUMNACCESS_DENIED_ERROR)
%s command denied to user '%s'@'%s' for column '%s' in table '%s'
1144 SQLSTATE: 42000 (ER_ILLEGAL_GRANT_FOR_TABLE)
Illegal GRANT/REVOKE command; please consult the manual to see which privileges can be used
1145 SQLSTATE: 42000 (ER_GRANT_WRONG_HOST_OR_USER)
The host or user argument to GRANT is too long
1146 SQLSTATE: 42S02 (ER_NO_SUCH_TABLE)
Table '%s.%s' doesn't exist
1147 SQLSTATE: 42000 (ER_NONEXISTING_TABLE_GRANT)
There is no such grant defined for user '%s' on host '%s' on table '%s'
1148 SQLSTATE: 42000 (ER_NOT_ALLOWED_COMMAND)
The used command is not allowed with this MySQL version
1149 SQLSTATE: 42000 (ER_SYNTAX_ERROR)
You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use
1150 SQLSTATE: HY000 (ER_DELAYED_CANT_CHANGE_LOCK)
Delayed insert thread couldn't get requested lock for table %s
1151 SQLSTATE: HY000 (ER_TOO_MANY_DELAYED_THREADS)
Too many delayed threads in use
1152 SQLSTATE: 08S01 (ER_ABORTING_CONNECTION)
Aborted connection %ld to db: '%s' user: '%s' (%s)
1153 SQLSTATE: 08S01 (ER_NET_PACKET_TOO_LARGE)
Got a packet bigger than 'max_allowed_packet' bytes
1154 SQLSTATE: 08S01 (ER_NET_READ_ERROR_FROM_PIPE)
Got a read error from the connection pipe
1155 SQLSTATE: 08S01 (ER_NET_FCNTL_ERROR)
Got an error from fcntl()
1156 SQLSTATE: 08S01 (ER_NET_PACKETS_OUT_OF_ORDER)
Got packets out of order
1157 SQLSTATE: 08S01 (ER_NET_UNCOMPRESS_ERROR)
Couldn't uncompress communication packet
1158 SQLSTATE: 08S01 (ER_NET_READ_ERROR)
Got an error reading communication packets
1159 SQLSTATE: 08S01 (ER_NET_READ_INTERRUPTED)
Got timeout reading communication packets
1160 SQLSTATE: 08S01 (ER_NET_ERROR_ON_WRITE)
Got an error writing communication packets
1161 SQLSTATE: 08S01 (ER_NET_WRITE_INTERRUPTED)
Got timeout writing communication packets
1162 SQLSTATE: 42000 (ER_TOO_LONG_STRING)
Result string is longer than 'max_allowed_packet' bytes
1163 SQLSTATE: 42000 (ER_TABLE_CANT_HANDLE_BLOB)
The used table type doesn't support BLOB/TEXT columns
1164 SQLSTATE: 42000 (ER_TABLE_CANT_HANDLE_AUTO_INCREMENT)
The used table type doesn't support AUTO_INCREMENT columns
1165 SQLSTATE: HY000 (ER_DELAYED_INSERT_TABLE_LOCKED)
INSERT DELAYED can't be used with table '%s' because it is locked with LOCK TABLES
1166 SQLSTATE: 42000 (ER_WRONG_COLUMN_NAME)
Incorrect column name '%s'
1167 SQLSTATE: 42000 (ER_WRONG_KEY_COLUMN)
The used storage engine can't index column '%s'
1168 SQLSTATE: HY000 (ER_WRONG_MRG_TABLE)
Unable to open underlying table which is differently defined or of non-MyISAM type or doesn't exist
1169 SQLSTATE: 23000 (ER_DUP_UNIQUE)
Can't write, because of unique constraint, to table '%s'
1170 SQLSTATE: 42000 (ER_BLOB_KEY_WITHOUT_LENGTH)
BLOB/TEXT column '%s' used in key specification without a key length
1171 SQLSTATE: 42000 (ER_PRIMARY_CANT_HAVE_NULL)
All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead
1172 SQLSTATE: 42000 (ER_TOO_MANY_ROWS)
Result consisted of more than one row
1173 SQLSTATE: 42000 (ER_REQUIRES_PRIMARY_KEY)
This table type requires a primary key
1174 SQLSTATE: HY000 (ER_NO_RAID_COMPILED)
This version of MySQL is not compiled with RAID support
1175 SQLSTATE: HY000 (ER_UPDATE_WITHOUT_KEY_IN_SAFE_MODE)
You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column
1176 SQLSTATE: 42000 (ER_KEY_DOES_NOT_EXITS)
Key '%s' doesn't exist in table '%s'
1177 SQLSTATE: 42000 (ER_CHECK_NO_SUCH_TABLE)
Can't open table
1178 SQLSTATE: 42000 (ER_CHECK_NOT_IMPLEMENTED)
The storage engine for the table doesn't support %s
1179 SQLSTATE: 25000 (ER_CANT_DO_THIS_DURING_AN_TRANSACTION)
You are not allowed to execute this command in a transaction
1180 SQLSTATE: HY000 (ER_ERROR_DURING_COMMIT)
Got error %d during COMMIT
1181 SQLSTATE: HY000 (ER_ERROR_DURING_ROLLBACK)
Got error %d during ROLLBACK
1182 SQLSTATE: HY000 (ER_ERROR_DURING_FLUSH_LOGS)
Got error %d during FLUSH_LOGS
1183 SQLSTATE: HY000 (ER_ERROR_DURING_CHECKPOINT)
Got error %d during CHECKPOINT
1184 SQLSTATE: 08S01 (ER_NEW_ABORTING_CONNECTION)
Aborted connection %ld to db: '%s' user: '%s' host: '%s' (%s)
1185 SQLSTATE: HY000 (ER_DUMP_NOT_IMPLEMENTED)
The storage engine for the table does not support binary table dump
1186 SQLSTATE: HY000 (ER_FLUSH_MASTER_BINLOG_CLOSED)
Binlog closed, cannot RESET MASTER
1187 SQLSTATE: HY000 (ER_INDEX_REBUILD)
Failed rebuilding the index of dumped table '%s'
1188 SQLSTATE: HY000 (ER_MASTER)
Error from master: '%s'
1189 SQLSTATE: 08S01 (ER_MASTER_NET_READ)
Net error reading from master
1190 SQLSTATE: 08S01 (ER_MASTER_NET_WRITE)
Net error writing to master
1191 SQLSTATE: HY000 (ER_FT_MATCHING_KEY_NOT_FOUND)
Can't find FULLTEXT index matching the column list
1192 SQLSTATE: HY000 (ER_LOCK_OR_ACTIVE_TRANSACTION)
Can't execute the given command because you have active locked tables or an active transaction
1193 SQLSTATE: HY000 (ER_UNKNOWN_SYSTEM_VARIABLE)
Unknown system variable '%s'
1194 SQLSTATE: HY000 (ER_CRASHED_ON_USAGE)
Table '%s' is marked as crashed and should be repaired
1195 SQLSTATE: HY000 (ER_CRASHED_ON_REPAIR)
Table '%s' is marked as crashed and last (automatic?) repair failed
1196 SQLSTATE: HY000 (ER_WARNING_NOT_COMPLETE_ROLLBACK)
Some non-transactional changed tables couldn't be rolled back
1197 SQLSTATE: HY000 (ER_TRANS_CACHE_FULL)
Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage; increase this mysqld variable and try again
1198 SQLSTATE: HY000 (ER_SLAVE_MUST_STOP)
This operation cannot be performed with a running slave; run STOP SLAVE first
1199 SQLSTATE: HY000 (ER_SLAVE_NOT_RUNNING)
This operation requires a running slave; configure slave and do START SLAVE
1200 SQLSTATE: HY000 (ER_BAD_SLAVE)
The server is not configured as slave; fix in config file or with CHANGE MASTER TO
1201 SQLSTATE: HY000 (ER_MASTER_INFO)
Could not initialize master info structure; more error messages can be found in the MySQL error log
1202 SQLSTATE: HY000 (ER_SLAVE_THREAD)
Could not create slave thread; check system resources
1203 SQLSTATE: 42000 (ER_TOO_MANY_USER_CONNECTIONS)
User %s already has more than 'max_user_connections' active connections
1204 SQLSTATE: HY000 (ER_SET_CONSTANTS_ONLY)
You may only use constant expressions with SET
1205 SQLSTATE: HY000 (ER_LOCK_WAIT_TIMEOUT)
Lock wait timeout exceeded; try restarting transaction
1206 SQLSTATE: HY000 (ER_LOCK_TABLE_FULL)
The total number of locks exceeds the lock table size
1207 SQLSTATE: 25000 (ER_READ_ONLY_TRANSACTION)
Update locks cannot be acquired during a READ UNCOMMITTED transaction
1208 SQLSTATE: HY000 (ER_DROP_DB_WITH_READ_LOCK)
DROP DATABASE not allowed while thread is holding global read lock
1209 SQLSTATE: HY000 (ER_CREATE_DB_WITH_READ_LOCK)
CREATE DATABASE not allowed while thread is holding global read lock
1210 SQLSTATE: HY000 (ER_WRONG_ARGUMENTS)
Incorrect arguments to %s
1211 SQLSTATE: 42000 (ER_NO_PERMISSION_TO_CREATE_USER)
'%s'@'%s' is not allowed to create new users
1212 SQLSTATE: HY000 (ER_UNION_TABLES_IN_DIFFERENT_DIR)
Incorrect table definition; all MERGE tables must be in the same database
1213 SQLSTATE: 40001 (ER_LOCK_DEADLOCK)
Deadlock found when trying to get lock; try restarting transaction
1214 SQLSTATE: HY000 (ER_TABLE_CANT_HANDLE_FT)
The used table type doesn't support FULLTEXT indexes
1215 SQLSTATE: HY000 (ER_CANNOT_ADD_FOREIGN)
Cannot add foreign key constraint
1216 SQLSTATE: 23000 (ER_NO_REFERENCED_ROW)
Cannot add or update a child row: a foreign key constraint fails
1217 SQLSTATE: 23000 (ER_ROW_IS_REFERENCED)
Cannot delete or update a parent row: a foreign key constraint fails
1218 SQLSTATE: 08S01 (ER_CONNECT_TO_MASTER)
Error connecting to master: %s
1219 SQLSTATE: HY000 (ER_QUERY_ON_MASTER)
Error running query on master: %s
1220 SQLSTATE: HY000 (ER_ERROR_WHEN_EXECUTING_COMMAND)
Error when executing command %s: %s
1221 SQLSTATE: HY000 (ER_WRONG_USAGE)
Incorrect usage of %s and %s
1222 SQLSTATE: 21000 (ER_WRONG_NUMBER_OF_COLUMNS_IN_SELECT)
The used SELECT statements have a different number of columns
1223 SQLSTATE: HY000 (ER_CANT_UPDATE_WITH_READLOCK)
Can't execute the query because you have a conflicting read lock
1224 SQLSTATE: HY000 (ER_MIXING_NOT_ALLOWED)
Mixing of transactional and non-transactional tables is disabled
1225 SQLSTATE: HY000 (ER_DUP_ARGUMENT)
Option '%s' used twice in statement
1226 SQLSTATE: 42000 (ER_USER_LIMIT_REACHED)
User '%s' has exceeded the '%s' resource (current value: %ld)
1227 SQLSTATE: 42000 (ER_SPECIFIC_ACCESS_DENIED_ERROR)
Access denied; you need the %s privilege for this operation
1228 SQLSTATE: HY000 (ER_LOCAL_VARIABLE)
Variable '%s' is a SESSION variable and can't be used with SET GLOBAL
1229 SQLSTATE: HY000 (ER_GLOBAL_VARIABLE)
Variable '%s' is a GLOBAL variable and should be set with SET GLOBAL
1230 SQLSTATE: 42000 (ER_NO_DEFAULT)
Variable '%s' doesn't have a default value
1231 SQLSTATE: 42000 (ER_WRONG_VALUE_FOR_VAR)
Variable '%s' can't be set to the value of '%s'
1232 SQLSTATE: 42000 (ER_WRONG_TYPE_FOR_VAR)
Incorrect argument type to variable '%s'
1233 SQLSTATE: HY000 (ER_VAR_CANT_BE_READ)
Variable '%s' can only be set, not read
1234 SQLSTATE: 42000 (ER_CANT_USE_OPTION_HERE)
Incorrect usage/placement of '%s'
1235 SQLSTATE: 42000 (ER_NOT_SUPPORTED_YET)
This version of MySQL doesn't yet support '%s'
1236 SQLSTATE: HY000 (ER_MASTER_FATAL_ERROR_READING_BINLOG)
Got fatal error %d from master when reading data from binary log: '%s'
1237 SQLSTATE: HY000 (ER_SLAVE_IGNORED_TABLE)
Slave SQL thread ignored the query because of replicate-*-table rules
1238 SQLSTATE: HY000 (ER_INCORRECT_GLOBAL_LOCAL_VAR)
Variable '%s' is a %s variable
1239 SQLSTATE: 42000 (ER_WRONG_FK_DEF)
Incorrect foreign key definition for '%s': %s
1240 SQLSTATE: HY000 (ER_KEY_REF_DO_NOT_MATCH_TABLE_REF)
Key reference and table reference don't match
1241 SQLSTATE: 21000 (ER_OPERAND_COLUMNS)
Operand should contain %d column(s)
1242 SQLSTATE: 21000 (ER_SUBQUERY_NO_1_ROW)
Subquery returns more than 1 row
1243 SQLSTATE: HY000 (ER_UNKNOWN_STMT_HANDLER)
Unknown prepared statement handler (%.*s) given to %s
1244 SQLSTATE: HY000 (ER_CORRUPT_HELP_DB)
Help database is corrupt or does not exist
1245 SQLSTATE: HY000 (ER_CYCLIC_REFERENCE)
Cyclic reference on subqueries
1246 SQLSTATE: HY000 (ER_AUTO_CONVERT)
Converting column '%s' from %s to %s
1247 SQLSTATE: 42S22 (ER_ILLEGAL_REFERENCE)
Reference '%s' not supported (%s)
1248 SQLSTATE: 42000 (ER_DERIVED_MUST_HAVE_ALIAS)
Every derived table must have its own alias
1249 SQLSTATE: 01000 (ER_SELECT_REDUCED)
Select %u was reduced during optimization
1250 SQLSTATE: 42000 (ER_TABLENAME_NOT_ALLOWED_HERE)
Table '%s' from one of the SELECTs cannot be used in %s
1251 SQLSTATE: 08004 (ER_NOT_SUPPORTED_AUTH_MODE)
Client does not support authentication protocol requested by server; consider upgrading MySQL client
1252 SQLSTATE: 42000 (ER_SPATIAL_CANT_HAVE_NULL)
All parts of a SPATIAL index must be NOT NULL
1253 SQLSTATE: 42000 (ER_COLLATION_CHARSET_MISMATCH)
COLLATION '%s' is not valid for CHARACTER SET '%s'
1254 SQLSTATE: HY000 (ER_SLAVE_WAS_RUNNING)
Slave is already running
1255 SQLSTATE: HY000 (ER_SLAVE_WAS_NOT_RUNNING)
Slave already has been stopped
1256 SQLSTATE: HY000 (ER_TOO_BIG_FOR_UNCOMPRESS)
Uncompressed data size too large; the maximum size is %d (probably, length of uncompressed data was corrupted)
1257 SQLSTATE: HY000 (ER_ZLIB_Z_MEM_ERROR)
ZLIB: Not enough memory
1258 SQLSTATE: HY000 (ER_ZLIB_Z_BUF_ERROR)
ZLIB: Not enough room in the output buffer (probably, length of uncompressed data was corrupted)
1259 SQLSTATE: HY000 (ER_ZLIB_Z_DATA_ERROR)
ZLIB: Input data corrupted
1260 SQLSTATE: HY000 (ER_CUT_VALUE_GROUP_CONCAT)
%d line(s) were cut by GROUP_CONCAT()
1261 SQLSTATE: 01000 (ER_WARN_TOO_FEW_RECORDS)
Row %ld doesn't contain data for all columns
1262 SQLSTATE: 01000 (ER_WARN_TOO_MANY_RECORDS)
Row %ld was truncated; it contained more data than there were input columns
1263 SQLSTATE: 22004 (ER_WARN_NULL_TO_NOTNULL)
Column set to default value; NULL supplied to NOT NULL column '%s' at row %ld
1264 SQLSTATE: 22003 (ER_WARN_DATA_OUT_OF_RANGE)
Out of range value for column '%s' at row %ld
1265 SQLSTATE: 01000 (WARN_DATA_TRUNCATED)
Data truncated for column '%s' at row %ld
1266 SQLSTATE: HY000 (ER_WARN_USING_OTHER_HANDLER)
Using storage engine %s for table '%s'
1267 SQLSTATE: HY000 (ER_CANT_AGGREGATE_2COLLATIONS)
Illegal mix of collations (%s,%s) and (%s,%s) for operation '%s'
1268 SQLSTATE: HY000 (ER_DROP_USER)
Cannot drop one or more of the requested users
1269 SQLSTATE: HY000 (ER_REVOKE_GRANTS)
Can't revoke all privileges for one or more of the requested users
1270 SQLSTATE: HY000 (ER_CANT_AGGREGATE_3COLLATIONS)
Illegal mix of collations (%s,%s), (%s,%s), (%s,%s) for operation '%s'
1271 SQLSTATE: HY000 (ER_CANT_AGGREGATE_NCOLLATIONS)
Illegal mix of collations for operation '%s'
1272 SQLSTATE: HY000 (ER_VARIABLE_IS_NOT_STRUCT)
Variable '%s' is not a variable component (can't be used as XXXX.variable_name)
1273 SQLSTATE: HY000 (ER_UNKNOWN_COLLATION)
Unknown collation: '%s'
1274 SQLSTATE: HY000 (ER_SLAVE_IGNORED_SSL_PARAMS)
SSL parameters in CHANGE MASTER are ignored because this MySQL slave was compiled without SSL support; they can be used later if MySQL slave with SSL is started
1275 SQLSTATE: HY000 (ER_SERVER_IS_IN_SECURE_AUTH_MODE)
Server is running in --secure-auth mode, but '%s'@'%s' has a password in the old format; please change the password to the new format
1276 SQLSTATE: HY000 (ER_WARN_FIELD_RESOLVED)
Field or reference '%s%s%s%s%s' of SELECT #%d was resolved in SELECT #%d
1277 SQLSTATE: HY000 (ER_BAD_SLAVE_UNTIL_COND)
Incorrect parameter or combination of parameters for START SLAVE UNTIL
1278 SQLSTATE: HY000 (ER_MISSING_SKIP_SLAVE)
It is recommended to use --skip-slave-start when doing step-by-step replication with START SLAVE UNTIL; otherwise, you will get problems if you get an unexpected slave's mysqld restart
1279 SQLSTATE: HY000 (ER_UNTIL_COND_IGNORED)
SQL thread is not to be started so UNTIL options are ignored
1280 SQLSTATE: 42000 (ER_WRONG_NAME_FOR_INDEX)
Incorrect index name '%s'
1281 SQLSTATE: 42000 (ER_WRONG_NAME_FOR_CATALOG)
Incorrect catalog name '%s'
1282 SQLSTATE: HY000 (ER_WARN_QC_RESIZE)
Query cache failed to set size %lu; new query cache size is %lu
1283 SQLSTATE: HY000 (ER_BAD_FT_COLUMN)
Column '%s' cannot be part of FULLTEXT index
1284 SQLSTATE: HY000 (ER_UNKNOWN_KEY_CACHE)
Unknown key cache '%s'
1285 SQLSTATE: HY000 (ER_WARN_HOSTNAME_WONT_WORK)
MySQL is started in --skip-name-resolve mode; you must restart it without this switch for this grant to work
1286 SQLSTATE: 42000 (ER_UNKNOWN_STORAGE_ENGINE)
Unknown table engine '%s'
1287 SQLSTATE: HY000 (ER_WARN_DEPRECATED_SYNTAX)
'%s' is deprecated; use '%s' instead
1288 SQLSTATE: HY000 (ER_NON_UPDATABLE_TABLE)
The target table %s of the %s is not updatable
1289 SQLSTATE: HY000 (ER_FEATURE_DISABLED)
The '%s' feature is disabled; you need MySQL built with '%s' to have it working
1290 SQLSTATE: HY000 (ER_OPTION_PREVENTS_STATEMENT)
The MySQL server is running with the %s option so it cannot execute this statement
1291 SQLSTATE: HY000 (ER_DUPLICATED_VALUE_IN_TYPE)
Column '%s' has duplicated value '%s' in %s
1292 SQLSTATE: 22007 (ER_TRUNCATED_WRONG_VALUE)
Truncated incorrect %s value: '%s'
1293 SQLSTATE: HY000 (ER_TOO_MUCH_AUTO_TIMESTAMP_COLS)
Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause
1294 SQLSTATE: HY000 (ER_INVALID_ON_UPDATE)
Invalid ON UPDATE clause for '%s' column
1295 SQLSTATE: HY000 (ER_UNSUPPORTED_PS)
This command is not supported in the prepared statement protocol yet
1296 SQLSTATE: HY000 (ER_GET_ERRMSG)
Got error %d '%s' from %s
1297 SQLSTATE: HY000 (ER_GET_TEMPORARY_ERRMSG)
Got temporary error %d '%s' from %s
1298 SQLSTATE: HY000 (ER_UNKNOWN_TIME_ZONE)
Unknown or incorrect time zone: '%s'
1299 SQLSTATE: HY000 (ER_WARN_INVALID_TIMESTAMP)
Invalid TIMESTAMP value in column '%s' at row %ld
1300 SQLSTATE: HY000 (ER_INVALID_CHARACTER_STRING)
Invalid %s character string: '%s'
1301 SQLSTATE: HY000 (ER_WARN_ALLOWED_PACKET_OVERFLOWED)
Result of %s() was larger than max_allowed_packet (%ld) - truncated
1302 SQLSTATE: HY000 (ER_CONFLICTING_DECLARATIONS)
Conflicting declarations: '%s%s' and '%s%s'
1303 SQLSTATE: 2F003 (ER_SP_NO_RECURSIVE_CREATE)
Can't create a %s from within another stored routine
1304 SQLSTATE: 42000 (ER_SP_ALREADY_EXISTS)
%s %s already exists
1305 SQLSTATE: 42000 (ER_SP_DOES_NOT_EXIST)
%s %s does not exist
1306 SQLSTATE: HY000 (ER_SP_DROP_FAILED)
Failed to DROP %s %s
1307 SQLSTATE: HY000 (ER_SP_STORE_FAILED)
Failed to CREATE %s %s
1308 SQLSTATE: 42000 (ER_SP_LILABEL_MISMATCH)
%s with no matching label: %s
1309 SQLSTATE: 42000 (ER_SP_LABEL_REDEFINE)
Redefining label %s
1310 SQLSTATE: 42000 (ER_SP_LABEL_MISMATCH)
End-label %s without match
1311 SQLSTATE: 01000 (ER_SP_UNINIT_VAR)
Referring to uninitialized variable %s
1312 SQLSTATE: 0A000 (ER_SP_BADSELECT)
PROCEDURE %s can't return a result set in the given context
1313 SQLSTATE: 42000 (ER_SP_BADRETURN)
RETURN is only allowed in a FUNCTION
1314 SQLSTATE: 0A000 (ER_SP_BADSTATEMENT)
%s is not allowed in stored procedures
1315 SQLSTATE: 42000 (ER_UPDATE_LOG_DEPRECATED_IGNORED)
The update log is deprecated and replaced by the binary log; SET SQL_LOG_UPDATE has been ignored
1316 SQLSTATE: 42000 (ER_UPDATE_LOG_DEPRECATED_TRANSLATED)
The update log is deprecated and replaced by the binary log; SET SQL_LOG_UPDATE has been translated to SET SQL_LOG_BIN
1317 SQLSTATE: 70100 (ER_QUERY_INTERRUPTED)
Query execution was interrupted
1318 SQLSTATE: 42000 (ER_SP_WRONG_NO_OF_ARGS)
Incorrect number of arguments for %s %s; expected %u, got %u
1319 SQLSTATE: 42000 (ER_SP_COND_MISMATCH)
Undefined CONDITION: %s
1320 SQLSTATE: 42000 (ER_SP_NORETURN)
No RETURN found in FUNCTION %s
1321 SQLSTATE: 2F005 (ER_SP_NORETURNEND)
FUNCTION %s ended without RETURN
1322 SQLSTATE: 42000 (ER_SP_BAD_CURSOR_QUERY)
Cursor statement must be a SELECT
1323 SQLSTATE: 42000 (ER_SP_BAD_CURSOR_SELECT)
Cursor SELECT must not have INTO
1324 SQLSTATE: 42000 (ER_SP_CURSOR_MISMATCH)
Undefined CURSOR: %s
1325 SQLSTATE: 24000 (ER_SP_CURSOR_ALREADY_OPEN)
Cursor is already open
1326 SQLSTATE: 24000 (ER_SP_CURSOR_NOT_OPEN)
Cursor is not open
1327 SQLSTATE: 42000 (ER_SP_UNDECLARED_VAR)
Undeclared variable: %s
1328 SQLSTATE: HY000 (ER_SP_WRONG_NO_OF_FETCH_ARGS)
Incorrect number of FETCH variables
1329 SQLSTATE: 02000 (ER_SP_FETCH_NO_DATA)
No data - zero rows fetched, selected, or processed
1330 SQLSTATE: 42000 (ER_SP_DUP_PARAM)
Duplicate parameter: %s
1331 SQLSTATE: 42000 (ER_SP_DUP_VAR)
Duplicate variable: %s
1332 SQLSTATE: 42000 (ER_SP_DUP_COND)
Duplicate condition: %s
1333 SQLSTATE: 42000 (ER_SP_DUP_CURS)
Duplicate cursor: %s
1334 SQLSTATE: HY000 (ER_SP_CANT_ALTER)
Failed to ALTER %s %s
1335 SQLSTATE: 0A000 (ER_SP_SUBSELECT_NYI)
Subquery value not supported
1336 SQLSTATE: 0A000 (ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG)
%s is not allowed in stored function or trigger
1337 SQLSTATE: 42000 (ER_SP_VARCOND_AFTER_CURSHNDLR)
Variable or condition declaration after cursor or handler declaration
1338 SQLSTATE: 42000 (ER_SP_CURSOR_AFTER_HANDLER)
Cursor declaration after handler declaration
1339 SQLSTATE: 20000 (ER_SP_CASE_NOT_FOUND)
Case not found for CASE statement
1340 SQLSTATE: HY000 (ER_FPARSER_TOO_BIG_FILE)
Configuration file '%s' is too big
1341 SQLSTATE: HY000 (ER_FPARSER_BAD_HEADER)
Malformed file type header in file '%s'
1342 SQLSTATE: HY000 (ER_FPARSER_EOF_IN_COMMENT)
Unexpected end of file while parsing comment '%s'
1343 SQLSTATE: HY000 (ER_FPARSER_ERROR_IN_PARAMETER)
Error while parsing parameter '%s' (line: '%s')
1344 SQLSTATE: HY000 (ER_FPARSER_EOF_IN_UNKNOWN_PARAMETER)
Unexpected end of file while skipping unknown parameter '%s'
1345 SQLSTATE: HY000 (ER_VIEW_NO_EXPLAIN)
EXPLAIN/SHOW can not be issued; lacking privileges for underlying table
1346 SQLSTATE: HY000 (ER_FRM_UNKNOWN_TYPE)
File '%s' has unknown type '%s' in its header
1347 SQLSTATE: HY000 (ER_WRONG_OBJECT)
'%s.%s' is not %s
1348 SQLSTATE: HY000 (ER_NONUPDATEABLE_COLUMN)
Column '%s' is not updatable
1349 SQLSTATE: HY000 (ER_VIEW_SELECT_DERIVED)
View's SELECT contains a subquery in the FROM clause
1350 SQLSTATE: HY000 (ER_VIEW_SELECT_CLAUSE)
View's SELECT contains a '%s' clause
1351 SQLSTATE: HY000 (ER_VIEW_SELECT_VARIABLE)
View's SELECT contains a variable or parameter
1352 SQLSTATE: HY000 (ER_VIEW_SELECT_TMPTABLE)
View's SELECT refers to a temporary table '%s'
1353 SQLSTATE: HY000 (ER_VIEW_WRONG_LIST)
View's SELECT and view's field list have different column counts
1354 SQLSTATE: HY000 (ER_WARN_VIEW_MERGE)
View merge algorithm can't be used here for now (assumed undefined algorithm)
1355 SQLSTATE: HY000 (ER_WARN_VIEW_WITHOUT_KEY)
View being updated does not have complete key of underlying table in it
1356 SQLSTATE: HY000 (ER_VIEW_INVALID)
View '%s.%s' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them
1357 SQLSTATE: HY000 (ER_SP_NO_DROP_SP)
Can't drop or alter a %s from within another stored routine
1358 SQLSTATE: HY000 (ER_SP_GOTO_IN_HNDLR)
GOTO is not allowed in a stored procedure handler
1359 SQLSTATE: HY000 (ER_TRG_ALREADY_EXISTS)
Trigger already exists
1360 SQLSTATE: HY000 (ER_TRG_DOES_NOT_EXIST)
Trigger does not exist
1361 SQLSTATE: HY000 (ER_TRG_ON_VIEW_OR_TEMP_TABLE)
Trigger's '%s' is view or temporary table
1362 SQLSTATE: HY000 (ER_TRG_CANT_CHANGE_ROW)
Updating of %s row is not allowed in %strigger
1363 SQLSTATE: HY000 (ER_TRG_NO_SUCH_ROW_IN_TRG)
There is no %s row in %s trigger
1364 SQLSTATE: HY000 (ER_NO_DEFAULT_FOR_FIELD)
Field '%s' doesn't have a default value
1365 SQLSTATE: 22012 (ER_DIVISION_BY_ZERO)
Division by 0
1366 SQLSTATE: HY000 (ER_TRUNCATED_WRONG_VALUE_FOR_FIELD)
Incorrect %s value: '%s' for column '%s' at row %ld
1367 SQLSTATE: 22007 (ER_ILLEGAL_VALUE_FOR_TYPE)
Illegal %s '%s' value found during parsing
1368 SQLSTATE: HY000 (ER_VIEW_NONUPD_CHECK)
CHECK OPTION on non-updatable view '%s.%s'
1369 SQLSTATE: HY000 (ER_VIEW_CHECK_FAILED)
CHECK OPTION failed '%s.%s'
1370 SQLSTATE: 42000 (ER_PROCACCESS_DENIED_ERROR)
%s command denied to user '%s'@'%s' for routine '%s'
1371 SQLSTATE: HY000 (ER_RELAY_LOG_FAIL)
Failed purging old relay logs: %s
1372 SQLSTATE: HY000 (ER_PASSWD_LENGTH)
Password hash should be a %d-digit hexadecimal number
1373 SQLSTATE: HY000 (ER_UNKNOWN_TARGET_BINLOG)
Target log not found in binlog index
1374 SQLSTATE: HY000 (ER_IO_ERR_LOG_INDEX_READ)
I/O error reading log index file
1375 SQLSTATE: HY000 (ER_BINLOG_PURGE_PROHIBITED)
Server configuration does not permit binlog purge
1376 SQLSTATE: HY000 (ER_FSEEK_FAIL)
Failed on fseek()
1377 SQLSTATE: HY000 (ER_BINLOG_PURGE_FATAL_ERR)
Fatal error during log purge
1378 SQLSTATE: HY000 (ER_LOG_IN_USE)
A purgeable log is in use, will not purge
1379 SQLSTATE: HY000 (ER_LOG_PURGE_UNKNOWN_ERR)
Unknown error during log purge
1380 SQLSTATE: HY000 (ER_RELAY_LOG_INIT)
Failed initializing relay log position: %s
1381 SQLSTATE: HY000 (ER_NO_BINARY_LOGGING)
You are not using binary logging
1382 SQLSTATE: HY000 (ER_RESERVED_SYNTAX)
The '%s' syntax is reserved for purposes internal to the MySQL server
1383 SQLSTATE: HY000 (ER_WSAS_FAILED)
WSAStartup Failed
1384 SQLSTATE: HY000 (ER_DIFF_GROUPS_PROC)
Can't handle procedures with different groups yet
1385 SQLSTATE: HY000 (ER_NO_GROUP_FOR_PROC)
Select must have a group with this procedure
1386 SQLSTATE: HY000 (ER_ORDER_WITH_PROC)
Can't use ORDER clause with this procedure
1387 SQLSTATE: HY000 (ER_LOGGING_PROHIBIT_CHANGING_OF)
Binary logging and replication forbid changing the global server %s
1388 SQLSTATE: HY000 (ER_NO_FILE_MAPPING)
Can't map file: %s, errno: %d
1389 SQLSTATE: HY000 (ER_WRONG_MAGIC)
Wrong magic in %s
1390 SQLSTATE: HY000 (ER_PS_MANY_PARAM)
Prepared statement contains too many placeholders
1391 SQLSTATE: HY000 (ER_KEY_PART_0)
Key part '%s' length cannot be 0
1392 SQLSTATE: HY000 (ER_VIEW_CHECKSUM)
View text checksum failed
1393 SQLSTATE: HY000 (ER_VIEW_MULTIUPDATE)
Can not modify more than one base table through a join view '%s.%s'
1394 SQLSTATE: HY000 (ER_VIEW_NO_INSERT_FIELD_LIST)
Can not insert into join view '%s.%s' without fields list
1395 SQLSTATE: HY000 (ER_VIEW_DELETE_MERGE_VIEW)
Can not delete from join view '%s.%s'
1396 SQLSTATE: HY000 (ER_CANNOT_USER)
Operation %s failed for %s
1397 SQLSTATE: XAE04 (ER_XAER_NOTA)
XAER_NOTA: Unknown XID
1398 SQLSTATE: XAE05 (ER_XAER_INVAL)
XAER_INVAL: Invalid arguments (or unsupported command)
1399 SQLSTATE: XAE07 (ER_XAER_RMFAIL)
XAER_RMFAIL: The command cannot be executed when global transaction is in the %s state
1400 SQLSTATE: XAE09 (ER_XAER_OUTSIDE)
XAER_OUTSIDE: Some work is done outside global transaction
1401 SQLSTATE: XAE03 (ER_XAER_RMERR)
XAER_RMERR: Fatal error occurred in the transaction branch - check your data for consistency
1402 SQLSTATE: XA100 (ER_XA_RBROLLBACK)
XA_RBROLLBACK: Transaction branch was rolled back
1403 SQLSTATE: 42000 (ER_NONEXISTING_PROC_GRANT)
There is no such grant defined for user '%s' on host '%s' on routine '%s'
1404 SQLSTATE: HY000 (ER_PROC_AUTO_GRANT_FAIL)
Failed to grant EXECUTE and ALTER ROUTINE privileges
1405 SQLSTATE: HY000 (ER_PROC_AUTO_REVOKE_FAIL)
Failed to revoke all privileges to dropped routine
1406 SQLSTATE: 22001 (ER_DATA_TOO_LONG)
Data too long for column '%s' at row %ld
1407 SQLSTATE: 42000 (ER_SP_BAD_SQLSTATE)
Bad SQLSTATE: '%s'
1408 SQLSTATE: HY000 (ER_STARTUP)
%s: ready for connections. Version: '%s' socket: '%s' port: %d %s
1409 SQLSTATE: HY000 (ER_LOAD_FROM_FIXED_SIZE_ROWS_TO_VAR)
Can't load value from file with fixed size rows to variable
1410 SQLSTATE: 42000 (ER_CANT_CREATE_USER_WITH_GRANT)
You are not allowed to create a user with GRANT
1411 SQLSTATE: HY000 (ER_WRONG_VALUE_FOR_TYPE)
Incorrect %s value: '%s' for function %s
1412 SQLSTATE: HY000 (ER_TABLE_DEF_CHANGED)
Table definition has changed, please retry transaction
1413 SQLSTATE: 42000 (ER_SP_DUP_HANDLER)
Duplicate handler declared in the same block
1414 SQLSTATE: 42000 (ER_SP_NOT_VAR_ARG)
OUT or INOUT argument %d for routine %s is not a variable or NEW pseudo-variable in BEFORE trigger
1415 SQLSTATE: 0A000 (ER_SP_NO_RETSET)
Not allowed to return a result set from a %s
1416 SQLSTATE: 22003 (ER_CANT_CREATE_GEOMETRY_OBJECT)
Cannot get geometry object from data you send to the GEOMETRY field
1417 SQLSTATE: HY000 (ER_FAILED_ROUTINE_BREAK_BINLOG)
A routine failed and has neither NO SQL nor READS SQL DATA in its declaration and binary logging is enabled; if non-transactional tables were updated, the binary log will miss their changes
1418 SQLSTATE: HY000 (ER_BINLOG_UNSAFE_ROUTINE)
This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
1419 SQLSTATE: HY000 (ER_BINLOG_CREATE_ROUTINE_NEED_SUPER)
You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
1420 SQLSTATE: HY000 (ER_EXEC_STMT_WITH_OPEN_CURSOR)
You can't execute a prepared statement which has an open cursor associated with it. Reset the statement to re-execute it.
1421 SQLSTATE: HY000 (ER_STMT_HAS_NO_OPEN_CURSOR)
The statement (%lu) has no open cursor.
1422 SQLSTATE: HY000 (ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG)
Explicit or implicit commit is not allowed in stored function or trigger.
1423 SQLSTATE: HY000 (ER_NO_DEFAULT_FOR_VIEW_FIELD)
Field of view '%s.%s' underlying table doesn't have a default value
1424 SQLSTATE: HY000 (ER_SP_NO_RECURSION)
Recursive stored functions and triggers are not allowed.
1425 SQLSTATE: 42000 (ER_TOO_BIG_SCALE)
Too big scale %d specified for column '%s'. Maximum is %lu.
1426 SQLSTATE: 42000 (ER_TOO_BIG_PRECISION)
Too big precision %d specified for column '%s'. Maximum is %lu.
1427 SQLSTATE: 42000 (ER_M_BIGGER_THAN_D)
For float(M,D), double(M,D) or decimal(M,D), M must be >= D (column '%s').
1428 SQLSTATE: HY000 (ER_WRONG_LOCK_OF_SYSTEM_TABLE)
You can't combine write-locking of system tables with other tables or lock types
1429 SQLSTATE: HY000 (ER_CONNECT_TO_FOREIGN_DATA_SOURCE)
Unable to connect to foreign data source: %s
1430 SQLSTATE: HY000 (ER_QUERY_ON_FOREIGN_DATA_SOURCE)
There was a problem processing the query on the foreign data source. Data source error: %s
1431 SQLSTATE: HY000 (ER_FOREIGN_DATA_SOURCE_DOESNT_EXIST)
The foreign data source you are trying to reference does not exist. Data source error: %s
1432 SQLSTATE: HY000 (ER_FOREIGN_DATA_STRING_INVALID_CANT_CREATE)
Can't create federated table. The data source connection string '%s' is not in the correct format
1433 SQLSTATE: HY000 (ER_FOREIGN_DATA_STRING_INVALID)
The data source connection string '%s' is not in the correct format
1434 SQLSTATE: HY000 (ER_CANT_CREATE_FEDERATED_TABLE)
Can't create federated table. Foreign data src error: %s
1435 SQLSTATE: HY000 (ER_TRG_IN_WRONG_SCHEMA)
Trigger in wrong schema
1436 SQLSTATE: HY000 (ER_STACK_OVERRUN_NEED_MORE)
Thread stack overrun: %ld bytes used of a %ld byte stack, and %ld bytes needed. Use 'mysqld -O thread_stack=#' to specify a bigger stack.
1437 SQLSTATE: 42000 (ER_TOO_LONG_BODY)
Routine body for '%s' is too long
1438 SQLSTATE: HY000 (ER_WARN_CANT_DROP_DEFAULT_KEYCACHE)
Cannot drop default keycache
1439 SQLSTATE: 42000 (ER_TOO_BIG_DISPLAYWIDTH)
Display width out of range for column '%s' (max = %lu)
1440 SQLSTATE: XAE08 (ER_XAER_DUPID)
XAER_DUPID: The XID already exists
1441 SQLSTATE: 22008 (ER_DATETIME_FUNCTION_OVERFLOW)
Datetime function: %s field overflow
1442 SQLSTATE: HY000 (ER_CANT_UPDATE_USED_TABLE_IN_SF_OR_TRG)
Can't update table '%s' in stored function/trigger because it is already used by statement which invoked this stored function/trigger.
1443 SQLSTATE: HY000 (ER_VIEW_PREVENT_UPDATE)
The definition of table '%s' prevents operation %s on table '%s'.
1444 SQLSTATE: HY000 (ER_PS_NO_RECURSION)
The prepared statement contains a stored routine call that refers to that same statement. It's not allowed to execute a prepared statement in such a recursive manner
1445 SQLSTATE: HY000 (ER_SP_CANT_SET_AUTOCOMMIT)
Not allowed to set autocommit from a stored function or trigger
1446 SQLSTATE: HY000 (ER_MALFORMED_DEFINER)
Definer is not fully qualified
1447 SQLSTATE: HY000 (ER_VIEW_FRM_NO_USER)
View '%s'.'%s' has no definer information (old table format). Current user is used as definer. Please recreate the view!
1448 SQLSTATE: HY000 (ER_VIEW_OTHER_USER)
You need the SUPER privilege for creation view with '%s'@'%s' definer
1449 SQLSTATE: HY000 (ER_NO_SUCH_USER)
The user specified as a definer ('%s'@'%s') does not exist
1450 SQLSTATE: HY000 (ER_FORBID_SCHEMA_CHANGE)
Changing schema from '%s' to '%s' is not allowed.
1451 SQLSTATE: 23000 (ER_ROW_IS_REFERENCED_2)
Cannot delete or update a parent row: a foreign key constraint fails (%s)
1452 SQLSTATE: 23000 (ER_NO_REFERENCED_ROW_2)
Cannot add or update a child row: a foreign key constraint fails (%s)
1453 SQLSTATE: 42000 (ER_SP_BAD_VAR_SHADOW)
Variable '%s' must be quoted with `...`, or renamed
1454 SQLSTATE: HY000 (ER_TRG_NO_DEFINER)
No definer attribute for trigger '%s'.'%s'. The trigger will be activated under the authorization of the invoker, which may have insufficient privileges. Please recreate the trigger.
1455 SQLSTATE: HY000 (ER_OLD_FILE_FORMAT)
'%s' has an old format, you should re-create the '%s' object(s)
1456 SQLSTATE: HY000 (ER_SP_RECURSION_LIMIT)
Recursive limit %d (as set by the max_sp_recursion_depth variable) was exceeded for routine %s
1457 SQLSTATE: HY000 (ER_SP_PROC_TABLE_CORRUPT)
Failed to load routine %s. The table mysql.proc is missing, corrupt, or contains bad data (internal code %d)
1458 SQLSTATE: 42000 (ER_SP_WRONG_NAME)
Incorrect routine name '%s'
1459 SQLSTATE: HY000 (ER_TABLE_NEEDS_UPGRADE)
Table upgrade required. Please do "REPAIR TABLE `%s`" or dump/reload to fix it!
1460 SQLSTATE: 42000 (ER_SP_NO_AGGREGATE)
AGGREGATE is not supported for stored functions
1461 SQLSTATE: 42000 (ER_MAX_PREPARED_STMT_COUNT_REACHED)
Can't create more than max_prepared_stmt_count statements (current value: %lu)
1462 SQLSTATE: HY000 (ER_VIEW_RECURSIVE)
`%s`.`%s` contains view recursion
1463 SQLSTATE: 42000 (ER_NON_GROUPING_FIELD_USED)
non-grouping field '%s' is used in %s clause
1464 SQLSTATE: HY000 (ER_TABLE_CANT_HANDLE_SPKEYS)
The used table type doesn't support SPATIAL indexes
1465 SQLSTATE: HY000 (ER_NO_TRIGGERS_ON_SYSTEM_SCHEMA)
Triggers can not be created on system tables
1466 SQLSTATE: HY000 (ER_REMOVED_SPACES)
Leading spaces are removed from name '%s'
1467 SQLSTATE: HY000 (ER_AUTOINC_READ_FAILED)
Failed to read auto-increment value from storage engine
1468 SQLSTATE: HY000 (ER_USERNAME)
user name
1469 SQLSTATE: HY000 (ER_HOSTNAME)
host name
1470 SQLSTATE: HY000 (ER_WRONG_STRING_LENGTH)
String '%s' is too long for %s (should be no longer than %d)
1471 SQLSTATE: HY000 (ER_NON_INSERTABLE_TABLE)
The target table %s of the %s is not insertable-into
1472 SQLSTATE: HY000 (ER_ADMIN_WRONG_MRG_TABLE)
Table '%s' is differently defined or of non-MyISAM type or doesn't exist
1473 SQLSTATE: HY000 (ER_TOO_HIGH_LEVEL_OF_NESTING_FOR_SELECT)
Too high level of nesting for select
1474 SQLSTATE: HY000 (ER_NAME_BECOMES_EMPTY)
Name '%s' has become ''
1475 SQLSTATE: HY000 (ER_AMBIGUOUS_FIELD_TERM)
First character of the FIELDS TERMINATED string is ambiguous; please use non-optional and non-empty FIELDS ENCLOSED BY
1476 SQLSTATE: HY000 (ER_FOREIGN_SERVER_EXISTS)
The foreign server, %s, you are trying to create already exists.
1477 SQLSTATE: HY000 (ER_FOREIGN_SERVER_DOESNT_EXIST)
The foreign server name you are trying to reference does not exist. Data source error: %s
1478 SQLSTATE: HY000 (ER_ILLEGAL_HA_CREATE_OPTION)
Table storage engine '%s' does not support the create option '%s'
1479 SQLSTATE: HY000 (ER_PARTITION_REQUIRES_VALUES_ERROR)
Syntax error: %s PARTITIONING requires definition of VALUES %s for each partition
1480 SQLSTATE: HY000 (ER_PARTITION_WRONG_VALUES_ERROR)
Only %s PARTITIONING can use VALUES %s in partition definition
1481 SQLSTATE: HY000 (ER_PARTITION_MAXVALUE_ERROR)
MAXVALUE can only be used in last partition definition
1482 SQLSTATE: HY000 (ER_PARTITION_SUBPARTITION_ERROR)
Subpartitions can only be hash partitions and by key
1483 SQLSTATE: HY000 (ER_PARTITION_SUBPART_MIX_ERROR)
Must define subpartitions on all partitions if on one partition
1484 SQLSTATE: HY000 (ER_PARTITION_WRONG_NO_PART_ERROR)
Wrong number of partitions defined, mismatch with previous setting
1485 SQLSTATE: HY000 (ER_PARTITION_WRONG_NO_SUBPART_ERROR)
Wrong number of subpartitions defined, mismatch with previous setting
1486 SQLSTATE: HY000 (ER_CONST_EXPR_IN_PARTITION_FUNC_ERROR)
Constant/Random expression in (sub)partitioning function is not allowed
1487 SQLSTATE: HY000 (ER_NO_CONST_EXPR_IN_RANGE_OR_LIST_ERROR)
Expression in RANGE/LIST VALUES must be constant
1488 SQLSTATE: HY000 (ER_FIELD_NOT_FOUND_PART_ERROR)
Field in list of fields for partition function not found in table
1489 SQLSTATE: HY000 (ER_LIST_OF_FIELDS_ONLY_IN_HASH_ERROR)
List of fields is only allowed in KEY partitions
1490 SQLSTATE: HY000 (ER_INCONSISTENT_PARTITION_INFO_ERROR)
The partition info in the frm file is not consistent with what can be written into the frm file
1491 SQLSTATE: HY000 (ER_PARTITION_FUNC_NOT_ALLOWED_ERROR)
The %s function returns the wrong type
1492 SQLSTATE: HY000 (ER_PARTITIONS_MUST_BE_DEFINED_ERROR)
For %s partitions each partition must be defined
1493 SQLSTATE: HY000 (ER_RANGE_NOT_INCREASING_ERROR)
VALUES LESS THAN value must be strictly increasing for each partition
1494 SQLSTATE: HY000 (ER_INCONSISTENT_TYPE_OF_FUNCTIONS_ERROR)
VALUES value must be of same type as partition function
1495 SQLSTATE: HY000 (ER_MULTIPLE_DEF_CONST_IN_LIST_PART_ERROR)
Multiple definition of same constant in list partitioning
1496 SQLSTATE: HY000 (ER_PARTITION_ENTRY_ERROR)
Partitioning can not be used stand-alone in query
1497 SQLSTATE: HY000 (ER_MIX_HANDLER_ERROR)
The mix of handlers in the partitions is not allowed in this version of MySQL
1498 SQLSTATE: HY000 (ER_PARTITION_NOT_DEFINED_ERROR)
For the partitioned engine it is necessary to define all %s
1499 SQLSTATE: HY000 (ER_TOO_MANY_PARTITIONS_ERROR)
Too many partitions (including subpartitions) were defined
1500 SQLSTATE: HY000 (ER_SUBPARTITION_ERROR)
It is only possible to mix RANGE/LIST partitioning with HASH/KEY partitioning for subpartitioning
1501 SQLSTATE: HY000 (ER_CANT_CREATE_HANDLER_FILE)
Failed to create specific handler file
1502 SQLSTATE: HY000 (ER_BLOB_FIELD_IN_PART_FUNC_ERROR)
A BLOB field is not allowed in partition function
1503 SQLSTATE: HY000 (ER_UNIQUE_KEY_NEED_ALL_FIELDS_IN_PF)
A %s must include all columns in the table's partitioning function
1504 SQLSTATE: HY000 (ER_NO_PARTS_ERROR)
Number of %s = 0 is not an allowed value
1505 SQLSTATE: HY000 (ER_PARTITION_MGMT_ON_NONPARTITIONED)
Partition management on a not partitioned table is not possible
1506 SQLSTATE: HY000 (ER_FOREIGN_KEY_ON_PARTITIONED)
Foreign key clause is not yet supported in conjunction with partitioning
1507 SQLSTATE: HY000 (ER_DROP_PARTITION_NON_EXISTENT)
Error in list of partitions to %s
1508 SQLSTATE: HY000 (ER_DROP_LAST_PARTITION)
Cannot remove all partitions, use DROP TABLE instead
1509 SQLSTATE: HY000 (ER_COALESCE_ONLY_ON_HASH_PARTITION)
COALESCE PARTITION can only be used on HASH/KEY partitions
1510 SQLSTATE: HY000 (ER_REORG_HASH_ONLY_ON_SAME_NO)
REORGANIZE PARTITION can only be used to reorganize partitions not to change their numbers
1511 SQLSTATE: HY000 (ER_REORG_NO_PARAM_ERROR)
REORGANIZE PARTITION without parameters can only be used on auto-partitioned tables using HASH PARTITIONs
1512 SQLSTATE: HY000 (ER_ONLY_ON_RANGE_LIST_PARTITION)
%s PARTITION can only be used on RANGE/LIST partitions
1513 SQLSTATE: HY000 (ER_ADD_PARTITION_SUBPART_ERROR)
Trying to Add partition(s) with wrong number of subpartitions
1514 SQLSTATE: HY000 (ER_ADD_PARTITION_NO_NEW_PARTITION)
At least one partition must be added
1515 SQLSTATE: HY000 (ER_COALESCE_PARTITION_NO_PARTITION)
At least one partition must be coalesced
1516 SQLSTATE: HY000 (ER_REORG_PARTITION_NOT_EXIST)
More partitions to reorganize than there are partitions
1517 SQLSTATE: HY000 (ER_SAME_NAME_PARTITION)
Duplicate partition name %s
1518 SQLSTATE: HY000 (ER_NO_BINLOG_ERROR)
It is not allowed to shut off binlog on this command
1519 SQLSTATE: HY000 (ER_CONSECUTIVE_REORG_PARTITIONS)
When reorganizing a set of partitions they must be in consecutive order
1520 SQLSTATE: HY000 (ER_REORG_OUTSIDE_RANGE)
Reorganize of range partitions cannot change total ranges except for last partition where it can extend the range
1521 SQLSTATE: HY000 (ER_PARTITION_FUNCTION_FAILURE)
Partition function not supported in this version for this handler
1522 SQLSTATE: HY000 (ER_PART_STATE_ERROR)
Partition state cannot be defined from CREATE/ALTER TABLE
1523 SQLSTATE: HY000 (ER_LIMITED_PART_RANGE)
The %s handler only supports 32 bit integers in VALUES
1524 SQLSTATE: HY000 (ER_PLUGIN_IS_NOT_LOADED)
Plugin '%s' is not loaded
1525 SQLSTATE: HY000 (ER_WRONG_VALUE)
Incorrect %s value: '%s'
1526 SQLSTATE: HY000 (ER_NO_PARTITION_FOR_GIVEN_VALUE)
Table has no partition for value %s
1527 SQLSTATE: HY000 (ER_FILEGROUP_OPTION_ONLY_ONCE)
It is not allowed to specify %s more than once
1528 SQLSTATE: HY000 (ER_CREATE_FILEGROUP_FAILED)
Failed to create %s
1529 SQLSTATE: HY000 (ER_DROP_FILEGROUP_FAILED)
Failed to drop %s
1530 SQLSTATE: HY000 (ER_TABLESPACE_AUTO_EXTEND_ERROR)
The handler doesn't support autoextend of tablespaces
1531 SQLSTATE: HY000 (ER_WRONG_SIZE_NUMBER)
A size parameter was incorrectly specified, either number or on the form 10M
1532 SQLSTATE: HY000 (ER_SIZE_OVERFLOW_ERROR)
The size number was correct but we don't allow the digit part to be more than 2 billion
1533 SQLSTATE: HY000 (ER_ALTER_FILEGROUP_FAILED)
Failed to alter: %s
1534 SQLSTATE: HY000 (ER_BINLOG_ROW_LOGGING_FAILED)
Writing one row to the row-based binary log failed
1535 SQLSTATE: HY000 (ER_BINLOG_ROW_WRONG_TABLE_DEF)
Table definition on master and slave does not match: %s
1536 SQLSTATE: HY000 (ER_BINLOG_ROW_RBR_TO_SBR)
Slave running with --log-slave-updates must use row-based binary logging to be able to replicate row-based binary log events
1537 SQLSTATE: HY000 (ER_EVENT_ALREADY_EXISTS)
Event '%s' already exists
1538 SQLSTATE: HY000 (ER_EVENT_STORE_FAILED)
Failed to store event %s. Error code %d from storage engine.
1539 SQLSTATE: HY000 (ER_EVENT_DOES_NOT_EXIST)
Unknown event '%s'
1540 SQLSTATE: HY000 (ER_EVENT_CANT_ALTER)
Failed to alter event '%s'
1541 SQLSTATE: HY000 (ER_EVENT_DROP_FAILED)
Failed to drop %s
1542 SQLSTATE: HY000 (ER_EVENT_INTERVAL_NOT_POSITIVE_OR_TOO_BIG)
INTERVAL is either not positive or too big
1543 SQLSTATE: HY000 (ER_EVENT_ENDS_BEFORE_STARTS)
ENDS is either invalid or before STARTS
1544 SQLSTATE: HY000 (ER_EVENT_EXEC_TIME_IN_THE_PAST)
Event execution time is in the past. Event has been disabled
1545 SQLSTATE: HY000 (ER_EVENT_OPEN_TABLE_FAILED)
Failed to open mysql.event
1546 SQLSTATE: HY000 (ER_EVENT_NEITHER_M_EXPR_NOR_M_AT)
No datetime expression provided
1547 SQLSTATE: HY000 (ER_COL_COUNT_DOESNT_MATCH_CORRUPTED)
Column count of mysql.%s is wrong. Expected %d, found %d. The table is probably corrupted
1548 SQLSTATE: HY000 (ER_CANNOT_LOAD_FROM_TABLE)
Cannot load from mysql.%s. The table is probably corrupted
1549 SQLSTATE: HY000 (ER_EVENT_CANNOT_DELETE)
Failed to delete the event from mysql.event
1550 SQLSTATE: HY000 (ER_EVENT_COMPILE_ERROR)
Error during compilation of event's body
1551 SQLSTATE: HY000 (ER_EVENT_SAME_NAME)
Same old and new event name
1552 SQLSTATE: HY000 (ER_EVENT_DATA_TOO_LONG)
Data for column '%s' too long
1553 SQLSTATE: HY000 (ER_DROP_INDEX_FK)
Cannot drop index '%s': needed in a foreign key constraint
1554 SQLSTATE: HY000 (ER_WARN_DEPRECATED_SYNTAX_WITH_VER)
The syntax '%s' is deprecated and will be removed in MySQL %s. Please use %s instead
1555 SQLSTATE: HY000 (ER_CANT_WRITE_LOCK_LOG_TABLE)
You can't write-lock a log table. Only read access is possible
1556 SQLSTATE: HY000 (ER_CANT_LOCK_LOG_TABLE)
You can't use locks with log tables.
1557 SQLSTATE: 23000 (ER_FOREIGN_DUPLICATE_KEY)
Upholding foreign key constraints for table '%s', entry '%s', key %d would lead to a duplicate entry
1558 SQLSTATE: HY000 (ER_COL_COUNT_DOESNT_MATCH_PLEASE_UPDATE)
Column count of mysql.%s is wrong. Expected %d, found %d. Created with MySQL %d, now running %d. Please use mysql_upgrade to fix this error.
1559 SQLSTATE: HY000 (ER_TEMP_TABLE_PREVENTS_SWITCH_OUT_OF_RBR)
Cannot switch out of the row-based binary log format when the session has open temporary tables
1560 SQLSTATE: HY000 (ER_STORED_FUNCTION_PREVENTS_SWITCH_BINLOG_FORMAT)
Cannot change the binary logging format inside a stored function or trigger
1561 SQLSTATE: HY000 (ER_NDB_CANT_SWITCH_BINLOG_FORMAT)
The NDB cluster engine does not support changing the binlog format on the fly yet
1562 SQLSTATE: HY000 (ER_PARTITION_NO_TEMPORARY)
Cannot create temporary table with partitions
1563 SQLSTATE: HY000 (ER_PARTITION_CONST_DOMAIN_ERROR)
Partition constant is out of partition function domain
1564 SQLSTATE: HY000 (ER_PARTITION_FUNCTION_IS_NOT_ALLOWED)
This partition function is not allowed
1565 SQLSTATE: HY000 (ER_DDL_LOG_ERROR)
Error in DDL log
1566 SQLSTATE: HY000 (ER_NULL_IN_VALUES_LESS_THAN)
Not allowed to use NULL value in VALUES LESS THAN
1567 SQLSTATE: HY000 (ER_WRONG_PARTITION_NAME)
Incorrect partition name
1568 SQLSTATE: 25001 (ER_CANT_CHANGE_TX_ISOLATION)
Transaction isolation level can't be changed while a transaction is in progress
1569 SQLSTATE: HY000 (ER_DUP_ENTRY_AUTOINCREMENT_CASE)
ALTER TABLE causes auto_increment resequencing, resulting in duplicate entry '%s' for key '%s'
1570 SQLSTATE: HY000 (ER_EVENT_MODIFY_QUEUE_ERROR)
Internal scheduler error %d
1571 SQLSTATE: HY000 (ER_EVENT_SET_VAR_ERROR)
Error during starting/stopping of the scheduler. Error code %u
1572 SQLSTATE: HY000 (ER_PARTITION_MERGE_ERROR)
Engine cannot be used in partitioned tables
1573 SQLSTATE: HY000 (ER_CANT_ACTIVATE_LOG)
Cannot activate '%s' log
1574 SQLSTATE: HY000 (ER_RBR_NOT_AVAILABLE)
The server was not built with row-based replication
1575 SQLSTATE: HY000 (ER_BASE64_DECODE_ERROR)
Decoding of base64 string failed
1576 SQLSTATE: HY000 (ER_EVENT_RECURSION_FORBIDDEN)
Recursion of EVENT DDL statements is forbidden when body is present
1577 SQLSTATE: HY000 (ER_EVENTS_DB_ERROR)
Cannot proceed because system tables used by Event Scheduler were found damaged at server start
1578 SQLSTATE: HY000 (ER_ONLY_INTEGERS_ALLOWED)
Only integers allowed as number here
1579 SQLSTATE: HY000 (ER_UNSUPORTED_LOG_ENGINE)
This storage engine cannot be used for log tables"
1580 SQLSTATE: HY000 (ER_BAD_LOG_STATEMENT)
You cannot '%s' a log table if logging is enabled
1581 SQLSTATE: HY000 (ER_CANT_RENAME_LOG_TABLE)
Cannot rename '%s'. When logging enabled, rename to/from log table must rename two tables: the log table to an archive table and another table back to '%s'
1582 SQLSTATE: 42000 (ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT)
Incorrect parameter count in the call to native function '%s'
1583 SQLSTATE: 42000 (ER_WRONG_PARAMETERS_TO_NATIVE_FCT)
Incorrect parameters in the call to native function '%s'
1584 SQLSTATE: 42000 (ER_WRONG_PARAMETERS_TO_STORED_FCT)
Incorrect parameters in the call to stored function '%s'
1585 SQLSTATE: HY000 (ER_NATIVE_FCT_NAME_COLLISION)
This function '%s' has the same name as a native function
1586 SQLSTATE: 23000 (ER_DUP_ENTRY_WITH_KEY_NAME)
Duplicate entry '%s' for key '%s'
1587 SQLSTATE: HY000 (ER_BINLOG_PURGE_EMFILE)
Too many files opened, please execute the command again
1588 SQLSTATE: HY000 (ER_EVENT_CANNOT_CREATE_IN_THE_PAST)
Event execution time is in the past and ON COMPLETION NOT PRESERVE is set. The event was dropped immediately after creation.
1589 SQLSTATE: HY000 (ER_EVENT_CANNOT_ALTER_IN_THE_PAST)
Event execution time is in the past and ON COMPLETION NOT PRESERVE is set. The event was dropped immediately after creation.
1590 SQLSTATE: HY000 (ER_SLAVE_INCIDENT)
The incident %s occured on the master. Message: %s
1591 SQLSTATE: HY000 (ER_NO_PARTITION_FOR_GIVEN_VALUE_SILENT)
Table has no partition for some existing values
1592 SQLSTATE: HY000 (ER_BINLOG_UNSAFE_STATEMENT)
Statement may not be safe to log in statement format.
1593 SQLSTATE: HY000 (ER_SLAVE_FATAL_ERROR)
Fatal error: %s
1594 SQLSTATE: HY000 (ER_SLAVE_RELAY_LOG_READ_FAILURE)
Relay log read failure: %s
1595 SQLSTATE: HY000 (ER_SLAVE_RELAY_LOG_WRITE_FAILURE)
Relay log write failure: %s
1596 SQLSTATE: HY000 (ER_SLAVE_CREATE_EVENT_FAILURE)
Failed to create %s
1597 SQLSTATE: HY000 (ER_SLAVE_MASTER_COM_FAILURE)
Master command %s failed: %s
1598 SQLSTATE: HY000 (ER_BINLOG_LOGGING_IMPOSSIBLE)
Binary logging not possible. Message: %s
1599 SQLSTATE: HY000 (ER_VIEW_NO_CREATION_CTX)
View `%s`.`%s` has no creation context
1600 SQLSTATE: HY000 (ER_VIEW_INVALID_CREATION_CTX)
Creation context of view `%s`.`%s' is invalid
1601 SQLSTATE: HY000 (ER_SR_INVALID_CREATION_CTX)
Creation context of stored routine `%s`.`%s` is invalid
1602 SQLSTATE: HY000 (ER_TRG_CORRUPTED_FILE)
Corrupted TRG file for table `%s`.`%s`
1603 SQLSTATE: HY000 (ER_TRG_NO_CREATION_CTX)
Triggers for table `%s`.`%s` have no creation context
1604 SQLSTATE: HY000 (ER_TRG_INVALID_CREATION_CTX)
Trigger creation context of table `%s`.`%s` is invalid
1605 SQLSTATE: HY000 (ER_EVENT_INVALID_CREATION_CTX)
Creation context of event `%s`.`%s` is invalid
1606 SQLSTATE: HY000 (ER_TRG_CANT_OPEN_TABLE)
Cannot open table for trigger `%s`.`%s`
1607 SQLSTATE: HY000 (ER_CANT_CREATE_SROUTINE)
Cannot create stored routine `%s`. Check warnings
1608 SQLSTATE: HY000 (ER_SLAVE_AMBIGOUS_EXEC_MODE)
Ambiguous slave modes combination. %s
1609 SQLSTATE: HY000 (ER_NO_FORMAT_DESCRIPTION_EVENT_BEFORE_BINLOG_STATEMENT)
The BINLOG statement of type `%s` was not preceded by a format description BINLOG statement.
1610 SQLSTATE: HY000 (ER_SLAVE_CORRUPT_EVENT)
Corrupted replication event was detected
1611 SQLSTATE: HY000 (ER_LOAD_DATA_INVALID_COLUMN)
Invalid column reference (%s) in LOAD DATA
1612 SQLSTATE: HY000 (ER_LOG_PURGE_NO_FILE)
Being purged log %s was not found
1613 SQLSTATE: XA106 (ER_XA_RBTIMEOUT)
XA_RBTIMEOUT: Transaction branch was rolled back: took too long
1614 SQLSTATE: XA102 (ER_XA_RBDEADLOCK)
XA_RBDEADLOCK: Transaction branch was rolled back: deadlock was detected
1615 SQLSTATE: HY000 (ER_NEED_REPREPARE)
Prepared statement needs to be re-prepared
1616 SQLSTATE: HY000 (ER_DELAYED_NOT_SUPPORTED)
DELAYED option not supported for table '%s'
1617 SQLSTATE: HY000 (WARN_NO_MASTER_INFO)
The master info structure does not exist
1618 SQLSTATE: HY000 (WARN_OPTION_IGNORED)
<%s> option ignored
1619 SQLSTATE: HY000 (WARN_PLUGIN_DELETE_BUILTIN)
Built-in plugins cannot be deleted
1620 SQLSTATE: HY000 (WARN_PLUGIN_BUSY)
Plugin is busy and will be uninstalled on shutdown
1621 SQLSTATE: HY000 (ER_VARIABLE_IS_READONLY)
%s variable '%s' is read-only. Use SET %s to assign the value
1622 SQLSTATE: HY000 (ER_WARN_ENGINE_TRANSACTION_ROLLBACK)
Storage engine %s does not support rollback for this statement. Transaction rolled back and must be restarted
1623 SQLSTATE: HY000 (ER_SLAVE_HEARTBEAT_FAILURE)
Unexpected master's heartbeat data: %s
1624 SQLSTATE: HY000 (ER_SLAVE_HEARTBEAT_VALUE_OUT_OF_RANGE)
The requested value for the heartbeat period %s %s
1625 SQLSTATE: HY000 (ER_NDB_REPLICATION_SCHEMA_ERROR)
Bad schema for mysql.ndb_replication table. Message: %s
1626 SQLSTATE: HY000 (ER_CONFLICT_FN_PARSE_ERROR)
Error in parsing conflict function. Message: %s
1627 SQLSTATE: HY000 (ER_EXCEPTIONS_WRITE_ERROR)
Write to exceptions table failed. Message: %s"
1628 SQLSTATE: HY000 (ER_TOO_LONG_TABLE_COMMENT)
Comment for table '%s' is too long (max = %lu)
1629 SQLSTATE: HY000 (ER_TOO_LONG_FIELD_COMMENT)
Comment for field '%s' is too long (max = %lu)
1630 SQLSTATE: 42000 (ER_FUNC_INEXISTENT_NAME_COLLISION)
FUNCTION %s does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
1631 SQLSTATE: HY000 (ER_DATABASE_NAME)
Database
1632 SQLSTATE: HY000 (ER_TABLE_NAME)
Table
1633 SQLSTATE: HY000 (ER_PARTITION_NAME)
Partition
1634 SQLSTATE: HY000 (ER_SUBPARTITION_NAME)
Subpartition
1635 SQLSTATE: HY000 (ER_TEMPORARY_NAME)
Temporary
1636 SQLSTATE: HY000 (ER_RENAMED_NAME)
Renamed
1637 SQLSTATE: HY000 (ER_TOO_MANY_CONCURRENT_TRXS)
Too many active concurrent transactions
1638 SQLSTATE: HY000 (WARN_NON_ASCII_SEPARATOR_NOT_IMPLEMENTED)
Non-ASCII separator arguments are not fully supported
1639 SQLSTATE: HY000 (ER_DEBUG_SYNC_TIMEOUT)
debug sync point wait timed out
1640 SQLSTATE: HY000 (ER_DEBUG_SYNC_HIT_LIMIT)
debug sync point hit limit reached
=end

};

sub error_handler {
   my $string = shift;
   my @args = ( original => $string );
   my $class = 'DBIx::Exception';

   $class->throw(@args);
}

1;
