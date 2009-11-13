#!perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/lib";
use JSON;
use DBI;
use DBIETester;
use DBIx::ParseException;

my $dbh = DBI->connect('dbi:SQLite:dbname=dbfile');
my $json;
{
   open( my $fh, '<', "$FindBin::Bin/orig.json" )
      or die "could not open orig.json: $!";
   my @json = <$fh>;
   $json = join '',@json;
}

$dbh->{HandleError} = DBIx::ParseException->handler({ dbh => $dbh });

DBIETester->new(
   dbh => $dbh,
   test_data => from_json($json),
)->run_tests;

END { unlink 'dbfile' }
