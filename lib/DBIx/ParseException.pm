package DBIx::ParseException;

use strict;
use warnings;

use Module::Load;
use Carp 'croak';

sub new {
   my ($class, $params) = @_;

   my $database = $params->{database}
      or croak 'database is a required parameter to make an exception parser!';

   my $next = "DBIx::ParseException::$database";
   load($next);
   $next->new($params);
}

1;

