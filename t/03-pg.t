#!perl

use strict;
use warnings;

use lib 't/lib';
use Test::More;
use DBIETester;

my ($dsn, $user, $pass) = @ENV{map { "DBIETEST_PG_${_}" } qw/DSN USER PASS/};

plan skip_all => 'Set $ENV{DBIETEST_PG_DSN}, _USER and _PASS to run this test'
   unless $dsn && $user;

DBIETester->new(
   dsn      => $dsn,
   username => $user,
   password => $pass,
   driver   => 'Pg'
)->run_tests;

