package DBIx::ParseException::SQLite;

use DBIx::Exceptions;

sub error_handler {
   my $string = shift;
   my @args   = ( original => $string );
   my $class  = 'DBIx::Exception';

   if ($string =~ /^DBD::SQLite::st \s+ execute \s+ failed: \s+ column \s+ (.*)
                    \s+ is \s+ not \s+ unique/ixm) {
      $class .= '::NotUnique';
      push @args, ( column => $1 );
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

1;
