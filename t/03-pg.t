#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIETester;

DBIETester->new( dsn => 'dbi:Pg:dbname=dbic_exceptions', username => 'postgres', password => '', driver => 'Pg')->run_tests;

