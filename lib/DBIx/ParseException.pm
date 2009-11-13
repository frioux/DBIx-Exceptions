package DBIx::ParseException;

use strict;
use warnings;
use DBI;
use Carp 'croak';

DRIVERS: {
   my %DRIVERS;

   sub handler {
      my $self = shift;
      my $params = shift or croak 'params are required for DBIx::ParseException!';
      my $driver = do {
         if (my $dbh = $params->{dbh}) {
            $dbh->{Driver}{Name};
         } else {
            ( DBI->parse_dsn($params->{dsn}) )[1];
         }
      };
      return $DRIVERS{$driver} ||= do {
         my $parser = __PACKAGE__ . "::$driver";
         eval "require $parser";
         die $@ if $@;
         $parser->can('error_handler');
      };
   }
}

1;
