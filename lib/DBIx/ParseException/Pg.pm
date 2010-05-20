package DBIx::ParseException::Pg;

use Moose;
use DBIx::Exceptions;

sub error_handler {
   my $string = shift;

   my %error_codes = (
      '00000' => {
         id => 'successful_completion',
      },
      '01000' => {
         id => 'warning',
      },
      '0100C' => {
         id => 'dynamic_result_sets_returned',
      },
      '01008' => {
         id => 'implicit_zero_bit_padding',
      },
      '01003' => {
         id => 'null_value_eliminated_in_set_function',
      },
      '01007' => {
         id => 'privilege_not_granted',
      },
      '01006' => {
         id => 'privilege_not_revoked',
      },
      '01004' => {
         id => 'string_data_right_truncation',
      },
      '01P01' => {
         id => 'deprecated_feature',
      },
      '02000' => {
         id => 'no_data',
      },
      '02001' => {
         id => 'no_additional_dynamic_result_sets_returned',
      },
      '03000' => {
         id => 'sql_statement_not_yet_complete',
      },
      '08000' => {
         id => 'connection_exception',
      },
      '08003' => {
         id => 'connection_does_not_exist',
      },
      '08006' => {
         id => 'connection_failure',
      },
      '08001' => {
         id => 'sqlclient_unable_to_establish_sqlconnection',
      },
      '08004' => {
         id => 'sqlserver_rejected_establishment_of_sqlconnection',
      },
      '08007' => {
         id => 'transaction_resolution_unknown',
      },
      '08P01' => {
         id => 'protocol_violation',
      },
      '09000' => {
         id => 'triggered_action_exception',
      },
      '0A000' => {
         id => 'feature_not_supported',
      },
      '0B000' => {
         id => 'invalid_transaction_initiation',
      },
      '0F000' => {
         id => 'locator_exception',
      },
      '0F001' => {
         id => 'invalid_locator_specification',
      },
      '0L000' => {
         id => 'invalid_grantor',
      },
      '0LP01' => {
         id => 'invalid_grant_operation',
      },
      '0P000' => {
         id => 'invalid_role_specification',
      },
      '21000' => {
         id => 'cardinality_violation',
      },
      '22000' => {
         id => 'data_exception',
      },
      '2202E' => {
         id => 'array_subscript_error',
      },
      '22021' => {
         id => 'character_not_in_repertoire',
      },
      '22008' => {
         id => 'datetime_field_overflow',
      },
      '22012' => {
         id => 'division_by_zero',
      },
      '22005' => {
         id => 'error_in_assignment',
      },
      '2200B' => {
         id => 'escape_character_conflict',
      },
      '22022' => {
         id => 'indicator_overflow',
      },
      '22015' => {
         id => 'interval_field_overflow',
      },
      '2201E' => {
         id => 'invalid_argument_for_logarithm',
      },
      '2201F' => {
         id => 'invalid_argument_for_power_function',
      },
      '2201G' => {
         id => 'invalid_argument_for_width_bucket_function',
      },
      '22018' => {
         id => 'invalid_character_value_for_cast',
      },
      '22007' => {
         id => 'invalid_datetime_format',
      },
      '22019' => {
         id => 'invalid_escape_character',
      },
      '2200D' => {
         id => 'invalid_escape_octet',
      },
      '22025' => {
         id => 'invalid_escape_sequence',
      },
      '22P06' => {
         id => 'nonstandard_use_of_escape_character',
      },
      '22010' => {
         id => 'invalid_indicator_parameter_value',
      },
      '22020' => {
         id => 'invalid_limit_value',
      },
      '22023' => {
         id => 'invalid_parameter_value',
      },
      '2201B' => {
         id => 'invalid_regular_expression',
      },
      '22009' => {
         id => 'invalid_time_zone_displacement_value',
      },
      '2200C' => {
         id => 'invalid_use_of_escape_character',
      },
      '2200G' => {
         id => 'most_specific_type_mismatch',
      },
      '22004' => {
         id => 'null_value_not_allowed',
      },
      '22002' => {
         id => 'null_value_no_indicator_parameter',
      },
      '22003' => {
         id => 'numeric_value_out_of_range',
      },
      '22026' => {
         id => 'string_data_length_mismatch',
      },
      '22001' => {
         id => 'string_data_right_truncation',
      },
      '22011' => {
         id => 'substring_error',
      },
      '22027' => {
         id => 'trim_error',
      },
      '22024' => {
         id => 'unterminated_c_string',
      },
      '2200F' => {
         id => 'zero_length_character_string',
      },
      '22P01' => {
         id => 'floating_point_exception',
      },
      '22P02' => {
         id => 'invalid_text_representation',
      },
      '22P03' => {
         id => 'invalid_binary_representation',
      },
      '22P04' => {
         id => 'bad_copy_file_format',
      },
      '22P05' => {
         id => 'untranslatable_character',
      },

      # constraints
      '23000' => {
         id => 'integrity_constraint_violation',
         group => 'constraint',
      },
      '23001' => {
         id => 'restrict_violation',
         group => 'constraint',
      },
      '23502' => {
         id => 'not_null_violation',
         group => 'constraint',
         class => 'NotNull',
      },
      '23503' => {
         id => 'foreign_key_violation',
         group => 'constraint',
         class => 'ForeignKey',
      },
      '23505' => {
         id => 'unique_violation',
         group => 'constraint',
         class => 'NotUnique',
      },


      '23514' => {
         id => 'check_violation',
      },
      '24000' => {
         id => 'invalid_cursor_state',
      },
      '25000' => {
         id => 'invalid_transaction_state',
      },
      '25001' => {
         id => 'active_sql_transaction',
      },
      '25002' => {
         id => 'branch_transaction_already_active',
      },
      '25008' => {
         id => 'held_cursor_requires_same_isolation_level',
      },
      '25003' => {
         id => 'inappropriate_access_mode_for_branch_transaction',
      },
      '25004' => {
         id => 'inappropriate_isolation_level_for_branch_transaction',
      },
      '25005' => {
         id => 'no_active_sql_transaction_for_branch_transaction',
      },
      '25006' => {
         id => 'read_only_sql_transaction',
      },
      '25007' => {
         id => 'schema_and_data_statement_mixing_not_supported',
      },
      '25P01' => {
         id => 'no_active_sql_transaction',
      },
      '25P02' => {
         id => 'in_failed_sql_transaction',
      },
      '26000' => {
         id => 'invalid_sql_statement_name',
      },
      '27000' => {
         id => 'triggered_data_change_violation',
      },
      '28000' => {
         id => 'invalid_authorization_specification',
      },
      '2B000' => {
         id => 'dependent_privilege_descriptors_still_exist',
      },
      '2BP01' => {
         id => 'dependent_objects_still_exist',
      },
      '2D000' => {
         id => 'invalid_transaction_termination',
      },
      '2F000' => {
         id => 'sql_routine_exception',
      },
      '2F005' => {
         id => 'function_executed_no_return_statement',
      },
      '2F002' => {
         id => 'modifying_sql_data_not_permitted',
      },
      '2F003' => {
         id => 'prohibited_sql_statement_attempted',
      },
      '2F004' => {
         id => 'reading_sql_data_not_permitted',
      },
      '34000' => {
         id => 'invalid_cursor_name',
      },
      '38000' => {
         id => 'external_routine_exception',
      },
      '38001' => {
         id => 'containing_sql_not_permitted',
      },
      '38002' => {
         id => 'modifying_sql_data_not_permitted',
      },
      '38003' => {
         id => 'prohibited_sql_statement_attempted',
      },
      '38004' => {
         id => 'reading_sql_data_not_permitted',
      },
      '39000' => {
         id => 'external_routine_invocation_exception',
      },
      '39001' => {
         id => 'invalid_sqlstate_returned',
      },
      '39004' => {
         id => 'null_value_not_allowed',
      },
      '39P01' => {
         id => 'trigger_protocol_violated',
      },
      '39P02' => {
         id => 'srf_protocol_violated',
      },
      '3B000' => {
         id => 'savepoint_exception',
      },
      '3B001' => {
         id => 'invalid_savepoint_specification',
      },
      '3D000' => {
         id => 'invalid_catalog_name',
      },
      '3F000' => {
         id => 'invalid_schema_name',
      },
      '40000' => {
         id => 'transaction_rollback',
      },
      '40002' => {
         id => 'transaction_integrity_constraint_violation',
      },
      '40001' => {
         id => 'serialization_failure',
      },
      '40003' => {
         id => 'statement_completion_unknown',
      },
      '40P01' => {
         id => 'deadlock_detected',
         class => 'Deadlock',
         group => 'deadlock'
      },

      # syntax errors
      '42000' => {
         id => 'syntax_error_or_access_rule_violation',
      },
      '42601' => {
         id => 'syntax_error',
         group => 'syntax',
         class => 'Syntax',
      },
      '42501' => {
         id => 'insufficient_privilege',
      },
      '42846' => {
         id => 'cannot_coerce',
      },
      '42803' => {
         id => 'grouping_error',
      },
      '42830' => {
         id => 'invalid_foreign_key',
      },
      '42602' => {
         id => 'invalid_name',
      },
      '42622' => {
         id => 'name_too_long',
      },
      '42939' => {
         id => 'reserved_name',
      },
      '42804' => {
         id => 'datatype_mismatch',
      },
      '42P18' => {
         id => 'indeterminate_datatype',
      },
      '42809' => {
         id => 'wrong_object_type',
      },
      '42703' => {
         id => 'undefined_column',
         class => 'NoSuchColumn',
         group => 'no_such',
      },
      '42883' => {
         id => 'undefined_function',
      },
      '42P01' => {
         id => 'undefined_table',
         class => 'NoSuchTable',
         group => 'no_such',
      },
      '42P02' => {
         id => 'undefined_parameter',
      },
      '42704' => {
         id => 'undefined_object',
      },
      '42701' => {
         id => 'duplicate_column',
      },
      '42P03' => {
         id => 'duplicate_cursor',
      },
      '42P04' => {
         id => 'duplicate_database',
      },
      '42723' => {
         id => 'duplicate_function',
      },
      '42P05' => {
         id => 'duplicate_prepared_statement',
      },
      '42P06' => {
         id => 'duplicate_schema',
      },
      '42P07' => {
         id => 'duplicate_table',
      },
      '42712' => {
         id => 'duplicate_alias',
      },
      '42710' => {
         id => 'duplicate_object',
      },
      '42702' => {
         id => 'ambiguous_column',
      },
      '42725' => {
         id => 'ambiguous_function',
      },
      '42P08' => {
         id => 'ambiguous_parameter',
      },
      '42P09' => {
         id => 'ambiguous_alias',
      },
      '42P10' => {
         id => 'invalid_column_reference',
      },
      '42611' => {
         id => 'invalid_column_definition',
      },
      '42P11' => {
         id => 'invalid_cursor_definition',
      },
      '42P12' => {
         id => 'invalid_database_definition',
      },
      '42P13' => {
         id => 'invalid_function_definition',
      },
      '42P14' => {
         id => 'invalid_prepared_statement_definition',
      },
      '42P15' => {
         id => 'invalid_schema_definition',
      },
      '42P16' => {
         id => 'invalid_table_definition',
      },
      '42P17' => {
         id => 'invalid_object_definition',
      },
      '44000' => {
         id => 'with_check_option_violation',
      },
      '53000' => {
         id => 'insufficient_resources',
      },
      '53100' => {
         id => 'disk_full',
      },
      '53200' => {
         id => 'out_of_memory',
      },
      '53300' => {
         id => 'too_many_connections',
      },
      '54000' => {
         id => 'program_limit_exceeded',
      },
      '54001' => {
         id => 'statement_too_complex',
      },
      '54011' => {
         id => 'too_many_columns',
      },
      '54023' => {
         id => 'too_many_arguments',
      },
      '55000' => {
         id => 'object_not_in_prerequisite_state',
      },
      '55006' => {
         id => 'object_in_use',
      },
      '55P02' => {
         id => 'cant_change_runtime_param',
      },
      '55P03' => {
         id => 'lock_not_available',
      },
      '57000' => {
         id => 'operator_intervention',
      },
      '57014' => {
         id => 'query_canceled',
         group => 'timeout',
         class => 'QueryCanceled'
      },
      '57P01' => {
         id => 'admin_shutdown',
      },
      '57P02' => {
         id => 'crash_shutdown',
      },
      '57P03' => {
         id => 'cannot_connect_now',
      },
      '58030' => {
         id => 'io_error',
      },
      '58P01' => {
         id => 'undefined_file',
      },
      '58P02' => {
         id => 'duplicate_file',
      },
      'F0000' => {
         id => 'config_file_error',
      },
      'F0001' => {
         id => 'lock_file_exists',
      },
      'P0000' => {
         id => 'plpgsql_error',
      },
      'P0001' => {
         id => 'raise_exception',
      },
      'XX000' => {
         id => 'internal_error',
      },
      'XX001' => {
         id => 'data_corrupted',
      },
      'XX002' => {
         id => 'index_corrupted',
      },
   );

   my $dbh = shift;
   my $code = $dbh->state;
   my $error_info = $error_codes{$code};

   # prepare class
   my $class = 'DBIx::Exception';
   if (my $class_ext = $error_info->{class}) {
      $class .= '::' . $class_ext;
   }

   my $group = $error_info->{group};

   # prepare args
   my @args = ( original => $string );
   if ($group eq 'constraint') {
      # fk constraints, unique constraints etc
      my ($constraint) = $string =~ /constraint "(.+)"/;
      push @args, ( constraint => $constraint );
      my ($column_name) = $string =~ /column "(.+)"/;
      if ($column_name) {
         push @args, ( column => $column_name );
      }

   } elsif ($group eq 'no_such') {
      # wrong table, wrong column etc
      my ($table_name) = $string =~ /relation "(.+)"/;
      my ($column_name) = $string =~ /column "(.+)" of/;
      push @args, ( table => $table_name );
      if ($column_name) {
         push @args, ( column => $column_name );
      }
   } elsif ($group eq 'syntax') {
      my ($near) = $string =~ /near "(.+)"/;
      push @args, ( near => $near );
   }

   $class->throw(@args);
}

1;
