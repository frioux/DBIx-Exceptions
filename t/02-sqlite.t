#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIETester;

DBIETester->new( dsn => 'dbi:SQLite:dbname=dbfile', driver => 'SQLite')->run_tests;

END { unlink 'dbfile' }
