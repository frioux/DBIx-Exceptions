package DBIx::ParseException::Pg;

use Moose;
use DBIx::Exceptions;
with 'DBIx::ParseException';

my $error_codes = {
   1000 => {
      err => 'HY000',
      err_etc => 'ER_HASHCHK',
      err_desc => "hashchk",
   },
   1001 => {
      err => 'HY000',
      err_etc => 'ER_NISAMCHK',
      err_desc => "isamchk",
   },
   1002 => {
      err => 'HY000',
      err_etc => 'ER_NO',
      err_desc => "NO",
   },
   1003 => {
      err => 'HY000',
      err_etc => 'ER_YES',
      err_desc => "YES",
   },
   1004 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_FILE',
      err_desc => "Can't create file '%s' (errno: %d)",
   },
   1005 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_TABLE',
      err_desc => "Can't create table '%s' (errno: %d)",
   },
   1006 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_DB',
      err_desc => "Can't create database '%s' (errno: %d)",
   },
   1007 => {
      err => 'HY000',
      err_etc => 'ER_DB_CREATE_EXISTS',
      err_desc => "Can't create database '%s'; database exists",
   },
   1008 => {
      err => 'HY000',
      err_etc => 'ER_DB_DROP_EXISTS',
      err_desc => "Can't drop database '%s'; database doesn't exist",
   },
   1009 => {
      err => 'HY000',
      err_etc => 'ER_DB_DROP_DELETE',
      err_desc => "Error dropping database (can't delete '%s', errno: %d)",
   },
   1010 => {
      err => 'HY000',
      err_etc => 'ER_DB_DROP_RMDIR',
      err_desc => "Error dropping database (can't rmdir '%s', errno: %d)",
   },
   1011 => {
      err => 'HY000',
      err_etc => 'ER_CANT_DELETE_FILE',
      err_desc => "Error on delete of '%s' (errno: %d)",
   },
   1012 => {
      err => 'HY000',
      err_etc => 'ER_CANT_FIND_SYSTEM_REC',
      err_desc => "Can't read record in system table",
   },
   1013 => {
      err => 'HY000',
      err_etc => 'ER_CANT_GET_STAT',
      err_desc => "Can't get status of '%s' (errno: %d)",
   },
   1014 => {
      err => 'HY000',
      err_etc => 'ER_CANT_GET_WD',
      err_desc => "Can't get working directory (errno: %d)",
   },
   1015 => {
      err => 'HY000',
      err_etc => 'ER_CANT_LOCK',
      err_desc => "Can't lock file (errno: %d)",
   },
   1016 => {
      err => 'HY000',
      err_etc => 'ER_CANT_OPEN_FILE',
      err_desc => "Can't open file: '%s' (errno: %d)",
   },
   1017 => {
      err => 'HY000',
      err_etc => 'ER_FILE_NOT_FOUND',
      err_desc => "Can't find file: '%s' (errno: %d)",
   },
   1018 => {
      err => 'HY000',
      err_etc => 'ER_CANT_READ_DIR',
      err_desc => "Can't read dir of '%s' (errno: %d)",
   },
   1019 => {
      err => 'HY000',
      err_etc => 'ER_CANT_SET_WD',
      err_desc => "Can't change dir to '%s' (errno: %d)",
   },
   1020 => {
      err => 'HY000',
      err_etc => 'ER_CHECKREAD',
      err_desc => "Record has changed since last read in table '%s'",
   },
   1021 => {
      err => 'HY000',
      err_etc => 'ER_DISK_FULL',
      err_desc => "Disk full (%s); waiting for someone to free some space...",
   },
   1022 => {
      err => '23000',
      err_etc => 'ER_DUP_KEY',
      err_desc => "Can't write; duplicate key in table '%s'",
   },
   1023 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_ON_CLOSE',
      err_desc => "Error on close of '%s' (errno: %d)",
   },
   1024 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_ON_READ',
      err_desc => "Error reading file '%s' (errno: %d)",
   },
   1025 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_ON_RENAME',
      err_desc => "Error on rename of '%s' to '%s' (errno: %d)",
   },
   1026 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_ON_WRITE',
      err_desc => "Error writing file '%s' (errno: %d)",
   },
   1027 => {
      err => 'HY000',
      err_etc => 'ER_FILE_USED',
      err_desc => "'%s' is locked against change",
   },
   1028 => {
      err => 'HY000',
      err_etc => 'ER_FILSORT_ABORT',
      err_desc => "Sort aborted",
   },
   1029 => {
      err => 'HY000',
      err_etc => 'ER_FORM_NOT_FOUND',
      err_desc => "View '%s' doesn't exist for '%s'",
   },
   1030 => {
      err => 'HY000',
      err_etc => 'ER_GET_ERRNO',
      err_desc => "Got error %d from storage engine",
   },
   1031 => {
      err => 'HY000',
      err_etc => 'ER_ILLEGAL_HA',
      err_desc => "Table storage engine for '%s' doesn't have this option",
   },
   1032 => {
      err => 'HY000',
      err_etc => 'ER_KEY_NOT_FOUND',
      err_desc => "Can't find record in '%s'",
   },
   1033 => {
      err => 'HY000',
      err_etc => 'ER_NOT_FORM_FILE',
      err_desc => "Incorrect information in file: '%s'",
   },
   1034 => {
      err => 'HY000',
      err_etc => 'ER_NOT_KEYFILE',
      err_desc => "Incorrect key file for table '%s'; try to repair it",
   },
   1035 => {
      err => 'HY000',
      err_etc => 'ER_OLD_KEYFILE',
      err_desc => "Old key file for table '%s'; repair it!",
   },
   1036 => {
      err => 'HY000',
      err_etc => 'ER_OPEN_AS_READONLY',
      err_desc => "Table '%s' is read only",
   },
   1037 => {
      err => 'HY001',
      err_etc => 'ER_OUTOFMEMORY',
      err_desc => "Out of memory; restart server and try again (needed %d bytes)",
   },
   1038 => {
      err => 'HY001',
      err_etc => 'ER_OUT_OF_SORTMEMORY',
      err_desc => "Out of sort memory; increase server sort buffer size",
   },
   1039 => {
      err => 'HY000',
      err_etc => 'ER_UNEXPECTED_EOF',
      err_desc => "Unexpected EOF found when reading file '%s' (errno: %d)",
   },
   1040 => {
      err => '08004',
      err_etc => 'ER_CON_COUNT_ERROR',
      err_desc => "Too many connections",
   },
   1041 => {
      err => 'HY000',
      err_etc => 'ER_OUT_OF_RESOURCES',
   },
   1042 =>
      err => '08S01',
      err_etc => 'ER_BAD_HOST_ERROR',
      err_desc => "Can't get hostname for your address",
   },
   1043 => {
      err => '08S01',
      err_etc => 'ER_HANDSHAKE_ERROR',
      err_desc => "Bad handshake",
   },
   1044 => {
      err => '42000',
      err_etc => 'ER_DBACCESS_DENIED_ERROR',
      err_desc => "Access denied for user '%s'@'%s' to database '%s'",
   },
   1045 => {
      err => '28000',
      err_etc => 'ER_ACCESS_DENIED_ERROR',
      err_desc => "Access denied for user '%s'@'%s' (using password: %s)",
   },
   1046 => {
      err => '3D000',
      err_etc => 'ER_NO_DB_ERROR',
      err_desc => "No database selected",
   },
   1047 => {
      err => '08S01',
      err_etc => 'ER_UNKNOWN_COM_ERROR',
      err_desc => "Unknown command",
   },
   1048 => {
      err => '23000',
      err_etc => 'ER_BAD_NULL_ERROR',
      err_desc => "Column '%s' cannot be null",
   },
   1049 => {
      err => '42000',
      err_etc => 'ER_BAD_DB_ERROR',
      err_desc => "Unknown database '%s'",
   },
   1050 => {
      err => '42S01',
      err_etc => 'ER_TABLE_EXISTS_ERROR',
      err_desc => "Table '%s' already exists",
   },
   1051 => {
      err => '42S02',
      err_etc => 'ER_BAD_TABLE_ERROR',
      err_desc => "Unknown table '%s'",
   },
   1052 => {
      err => '23000',
      err_etc => 'ER_NON_UNIQ_ERROR',
      err_desc => "Column '%s' in %s is ambiguous",
   },
   1053 => {
      err => '08S01',
      err_etc => 'ER_SERVER_SHUTDOWN',
      err_desc => "Server shutdown in progress",
   },
   1054 => {
      err => '42S22',
      err_etc => 'ER_BAD_FIELD_ERROR',
      err_desc => "Unknown column '%s' in '%s'",
   },
   1055 => {
      err => '42000',
      err_etc => 'ER_WRONG_FIELD_WITH_GROUP',
      err_desc => "'%s' isn't in GROUP BY",
   },
   1056 => {
      err => '42000',
      err_etc => 'ER_WRONG_GROUP_FIELD',
      err_desc => "Can't group on '%s'",
   },
   1057 => {
      err => '42000',
      err_etc => 'ER_WRONG_SUM_SELECT',
      err_desc => "Statement has sum functions and columns in same statement",
   },
   1058 => {
      err => '21S01',
      err_etc => 'ER_WRONG_VALUE_COUNT',
      err_desc => "Column count doesn't match value count",
   },
   1059 => {
      err => '42000',
      err_etc => 'ER_TOO_LONG_IDENT',
      err_desc => "Identifier name '%s' is too long",
   },
   1060 => {
      err => '42S21',
      err_etc => 'ER_DUP_FIELDNAME',
      err_desc => "Duplicate column name '%s'",
   },
   1061 => {
      err => '42000',
      err_etc => 'ER_DUP_KEYNAME',
      err_desc => "Duplicate key name '%s'",
   },
   1062 => {
      err => '23000',
      err_etc => 'ER_DUP_ENTRY',
      err_desc => "Duplicate entry '%s' for key %d",
   },
   1063 => {
      err => '42000',
      err_etc => 'ER_WRONG_FIELD_SPEC',
      err_desc => "Incorrect column specifier for column '%s'",
   },
   1064 => {
      err => '42000',
      err_etc => 'ER_PARSE_ERROR',
      err_desc => "%s near '%s' at line %d",
   },
   1065 => {
      err => '42000',
      err_etc => 'ER_EMPTY_QUERY',
      err_desc => "Query was empty",
   },
   1066 => {
      err => '42000',
      err_etc => 'ER_NONUNIQ_TABLE',
      err_desc => "Not unique table/alias: '%s'",
   },
   1067 => {
      err => '42000',
      err_etc => 'ER_INVALID_DEFAULT',
      err_desc => "Invalid default value for '%s'",
   },
   1068 => {
      err => '42000',
      err_etc => 'ER_MULTIPLE_PRI_KEY',
      err_desc => "Multiple primary key defined",
   },
   1069 => {
      err => '42000',
      err_etc => 'ER_TOO_MANY_KEYS',
      err_desc => "Too many keys specified; max %d keys allowed",
   },
   1070 => {
      err => '42000',
      err_etc => 'ER_TOO_MANY_KEY_PARTS',
      err_desc => "Too many key parts specified; max %d parts allowed",
   },
   1071 => {
      err => '42000',
      err_etc => 'ER_TOO_LONG_KEY',
      err_desc => "Specified key was too long; max key length is %d bytes",
   },
   1072 => {
      err => '42000',
      err_etc => 'ER_KEY_COLUMN_DOES_NOT_EXITS',
      err_desc => "Key column '%s' doesn't exist in table",
   },
   1073 => {
      err => '42000',
      err_etc => 'ER_BLOB_USED_AS_KEY',
      err_desc => "BLOB column '%s' can't be used in key specification with the used table type",
   },
   1074 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_FIELDLENGTH',
      err_desc => "Column length too big for column '%s' (max = %lu); use BLOB or TEXT instead",
   },
   1075 => {
      err => '42000',
      err_etc => 'ER_WRONG_AUTO_KEY',
      err_desc => "Incorrect table definition; there can be only one auto column and it must be defined as a key",
   },
   1076 => {
      err => 'HY000',
      err_etc => 'ER_READY',
      err_desc => "%s: ready for connections. Version: '%s' socket: '%s' port: %d",
   },
   1077 => {
      err => 'HY000',
      err_etc => 'ER_NORMAL_SHUTDOWN',
      err_desc => "%s: Normal shutdown",
   },
   1078 => {
      err => 'HY000',
      err_etc => 'ER_GOT_SIGNAL',
      err_desc => "%s: Got signal %d. Aborting!",
   },
   1079 => {
      err => 'HY000',
      err_etc => 'ER_SHUTDOWN_COMPLETE',
      err_desc => "%s: Shutdown complete",
   },
   1080 => {
      err => '08S01',
      err_etc => 'ER_FORCING_CLOSE',
      err_desc => "%s: Forcing close of thread %ld user: '%s'",
   },
   1081 => {
      err => '08S01',
      err_etc => 'ER_IPSOCK_ERROR',
      err_desc => "Can't create IP socket",
   },
   1082 => {
      err => '42S12',
      err_etc => 'ER_NO_SUCH_INDEX',
      err_desc => "Table '%s' has no index like the one used in CREATE INDEX; recreate the table",
   },
   1083 => {
      err => '42000',
      err_etc => 'ER_WRONG_FIELD_TERMINATORS',
      err_desc => "Field separator argument is not what is expected; check the manual",
   },
   1084 => {
      err => '42000',
      err_etc => 'ER_BLOBS_AND_NO_TERMINATED',
      err_desc => "You can't use fixed rowlength with BLOBs; please use 'fields terminated by'",
   },
   1085 => {
      err => 'HY000',
      err_etc => 'ER_TEXTFILE_NOT_READABLE',
      err_desc => "The file '%s' must be in the database directory or be readable by all",
   },
   1086 => {
      err => 'HY000',
      err_etc => 'ER_FILE_EXISTS_ERROR',
      err_desc => "File '%s' already exists",
   },
   1087 => {
      err => 'HY000',
      err_etc => 'ER_LOAD_INFO',
      err_desc => "Records: %ld Deleted: %ld Skipped: %ld Warnings: %ld",
   },
   1088 => {
      err => 'HY000',
      err_etc => 'ER_ALTER_INFO',
      err_desc => "Records: %ld Duplicates: %ld",
   },
   1089 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_SUB_KEY',
      err_desc => "Incorrect prefix key; the used key part isn't a string, the used length is longer than the key part, or the storage engine doesn't support unique prefix keys",
   },
   1090 => {
      err => '42000',
      err_etc => 'ER_CANT_REMOVE_ALL_FIELDS',
      err_desc => "You can't delete all columns with ALTER TABLE; use DROP TABLE instead",
   },
   1091 => {
      err => '42000',
      err_etc => 'ER_CANT_DROP_FIELD_OR_KEY',
      err_desc => "Can't DROP '%s'; check that column/key exists",
   },
   1092 => {
      err => 'HY000',
      err_etc => 'ER_INSERT_INFO',
      err_desc => "Records: %ld Duplicates: %ld Warnings: %ld",
   },
   1093 => {
      err => 'HY000',
      err_etc => 'ER_UPDATE_TABLE_USED',
      err_desc => "You can't specify target table '%s' for update in FROM clause",
   },
   1094 => {
      err => 'HY000',
      err_etc => 'ER_NO_SUCH_THREAD',
      err_desc => "Unknown thread id: %lu",
   },
   1095 => {
      err => 'HY000',
      err_etc => 'ER_KILL_DENIED_ERROR',
      err_desc => "You are not owner of thread %lu",
   },
   1096 => {
      err => 'HY000',
      err_etc => 'ER_NO_TABLES_USED',
      err_desc => "No tables used",
   },
   1097 => {
      err => 'HY000',
      err_etc => 'ER_TOO_BIG_SET',
      err_desc => "Too many strings for column %s and SET",
   },
   1098 => {
      err => 'HY000',
      err_etc => 'ER_NO_UNIQUE_LOGFILE',
      err_desc => "Can't generate a unique log-filename %s.(1-999)",
   },
   1099 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_NOT_LOCKED_FOR_WRITE',
      err_desc => "Table '%s' was locked with a READ lock and can't be updated",
   },
   1100 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_NOT_LOCKED',
      err_desc => "Table '%s' was not locked with LOCK TABLES",
   },
   1101 => {
      err => '42000',
      err_etc => 'ER_BLOB_CANT_HAVE_DEFAULT',
      err_desc => "BLOB/TEXT column '%s' can't have a default value",
   },
   1102 => {
      err => '42000',
      err_etc => 'ER_WRONG_DB_NAME',
      err_desc => "Incorrect database name '%s'",
   },
   1103 => {
      err => '42000',
      err_etc => 'ER_WRONG_TABLE_NAME',
      err_desc => "Incorrect table name '%s'",
   },
   1104 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_SELECT',
      err_desc => "The SELECT would examine more than MAX_JOIN_SIZE rows; check your WHERE and use SET SQL_BIG_SELECTS=1 or SET SQL_MAX_JOIN_SIZE=# if the SELECT is okay",
   },
   1105 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_ERROR',
      err_desc => "Unknown error",
   },
   1106 => {
      err => '42000',
      err_etc => 'ER_UNKNOWN_PROCEDURE',
      err_desc => "Unknown procedure '%s'",
   },
   1107 => {
      err => '42000',
      err_etc => 'ER_WRONG_PARAMCOUNT_TO_PROCEDURE',
      err_desc => "Incorrect parameter count to procedure '%s'",
   },
   1108 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_PARAMETERS_TO_PROCEDURE',
      err_desc => "Incorrect parameters to procedure '%s'",
   },
   1109 => {
      err => '42S02',
      err_etc => 'ER_UNKNOWN_TABLE',
      err_desc => "Unknown table '%s' in %s",
   },
   1110 => {
      err => '42000',
      err_etc => 'ER_FIELD_SPECIFIED_TWICE',
      err_desc => "Column '%s' specified twice",
   },
   1111 => {
      err => 'HY000',
      err_etc => 'ER_INVALID_GROUP_FUNC_USE',
      err_desc => "Invalid use of group function",
   },
   1112 => {
      err => '42000',
      err_etc => 'ER_UNSUPPORTED_EXTENSION',
      err_desc => "Table '%s' uses an extension that doesn't exist in this MySQL version",
   },
   1113 => {
      err => '42000',
      err_etc => 'ER_TABLE_MUST_HAVE_COLUMNS',
      err_desc => "A table must have at least 1 column",
   },
   1114 => {
      err => 'HY000',
      err_etc => 'ER_RECORD_FILE_FULL',
      err_desc => "The table '%s' is full",
   },
   1115 => {
      err => '42000',
      err_etc => 'ER_UNKNOWN_CHARACTER_SET',
      err_desc => "Unknown character set: '%s'",
   },
   1116 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MANY_TABLES',
      err_desc => "Too many tables; MySQL can only use %d tables in a join",
   },
   1117 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MANY_FIELDS',
      err_desc => "Too many columns",
   },
   1118 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_ROWSIZE',
      err_desc => "Row size too large. The maximum row size for the used table type, not counting BLOBs, is %ld. You have to change some columns to TEXT or BLOBs",
   },
   1119 => {
      err => 'HY000',
      err_etc => 'ER_STACK_OVERRUN',
      err_desc => "Thread stack overrun: Used: %ld of a %ld stack. Use 'mysqld -O thread_stack=#' to specify a bigger stack if needed",
   },
   1120 => {
      err => '42000',
      err_etc => 'ER_WRONG_OUTER_JOIN',
      err_desc => "Cross dependency found in OUTER JOIN; examine your ON conditions",
   },
   1121 => {
      err => '42000',
      err_etc => 'ER_NULL_COLUMN_IN_INDEX',
      err_desc => "Table handler doesn't support NULL in given index. Please change column '%s' to be NOT NULL or use another handler",
   },
   1122 => {
      err => 'HY000',
      err_etc => 'ER_CANT_FIND_UDF',
      err_desc => "Can't load function '%s'",
   },
   1123 => {
      err => 'HY000',
      err_etc => 'ER_CANT_INITIALIZE_UDF',
      err_desc => "Can't initialize function '%s'; %s",
   },
   1124 => {
      err => 'HY000',
      err_etc => 'ER_UDF_NO_PATHS',
      err_desc => "No paths allowed for shared library",
   },
   1125 => {
      err => 'HY000',
      err_etc => 'ER_UDF_EXISTS',
      err_desc => "Function '%s' already exists",
   },
   1126 => {
      err => 'HY000',
      err_etc => 'ER_CANT_OPEN_LIBRARY',
      err_desc => "Can't open shared library '%s' (errno: %d %s)",
   },
   1127 => {
      err => 'HY000',
      err_etc => 'ER_CANT_FIND_DL_ENTRY',
      err_desc => "Can't find symbol '%s' in library",
   },
   1128 => {
      err => 'HY000',
      err_etc => 'ER_FUNCTION_NOT_DEFINED',
      err_desc => "Function '%s' is not defined",
   },
   1129 => {
      err => 'HY000',
      err_etc => 'ER_HOST_IS_BLOCKED',
      err_desc => "Host '%s' is blocked because of many connection errors; unblock with 'mysqladmin flush-hosts'",
   },
   1130 => {
      err => 'HY000',
      err_etc => 'ER_HOST_NOT_PRIVILEGED',
      err_desc => "Host '%s' is not allowed to connect to this MySQL server",
   },
   1131 => {
      err => '42000',
      err_etc => 'ER_PASSWORD_ANONYMOUS_USER',
      err_desc => "You are using MySQL as an anonymous user and anonymous users are not allowed to change passwords",
   },
   1132 => {
      err => '42000',
      err_etc => 'ER_PASSWORD_NOT_ALLOWED',
      err_desc => "You must have privileges to update tables in the mysql database to be able to change passwords for others",
   },
   1133 => {
      err => '42000',
      err_etc => 'ER_PASSWORD_NO_MATCH',
      err_desc => "Can't find any matching row in the user table",
   },
   1134 => {
      err => 'HY000',
      err_etc => 'ER_UPDATE_INFO',
      err_desc => "Rows matched: %ld Changed: %ld Warnings: %ld",
   },
   1135 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_THREAD',
      err_desc => "Can't create a new thread (errno %d); if you are not out of available memory, you can consult the manual for a possible OS-dependent bug",
   },
   1136 => {
      err => '21S01',
      err_etc => 'ER_WRONG_VALUE_COUNT_ON_ROW',
      err_desc => "Column count doesn't match value count at row %ld",
   },
   1137 => {
      err => 'HY000',
      err_etc => 'ER_CANT_REOPEN_TABLE',
      err_desc => "Can't reopen table: '%s'",
   },
   1138 => {
      err => '22004',
      err_etc => 'ER_INVALID_USE_OF_NULL',
      err_desc => "Invalid use of NULL value",
   },
   1139 => {
      err => '42000',
      err_etc => 'ER_REGEXP_ERROR',
      err_desc => "Got error '%s' from regexp",
   },
   1140 => {
      err => '42000',
      err_etc => 'ER_MIX_OF_GROUP_FUNC_AND_FIELDS',
      err_desc => "Mixing of GROUP columns (MIN(),MAX(),COUNT(),...) with no GROUP columns is illegal if there is no GROUP BY clause",
   },
   1141 => {
      err => '42000',
      err_etc => 'ER_NONEXISTING_GRANT',
      err_desc => "There is no such grant defined for user '%s' on host '%s'",
   },
   1142 => {
      err => '42000',
      err_etc => 'ER_TABLEACCESS_DENIED_ERROR',
      err_desc => "%s command denied to user '%s'@'%s' for table '%s'",
   },
   1143 => {
      err => '42000',
      err_etc => 'ER_COLUMNACCESS_DENIED_ERROR',
      err_desc => "%s command denied to user '%s'@'%s' for column '%s' in table '%s'",
   },
   1144 => {
      err => '42000',
      err_etc => 'ER_ILLEGAL_GRANT_FOR_TABLE',
      err_desc => "Illegal GRANT/REVOKE command; please consult the manual to see which privileges can be used",
   },
   1145 => {
      err => '42000',
      err_etc => 'ER_GRANT_WRONG_HOST_OR_USER',
      err_desc => "The host or user argument to GRANT is too long",
   },
   1146 => {
      err => '42S02',
      err_etc => 'ER_NO_SUCH_TABLE',
      err_desc => "Table '%s.%s' doesn't exist",
   },
   1147 => {
      err => '42000',
      err_etc => 'ER_NONEXISTING_TABLE_GRANT',
      err_desc => "There is no such grant defined for user '%s' on host '%s' on table '%s'",
   },
   1148 => {
      err => '42000',
      err_etc => 'ER_NOT_ALLOWED_COMMAND',
      err_desc => "The used command is not allowed with this MySQL version",
   },
   1149 => {
      err => '42000',
      err_etc => 'ER_SYNTAX_ERROR',
      err_desc => "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use",
   },
   1150 => {
      err => 'HY000',
      err_etc => 'ER_DELAYED_CANT_CHANGE_LOCK',
      err_desc => "Delayed insert thread couldn't get requested lock for table %s",
   },
   1151 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MANY_DELAYED_THREADS',
      err_desc => "Too many delayed threads in use",
   },
   1152 => {
      err => '08S01',
      err_etc => 'ER_ABORTING_CONNECTION',
      err_desc => "Aborted connection %ld to db: '%s' user: '%s' (%s)",
   },
   1153 => {
      err => '08S01',
      err_etc => 'ER_NET_PACKET_TOO_LARGE',
      err_desc => "Got a packet bigger than 'max_allowed_packet' bytes",
   },
   1154 => {
      err => '08S01',
      err_etc => 'ER_NET_READ_ERROR_FROM_PIPE',
      err_desc => "Got a read error from the connection pipe",
   },
   1155 => {
      err => '08S01',
      err_etc => 'ER_NET_FCNTL_ERROR',
      err_desc => "Got an error from fcntl()",
   },
   1156 => {
      err => '08S01',
      err_etc => 'ER_NET_PACKETS_OUT_OF_ORDER',
      err_desc => "Got packets out of order",
   },
   1157 => {
      err => '08S01',
      err_etc => 'ER_NET_UNCOMPRESS_ERROR',
      err_desc => "Couldn't uncompress communication packet",
   },
   1158 => {
      err => '08S01',
      err_etc => 'ER_NET_READ_ERROR',
      err_desc => "Got an error reading communication packets",
   },
   1159 => {
      err => '08S01',
      err_etc => 'ER_NET_READ_INTERRUPTED',
      err_desc => "Got timeout reading communication packets",
   },
   1160 => {
      err => '08S01',
      err_etc => 'ER_NET_ERROR_ON_WRITE',
      err_desc => "Got an error writing communication packets",
   },
   1161 => {
      err => '08S01',
      err_etc => 'ER_NET_WRITE_INTERRUPTED',
      err_desc => "Got timeout writing communication packets",
   },
   1162 => {
      err => '42000',
      err_etc => 'ER_TOO_LONG_STRING',
      err_desc => "Result string is longer than 'max_allowed_packet' bytes",
   },
   1163 => {
      err => '42000',
      err_etc => 'ER_TABLE_CANT_HANDLE_BLOB',
      err_desc => "The used table type doesn't support BLOB/TEXT columns",
   },
   1164 => {
      err => '42000',
      err_etc => 'ER_TABLE_CANT_HANDLE_AUTO_INCREMENT',
      err_desc => "The used table type doesn't support AUTO_INCREMENT columns",
   },
   1165 => {
      err => 'HY000',
      err_etc => 'ER_DELAYED_INSERT_TABLE_LOCKED',
      err_desc => "INSERT DELAYED can't be used with table '%s' because it is locked with LOCK TABLES",
   },
   1166 => {
      err => '42000',
      err_etc => 'ER_WRONG_COLUMN_NAME',
      err_desc => "Incorrect column name '%s'",
   },
   1167 => {
      err => '42000',
      err_etc => 'ER_WRONG_KEY_COLUMN',
      err_desc => "The used storage engine can't index column '%s'",
   },
   1168 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_MRG_TABLE',
      err_desc => "Unable to open underlying table which is differently defined or of non-MyISAM type or doesn't exist",
   },
   1169 => {
      err => '23000',
      err_etc => 'ER_DUP_UNIQUE',
      err_desc => "Can't write, because of unique constraint, to table '%s'",
   },
   1170 => {
      err => '42000',
      err_etc => 'ER_BLOB_KEY_WITHOUT_LENGTH',
      err_desc => "BLOB/TEXT column '%s' used in key specification without a key length",
   },
   1171 => {
      err => '42000',
      err_etc => 'ER_PRIMARY_CANT_HAVE_NULL',
      err_desc => "All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead",
   },
   1172 => {
      err => '42000',
      err_etc => 'ER_TOO_MANY_ROWS',
      err_desc => "Result consisted of more than one row",
   },
   1173 => {
      err => '42000',
      err_etc => 'ER_REQUIRES_PRIMARY_KEY',
      err_desc => "This table type requires a primary key",
   },
   1174 => {
      err => 'HY000',
      err_etc => 'ER_NO_RAID_COMPILED',
      err_desc => "This version of MySQL is not compiled with RAID support",
   },
   1175 => {
      err => 'HY000',
      err_etc => 'ER_UPDATE_WITHOUT_KEY_IN_SAFE_MODE',
      err_desc => "You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column",
   },
   1176 => {
      err => '42000',
      err_etc => 'ER_KEY_DOES_NOT_EXITS',
      err_desc => "Key '%s' doesn't exist in table '%s'",
   },
   1177 => {
      err => '42000',
      err_etc => 'ER_CHECK_NO_SUCH_TABLE',
      err_desc => "Can't open table",
   },
   1178 => {
      err => '42000',
      err_etc => 'ER_CHECK_NOT_IMPLEMENTED',
      err_desc => "The storage engine for the table doesn't support %s",
   },
   1179 => {
      err => '25000',
      err_etc => 'ER_CANT_DO_THIS_DURING_AN_TRANSACTION',
      err_desc => "You are not allowed to execute this command in a transaction",
   },
   1180 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_DURING_COMMIT',
      err_desc => "Got error %d during COMMIT",
   },
   1181 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_DURING_ROLLBACK',
      err_desc => "Got error %d during ROLLBACK",
   },
   1182 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_DURING_FLUSH_LOGS',
      err_desc => "Got error %d during FLUSH_LOGS",
   },
   1183 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_DURING_CHECKPOINT',
      err_desc => "Got error %d during CHECKPOINT",
   },
   1184 => {
      err => '08S01',
      err_etc => 'ER_NEW_ABORTING_CONNECTION',
      err_desc => "Aborted connection %ld to db: '%s' user: '%s' host: '%s' (%s)",
   },
   1185 => {
      err => 'HY000',
      err_etc => 'ER_DUMP_NOT_IMPLEMENTED',
      err_desc => "The storage engine for the table does not support binary table dump",
   },
   1186 => {
      err => 'HY000',
      err_etc => 'ER_FLUSH_MASTER_BINLOG_CLOSED',
      err_desc => "Binlog closed, cannot RESET MASTER",
   },
   1187 => {
      err => 'HY000',
      err_etc => 'ER_INDEX_REBUILD',
      err_desc => "Failed rebuilding the index of dumped table '%s'",
   },
   1188 => {
      err => 'HY000',
      err_etc => 'ER_MASTER',
      err_desc => "Error from master: '%s'",
   },
   1189 => {
      err => '08S01',
      err_etc => 'ER_MASTER_NET_READ',
      err_desc => "Net error reading from master",
   },
   1190 => {
      err => '08S01',
      err_etc => 'ER_MASTER_NET_WRITE',
      err_desc => "Net error writing to master",
   },
   1191 => {
      err => 'HY000',
      err_etc => 'ER_FT_MATCHING_KEY_NOT_FOUND',
      err_desc => "Can't find FULLTEXT index matching the column list",
   },
   1192 => {
      err => 'HY000',
      err_etc => 'ER_LOCK_OR_ACTIVE_TRANSACTION',
      err_desc => "Can't execute the given command because you have active locked tables or an active transaction",
   },
   1193 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_SYSTEM_VARIABLE',
      err_desc => "Unknown system variable '%s'",
   },
   1194 => {
      err => 'HY000',
      err_etc => 'ER_CRASHED_ON_USAGE',
      err_desc => "Table '%s' is marked as crashed and should be repaired",
   },
   1195 => {
      err => 'HY000',
      err_etc => 'ER_CRASHED_ON_REPAIR',
      err_desc => "Table '%s' is marked as crashed and last (automatic?) repair failed",
   },
   1196 => {
      err => 'HY000',
      err_etc => 'ER_WARNING_NOT_COMPLETE_ROLLBACK',
      err_desc => "Some non-transactional changed tables couldn't be rolled back",
   },
   1197 => {
      err => 'HY000',
      err_etc => 'ER_TRANS_CACHE_FULL',
      err_desc => "Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage; increase this mysqld variable and try again",
   },
   1198 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_MUST_STOP',
      err_desc => "This operation cannot be performed with a running slave; run STOP SLAVE first",
   },
   1199 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_NOT_RUNNING',
      err_desc => "This operation requires a running slave; configure slave and do START SLAVE",
   },
   1200 => {
      err => 'HY000',
      err_etc => 'ER_BAD_SLAVE',
      err_desc => "The server is not configured as slave; fix in config file or with CHANGE MASTER TO",
   },
   1201 => {
      err => 'HY000',
      err_etc => 'ER_MASTER_INFO',
      err_desc => "Could not initialize master info structure; more error messages can be found in the MySQL error log",
   },
   1202 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_THREAD',
      err_desc => "Could not create slave thread; check system resources",
   },
   1203 => {
      err => '42000',
      err_etc => 'ER_TOO_MANY_USER_CONNECTIONS',
      err_desc => "User %s already has more than 'max_user_connections' active connections",
   },
   1204 => {
      err => 'HY000',
      err_etc => 'ER_SET_CONSTANTS_ONLY',
      err_desc => "You may only use constant expressions with SET",
   },
   1205 => {
      err => 'HY000',
      err_etc => 'ER_LOCK_WAIT_TIMEOUT',
      err_desc => "Lock wait timeout exceeded; try restarting transaction",
   },
   1206 => {
      err => 'HY000',
      err_etc => 'ER_LOCK_TABLE_FULL',
      err_desc => "The total number of locks exceeds the lock table size",
   },
   1207 => {
      err => '25000',
      err_etc => 'ER_READ_ONLY_TRANSACTION',
      err_desc => "Update locks cannot be acquired during a READ UNCOMMITTED transaction",
   },
   1208 => {
      err => 'HY000',
      err_etc => 'ER_DROP_DB_WITH_READ_LOCK',
      err_desc => "DROP DATABASE not allowed while thread is holding global read lock",
   },
   1209 => {
      err => 'HY000',
      err_etc => 'ER_CREATE_DB_WITH_READ_LOCK',
      err_desc => "CREATE DATABASE not allowed while thread is holding global read lock",
   },
   1210 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_ARGUMENTS',
      err_desc => "Incorrect arguments to %s",
   },
   1211 => {
      err => '42000',
      err_etc => 'ER_NO_PERMISSION_TO_CREATE_USER',
      err_desc => "'%s'@'%s' is not allowed to create new users",
   },
   1212 => {
      err => 'HY000',
      err_etc => 'ER_UNION_TABLES_IN_DIFFERENT_DIR',
      err_desc => "Incorrect table definition; all MERGE tables must be in the same database",
   },
   1213 => {
      err => '40001',
      err_etc => 'ER_LOCK_DEADLOCK',
      err_desc => "Deadlock found when trying to get lock; try restarting transaction",
   },
   1214 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_CANT_HANDLE_FT',
      err_desc => "The used table type doesn't support FULLTEXT indexes",
   },
   1215 => {
      err => 'HY000',
      err_etc => 'ER_CANNOT_ADD_FOREIGN',
      err_desc => "Cannot add foreign key constraint",
   },
   1216 => {
      err => '23000',
      err_etc => 'ER_NO_REFERENCED_ROW',
      err_desc => "Cannot add or update a child row: a foreign key constraint fails",
   },
   1217 => {
      err => '23000',
      err_etc => 'ER_ROW_IS_REFERENCED',
      err_desc => "Cannot delete or update a parent row: a foreign key constraint fails",
   },
   1218 => {
      err => '08S01',
      err_etc => 'ER_CONNECT_TO_MASTER',
      err_desc => "Error connecting to master: %s",
   },
   1219 => {
      err => 'HY000',
      err_etc => 'ER_QUERY_ON_MASTER',
      err_desc => "Error running query on master: %s",
   },
   1220 => {
      err => 'HY000',
      err_etc => 'ER_ERROR_WHEN_EXECUTING_COMMAND',
      err_desc => "Error when executing command %s: %s",
   },
   1221 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_USAGE',
      err_desc => "Incorrect usage of %s and %s",
   },
   1222 => {
      err => '21000',
      err_etc => 'ER_WRONG_NUMBER_OF_COLUMNS_IN_SELECT',
      err_desc => "The used SELECT statements have a different number of columns",
   },
   1223 => {
      err => 'HY000',
      err_etc => 'ER_CANT_UPDATE_WITH_READLOCK',
      err_desc => "Can't execute the query because you have a conflicting read lock",
   },
   1224 => {
      err => 'HY000',
      err_etc => 'ER_MIXING_NOT_ALLOWED',
      err_desc => "Mixing of transactional and non-transactional tables is disabled",
   },
   1225 => {
      err => 'HY000',
      err_etc => 'ER_DUP_ARGUMENT',
      err_desc => "Option '%s' used twice in statement",
   },
   1226 => {
      err => '42000',
      err_etc => 'ER_USER_LIMIT_REACHED',
      err_desc => "User '%s' has exceeded the '%s' resource (current value: %ld)",
   },
   1227 => {
      err => '42000',
      err_etc => 'ER_SPECIFIC_ACCESS_DENIED_ERROR',
      err_desc => "Access denied; you need the %s privilege for this operation",
   },
   1228 => {
      err => 'HY000',
      err_etc => 'ER_LOCAL_VARIABLE',
      err_desc => "Variable '%s' is a SESSION variable and can't be used with SET GLOBAL",
   },
   1229 => {
      err => 'HY000',
      err_etc => 'ER_GLOBAL_VARIABLE',
      err_desc => "Variable '%s' is a GLOBAL variable and should be set with SET GLOBAL",
   },
   1230 => {
      err => '42000',
      err_etc => 'ER_NO_DEFAULT',
      err_desc => "Variable '%s' doesn't have a default value",
   },
   1231 => {
      err => '42000',
      err_etc => 'ER_WRONG_VALUE_FOR_VAR',
      err_desc => "Variable '%s' can't be set to the value of '%s'",
   },
   1232 => {
      err => '42000',
      err_etc => 'ER_WRONG_TYPE_FOR_VAR',
      err_desc => "Incorrect argument type to variable '%s'",
   },
   1233 => {
      err => 'HY000',
      err_etc => 'ER_VAR_CANT_BE_READ',
      err_desc => "Variable '%s' can only be set, not read",
   },
   1234 => {
      err => '42000',
      err_etc => 'ER_CANT_USE_OPTION_HERE',
      err_desc => "Incorrect usage/placement of '%s'",
   },
   1235 => {
      err => '42000',
      err_etc => 'ER_NOT_SUPPORTED_YET',
      err_desc => "This version of MySQL doesn't yet support '%s'",
   },
   1236 => {
      err => 'HY000',
      err_etc => 'ER_MASTER_FATAL_ERROR_READING_BINLOG',
      err_desc => "Got fatal error %d from master when reading data from binary log: '%s'",
   },
   1237 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_IGNORED_TABLE',
      err_desc => "Slave SQL thread ignored the query because of replicate-*-table rules",
   },
   1238 => {
      err => 'HY000',
      err_etc => 'ER_INCORRECT_GLOBAL_LOCAL_VAR',
      err_desc => "Variable '%s' is a %s variable",
   },
   1239 => {
      err => '42000',
      err_etc => 'ER_WRONG_FK_DEF',
      err_desc => "Incorrect foreign key definition for '%s': %s",
   },
   1240 => {
      err => 'HY000',
      err_etc => 'ER_KEY_REF_DO_NOT_MATCH_TABLE_REF',
      err_desc => "Key reference and table reference don't match",
   },
   1241 => {
      err => '21000',
      err_etc => 'ER_OPERAND_COLUMNS',
      err_desc => "Operand should contain %d column(s)",
   },
   1242 => {
      err => '21000',
      err_etc => 'ER_SUBQUERY_NO_1_ROW',
      err_desc => "Subquery returns more than 1 row",
   },
   1243 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_STMT_HANDLER',
      err_desc => "Unknown prepared statement handler (%.*s) given to %s",
   },
   1244 => {
      err => 'HY000',
      err_etc => 'ER_CORRUPT_HELP_DB',
      err_desc => "Help database is corrupt or does not exist",
   },
   1245 => {
      err => 'HY000',
      err_etc => 'ER_CYCLIC_REFERENCE',
      err_desc => "Cyclic reference on subqueries",
   },
   1246 => {
      err => 'HY000',
      err_etc => 'ER_AUTO_CONVERT',
      err_desc => "Converting column '%s' from %s to %s",
   },
   1247 => {
      err => '42S22',
      err_etc => 'ER_ILLEGAL_REFERENCE',
      err_desc => "Reference '%s' not supported (%s)",
   },
   1248 => {
      err => '42000',
      err_etc => 'ER_DERIVED_MUST_HAVE_ALIAS',
      err_desc => "Every derived table must have its own alias",
   },
   1249 => {
      err => '01000',
      err_etc => 'ER_SELECT_REDUCED',
      err_desc => "Select %u was reduced during optimization",
   },
   1250 => {
      err => '42000',
      err_etc => 'ER_TABLENAME_NOT_ALLOWED_HERE',
      err_desc => "Table '%s' from one of the SELECTs cannot be used in %s",
   },
   1251 => {
      err => '08004',
      err_etc => 'ER_NOT_SUPPORTED_AUTH_MODE',
      err_desc => "Client does not support authentication protocol requested by server; consider upgrading MySQL client",
   },
   1252 => {
      err => '42000',
      err_etc => 'ER_SPATIAL_CANT_HAVE_NULL',
      err_desc => "All parts of a SPATIAL index must be NOT NULL",
   },
   1253 => {
      err => '42000',
      err_etc => 'ER_COLLATION_CHARSET_MISMATCH',
      err_desc => "COLLATION '%s' is not valid for CHARACTER SET '%s'",
   },
   1254 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_WAS_RUNNING',
      err_desc => "Slave is already running",
   },
   1255 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_WAS_NOT_RUNNING',
      err_desc => "Slave already has been stopped",
   },
   1256 => {
      err => 'HY000',
      err_etc => 'ER_TOO_BIG_FOR_UNCOMPRESS',
      err_desc => "Uncompressed data size too large; the maximum size is %d (probably, length of uncompressed data was corrupted)",
   },
   1257 => {
      err => 'HY000',
      err_etc => 'ER_ZLIB_Z_MEM_ERROR',
      err_desc => "ZLIB: Not enough memory",
   },
   1258 => {
      err => 'HY000',
      err_etc => 'ER_ZLIB_Z_BUF_ERROR',
      err_desc => "ZLIB: Not enough room in the output buffer (probably, length of uncompressed data was corrupted)",
   },
   1259 => {
      err => 'HY000',
      err_etc => 'ER_ZLIB_Z_DATA_ERROR',
      err_desc => "ZLIB: Input data corrupted",
   },
   1260 => {
      err => 'HY000',
      err_etc => 'ER_CUT_VALUE_GROUP_CONCAT',
      err_desc => "%d line(s) were cut by GROUP_CONCAT()",
   },
   1261 => {
      err => '01000',
      err_etc => 'ER_WARN_TOO_FEW_RECORDS',
      err_desc => "Row %ld doesn't contain data for all columns",
   },
   1262 => {
      err => '01000',
      err_etc => 'ER_WARN_TOO_MANY_RECORDS',
      err_desc => "Row %ld was truncated; it contained more data than there were input columns",
   },
   1263 => {
      err => '22004',
      err_etc => 'ER_WARN_NULL_TO_NOTNULL',
      err_desc => "Column set to default value; NULL supplied to NOT NULL column '%s' at row %ld",
   },
   1264 => {
      err => '22003',
      err_etc => 'ER_WARN_DATA_OUT_OF_RANGE',
      err_desc => "Out of range value for column '%s' at row %ld",
   },
   1265 => {
      err => '01000',
      err_etc => 'WARN_DATA_TRUNCATED',
      err_desc => "Data truncated for column '%s' at row %ld",
   },
   1266 => {
      err => 'HY000',
      err_etc => 'ER_WARN_USING_OTHER_HANDLER',
      err_desc => "Using storage engine %s for table '%s'",
   },
   1267 => {
      err => 'HY000',
      err_etc => 'ER_CANT_AGGREGATE_2COLLATIONS',
      err_desc => "Illegal mix of collations (%s,%s) and (%s,%s) for operation '%s'",
   },
   1268 => {
      err => 'HY000',
      err_etc => 'ER_DROP_USER',
      err_desc => "Cannot drop one or more of the requested users",
   },
   1269 => {
      err => 'HY000',
      err_etc => 'ER_REVOKE_GRANTS',
      err_desc => "Can't revoke all privileges for one or more of the requested users",
   },
   1270 => {
      err => 'HY000',
      err_etc => 'ER_CANT_AGGREGATE_3COLLATIONS',
      err_desc => "Illegal mix of collations (%s,%s), (%s,%s), (%s,%s) for operation '%s'",
   },
   1271 => {
      err => 'HY000',
      err_etc => 'ER_CANT_AGGREGATE_NCOLLATIONS',
      err_desc => "Illegal mix of collations for operation '%s'",
   },
   1272 => {
      err => 'HY000',
      err_etc => 'ER_VARIABLE_IS_NOT_STRUCT',
      err_desc => "Variable '%s' is not a variable component (can't be used as XXXX.variable_name)",
   },
   1273 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_COLLATION',
      err_desc => "Unknown collation: '%s'",
   },
   1274 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_IGNORED_SSL_PARAMS',
      err_desc => "SSL parameters in CHANGE MASTER are ignored because this MySQL slave was compiled without SSL support; they can be used later if MySQL slave with SSL is started",
   },
   1275 => {
      err => 'HY000',
      err_etc => 'ER_SERVER_IS_IN_SECURE_AUTH_MODE',
      err_desc => "Server is running in --secure-auth mode, but '%s'@'%s' has a password in the old format; please change the password to the new format",
   },
   1276 => {
      err => 'HY000',
      err_etc => 'ER_WARN_FIELD_RESOLVED',
      err_desc => "Field or reference '%s%s%s%s%s' of SELECT #%d was resolved in SELECT #%d",
   },
   1277 => {
      err => 'HY000',
      err_etc => 'ER_BAD_SLAVE_UNTIL_COND',
      err_desc => "Incorrect parameter or combination of parameters for START SLAVE UNTIL",
   },
   1278 => {
      err => 'HY000',
      err_etc => 'ER_MISSING_SKIP_SLAVE',
      err_desc => "It is recommended to use --skip-slave-start when doing step-by-step replication with START SLAVE UNTIL; otherwise, you will get problems if you get an unexpected slave's mysqld restart",
   },
   1279 => {
      err => 'HY000',
      err_etc => 'ER_UNTIL_COND_IGNORED',
      err_desc => "SQL thread is not to be started so UNTIL options are ignored",
   },
   1280 => {
      err => '42000',
      err_etc => 'ER_WRONG_NAME_FOR_INDEX',
      err_desc => "Incorrect index name '%s'",
   },
   1281 => {
      err => '42000',
      err_etc => 'ER_WRONG_NAME_FOR_CATALOG',
      err_desc => "Incorrect catalog name '%s'",
   },
   1282 => {
      err => 'HY000',
      err_etc => 'ER_WARN_QC_RESIZE',
      err_desc => "Query cache failed to set size %lu; new query cache size is %lu",
   },
   1283 => {
      err => 'HY000',
      err_etc => 'ER_BAD_FT_COLUMN',
      err_desc => "Column '%s' cannot be part of FULLTEXT index",
   },
   1284 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_KEY_CACHE',
      err_desc => "Unknown key cache '%s'",
   },
   1285 => {
      err => 'HY000',
      err_etc => 'ER_WARN_HOSTNAME_WONT_WORK',
      err_desc => "MySQL is started in --skip-name-resolve mode; you must restart it without this switch for this grant to work",
   },
   1286 => {
      err => '42000',
      err_etc => 'ER_UNKNOWN_STORAGE_ENGINE',
      err_desc => "Unknown table engine '%s'",
   },
   1287 => {
      err => 'HY000',
      err_etc => 'ER_WARN_DEPRECATED_SYNTAX',
      err_desc => "'%s' is deprecated; use '%s' instead",
   },
   1288 => {
      err => 'HY000',
      err_etc => 'ER_NON_UPDATABLE_TABLE',
      err_desc => "The target table %s of the %s is not updatable",
   },
   1289 => {
      err => 'HY000',
      err_etc => 'ER_FEATURE_DISABLED',
      err_desc => "The '%s' feature is disabled; you need MySQL built with '%s' to have it working",
   },
   1290 => {
      err => 'HY000',
      err_etc => 'ER_OPTION_PREVENTS_STATEMENT',
      err_desc => "The MySQL server is running with the %s option so it cannot execute this statement",
   },
   1291 => {
      err => 'HY000',
      err_etc => 'ER_DUPLICATED_VALUE_IN_TYPE',
      err_desc => "Column '%s' has duplicated value '%s' in %s",
   },
   1292 => {
      err => '22007',
      err_etc => 'ER_TRUNCATED_WRONG_VALUE',
      err_desc => "Truncated incorrect %s value: '%s'",
   },
   1293 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MUCH_AUTO_TIMESTAMP_COLS',
      err_desc => "Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause",
   },
   1294 => {
      err => 'HY000',
      err_etc => 'ER_INVALID_ON_UPDATE',
      err_desc => "Invalid ON UPDATE clause for '%s' column",
   },
   1295 => {
      err => 'HY000',
      err_etc => 'ER_UNSUPPORTED_PS',
      err_desc => "This command is not supported in the prepared statement protocol yet",
   },
   1296 => {
      err => 'HY000',
      err_etc => 'ER_GET_ERRMSG',
      err_desc => "Got error %d '%s' from %s",
   },
   1297 => {
      err => 'HY000',
      err_etc => 'ER_GET_TEMPORARY_ERRMSG',
      err_desc => "Got temporary error %d '%s' from %s",
   },
   1298 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_TIME_ZONE',
      err_desc => "Unknown or incorrect time zone: '%s'",
   },
   1299 => {
      err => 'HY000',
      err_etc => 'ER_WARN_INVALID_TIMESTAMP',
      err_desc => "Invalid TIMESTAMP value in column '%s' at row %ld",
   },
   1300 => {
      err => 'HY000',
      err_etc => 'ER_INVALID_CHARACTER_STRING',
      err_desc => "Invalid %s character string: '%s'",
   },
   1301 => {
      err => 'HY000',
      err_etc => 'ER_WARN_ALLOWED_PACKET_OVERFLOWED',
      err_desc => "Result of %s() was larger than max_allowed_packet (%ld) - truncated",
   },
   1302 => {
      err => 'HY000',
      err_etc => 'ER_CONFLICTING_DECLARATIONS',
      err_desc => "Conflicting declarations: '%s%s' and '%s%s'",
   },
   1303 => {
      err => '2F003',
      err_etc => 'ER_SP_NO_RECURSIVE_CREATE',
      err_desc => "Can't create a %s from within another stored routine",
   },
   1304 => {
      err => '42000',
      err_etc => 'ER_SP_ALREADY_EXISTS',
      err_desc => "%s %s already exists",
   },
   1305 => {
      err => '42000',
      err_etc => 'ER_SP_DOES_NOT_EXIST',
      err_desc => "%s %s does not exist",
   },
   1306 => {
      err => 'HY000',
      err_etc => 'ER_SP_DROP_FAILED',
      err_desc => "Failed to DROP %s %s",
   },
   1307 => {
      err => 'HY000',
      err_etc => 'ER_SP_STORE_FAILED',
      err_desc => "Failed to CREATE %s %s",
   },
   1308 => {
      err => '42000',
      err_etc => 'ER_SP_LILABEL_MISMATCH',
      err_desc => "%s with no matching label: %s",
   },
   1309 => {
      err => '42000',
      err_etc => 'ER_SP_LABEL_REDEFINE',
      err_desc => "Redefining label %s",
   },
   1310 => {
      err => '42000',
      err_etc => 'ER_SP_LABEL_MISMATCH',
      err_desc => "End-label %s without match",
   },
   1311 => {
      err => '01000',
      err_etc => 'ER_SP_UNINIT_VAR',
      err_desc => "Referring to uninitialized variable %s",
   },
   1312 => {
      err => '0A000',
      err_etc => 'ER_SP_BADSELECT',
      err_desc => "PROCEDURE %s can't return a result set in the given context",
   },
   1313 => {
      err => '42000',
      err_etc => 'ER_SP_BADRETURN',
      err_desc => "RETURN is only allowed in a FUNCTION",
   },
   1314 => {
      err => '0A000',
      err_etc => 'ER_SP_BADSTATEMENT',
      err_desc => "%s is not allowed in stored procedures",
   },
   1315 => {
      err => '42000',
      err_etc => 'ER_UPDATE_LOG_DEPRECATED_IGNORED',
      err_desc => "The update log is deprecated and replaced by the binary log; SET SQL_LOG_UPDATE has been ignored",
   },
   1316 => {
      err => '42000',
      err_etc => 'ER_UPDATE_LOG_DEPRECATED_TRANSLATED',
      err_desc => "The update log is deprecated and replaced by the binary log; SET SQL_LOG_UPDATE has been translated to SET SQL_LOG_BIN",
   },
   1317 => {
      err => '70100',
      err_etc => 'ER_QUERY_INTERRUPTED',
      err_desc => "Query execution was interrupted",
   },
   1318 => {
      err => '42000',
      err_etc => 'ER_SP_WRONG_NO_OF_ARGS',
      err_desc => "Incorrect number of arguments for %s %s; expected %u, got %u",
   },
   1319 => {
      err => '42000',
      err_etc => 'ER_SP_COND_MISMATCH',
      err_desc => "Undefined CONDITION: %s",
   },
   1320 => {
      err => '42000',
      err_etc => 'ER_SP_NORETURN',
      err_desc => "No RETURN found in FUNCTION %s",
   },
   1321 => {
      err => '2F005',
      err_etc => 'ER_SP_NORETURNEND',
      err_desc => "FUNCTION %s ended without RETURN",
   },
   1322 => {
      err => '42000',
      err_etc => 'ER_SP_BAD_CURSOR_QUERY',
      err_desc => "Cursor statement must be a SELECT",
   },
   1323 => {
      err => '42000',
      err_etc => 'ER_SP_BAD_CURSOR_SELECT',
      err_desc => "Cursor SELECT must not have INTO",
   },
   1324 => {
      err => '42000',
      err_etc => 'ER_SP_CURSOR_MISMATCH',
      err_desc => "Undefined CURSOR: %s",
   },
   1325 => {
      err => '24000',
      err_etc => 'ER_SP_CURSOR_ALREADY_OPEN',
      err_desc => "Cursor is already open",
   },
   1326 => {
      err => '24000',
      err_etc => 'ER_SP_CURSOR_NOT_OPEN',
      err_desc => "Cursor is not open",
   },
   1327 => {
      err => '42000',
      err_etc => 'ER_SP_UNDECLARED_VAR',
      err_desc => "Undeclared variable: %s",
   },
   1328 => {
      err => 'HY000',
      err_etc => 'ER_SP_WRONG_NO_OF_FETCH_ARGS',
      err_desc => "Incorrect number of FETCH variables",
   },
   1329 => {
      err => '02000',
      err_etc => 'ER_SP_FETCH_NO_DATA',
      err_desc => "No data - zero rows fetched, selected, or processed",
   },
   1330 => {
      err => '42000',
      err_etc => 'ER_SP_DUP_PARAM',
      err_desc => "Duplicate parameter: %s",
   },
   1331 => {
      err => '42000',
      err_etc => 'ER_SP_DUP_VAR',
      err_desc => "Duplicate variable: %s",
   },
   1332 => {
      err => '42000',
      err_etc => 'ER_SP_DUP_COND',
      err_desc => "Duplicate condition: %s",
   },
   1333 => {
      err => '42000',
      err_etc => 'ER_SP_DUP_CURS',
      err_desc => "Duplicate cursor: %s",
   },
   1334 => {
      err => 'HY000',
      err_etc => 'ER_SP_CANT_ALTER',
      err_desc => "Failed to ALTER %s %s",
   },
   1335 => {
      err => '0A000',
      err_etc => 'ER_SP_SUBSELECT_NYI',
      err_desc => "Subquery value not supported",
   },
   1336 => {
      err => '0A000',
      err_etc => 'ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG',
      err_desc => "%s is not allowed in stored function or trigger",
   },
   1337 => {
      err => '42000',
      err_etc => 'ER_SP_VARCOND_AFTER_CURSHNDLR',
      err_desc => "Variable or condition declaration after cursor or handler declaration",
   },
   1338 => {
      err => '42000',
      err_etc => 'ER_SP_CURSOR_AFTER_HANDLER',
      err_desc => "Cursor declaration after handler declaration",
   },
   1339 => {
      err => '20000',
      err_etc => 'ER_SP_CASE_NOT_FOUND',
      err_desc => "Case not found for CASE statement",
   },
   1340 => {
      err => 'HY000',
      err_etc => 'ER_FPARSER_TOO_BIG_FILE',
      err_desc => "Configuration file '%s' is too big",
   },
   1341 => {
      err => 'HY000',
      err_etc => 'ER_FPARSER_BAD_HEADER',
      err_desc => "Malformed file type header in file '%s'",
   },
   1342 => {
      err => 'HY000',
      err_etc => 'ER_FPARSER_EOF_IN_COMMENT',
      err_desc => "Unexpected end of file while parsing comment '%s'",
   },
   1343 => {
      err => 'HY000',
      err_etc => 'ER_FPARSER_ERROR_IN_PARAMETER',
      err_desc => "Error while parsing parameter '%s' (line: '%s')",
   },
   1344 => {
      err => 'HY000',
      err_etc => 'ER_FPARSER_EOF_IN_UNKNOWN_PARAMETER',
      err_desc => "Unexpected end of file while skipping unknown parameter '%s'",
   },
   1345 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_NO_EXPLAIN',
      err_desc => "EXPLAIN/SHOW can not be issued; lacking privileges for underlying table",
   },
   1346 => {
      err => 'HY000',
      err_etc => 'ER_FRM_UNKNOWN_TYPE',
      err_desc => "File '%s' has unknown type '%s' in its header",
   },
   1347 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_OBJECT',
      err_desc => "'%s.%s' is not %s",
   },
   1348 => {
      err => 'HY000',
      err_etc => 'ER_NONUPDATEABLE_COLUMN',
      err_desc => "Column '%s' is not updatable",
   },
   1349 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_SELECT_DERIVED',
      err_desc => "View's SELECT contains a subquery in the FROM clause",
   },
   1350 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_SELECT_CLAUSE',
      err_desc => "View's SELECT contains a '%s' clause",
   },
   1351 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_SELECT_VARIABLE',
      err_desc => "View's SELECT contains a variable or parameter",
   },
   1352 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_SELECT_TMPTABLE',
      err_desc => "View's SELECT refers to a temporary table '%s'",
   },
   1353 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_WRONG_LIST',
      err_desc => "View's SELECT and view's field list have different column counts",
   },
   1354 => {
      err => 'HY000',
      err_etc => 'ER_WARN_VIEW_MERGE',
      err_desc => "View merge algorithm can't be used here for now (assumed undefined algorithm)",
   },
   1355 => {
      err => 'HY000',
      err_etc => 'ER_WARN_VIEW_WITHOUT_KEY',
      err_desc => "ew being updated does not have complete key of underlying table in it",
   },
   1356 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_INVALID',
      err_desc => "View '%s.%s' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them",
   },
   1357 => {
      err => 'HY000',
      err_etc => 'ER_SP_NO_DROP_SP',
      err_desc => "Can't drop or alter a %s from within another stored routine",
   },
   1358 => {
      err => 'HY000',
      err_etc => 'ER_SP_GOTO_IN_HNDLR',
      err_desc => "GOTO is not allowed in a stored procedure handler",
   },
   1359 => {
      err => 'HY000',
      err_etc => 'ER_TRG_ALREADY_EXISTS',
      err_desc => "Trigger already exists",
   },
   1360 => {
      err => 'HY000',
      err_etc => 'ER_TRG_DOES_NOT_EXIST',
      err_desc => "Trigger does not exist",
   },
   1361 => {
      err => 'HY000',
      err_etc => 'ER_TRG_ON_VIEW_OR_TEMP_TABLE',
      err_desc => "Trigger's '%s' is view or temporary table",
   },
   1362 => {
      err => 'HY000',
      err_etc => 'ER_TRG_CANT_CHANGE_ROW',
      err_desc => "Updating of %s row is not allowed in %strigger",
   },
   1363 => {
      err => 'HY000',
      err_etc => 'ER_TRG_NO_SUCH_ROW_IN_TRG',
      err_desc => "There is no %s row in %s trigger",
   },
   1364 => {
      err => 'HY000',
      err_etc => 'ER_NO_DEFAULT_FOR_FIELD',
      err_desc => "Field '%s' doesn't have a default value",
   },
   1365 => {
      err => '22012',
      err_etc => 'ER_DIVISION_BY_ZERO',
      err_desc => "Division by 0",
   },
   1366 => {
      err => 'HY000',
      err_etc => 'ER_TRUNCATED_WRONG_VALUE_FOR_FIELD',
      err_desc => "Incorrect %s value: '%s' for column '%s' at row %ld",
   },
   1367 => {
      err => '22007',
      err_etc => 'ER_ILLEGAL_VALUE_FOR_TYPE',
      err_desc => "Illegal %s '%s' value found during parsing",
   },
   1368 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_NONUPD_CHECK',
      err_desc => "CHECK OPTION on non-updatable view '%s.%s'",
   },
   1369 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_CHECK_FAILED',
      err_desc => "CHECK OPTION failed '%s.%s'",
   },
   1370 => {
      err => '42000',
      err_etc => 'ER_PROCACCESS_DENIED_ERROR',
      err_desc => "%s command denied to user '%s'@'%s' for routine '%s'",
   },
   1371 => {
      err => 'HY000',
      err_etc => 'ER_RELAY_LOG_FAIL',
      err_desc => "Failed purging old relay logs: %s",
   },
   1372 => {
      err => 'HY000',
      err_etc => 'ER_PASSWD_LENGTH',
      err_desc => "Password hash should be a %d-digit hexadecimal number",
   },
   1373 => {
      err => 'HY000',
      err_etc => 'ER_UNKNOWN_TARGET_BINLOG',
      err_desc => "Target log not found in binlog index",
   },
   1374 => {
      err => 'HY000',
      err_etc => 'ER_IO_ERR_LOG_INDEX_READ',
      err_desc => "I/O error reading log index file",
   },
   1375 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_PURGE_PROHIBITED',
      err_desc => "Server configuration does not permit binlog purge",
   },
   1376 => {
      err => 'HY000',
      err_etc => 'ER_FSEEK_FAIL',
      err_desc => "Failed on fseek()",
   },
   1377 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_PURGE_FATAL_ERR',
      err_desc => "Fatal error during log purge",
   },
   1378 => {
      err => 'HY000',
      err_etc => 'ER_LOG_IN_USE',
      err_desc => "A purgeable log is in use, will not purge",
   },
   1379 => {
      err => 'HY000',
      err_etc => 'ER_LOG_PURGE_UNKNOWN_ERR',
      err_desc => "Unknown error during log purge",
   },
   1380 => {
      err => 'HY000',
      err_etc => 'ER_RELAY_LOG_INIT',
      err_desc => "Failed initializing relay log position: %s",
   },
   1381 => {
      err => 'HY000',
      err_etc => 'ER_NO_BINARY_LOGGING',
      err_desc => "You are not using binary logging",
   },
   1382 => {
      err => 'HY000',
      err_etc => 'ER_RESERVED_SYNTAX',
      err_desc => "The '%s' syntax is reserved for purposes internal to the MySQL server",
   },
   1383 => {
      err => 'HY000',
      err_etc => 'ER_WSAS_FAILED',
      err_desc => "WSAStartup Failed",
   },
   1384 => {
      err => 'HY000',
      err_etc => 'ER_DIFF_GROUPS_PROC',
      err_desc => "Can't handle procedures with different groups yet",
   },
   1385 => {
      err => 'HY000',
      err_etc => 'ER_NO_GROUP_FOR_PROC',
      err_desc => "Select must have a group with this procedure",
   },
   1386 => {
      err => 'HY000',
      err_etc => 'ER_ORDER_WITH_PROC',
      err_desc => "Can't use ORDER clause with this procedure",
   },
   1387 => {
      err => 'HY000',
      err_etc => 'ER_LOGGING_PROHIBIT_CHANGING_OF',
      err_desc => "Binary logging and replication forbid changing the global server %s",
   },
   1388 => {
      err => 'HY000',
      err_etc => 'ER_NO_FILE_MAPPING',
      err_desc => "Can't map file: %s, errno: %d",
   },
   1389 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_MAGIC',
      err_desc => "Wrong magic in %s",
   },
   1390 => {
      err => 'HY000',
      err_etc => 'ER_PS_MANY_PARAM',
      err_desc => "Prepared statement contains too many placeholders",
   },
   1391 => {
      err => 'HY000',
      err_etc => 'ER_KEY_PART_0',
      err_desc => "Key part '%s' length cannot be 0",
   },
   1392 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_CHECKSUM',
      err_desc => "View text checksum failed",
   },
   1393 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_MULTIUPDATE',
      err_desc => "Can not modify more than one base table through a join view '%s.%s'",
   },
   1394 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_NO_INSERT_FIELD_LIST',
      err_desc => "Can not insert into join view '%s.%s' without fields list",
   },
   1395 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_DELETE_MERGE_VIEW',
      err_desc => "Can not delete from join view '%s.%s'",
   },
   1396 => {
      err => 'HY000',
      err_etc => 'ER_CANNOT_USER',
      err_desc => "Operation %s failed for %s",
   },
   1397 => {
      err => 'XAE04',
      err_etc => 'ER_XAER_NOTA',
      err_desc => "XAER_NOTA: Unknown XID",
   },
   1398 => {
      err => 'XAE05',
      err_etc => 'ER_XAER_INVAL',
      err_desc => "XAER_INVAL: Invalid arguments (or unsupported command)",
   },
   1399 => {
      err => 'XAE07',
      err_etc => 'ER_XAER_RMFAIL',
      err_desc => "XAER_RMFAIL: The command cannot be executed when global transaction is in the %s state",
   },
   1400 => {
      err => 'XAE09',
      err_etc => 'ER_XAER_OUTSIDE',
      err_desc => "XAER_OUTSIDE: Some work is done outside global transaction",
   },
   1401 => {
      err => 'XAE03',
      err_etc => 'ER_XAER_RMERR',
      err_desc => "XAER_RMERR: Fatal error occurred in the transaction branch - check your data for consistency",
   },
   1402 => {
      err => 'XA100',
      err_etc => 'ER_XA_RBROLLBACK',
      err_desc => "XA_RBROLLBACK: Transaction branch was rolled back",
   },
   1403 => {
      err => '42000',
      err_etc => 'ER_NONEXISTING_PROC_GRANT',
      err_desc => "There is no such grant defined for user '%s' on host '%s' on routine '%s'",
   },
   1404 => {
      err => 'HY000',
      err_etc => 'ER_PROC_AUTO_GRANT_FAIL',
      err_desc => "Failed to grant EXECUTE and ALTER ROUTINE privileges",
   },
   1405 => {
      err => 'HY000',
      err_etc => 'ER_PROC_AUTO_REVOKE_FAIL',
      err_desc => "Failed to revoke all privileges to dropped routine",
   },
   1406 => {
      err => '22001',
      err_etc => 'ER_DATA_TOO_LONG',
      err_desc => "Data too long for column '%s' at row %ld",
   },
   1407 => {
      err => '42000',
      err_etc => 'ER_SP_BAD_SQLSTATE',
      err_desc => "Bad SQLSTATE: '%s'",
   },
   1408 => {
      err => 'HY000',
      err_etc => 'ER_STARTUP',
      err_desc => "%s: ready for connections. Version: '%s' socket: '%s' port: %d %s",
   },
   1409 => {
      err => 'HY000',
      err_etc => 'ER_LOAD_FROM_FIXED_SIZE_ROWS_TO_VAR',
      err_desc => "Can't load value from file with fixed size rows to variable",
   },
   1410 => {
      err => '42000',
      err_etc => 'ER_CANT_CREATE_USER_WITH_GRANT',
      err_desc => "You are not allowed to create a user with GRANT",
   },
   1411 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_VALUE_FOR_TYPE',
      err_desc => "Incorrect %s value: '%s' for function %s",
   },
   1412 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_DEF_CHANGED',
      err_desc => "Table definition has changed, please retry transaction",
   },
   1413 => {
      err => '42000',
      err_etc => 'ER_SP_DUP_HANDLER',
      err_desc => "Duplicate handler declared in the same block",
   },
   1414 => {
      err => '42000',
      err_etc => 'ER_SP_NOT_VAR_ARG',
      err_desc => "OUT or INOUT argument %d for routine %s is not a variable or NEW pseudo-variable in BEFORE trigger",
   },
   1415 => {
      err => '0A000',
      err_etc => 'ER_SP_NO_RETSET',
      err_desc => "Not allowed to return a result set from a %s",
   },
   1416 => {
      err => '22003',
      err_etc => 'ER_CANT_CREATE_GEOMETRY_OBJECT',
      err_desc => "Cannot get geometry object from data you send to the GEOMETRY field",
   },
   1417 => {
      err => 'HY000',
      err_etc => 'ER_FAILED_ROUTINE_BREAK_BINLOG',
      err_desc => "A routine failed and has neither NO SQL nor READS SQL DATA in its declaration and binary logging is enabled; if non-transactional tables were updated, the binary log will miss their changes",
   },
   1418 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_UNSAFE_ROUTINE',
      err_desc => "This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)",
   },
   1419 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_CREATE_ROUTINE_NEED_SUPER',
      err_desc => "You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)",
   },
   1420 => {
      err => 'HY000',
      err_etc => 'ER_EXEC_STMT_WITH_OPEN_CURSOR',
      err_desc => "You can't execute a prepared statement which has an open cursor associated with it. Reset the statement to re-execute it.",
   },
   1421 => {
      err => 'HY000',
      err_etc => 'ER_STMT_HAS_NO_OPEN_CURSOR',
      err_desc => "The statement (%lu) has no open cursor.",
   },
   1422 => {
      err => 'HY000',
      err_etc => 'ER_COMMIT_NOT_ALLOWED_IN_SF_OR_TRG',
      err_desc => "Explicit or implicit commit is not allowed in stored function or trigger.",
   },
   1423 => {
      err => 'HY000',
      err_etc => 'ER_NO_DEFAULT_FOR_VIEW_FIELD',
      err_desc => "Field of view '%s.%s' underlying table doesn't have a default value",
   },
   1424 => {
      err => 'HY000',
      err_etc => 'ER_SP_NO_RECURSION',
      err_desc => "Recursive stored functions and triggers are not allowed.",
   },
   1425 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_SCALE',
      err_desc => "Too big scale %d specified for column '%s'. Maximum is %lu.",
   },
   1426 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_PRECISION',
      err_desc => "Too big precision %d specified for column '%s'. Maximum is %lu.",
   },
   1427 => {
      err => '42000',
      err_etc => 'ER_M_BIGGER_THAN_D',
      err_desc => "For float(M,D), double(M,D) or decimal(M,D), M must be >= D (column '%s').",
   },
   1428 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_LOCK_OF_SYSTEM_TABLE',
      err_desc => "You can't combine write-locking of system tables with other tables or lock types",
   },
   1429 => {
      err => 'HY000',
      err_etc => 'ER_CONNECT_TO_FOREIGN_DATA_SOURCE',
      err_desc => "Unable to connect to foreign data source: %s",
   },
   1430 => {
      err => 'HY000',
      err_etc => 'ER_QUERY_ON_FOREIGN_DATA_SOURCE',
      err_desc => "There was a problem processing the query on the foreign data source. Data source error: %s",
   },
   1431 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_DATA_SOURCE_DOESNT_EXIST',
      err_desc => "The foreign data source you are trying to reference does not exist. Data source error: %s",
   },
   1432 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_DATA_STRING_INVALID_CANT_CREATE',
      err_desc => "Can't create federated table. The data source connection string '%s' is not in the correct format",
   },
   1433 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_DATA_STRING_INVALID',
      err_desc => "The data source connection string '%s' is not in the correct format",
   },
   1434 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_FEDERATED_TABLE',
      err_desc => "Can't create federated table. Foreign data src error: %s",
   },
   1435 => {
      err => 'HY000',
      err_etc => 'ER_TRG_IN_WRONG_SCHEMA',
      err_desc => "Trigger in wrong schema",
   },
   1436 => {
      err => 'HY000',
      err_etc => 'ER_STACK_OVERRUN_NEED_MORE',
      err_desc => "Thread stack overrun: %ld bytes used of a %ld byte stack, and %ld bytes needed. Use 'mysqld -O thread_stack=#' to specify a bigger stack.",
   },
   1437 => {
      err => '42000',
      err_etc => 'ER_TOO_LONG_BODY',
      err_desc => "Routine body for '%s' is too long",
   },
   1438 => {
      err => 'HY000',
      err_etc => 'ER_WARN_CANT_DROP_DEFAULT_KEYCACHE',
      err_desc => "Cannot drop default keycache",
   },
   1439 => {
      err => '42000',
      err_etc => 'ER_TOO_BIG_DISPLAYWIDTH',
      err_desc => "Display width out of range for column '%s' (max = %lu)",
   },
   1440 => {
      err => 'XAE08',
      err_etc => 'ER_XAER_DUPID',
      err_desc => "XAER_DUPID: The XID already exists",
   },
   1441 => {
      err => '22008',
      err_etc => 'ER_DATETIME_FUNCTION_OVERFLOW',
      err_desc => "Datetime function: %s field overflow",
   },
   1442 => {
      err => 'HY000',
      err_etc => 'ER_CANT_UPDATE_USED_TABLE_IN_SF_OR_TRG',
      err_desc => "Can't update table '%s' in stored function/trigger because it is already used by statement which invoked this stored function/trigger.",
   },
   1443 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_PREVENT_UPDATE',
      err_desc => "The definition of table '%s' prevents operation %s on table '%s'.",
   },
   1444 => {
      err => 'HY000',
      err_etc => 'ER_PS_NO_RECURSION',
      err_desc => "The prepared statement contains a stored routine call that refers to that same statement. It's not allowed to execute a prepared statement in such a recursive manner",
   },
   1445 => {
      err => 'HY000',
      err_etc => 'ER_SP_CANT_SET_AUTOCOMMIT',
      err_desc => "Not allowed to set autocommit from a stored function or trigger",
   },
   1446 => {
      err => 'HY000',
      err_etc => 'ER_MALFORMED_DEFINER',
      err_desc => "Definer is not fully qualified",
   },
   1447 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_FRM_NO_USER',
      err_desc => "View '%s'.'%s' has no definer information (old table format). Current user is used as definer. Please recreate the view!",
   },
   1448 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_OTHER_USER',
      err_desc => "You need the SUPER privilege for creation view with '%s'@'%s' definer",
   },
   1449 => {
      err => 'HY000',
      err_etc => 'ER_NO_SUCH_USER',
      err_desc => "The user specified as a definer ('%s'@'%s') does not exist",
   },
   1450 => {
      err => 'HY000',
      err_etc => 'ER_FORBID_SCHEMA_CHANGE',
      err_desc => "Changing schema from '%s' to '%s' is not allowed.",
   },
   1451 => {
      err => '23000',
      err_etc => 'ER_ROW_IS_REFERENCED_2',
      err_desc => "Cannot delete or update a parent row: a foreign key constraint fails (%s)",
   },
   1452 => {
      err => '23000',
      err_etc => 'ER_NO_REFERENCED_ROW_2',
      err_desc => "Cannot add or update a child row: a foreign key constraint fails (%s)",
   },
   1453 => {
      err => '42000',
      err_etc => 'ER_SP_BAD_VAR_SHADOW',
      err_desc => "Variable '%s' must be quoted with `...`, or renamed",
   },
   1454 => {
      err => 'HY000',
      err_etc => 'ER_TRG_NO_DEFINER',
      err_desc => "No definer attribute for trigger '%s'.'%s'. The trigger will be activated under the authorization of the invoker, which may have insufficient privileges. Please recreate the trigger.",
   },
   1455 => {
      err => 'HY000',
      err_etc => 'ER_OLD_FILE_FORMAT',
      err_desc => "'%s' has an old format, you should re-create the '%s' object(s)",
   },
   1456 => {
      err => 'HY000',
      err_etc => 'ER_SP_RECURSION_LIMIT',
      err_desc => "Recursive limit %d (as set by the max_sp_recursion_depth variable) was exceeded for routine %s",
   },
   1457 => {
      err => 'HY000',
      err_etc => 'ER_SP_PROC_TABLE_CORRUPT',
      err_desc => "Failed to load routine %s. The table mysql.proc is missing, corrupt, or contains bad data (internal code %d)",
   },
   1458 => {
      err => '42000',
      err_etc => 'ER_SP_WRONG_NAME',
      err_desc => "Incorrect routine name '%s'",
   },
   1459 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_NEEDS_UPGRADE',
      err_desc => "Table upgrade required. Please do "REPAIR TABLE `%s`" or dump/reload to fix it!",
   },
   1460 => {
      err => '42000',
      err_etc => 'ER_SP_NO_AGGREGATE',
      err_desc => "AGGREGATE is not supported for stored functions",
   },
   1461 => {
      err => '42000',
      err_etc => 'ER_MAX_PREPARED_STMT_COUNT_REACHED',
      err_desc => "Can't create more than max_prepared_stmt_count statements (current value: %lu)",
   },
   1462 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_RECURSIVE',
      err_desc => "`%s`.`%s` contains view recursion",
   },
   1463 => {
      err => '42000',
      err_etc => 'ER_NON_GROUPING_FIELD_USED',
      err_desc => "non-grouping field '%s' is used in %s clause",
   },
   1464 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_CANT_HANDLE_SPKEYS',
      err_desc => "The used table type doesn't support SPATIAL indexes",
   },
   1465 => {
      err => 'HY000',
      err_etc => 'ER_NO_TRIGGERS_ON_SYSTEM_SCHEMA',
      err_desc => "Triggers can not be created on system tables",
   },
   1466 => {
      err => 'HY000',
      err_etc => 'ER_REMOVED_SPACES',
      err_desc => "Leading spaces are removed from name '%s'",
   },
   1467 => {
      err => 'HY000',
      err_etc => 'ER_AUTOINC_READ_FAILED',
      err_desc => "Failed to read auto-increment value from storage engine",
   },
   1468 => {
      err => 'HY000',
      err_etc => 'ER_USERNAME',
      err_desc => "user name",
   },
   1469 => {
      err => 'HY000',
      err_etc => 'ER_HOSTNAME',
      err_desc => "host name",
   },
   1470 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_STRING_LENGTH',
      err_desc => "String '%s' is too long for %s (should be no longer than %d)",
   },
   1471 => {
      err => 'HY000',
      err_etc => 'ER_NON_INSERTABLE_TABLE',
      err_desc => "The target table %s of the %s is not insertable-into",
   },
   1472 => {
      err => 'HY000',
      err_etc => 'ER_ADMIN_WRONG_MRG_TABLE',
      err_desc => "Table '%s' is differently defined or of non-MyISAM type or doesn't exist",
   },
   1473 => {
      err => 'HY000',
      err_etc => 'ER_TOO_HIGH_LEVEL_OF_NESTING_FOR_SELECT',
      err_desc => "Too high level of nesting for select",
   },
   1474 => {
      err => 'HY000',
      err_etc => 'ER_NAME_BECOMES_EMPTY',
      err_desc => "Name '%s' has become ''",
   },
   1475 => {
      err => 'HY000',
      err_etc => 'ER_AMBIGUOUS_FIELD_TERM',
      err_desc => "First character of the FIELDS TERMINATED string is ambiguous; please use non-optional and non-empty FIELDS ENCLOSED BY",
   },
   1476 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_SERVER_EXISTS',
      err_desc => "The foreign server, %s, you are trying to create already exists.",
   },
   1477 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_SERVER_DOESNT_EXIST',
      err_desc => "The foreign server name you are trying to reference does not exist. Data source error: %s",
   },
   1478 => {
      err => 'HY000',
      err_etc => 'ER_ILLEGAL_HA_CREATE_OPTION',
      err_desc => "Table storage engine '%s' does not support the create option '%s'",
   },
   1479 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_REQUIRES_VALUES_ERROR',
      err_desc => "Syntax error: %s PARTITIONING requires definition of VALUES %s for each partition",
   },
   1480 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_WRONG_VALUES_ERROR',
      err_desc => "Only %s PARTITIONING can use VALUES %s in partition definition",
   },
   1481 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_MAXVALUE_ERROR',
      err_desc => "MAXVALUE can only be used in last partition definition",
   },
   1482 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_SUBPARTITION_ERROR',
      err_desc => "Subpartitions can only be hash partitions and by key",
   },
   1483 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_SUBPART_MIX_ERROR',
      err_desc => "Must define subpartitions on all partitions if on one partition",
   },
   1484 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_WRONG_NO_PART_ERROR',
      err_desc => "Wrong number of partitions defined, mismatch with previous setting",
   },
   1485 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_WRONG_NO_SUBPART_ERROR',
      err_desc => "Wrong number of subpartitions defined, mismatch with previous setting",
   },
   1486 => {
      err => 'HY000',
      err_etc => 'ER_CONST_EXPR_IN_PARTITION_FUNC_ERROR',
      err_desc => "Constant/Random expression in (sub)partitioning function is not allowed",
   },
   1487 => {
      err => 'HY000',
      err_etc => 'ER_NO_CONST_EXPR_IN_RANGE_OR_LIST_ERROR',
      err_desc => "Expression in RANGE/LIST VALUES must be constant",
   },
   1488 => {
      err => 'HY000',
      err_etc => 'ER_FIELD_NOT_FOUND_PART_ERROR',
      err_desc => "Field in list of fields for partition function not found in table",
   },
   1489 => {
      err => 'HY000',
      err_etc => 'ER_LIST_OF_FIELDS_ONLY_IN_HASH_ERROR',
      err_desc => "List of fields is only allowed in KEY partitions",
   },
   1490 => {
      err => 'HY000',
      err_etc => 'ER_INCONSISTENT_PARTITION_INFO_ERROR',
      err_desc => "The partition info in the frm file is not consistent with what can be written into the frm file",
   },
   1491 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_FUNC_NOT_ALLOWED_ERROR',
      err_desc => "The %s function returns the wrong type",
   },
   1492 => {
      err => 'HY000',
      err_etc => 'ER_PARTITIONS_MUST_BE_DEFINED_ERROR',
      err_desc => "For %s partitions each partition must be defined",
   },
   1493 => {
      err => 'HY000',
      err_etc => 'ER_RANGE_NOT_INCREASING_ERROR',
      err_desc => "VALUES LESS THAN value must be strictly increasing for each partition",
   },
   1494 => {
      err => 'HY000',
      err_etc => 'ER_INCONSISTENT_TYPE_OF_FUNCTIONS_ERROR',
      err_desc => "VALUES value must be of same type as partition function",
   },
   1495 => {
      err => 'HY000',
      err_etc => 'ER_MULTIPLE_DEF_CONST_IN_LIST_PART_ERROR',
      err_desc => "Multiple definition of same constant in list partitioning",
   },
   1496 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_ENTRY_ERROR',
      err_desc => "Partitioning can not be used stand-alone in query",
   },
   1497 => {
      err => 'HY000',
      err_etc => 'ER_MIX_HANDLER_ERROR',
      err_desc => "The mix of handlers in the partitions is not allowed in this version of MySQL",
   },
   1498 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_NOT_DEFINED_ERROR',
      err_desc => "For the partitioned engine it is necessary to define all %s",
   },
   1499 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MANY_PARTITIONS_ERROR',
      err_desc => "Too many partitions (including subpartitions) were defined",
   },
   1500 => {
      err => 'HY000',
      err_etc => 'ER_SUBPARTITION_ERROR',
      err_desc => "It is only possible to mix RANGE/LIST partitioning with HASH/KEY partitioning for subpartitioning",
   },
   1501 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_HANDLER_FILE',
      err_desc => "Failed to create specific handler file",
   },
   1502 => {
      err => 'HY000',
      err_etc => 'ER_BLOB_FIELD_IN_PART_FUNC_ERROR',
      err_desc => "A BLOB field is not allowed in partition function",
   },
   1503 => {
      err => 'HY000',
      err_etc => 'ER_UNIQUE_KEY_NEED_ALL_FIELDS_IN_PF',
      err_desc => "A %s must include all columns in the table's partitioning function",
   },
   1504 => {
      err => 'HY000',
      err_etc => 'ER_NO_PARTS_ERROR',
      err_desc => "Number of %s = 0 is not an allowed value",
   },
   1505 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_MGMT_ON_NONPARTITIONED',
      err_desc => "Partition management on a not partitioned table is not possible",
   },
   1506 => {
      err => 'HY000',
      err_etc => 'ER_FOREIGN_KEY_ON_PARTITIONED',
      err_desc => "Foreign key clause is not yet supported in conjunction with partitioning",
   },
   1507 => {
      err => 'HY000',
      err_etc => 'ER_DROP_PARTITION_NON_EXISTENT',
      err_desc => "Error in list of partitions to %s",
   },
   1508 => {
      err => 'HY000',
      err_etc => 'ER_DROP_LAST_PARTITION',
      err_desc => "Cannot remove all partitions, use DROP TABLE instead",
   },
   1509 => {
      err => 'HY000',
      err_etc => 'ER_COALESCE_ONLY_ON_HASH_PARTITION',
      err_desc => "COALESCE PARTITION can only be used on HASH/KEY partitions",
   },
   1510 => {
      err => 'HY000',
      err_etc => 'ER_REORG_HASH_ONLY_ON_SAME_NO',
      err_desc => "REORGANIZE PARTITION can only be used to reorganize partitions not to change their numbers",
   },
   1511 => {
      err => 'HY000',
      err_etc => 'ER_REORG_NO_PARAM_ERROR',
      err_desc => "REORGANIZE PARTITION without parameters can only be used on auto-partitioned tables using HASH PARTITIONs",
   },
   1512 => {
      err => 'HY000',
      err_etc => 'ER_ONLY_ON_RANGE_LIST_PARTITION',
      err_desc => "%s PARTITION can only be used on RANGE/LIST partitions",
   },
   1513 => {
      err => 'HY000',
      err_etc => 'ER_ADD_PARTITION_SUBPART_ERROR',
      err_desc => "Trying to Add partition(s) with wrong number of subpartitions",
   },
   1514 => {
      err => 'HY000',
      err_etc => 'ER_ADD_PARTITION_NO_NEW_PARTITION',
      err_desc => "At least one partition must be added",
   },
   1515 => {
      err => 'HY000',
      err_etc => 'ER_COALESCE_PARTITION_NO_PARTITION',
      err_desc => "At least one partition must be coalesced",
   },
   1516 => {
      err => 'HY000',
      err_etc => 'ER_REORG_PARTITION_NOT_EXIST',
      err_desc => "More partitions to reorganize than there are partitions",
   },
   1517 => {
      err => 'HY000',
      err_etc => 'ER_SAME_NAME_PARTITION',
      err_desc => "Duplicate partition name %s",
   },
   1518 => {
      err => 'HY000',
      err_etc => 'ER_NO_BINLOG_ERROR',
      err_desc => "It is not allowed to shut off binlog on this command",
   },
   1519 => {
      err => 'HY000',
      err_etc => 'ER_CONSECUTIVE_REORG_PARTITIONS',
      err_desc => "When reorganizing a set of partitions they must be in consecutive order",
   },
   1520 => {
      err => 'HY000',
      err_etc => 'ER_REORG_OUTSIDE_RANGE',
      err_desc => "Reorganize of range partitions cannot change total ranges except for last partition where it can extend the range",
   },
   1521 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_FUNCTION_FAILURE',
      err_desc => "Partition function not supported in this version for this handler",
   },
   1522 => {
      err => 'HY000',
      err_etc => 'ER_PART_STATE_ERROR',
      err_desc => "Partition state cannot be defined from CREATE/ALTER TABLE",
   },
   1523 => {
      err => 'HY000',
      err_etc => 'ER_LIMITED_PART_RANGE',
      err_desc => "The %s handler only supports 32 bit integers in VALUES",
   },
   1524 => {
      err => 'HY000',
      err_etc => 'ER_PLUGIN_IS_NOT_LOADED',
      err_desc => "Plugin '%s' is not loaded",
   },
   1525 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_VALUE',
      err_desc => "Incorrect %s value: '%s'",
   },
   1526 => {
      err => 'HY000',
      err_etc => 'ER_NO_PARTITION_FOR_GIVEN_VALUE',
      err_desc => "Table has no partition for value %s",
   },
   1527 => {
      err => 'HY000',
      err_etc => 'ER_FILEGROUP_OPTION_ONLY_ONCE',
      err_desc => "It is not allowed to specify %s more than once",
   },
   1528 => {
      err => 'HY000',
      err_etc => 'ER_CREATE_FILEGROUP_FAILED',
      err_desc => "Failed to create %s",
   },
   1529 => {
      err => 'HY000',
      err_etc => 'ER_DROP_FILEGROUP_FAILED',
      err_desc => "Failed to drop %s",
   },
   1530 => {
      err => 'HY000',
      err_etc => 'ER_TABLESPACE_AUTO_EXTEND_ERROR',
      err_desc => "The handler doesn't support autoextend of tablespaces",
   },
   1531 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_SIZE_NUMBER',
      err_desc => "A size parameter was incorrectly specified, either number or on the form 10M",
   },
   1532 => {
      err => 'HY000',
      err_etc => 'ER_SIZE_OVERFLOW_ERROR',
      err_desc => "The size number was correct but we don't allow the digit part to be more than 2 billion",
   },
   1533 => {
      err => 'HY000',
      err_etc => 'ER_ALTER_FILEGROUP_FAILED',
      err_desc => "Failed to alter: %s",
   },
   1534 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_ROW_LOGGING_FAILED',
      err_desc => "Writing one row to the row-based binary log failed",
   },
   1535 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_ROW_WRONG_TABLE_DEF',
      err_desc => "Table definition on master and slave does not match: %s",
   },
   1536 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_ROW_RBR_TO_SBR',
      err_desc => "Slave running with --log-slave-updates must use row-based binary logging to be able to replicate row-based binary log events",
   },
   1537 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_ALREADY_EXISTS',
      err_desc => "Event '%s' already exists",
   },
   1538 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_STORE_FAILED',
      err_desc => "Failed to store event %s. Error code %d from storage engine.",
   },
   1539 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_DOES_NOT_EXIST',
      err_desc => "Unknown event '%s'",
   },
   1540 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_CANT_ALTER',
      err_desc => "Failed to alter event '%s'",
   },
   1541 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_DROP_FAILED',
      err_desc => "Failed to drop %s",
   },
   1542 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_INTERVAL_NOT_POSITIVE_OR_TOO_BIG',
      err_desc => "INTERVAL is either not positive or too big",
   },
   1543 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_ENDS_BEFORE_STARTS',
      err_desc => "ENDS is either invalid or before STARTS",
   },
   1544 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_EXEC_TIME_IN_THE_PAST',
      err_desc => "Event execution time is in the past. Event has been disabled",
   },
   1545 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_OPEN_TABLE_FAILED',
      err_desc => "Failed to open mysql.event",
   },
   1546 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_NEITHER_M_EXPR_NOR_M_AT',
      err_desc => "No datetime expression provided",
   },
   1547 => {
      err => 'HY000',
      err_etc => 'ER_COL_COUNT_DOESNT_MATCH_CORRUPTED',
      err_desc => "Column count of mysql.%s is wrong. Expected %d, found %d. The table is probably corrupted",
   },
   1548 => {
      err => 'HY000',
      err_etc => 'ER_CANNOT_LOAD_FROM_TABLE',
      err_desc => "Cannot load from mysql.%s. The table is probably corrupted",
   },
   1549 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_CANNOT_DELETE',
      err_desc => "Failed to delete the event from mysql.event",
   },
   1550 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_COMPILE_ERROR',
      err_desc => "Error during compilation of event's body",
   },
   1551 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_SAME_NAME',
      err_desc => "Same old and new event name",
   },
   1552 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_DATA_TOO_LONG',
      err_desc => "Data for column '%s' too long",
   },
   1553 => {
      err => 'HY000',
      err_etc => 'ER_DROP_INDEX_FK',
      err_desc => "Cannot drop index '%s': needed in a foreign key constraint",
   },
   1554 => {
      err => 'HY000',
      err_etc => 'ER_WARN_DEPRECATED_SYNTAX_WITH_VER',
      err_desc => "The syntax '%s' is deprecated and will be removed in MySQL %s. Please use %s instead",
   },
   1555 => {
      err => 'HY000',
      err_etc => 'ER_CANT_WRITE_LOCK_LOG_TABLE',
      err_desc => "You can't write-lock a log table. Only read access is possible",
   },
   1556 => {
      err => 'HY000',
      err_etc => 'ER_CANT_LOCK_LOG_TABLE',
      err_desc => "You can't use locks with log tables.",
   },
   1557 => {
      err => '23000',
      err_etc => 'ER_FOREIGN_DUPLICATE_KEY',
      err_desc => "Upholding foreign key constraints for table '%s', entry '%s', key %d would lead to a duplicate entry",
   },
   1558 => {
      err => 'HY000',
      err_etc => 'ER_COL_COUNT_DOESNT_MATCH_PLEASE_UPDATE',
      err_desc => "Column count of mysql.%s is wrong. Expected %d, found %d. Created with MySQL %d, now running %d. Please use mysql_upgrade to fix this error.",
   },
   1559 => {
      err => 'HY000',
      err_etc => 'ER_TEMP_TABLE_PREVENTS_SWITCH_OUT_OF_RBR',
      err_desc => "Cannot switch out of the row-based binary log format when the session has open temporary tables",
   },
   1560 => {
      err => 'HY000',
      err_etc => 'ER_STORED_FUNCTION_PREVENTS_SWITCH_BINLOG_FORMAT',
      err_desc => "Cannot change the binary logging format inside a stored function or trigger",
   },
   1561 => {
      err => 'HY000',
      err_etc => 'ER_NDB_CANT_SWITCH_BINLOG_FORMAT',
      err_desc => "The NDB cluster engine does not support changing the binlog format on the fly yet",
   },
   1562 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_NO_TEMPORARY',
      err_desc => "Cannot create temporary table with partitions",
   },
   1563 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_CONST_DOMAIN_ERROR',
      err_desc => "Partition constant is out of partition function domain",
   },
   1564 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_FUNCTION_IS_NOT_ALLOWED',
      err_desc => "This partition function is not allowed",
   },
   1565 => {
      err => 'HY000',
      err_etc => 'ER_DDL_LOG_ERROR',
      err_desc => "Error in DDL log",
   },
   1566 => {
      err => 'HY000',
      err_etc => 'ER_NULL_IN_VALUES_LESS_THAN',
      err_desc => "Not allowed to use NULL value in VALUES LESS THAN",
   },
   1567 => {
      err => 'HY000',
      err_etc => 'ER_WRONG_PARTITION_NAME',
      err_desc => "Incorrect partition name",
   },
   1568 => {
      err => '25001',
      err_etc => 'ER_CANT_CHANGE_TX_ISOLATION',
      err_desc => "Transaction isolation level can't be changed while a transaction is in progress",
   },
   1569 => {
      err => 'HY000',
      err_etc => 'ER_DUP_ENTRY_AUTOINCREMENT_CASE',
      err_desc => "ALTER TABLE causes auto_increment resequencing, resulting in duplicate entry '%s' for key '%s'",
   },
   1570 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_MODIFY_QUEUE_ERROR',
      err_desc => "Internal scheduler error %d",
   },
   1571 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_SET_VAR_ERROR',
      err_desc => "Error during starting/stopping of the scheduler. Error code %u",
   },
   1572 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_MERGE_ERROR',
      err_desc => "Engine cannot be used in partitioned tables",
   },
   1573 => {
      err => 'HY000',
      err_etc => 'ER_CANT_ACTIVATE_LOG',
      err_desc => "Cannot activate '%s' log",
   },
   1574 => {
      err => 'HY000',
      err_etc => 'ER_RBR_NOT_AVAILABLE',
      err_desc => "The server was not built with row-based replication",
   },
   1575 => {
      err => 'HY000',
      err_etc => 'ER_BASE64_DECODE_ERROR',
      err_desc => "Decoding of base64 string failed",
   },
   1576 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_RECURSION_FORBIDDEN',
      err_desc => "Recursion of EVENT DDL statements is forbidden when body is present",
   },
   1577 => {
      err => 'HY000',
      err_etc => 'ER_EVENTS_DB_ERROR',
      err_desc => "Cannot proceed because system tables used by Event Scheduler were found damaged at server start",
   },
   1578 => {
      err => 'HY000',
      err_etc => 'ER_ONLY_INTEGERS_ALLOWED',
      err_desc => "Only integers allowed as number here",
   },
   1579 => {
      err => 'HY000',
      err_etc => 'ER_UNSUPORTED_LOG_ENGINE',
      err_desc => "This storage engine cannot be used for log tables",
   },
   1580 => {
      err => 'HY000',
      err_etc => 'ER_BAD_LOG_STATEMENT',
      err_desc => "You cannot '%s' a log table if logging is enabled",
   },
   1581 => {
      err => 'HY000',
      err_etc => 'ER_CANT_RENAME_LOG_TABLE',
      err_desc => "Cannot rename '%s'. When logging enabled, rename to/from log table must rename two tables: the log table to an archive table and another table back to '%s'",
   },
   1582 => {
      err => '42000',
      err_etc => 'ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT',
      err_desc => "Incorrect parameter count in the call to native function '%s'",
   },
   1583 => {
      err => '42000',
      err_etc => 'ER_WRONG_PARAMETERS_TO_NATIVE_FCT',
      err_desc => "Incorrect parameters in the call to native function '%s'",
   },
   1584 => {
      err => '42000',
      err_etc => 'ER_WRONG_PARAMETERS_TO_STORED_FCT',
      err_desc => "Incorrect parameters in the call to stored function '%s'",
   },
   1585 => {
      err => 'HY000',
      err_etc => 'ER_NATIVE_FCT_NAME_COLLISION',
      err_desc => "This function '%s' has the same name as a native function",
   },
   1586 => {
      err => '23000',
      err_etc => 'ER_DUP_ENTRY_WITH_KEY_NAME',
      err_desc => "Duplicate entry '%s' for key '%s'",
   },
   1587 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_PURGE_EMFILE',
      err_desc => "Too many files opened, please execute the command again",
   },
   1588 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_CANNOT_CREATE_IN_THE_PAST',
      err_desc => "Event execution time is in the past and ON COMPLETION NOT PRESERVE is set. The event was dropped immediately after creation.",
   },
   1589 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_CANNOT_ALTER_IN_THE_PAST',
      err_desc => "Event execution time is in the past and ON COMPLETION NOT PRESERVE is set. The event was dropped immediately after creation.",
   },
   1590 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_INCIDENT',
      err_desc => "The incident %s occured on the master. Message: %s",
   },
   1591 => {
      err => 'HY000',
      err_etc => 'ER_NO_PARTITION_FOR_GIVEN_VALUE_SILENT',
      err_desc => "Table has no partition for some existing values",
   },
   1592 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_UNSAFE_STATEMENT',
      err_desc => "Statement may not be safe to log in statement format.",
   },
   1593 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_FATAL_ERROR',
      err_desc => "Fatal error: %s",
   },
   1594 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_RELAY_LOG_READ_FAILURE',
      err_desc => "Relay log read failure: %s",
   },
   1595 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_RELAY_LOG_WRITE_FAILURE',
      err_desc => "Relay log write failure: %s",
   },
   1596 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_CREATE_EVENT_FAILURE',
      err_desc => "Failed to create %s",
   },
   1597 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_MASTER_COM_FAILURE',
      err_desc => "Master command %s failed: %s",
   },
   1598 => {
      err => 'HY000',
      err_etc => 'ER_BINLOG_LOGGING_IMPOSSIBLE',
      err_desc => "Binary logging not possible. Message: %s",
   },
   1599 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_NO_CREATION_CTX',
      err_desc => "View `%s`.`%s` has no creation context",
   },
   1600 => {
      err => 'HY000',
      err_etc => 'ER_VIEW_INVALID_CREATION_CTX',
      err_desc => "Creation context of view `%s`.`%s' is invalid",
   },
   1601 => {
      err => 'HY000',
      err_etc => 'ER_SR_INVALID_CREATION_CTX',
      err_desc => "Creation context of stored routine `%s`.`%s` is invalid",
   },
   1602 => {
      err => 'HY000',
      err_etc => 'ER_TRG_CORRUPTED_FILE',
      err_desc => "Corrupted TRG file for table `%s`.`%s`",
   },
   1603 => {
      err => 'HY000',
      err_etc => 'ER_TRG_NO_CREATION_CTX',
      err_desc => "Triggers for table `%s`.`%s` have no creation context",
   },
   1604 => {
      err => 'HY000',
      err_etc => 'ER_TRG_INVALID_CREATION_CTX',
      err_desc => "Trigger creation context of table `%s`.`%s` is invalid",
   },
   1605 => {
      err => 'HY000',
      err_etc => 'ER_EVENT_INVALID_CREATION_CTX',
      err_desc => "Creation context of event `%s`.`%s` is invalid",
   },
   1606 => {
      err => 'HY000',
      err_etc => 'ER_TRG_CANT_OPEN_TABLE',
      err_desc => "Cannot open table for trigger `%s`.`%s`",
   },
   1607 => {
      err => 'HY000',
      err_etc => 'ER_CANT_CREATE_SROUTINE',
      err_desc => "Cannot create stored routine `%s`. Check warnings",
   },
   1608 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_AMBIGOUS_EXEC_MODE',
      err_desc => "Ambiguous slave modes combination. %s",
   },
   1609 => {
      err => 'HY000',
      err_etc => 'ER_NO_FORMAT_DESCRIPTION_EVENT_BEFORE_BINLOG_STATEMENT',
      err_desc => "The BINLOG statement of type `%s` was not preceded by a format description BINLOG statement.",
   },
   1610 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_CORRUPT_EVENT',
      err_desc => "Corrupted replication event was detected",
   },
   1611 => {
      err => 'HY000',
      err_etc => 'ER_LOAD_DATA_INVALID_COLUMN',
      err_desc => "Invalid column reference (%s) in LOAD DATA",
   },
   1612 => {
      err => 'HY000',
      err_etc => 'ER_LOG_PURGE_NO_FILE',
      err_desc => "Being purged log %s was not found",
   },
   1613 => {
      err => 'XA106',
      err_etc => 'ER_XA_RBTIMEOUT',
      err_desc => "XA_RBTIMEOUT: Transaction branch was rolled back: took too long",
   },
   1614 => {
      err => 'XA102',
      err_etc => 'ER_XA_RBDEADLOCK',
      err_desc => "XA_RBDEADLOCK: Transaction branch was rolled back: deadlock was detected",
   },
   1615 => {
      err => 'HY000',
      err_etc => 'ER_NEED_REPREPARE',
      err_desc => "Prepared statement needs to be re-prepared",
   },
   1616 => {
      err => 'HY000',
      err_etc => 'ER_DELAYED_NOT_SUPPORTED',
      err_desc => "DELAYED option not supported for table '%s'",
   },
   1617 => {
      err => 'HY000',
      err_etc => 'WARN_NO_MASTER_INFO',
      err_desc => "The master info structure does not exist",
   },
   1618 => {
      err => 'HY000',
      err_etc => 'WARN_OPTION_IGNORED',
      err_desc => "<%s> option ignored",
   },
   1619 => {
      err => 'HY000',
      err_etc => 'WARN_PLUGIN_DELETE_BUILTIN',
      err_desc => "Built-in plugins cannot be deleted",
   },
   1620 => {
      err => 'HY000',
      err_etc => 'WARN_PLUGIN_BUSY',
      err_desc => "Plugin is busy and will be uninstalled on shutdown",
   },
   1621 => {
      err => 'HY000',
      err_etc => 'ER_VARIABLE_IS_READONLY',
      err_desc => "%s variable '%s' is read-only. Use SET %s to assign the value",
   },
   1622 => {
      err => 'HY000',
      err_etc => 'ER_WARN_ENGINE_TRANSACTION_ROLLBACK',
      err_desc => "Storage engine %s does not support rollback for this statement. Transaction rolled back and must be restarted",
   },
   1623 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_HEARTBEAT_FAILURE',
      err_desc => "Unexpected master's heartbeat data: %s",
   },
   1624 => {
      err => 'HY000',
      err_etc => 'ER_SLAVE_HEARTBEAT_VALUE_OUT_OF_RANGE',
      err_desc => "The requested value for the heartbeat period %s %s",
   },
   1625 => {
      err => 'HY000',
      err_etc => 'ER_NDB_REPLICATION_SCHEMA_ERROR',
      err_desc => "Bad schema for mysql.ndb_replication table. Message: %s",
   },
   1626 => {
      err => 'HY000',
      err_etc => 'ER_CONFLICT_FN_PARSE_ERROR',
      err_desc => "Error in parsing conflict function. Message: %s",
   },
   1627 => {
      err => 'HY000',
      err_etc => 'ER_EXCEPTIONS_WRITE_ERROR',
      err_desc => "Write to exceptions table failed. Message: %s",
   },
   1628 => {
      err => 'HY000',
      err_etc => 'ER_TOO_LONG_TABLE_COMMENT',
      err_desc => "Comment for table '%s' is too long (max = %lu)",
   },
   1629 => {
      err => 'HY000',
      err_etc => 'ER_TOO_LONG_FIELD_COMMENT',
      err_desc => "Comment for field '%s' is too long (max = %lu)",
   },
   1630 => {
      err => '42000',
      err_etc => 'ER_FUNC_INEXISTENT_NAME_COLLISION',
      err_desc => "FUNCTION %s does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual",
   },
   1631 => {
      err => 'HY000',
      err_etc => 'ER_DATABASE_NAME',
      err_desc => "Database",
   },
   1632 => {
      err => 'HY000',
      err_etc => 'ER_TABLE_NAME',
      err_desc => "Table",
   },
   1633 => {
      err => 'HY000',
      err_etc => 'ER_PARTITION_NAME',
      err_desc => "Partition",
   },
   1634 => {
      err => 'HY000',
      err_etc => 'ER_SUBPARTITION_NAME',
      err_desc => "Subpartition",
   },
   1635 => {
      err => 'HY000',
      err_etc => 'ER_TEMPORARY_NAME',
      err_desc => "Temporary",
   },
   1636 => {
      err => 'HY000',
      err_etc => 'ER_RENAMED_NAME',
      err_desc => "Renamed",
   },
   1637 => {
      err => 'HY000',
      err_etc => 'ER_TOO_MANY_CONCURRENT_TRXS',
      err_desc => "Too many active concurrent transactions",
   },
   1638 => {
      err => 'HY000',
      err_etc => 'WARN_NON_ASCII_SEPARATOR_NOT_IMPLEMENTED',
      err_desc => "Non-ASCII separator arguments are not fully supported",
   },
   1639 => {
      err => 'HY000',
      err_etc => 'ER_DEBUG_SYNC_TIMEOUT',
      err_desc => "debug sync point wait timed out",
   },
   1640 => {
      err => 'HY000',
      err_etc => 'ER_DEBUG_SYNC_HIT_LIMIT',
      err_desc => "debug sync point hit limit reached",
   },
};
sub error_handler {
   my $string = shift;
   my @args = ( original => $string );
   my $class = 'DBIx::Exception';

   $class->throw(@args);
}

1;
