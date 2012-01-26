package DBIx::ParseException::Role::Capabilities;

use Moo::Role;

sub capabilities { $_[0] }

sub can_unique_constraint        () { 0 }
sub can_unique_constraint_column () { 0 }
sub can_syntax                   () { 0 }
sub can_syntax_near              () { 0 }
sub can_syntax_near_end          () { 0 }
sub can_no_such_table            () { 0 }
sub can_no_such_table_table      () { 0 }
sub can_no_such_column           () { 0 }
sub can_no_such_column_table     () { 0 }
sub can_no_such_column_column    () { 0 }

1;
