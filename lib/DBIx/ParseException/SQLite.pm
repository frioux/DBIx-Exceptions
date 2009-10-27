package DBIx::ParseException::SQLite;

use Moose;
use DBIx::Exceptions;
with 'DBIx::ParseException';

sub error_handler {
   my $string = shift;
   my @args = ( original => $string );

   if ($string =~ /^DBD::SQLite::st \s+ execute \s+ failed: \s+ column \s+ (.*)
                    \s+ is \s+ not \s+ unique/ixm) {
      DBIx::Exception::NotUnique->throw(
         column => $1,
         @args,
      );
   } elsif ($string =~ /^DBD::SQLite::db \s+ prepare \s+ failed: \s+ near \s+
                        "(.*)": \s+ syntax \s+ error/ixm) {
      DBIx::Exception::Syntax->throw(
         near => $1,
         @args,
      );
   } else {
      DBIx::Exception->throw(@args);
   }
}

1;
