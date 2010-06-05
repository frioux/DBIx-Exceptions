package DBIx::ParseException::SQLite;

use DBIx::Exceptions;

sub capabilities { $_[0] }

sub error_handler {
   my $string = shift;
   my @args   = ( original => $string );
   my $class  = 'DBIx::Exception';

   if (my ($column) = $string =~ /^DBD::SQLite::st \s+ execute \s+ failed: \s+ (?:constraint \s+ failed \s+)?
                                   column \s+ (.*) \s+ is \s+ not \s+ unique/ixm) {
      $class .= '::NotUnique';
      push @args, ( column => $column );
   } elsif ($string =~ /^DBD::SQLite::db \s+ prepare \s+ failed: \s+ near \s+
                        "(.*)": \s+ syntax \s+ error/ixm) {
      $class .= '::Syntax';
      push @args, ( near => $1 );
   } elsif ($string =~ /^DBD::SQLite::db \s+ prepare \s+ failed: \s+ no \s+
                        such \s+ table: \s+ (.*)/ixm) {
      $class .= '::NoSuchTable';
      push @args, ( table => $1 );
   } elsif ($string =~ /^DBD::SQLite::db \s+ prepare \s+ failed: \s+ table \s+
                        (.*) \s+ has \s+ no \s+ column \s+ named \s+ (.*)/ixm) {
      $class .= '::NoSuchColumn';
      push @args, ( table => $1, column => $2 );
   }

   $class->throw(@args);
}

use constant {
  can_unique_constraint        => 1,
  can_unique_constraint_column => 1,

  can_syntax                   => 1,
  can_syntax_near              => 1,

  can_no_such_table            => 1,
  can_no_such_table_table      => 1,

  can_no_such_column           => 1,
  can_no_such_column_table     => 1,
  can_no_such_column_column    => 1,
};

1;
# vim: ts=2 tw=2 expandtab
