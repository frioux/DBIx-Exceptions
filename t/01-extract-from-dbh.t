#!perl

use strict;
use warnings;

use lib 't/lib';
use DBIx::ParseException::Role::ExtractFromDBH;
use DBIETester::MockErrorDBH;
use Test::More;

use Devel::Dwarn;
is_deeply(
DBIx::ParseException::Role::ExtractFromDBH->extract_from_dbh(
   DBIETester::MockErrorDBH->new({
      Type         => 'st',
      ParamValues  => { foo => 'bar' },
      ParamArrays  => [1, 2, 3],
      Name         => 'fREW',
      Username     => 'admin',
      Statement    => 'SELECT * FROM pals',
      Kids         => 0,
      ActiveKids   => 0,
      errstr       => 'OH DANG',
      Callbacks   => {
        foo => 'punp',
      },

      # if we eventually make EFD recursive this will obviously need to be
      # marginally more complex,
      ChildHandles => [{
         Statement => 'SELECT * FROM frenz',
         ParamValues => { bar => 'baz' },
      }]
   })
), {
  active_kids   => 0,
  error_string  => 'OH DANG',
  kids          => 0,
  name          => 'fREW',
  param_arrays  => [ 1, 2, 3 ],
  statement     => 'SELECT * FROM pals',
  type          => 'st',
  username      => 'admin',
  callbacks     => {
     foo => 'punp',
  },
  param_values  => {
     foo => 'bar'
  },
  substatements => [{
     param_values  => {
        bar => 'baz'
     },
     statement => 'SELECT * FROM frenz'
  }],
}, 'values are correctly extracted from dbh');

done_testing;
