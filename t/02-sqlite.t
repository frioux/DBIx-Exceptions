#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIETester;

DBIETester->new( dsn => 'dbi:SQLite::memory:', driver => 'SQLite')->run_tests;

