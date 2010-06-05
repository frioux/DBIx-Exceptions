#!perl

use strict;
use warnings;

use Test::More;

use_ok 'DBIx::ParseException';
use_ok 'DBIx::ParseException::SQLite';
my $dbh = DBI->connect('dbi:SQLite::memory:');
my $correct_handler = \&DBIx::ParseException::SQLite::error_handler;

my $handler  = DBIx::ParseException->handler({ dsn => 'dbi:SQLite::memory:'});
is $correct_handler, $handler, 'Correct handler gets set by dsn';

my $handler2 = DBIx::ParseException->handler({ dbh => $dbh });
is $handler, $handler2, 'dbh and dsn both work';

done_testing;
