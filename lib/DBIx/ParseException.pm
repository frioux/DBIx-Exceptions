package DBIx::ParseException;

use strict;
use warnings;
use DBI;
use Carp 'croak';

sub _get_driver {
  return do {
      if (my $dbh = $_[1]->{dbh}) {
      $dbh->{Driver}{Name};
    } else {
      ( DBI->parse_dsn($_[1]->{dsn}) )[1];
    }
  }
}

DRIVERS: {
   my %DRIVERS;

   sub handler {
      my $self = shift;
      my $params = shift or croak 'params are required for DBIx::ParseException!';
      my $driver = $self->_get_driver($params);
      return $DRIVERS{$driver} ||= do {
         my $parser = __PACKAGE__ . "::$driver";
         eval "require $parser";
         die $@ if $@;
         $parser->can('error_handler');
      };
   }
}

CAPABILITIES: {
   my %CAPABILITIES;

   sub capabilities {
      my $self = shift;
      my $params = shift or croak 'params are required for DBIx::ParseException!';
      my $driver = $self->_get_driver($params);
      return $CAPABILITIES{$driver} ||= do {
         my $parser = __PACKAGE__ . "::$driver";
         eval "require $parser";
         die $@ if $@;
         $parser->can('capabilities')->($parser);
      };
   }
}

1;

# vim: ts=2 tw=2 expandtab
