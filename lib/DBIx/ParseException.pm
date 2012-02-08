package DBIx::ParseException;

use strict;
use warnings;

# ABSTRACT: Parse exceptions into objects

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


=pod

=head1 SYNOPSIS

 my $parser = DBIx::ParseException->new({
    database => 'SQLite',
    api      => 0,
 });

 $dbh->{HandleError} = sub { die($parser->parse(@_)) };

=head1 DESCRIPTION

This module is for converting all the myriad bits of information L<DBI>
L<provides|DBI/HandleError> when an error occurs into a nice, structured
object.

Currently the API is very simple, one constructs a new parser by calling
L</new>, and then calling L<parse|DBIx::ParseException::Role::API0/parse> with
the information that gets passed to L<HandleError|DBI/HandleError>.

=head1 IMPORTANT NOTE REGARDING DATA EXTRACTION

Although the API you use may provide a slot for a piece of data, the data may
be blank nonetheless.  The data may be unavailable for your database, or this
module may not take advantage of special DBD features yet.

=head1 METHODS

=head2 new

 DBIx::ParseException->new({
    database => 'SQLite',
    api      => 0,
 });

Arguments:

=over

=item C<api>

B<required>, this defines the api version to use.  See the role in
L<DBIx::ParseException::Role> with the version of the api you request for
documentation.  The API ultimately decides what kinds of Exception objects
you get back.

=item C<database>

B<required>, this defines which database type you are "parsing."  Note that
there may be more required parameters for a given database, as it may need to
know, for example, the version of the database or the connection method.

=back
