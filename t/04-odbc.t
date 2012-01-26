#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIETester;

DBIETester->new( database => 'ODBC' )->run_tests;

