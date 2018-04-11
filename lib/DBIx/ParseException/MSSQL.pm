package DBIx::ParseException::MSSQL;

use Moo;
use DBIx::Exceptions;
use Carp 'croak';

with $_ for 'DBIx::ParseException::Role::Capabilities',
     'DBIx::ParseException::Role::ExtractFromDBH';

my %error_codes = (
   '00000' => {
         group => 'ungrouped',
         err_desc => "Success",
      },
   '01000' => {
         group => 'ungrouped',
         err_desc => "General warning",
      },
   '01002' => {
         group => 'ungrouped',
         err_desc => "Disconnect error",
      },
   '01004' => {
         group => 'ungrouped',
         err_desc => "Data truncated",
      },
   '01006' => {
         group => 'ungrouped',
         err_desc => "Privilege not revoked",
      },
   '01S00' => {
         group => 'ungrouped',
         err_desc => "Invalid connection string attribute",
      },
   '01S01' => {
         group => 'ungrouped',
         err_desc => "Error in row",
      },
   '01S02' => {
         group => 'ungrouped',
         err_desc => "Option value changed",
      },
   '01S03' => {
         group => 'ungrouped',
         err_desc => "No rows updated or deleted",
      },
   '01S04' => {
         group => 'ungrouped',
         err_desc => "More than one row updated or deleted",
      },
   '01S05' => {
         group => 'ungrouped',
         err_desc => "Cancel treated as FreeStmt/Close",
      },
   '01S06' => {
         group => 'ungrouped',
         err_desc => "Attempt to fetch before the result returned the first rowset",
      },
   '07001' => {
         group => 'ungrouped',
         err_desc => "Wrong number of parameters",
      },
   '07006' => {
         group => 'ungrouped',
         err_desc => "Restricted data type attribute violation",
      },
   '07S01' => {
         group => 'ungrouped',
         err_desc => "Invalid use of default paramater",
      },
   '08001' => {
         group => 'ungrouped',
         err_desc => "Unable to connect to data source",
      },
   '08002' => {
         group => 'ungrouped',
         err_desc => "Connection in use",
      },
   '08003' => {
         group => 'ungrouped',
         err_desc => "Connection not open",
      },
   '08004' => {
         group => 'ungrouped',
         err_desc => "Data source rejected establishment of connection",
      },
   '08007' => {
         group => 'ungrouped',
         err_desc => "Connection failure during transaction",
      },
   '08S01' => {
         group => 'ungrouped',
         err_desc => "Communication link failure",
      },
   '21S01' => {
         group => 'ungrouped',
         err_desc => "Insert value list does not match column list",
      },
   '21S02' => {
         group => 'ungrouped',
         err_desc => "Degree of derived table does not match column list",
      },
   '22001' => {
         group => 'ungrouped',
         err_desc => "String data right truncation",
      },
   '22002' => {
         group => 'ungrouped',
         err_desc => "Indicator variable required but not supplied",
      },
   '22003' => {
         group => 'ungrouped',
         err_desc => "Numeric value out of range",
      },
   '22005' => {
         group => 'ungrouped',
         err_desc => "Error in assignment",
      },
   '22008' => {
         group => 'ungrouped',
         err_desc => "Datetime field overflow",
      },
   '22012' => {
         group => 'ungrouped',
         err_desc => "Division by zero",
      },
   '22026' => {
         group => 'ungrouped',
         err_desc => "String data, length mismatch",
      },
   '23000' => {
         group => 'constraint',
         err_desc => "Integrity constraint violation",
         class => 'NotNull'
      },
   'Invalid' => {
         group => 'ungrouped',
         err_desc => "cursor state",
      },
   '25000' => {
         group => 'ungrouped',
         err_desc => "Invalid transaction state",
      },
   '28000' => {
         group => 'ungrouped',
         err_desc => "Invalid authorization specification",
      },
   '34000' => {
         group => 'ungrouped',
         err_desc => "Invalid cursor name",
      },
   '37000' => {
         group => 'ungrouped',
         err_desc => "Syntax error or access violation",
      },
   '3C000' => {
         group => 'ungrouped',
         err_desc => "Duplicate cursor name",
      },
   '40001' => {
         group => 'ungrouped',
         err_desc => "Serialization failure",
      },
   '70100' => {
         group => 'ungrouped',
         err_desc => "Operation aborted",
      },
   'IM001' => {
         group => 'ungrouped',
         err_desc => "Driver does not support this function",
      },
   'IM002' => {
         group => 'ungrouped',
         err_desc => "Data source name not found and no default driver specified",
      },
   'IM003' => {
         group => 'ungrouped',
         err_desc => "Specified driver could not be loaded",
      },
   'IM004' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLAllocEnv failed",
      },
   'IM005' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLAllocConnect failed",
      },
   'IM006' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLSetConnectOption failed",
      },
   'IM007' => {
         group => 'ungrouped',
         err_desc => "No data source or driver specified; dialog prohibited",
      },
   'IM008' => {
         group => 'ungrouped',
         err_desc => "Dialog failed",
      },
   'IM009' => {
         group => 'ungrouped',
         err_desc => "Unable to load translation DLL",
      },
   'IM010' => {
         group => 'ungrouped',
         err_desc => "Data source name too long",
      },
   'IM011' => {
         group => 'ungrouped',
         err_desc => "Driver name too long",
      },
   'IM012' => {
         group => 'ungrouped',
         err_desc => "DRIVER keyword syntax error",
      },
   'IM013' => {
         group => 'ungrouped',
         err_desc => "Trace file error",
      },
   'S0001' => {
         group => 'ungrouped',
         err_desc => "Base table or view already exists",
      },
   'S0002' => {
         group => 'ungrouped',
         err_desc => "Base table not found",
      },
   'S0011' => {
         group => 'ungrouped',
         err_desc => "Index already exists",
      },
   'S0012' => {
         group => 'ungrouped',
         err_desc => "Index not found",
      },
   'S0021' => {
         group => 'ungrouped',
         err_desc => "Column already exists",
      },
   'S0022' => {
         group => 'ungrouped',
         err_desc => "Column not found",
      },
   'S0023' => {
         group => 'ungrouped',
         err_desc => "No default for column",
      },
   'S1000' => {
         group => 'ungrouped',
         err_desc => "General error",
      },
   'S1001' => {
         group => 'ungrouped',
         err_desc => "Memory allocation failure",
      },
   'S1002' => {
         group => 'ungrouped',
         err_desc => "Invalid column number",
      },
   'S1003' => {
         group => 'ungrouped',
         err_desc => "Program type out of range",
      },
   'S1004' => {
         group => 'ungrouped',
         err_desc => "SQL data type out of range",
      },
   'S1008' => {
         group => 'ungrouped',
         err_desc => "Operation canceled",
      },
   'S1009' => {
         group => 'ungrouped',
         err_desc => "Invalid argument value",
      },
   'S1010' => {
         group => 'ungrouped',
         err_desc => "Function sequence error",
      },
   'S1011' => {
         group => 'ungrouped',
         err_desc => "Operation invalid at this time",
      },
   'S1012' => {
         group => 'ungrouped',
         err_desc => "Invalid transaction operation code specified",
      },
   'S1015' => {
         group => 'ungrouped',
         err_desc => "No cursor name available",
      },
   'S1090' => {
         group => 'ungrouped',
         err_desc => "Invalid string or buffer length",
      },
   'S1091' => {
         group => 'ungrouped',
         err_desc => "Descriptor type out of range",
      },
   'S1092' => {
         group => 'ungrouped',
         err_desc => "Option type out of range",
      },
   'S1093' => {
         group => 'ungrouped',
         err_desc => "Invalid parameter number",
      },
   'S1094' => {
         group => 'ungrouped',
         err_desc => "Invalid scale value",
      },
   'S1095' => {
         group => 'ungrouped',
         err_desc => "Function type out of range",
      },
   'S1096' => {
         group => 'ungrouped',
         err_desc => "Information type out of range",
      },
   'S1097' => {
         group => 'ungrouped',
         err_desc => "Column type out of range",
      },
   'S1098' => {
         group => 'ungrouped',
         err_desc => "Scope type out of range",
      },
   'S1099' => {
         group => 'ungrouped',
         err_desc => "Nullable type out of range",
      },
   'S1100' => {
         group => 'ungrouped',
         err_desc => "Uniqueness option type out of range",
      },
   'S1101' => {
         group => 'ungrouped',
         err_desc => "Accuracy option type out of range",
      },
   'S1103' => {
         group => 'ungrouped',
         err_desc => "Direction option out of range",
      },
   'S1104' => {
         group => 'ungrouped',
         err_desc => "Invalid precision value",
      },
   'S1105' => {
         group => 'ungrouped',
         err_desc => "Invalid parameter type",
      },
   'S1106' => {
         group => 'ungrouped',
         err_desc => "Fetch type out of range",
      },
   'S1107' => {
         group => 'ungrouped',
         err_desc => "Row value out of range",
      },
   'S1108' => {
         group => 'ungrouped',
         err_desc => "Concurrency option out of range",
      },
   'S1109' => {
         group => 'ungrouped',
         err_desc => "Invalid cursor position",
      },
   'S1110' => {
         group => 'ungrouped',
         err_desc => "Invalid driver completion",
      },
   'S1111' => {
         group => 'ungrouped',
         err_desc => "Invalid bookmark value",
      },
   'S1C00' => {
         group => 'ungrouped',
         err_desc => "Driver not capable",
      },
   'S1DE0' => {
         group => 'ungrouped',
         err_desc => "No data at execution values pending",
      },
   'S1T00' => {
         group => 'ungrouped',
         err_desc => "Timeout expired",
      },
   'SQLSTATE' => {
         group => 'ungrouped',
         err_desc => "Error",
      },
   '1000' => {
         group => 'ungrouped',
         err_desc => "General warning",
      },
   '1001' => {
         group => 'ungrouped',
         err_desc => "Cursor operation conflict",
      },
   '1002' => {
         group => 'ungrouped',
         err_desc => "Disconnect error",
      },
   '1003' => {
         group => 'ungrouped',
         err_desc => "NULL value eliminated in set function",
      },
   '1004' => {
         group => 'ungrouped',
         err_desc => "String data, right-truncated",
      },
   '1006' => {
         group => 'ungrouped',
         err_desc => "Privilege not revoked",
      },
   '1007' => {
         group => 'ungrouped',
         err_desc => "Privilege not granted",
      },
   '01S00' => {
         group => 'ungrouped',
         err_desc => "Invalid connection string attribute",
      },
   '01S01' => {
         group => 'ungrouped',
         err_desc => "Error in row",
      },
   '01S02' => {
         group => 'ungrouped',
         err_desc => "Option value changed",
      },
   '01S06' => {
         group => 'ungrouped',
         err_desc => "Attempt to fetch before the result set returned the first rowset",
      },
   '01S07' => {
         group => 'ungrouped',
         err_desc => "Fractional truncation",
      },
   '01S08' => {
         group => 'ungrouped',
         err_desc => "Error saving File DSN",
      },
   '01S09' => {
         group => 'ungrouped',
         err_desc => "Invalid keyword",
      },
   '7001' => {
         group => 'ungrouped',
         err_desc => "Wrong number of parameters",
      },
   '7002' => {
         group => 'ungrouped',
         err_desc => "COUNT field incorrect",
      },
   '7005' => {
         group => 'ungrouped',
         err_desc => "Prepared statement not a cursor-specification",
      },
   '7006' => {
         group => 'ungrouped',
         err_desc => "Restricted data type attribute violation",
      },
   '7009' => {
         group => 'ungrouped',
         err_desc => "Invalid descriptor index",
      },
   '07S01' => {
         group => 'ungrouped',
         err_desc => "Invalid use of default parameter",
      },
   '8001' => {
         group => 'ungrouped',
         err_desc => "Client unable to establish connection",
      },
   '8002' => {
         group => 'ungrouped',
         err_desc => "Connection name in use",
      },
   '8003' => {
         group => 'ungrouped',
         err_desc => "Connection not open",
      },
   '8004' => {
         group => 'ungrouped',
         err_desc => "Server rejected the connection",
      },
   '8007' => {
         group => 'ungrouped',
         err_desc => "Connection failure during transaction",
      },
   '08S01' => {
         group => 'ungrouped',
         err_desc => "Communication link failure",
      },
   '21S01' => {
         group => 'ungrouped',
         err_desc => "Insert value list does not match column list",
      },
   '21S02' => {
         group => 'ungrouped',
         err_desc => "Degree of derived table does not match column list",
      },
   '22001' => {
         group => 'ungrouped',
         err_desc => "String data, right-truncated",
      },
   '22002' => {
         group => 'ungrouped',
         err_desc => "Indicator variable required but not supplied",
      },
   '22003' => {
         group => 'ungrouped',
         err_desc => "Numeric value out of range",
      },
   '22007' => {
         group => 'ungrouped',
         err_desc => "Invalid datetime format",
      },
   '22008' => {
         group => 'ungrouped',
         err_desc => "Datetime field overflow",
      },
   '22012' => {
         group => 'ungrouped',
         err_desc => "Division by zero",
      },
   '22015' => {
         group => 'ungrouped',
         err_desc => "Interval field overflow",
      },
   '22018' => {
         group => 'ungrouped',
         err_desc => "Invalid character value for cast specification",
      },
   '22019' => {
         group => 'ungrouped',
         err_desc => "Invalid escape character",
      },
   '22025' => {
         group => 'ungrouped',
         err_desc => "Invalid escape sequence",
      },
   '22026' => {
         group => 'ungrouped',
         err_desc => "String data, length mismatch",
      },
   '24000' => {
         group => 'ungrouped',
         err_desc => "Invalid cursor state",
      },
   '25000' => {
         group => 'ungrouped',
         err_desc => "Invalid transaction state",
      },
   '25S01' => {
         group => 'ungrouped',
         err_desc => "Transaction state",
      },
   '25S02' => {
         group => 'ungrouped',
         err_desc => "Transaction is still active",
      },
   '25S03' => {
         group => 'ungrouped',
         err_desc => "Transaction is rolled back",
      },
   '28000' => {
         group => 'ungrouped',
         err_desc => "Invalid authorization specification",
      },
   '34000' => {
         group => 'ungrouped',
         err_desc => "Invalid cursor name",
      },
   '3C000' => {
         group => 'ungrouped',
         err_desc => "Duplicate cursor name",
      },
   '3D000' => {
         group => 'ungrouped',
         err_desc => "Invalid catalog name",
      },
   '3F000' => {
         group => 'ungrouped',
         err_desc => "Invalid schema name",
      },
   '40001' => {
         group => 'ungrouped',
         err_desc => "Serialization failure",
      },
   '40002' => {
         group => 'ungrouped',
         err_desc => "Integrity constraint violation",
      },
   '40003' => {
         group => 'ungrouped',
         err_desc => "Statement completion unknown",
      },
   '42000' => {
         group => 'syntax',
         err_desc => "Syntax error or access violation",
         class => 'Syntax'
      },
   '42S01' => {
         group => 'ungrouped',
         err_desc => "Base table or view already exists",
      },
   '42S02' => {
         group => 'no_such',
         err_desc => "Base table or view not found",
         class => 'NoSuchTable'
      },
   '42S11' => {
         group => 'ungrouped',
         err_desc => "Index already exists",
      },
   '42S12' => {
         group => 'ungrouped',
         err_desc => "Index not found",
      },
   '42S21' => {
         group => 'ungrouped',
         err_desc => "Column already exists",
      },
   '42S22' => {
         group => 'no_such',
         err_desc => "Column not found",
         class => 'NoSuchColumn'
      },
   '44000' => {
         group => 'ungrouped',
         err_desc => "WITH CHECK OPTION violation",
      },
   'HY000' => {
         group => 'ungrouped',
         err_desc => "General error",
      },
   'HY001' => {
         group => 'ungrouped',
         err_desc => "Memory allocation error",
      },
   'HY003' => {
         group => 'ungrouped',
         err_desc => "Invalid application buffer type",
      },
   'HY004' => {
         group => 'ungrouped',
         err_desc => "Invalid SQL data type",
      },
   'HY007' => {
         group => 'ungrouped',
         err_desc => "Associated statement is not prepared",
      },
   'HY008' => {
         group => 'ungrouped',
         err_desc => "Operation canceled",
      },
   'HY009' => {
         group => 'ungrouped',
         err_desc => "Invalid use of null pointer",
      },
   'HY010' => {
         group => 'ungrouped',
         err_desc => "Function sequence error",
      },
   'HY011' => {
         group => 'ungrouped',
         err_desc => "Attribute cannot be set now",
      },
   'HY012' => {
         group => 'ungrouped',
         err_desc => "Invalid transaction operation code",
      },
   'HY013' => {
         group => 'ungrouped',
         err_desc => "Memory management error",
      },
   'HY014' => {
         group => 'ungrouped',
         err_desc => "Limit on the number of handles exceeded",
      },
   'HY015' => {
         group => 'ungrouped',
         err_desc => "No cursor name available",
      },
   'HY016' => {
         group => 'ungrouped',
         err_desc => "Cannot modify an implementation row descriptor",
      },
   'HY017' => {
         group => 'ungrouped',
         err_desc => "Invalid use of an automatically allocated descriptor handle",
      },
   'HY018' => {
         group => 'ungrouped',
         err_desc => "Server declined cancel request",
      },
   'HY019' => {
         group => 'ungrouped',
         err_desc => "Non-character and non-binary data sent in pieces",
      },
   'HY020' => {
         group => 'ungrouped',
         err_desc => "Attempt to concatenate a null value",
      },
   'HY021' => {
         group => 'ungrouped',
         err_desc => "Inconsistent descriptor information",
      },
   'HY024' => {
         group => 'ungrouped',
         err_desc => "Invalid attribute value",
      },
   'HY090' => {
         group => 'ungrouped',
         err_desc => "Invalid string or buffer length",
      },
   'HY091' => {
         group => 'ungrouped',
         err_desc => "Invalid descriptor field identifier",
      },
   'HY092' => {
         group => 'ungrouped',
         err_desc => "Invalid attribute/option identifier",
      },
   'HY095' => {
         group => 'ungrouped',
         err_desc => "Function type out of range",
      },
   'HY096' => {
         group => 'ungrouped',
         err_desc => "Invalid information type",
      },
   'HY097' => {
         group => 'ungrouped',
         err_desc => "Column type out of range",
      },
   'HY098' => {
         group => 'ungrouped',
         err_desc => "Scope type out of range",
      },
   'HY099' => {
         group => 'ungrouped',
         err_desc => "Nullable type out of range",
      },
   'HY100' => {
         group => 'ungrouped',
         err_desc => "Uniqueness option type out of range",
      },
   'HY101' => {
         group => 'ungrouped',
         err_desc => "Accuracy option type out of range",
      },
   'HY103' => {
         group => 'ungrouped',
         err_desc => "Invalid retrieval code",
      },
   'HY104' => {
         group => 'ungrouped',
         err_desc => "Invalid precision or scale value",
      },
   'HY105' => {
         group => 'ungrouped',
         err_desc => "Invalid parameter type",
      },
   'HY106' => {
         group => 'ungrouped',
         err_desc => "Fetch type out of range",
      },
   'HY107' => {
         group => 'ungrouped',
         err_desc => "Row value out of range",
      },
   'HY109' => {
         group => 'ungrouped',
         err_desc => "Invalid cursor position",
      },
   'HY110' => {
         group => 'ungrouped',
         err_desc => "Invalid driver completion",
      },
   'HY111' => {
         group => 'ungrouped',
         err_desc => "Invalid bookmark value",
      },
   'HYC00' => {
         group => 'ungrouped',
         err_desc => "Optional feature not implemented",
      },
   'HYT00' => {
         group => 'ungrouped',
         err_desc => "Timeout expired",
      },
   'HYT01' => {
         group => 'ungrouped',
         err_desc => "Connection timeout expired",
      },
   'IM001' => {
         group => 'ungrouped',
         err_desc => "Driver does not support this function",
      },
   'IM002' => {
         group => 'ungrouped',
         err_desc => "Data source name not found and no default driver specified",
      },
   'IM003' => {
         group => 'ungrouped',
         err_desc => "Specified driver could not be loaded",
      },
   'IM004' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLAllocHandle on SQL_HANDLE_ENV failed",
      },
   'IM005' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLAllocHandle on SQL_HANDLE_DBC failed",
      },
   'IM006' => {
         group => 'ungrouped',
         err_desc => "Driver's SQLSetConnectAttr failed",
      },
   'IM007' => {
         group => 'ungrouped',
         err_desc => "No data source or driver specified; dialog prohibited",
      },
   'IM008' => {
         group => 'ungrouped',
         err_desc => "Dialog failed",
      },
   'IM009' => {
         group => 'ungrouped',
         err_desc => "Unable to load translation DLL",
      },
   'IM010' => {
         group => 'ungrouped',
         err_desc => "Data source name too long",
      },
   'IM011' => {
         group => 'ungrouped',
         err_desc => "Driver name too long      ",
      },
   'IM012' => {
         group => 'ungrouped',
         err_desc => "DRIVER keyword syntax error",
      },
   'IM013' => {
         group => 'ungrouped',
         err_desc => "Trace file error",
      },
   'IM014' => {
         group => 'ungrouped',
         err_desc => "Invalid name of File DSN",
      },
   'IM015' => {
         group => 'ungrouped',
         err_desc => "Corrupt file data source",
      },
);

sub capabilities { $_[0] }

sub parse {
   my ($self, $string, $dbh) = @_;

   croak 'You built your parser wrong, use DBIx::ParseException!'
      unless $self->does('DBIx::ParseException::Role::API');

   # prepare args
   my @args = ( original => $string, %{$self->extract_from_dbh($dbh)} );
   my $code = $dbh->state;

   #the old code is what we really want
   if ( $string =~ m/\[state was (.*) now (.*)\]/ ) {
      $code = $1
   }

   my $error_info = $error_codes{$code};

   # prepare class
   my $class = 'DBIx::Exception';
   my $group = '';
   if ($string =~ m/Violation of UNIQUE KEY constraint|Cannot insert duplicate key/){
      $class .= '::NotUnique';
      $group = 'constraint';
   } elsif (my $class_ext = $error_info->{class}) {
     $class .= "::$class_ext";
     $group = $error_info->{group};
   }

   if ($group eq 'constraint') {
      # fk constraints, unique constraints etc
      my ($constraint) = grep $_, $string =~ /Violation of UNIQUE KEY constraint '([^']+)'|with unique index '([^']+)'/;
      push @args, ( constraint => $constraint );
      my ($column_name) = $string =~ /column '(.+)', table/;
      push @args, ( column => $column_name ) if $column_name;
   } elsif ($group eq 'no_such') {
      # wrong table, wrong column etc
      my ($table_name)  = $string =~ /Invalid object name '(.+)'/;
      my ($column_name) = $string =~ /Invalid column name '(.+)'/;
      push @args, ( table  => $table_name  ) if $table_name;
      push @args, ( column => $column_name ) if $column_name;
   } elsif ($group eq 'syntax') {
      my ($near) = $string =~ /near "(.+)"/;
      push @args, ( near => $near );
   }

   $class->new(@args);
}

use constant {
  can_unique_constraint        => 1,

  can_syntax                   => 1,

  can_no_such_table            => 1,
  can_no_such_table_table      => 1,

  can_no_such_column           => 1,
  can_no_such_column_column    => 1,
};

1;
