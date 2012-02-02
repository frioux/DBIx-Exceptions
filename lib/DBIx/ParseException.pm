package DBIx::ParseException;

use strict;
use warnings;

use Module::Load;
use Role::Tiny;
use Carp 'croak';

sub new {
   my ($class, $params) = @_;

   my $database = $params->{database}
      or croak 'database is a required parameter to make an exception parser!';

   my $api = $params->{api};

   croak 'api is a required parameter to make an exception parser!'
      unless defined $api;

   croak 'api must be an integer!'
      unless $api =~ /^\d+$/;

   my $next = "DBIx::ParseException::$database";
   load($next);

   my $ret = $next->new($params);

   Role::Tiny->apply_roles_to_object($ret, "DBIx::ParseException::Role::API$api");

   return $ret;
}

1;

