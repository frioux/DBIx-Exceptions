#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIETester;

DBIETester->new( database => 'SQLite' )->run_tests;

