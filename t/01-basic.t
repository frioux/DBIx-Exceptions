#!perl

use strict;
use warnings;

use Test::More;
use Try::Tiny;

use Test::Exception;

use Carp 'confess';
use DBI;
use DBIx::ParseException::SQLite;

my $dbh = DBI->connect('dbi:SQLite:dbname=dbfile');

$dbh->{HandleError} = \&DBIx::ParseException::SQLite::error_handler;

$dbh->do(<<'SQL');
CREATE TABLE amigos (
   name VARCHAR(25),
   email VARCHAR(25),
   UNIQUE(email),
   UNIQUE(name)
);
SQL

subtest 'non-unique' => sub {
   plan tests => 3;
   try {
      my $sth = $dbh->prepare('INSERT INTO amigos (name) VALUES (?)');
      $sth->execute('frew') for (1..2);
   } catch {
      isa_ok $_, 'DBIx::Exception::NotUnique';
      is $_->original, 'DBD::SQLite::st execute failed: column name is not unique',
         '... and original exception message got set correctly';
      is $_->column, 'name', '... and column name got set correctly';
   };
};

subtest 'invalid table' => sub {
   plan tests => 3;
   try {
      my $sth = $dbh->prepare('INSERT INTO amigo (name) VALUES (?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::NoSuchTable';
      is $_->original, 'DBD::SQLite::db prepare failed: no such table: amigo',
         '... and original exception message got set correctly';
      is $_->table, 'amigo', '... and table name got set correctly';
   };
};

subtest 'invalid column' => sub {
   plan tests => 4;
   try {
      my $sth = $dbh->prepare('INSERT INTO amigos (names) VALUES (?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::NoSuchColumn';
      is $_->original, 'DBD::SQLite::db prepare failed: table amigos has no column named names',
         '... and original exception message got set correctly';
      is $_->column, 'names', '... and column name got set correctly';
      is $_->table, 'amigos', '... and table name got set correctly';
   };
};

subtest 'syntax' => sub {
   plan tests => 15;
   try {
      my $sth = $dbh->prepare('INERT INTO amigos (name) VALUES (?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::Syntax';
      is $_->original, 'DBD::SQLite::db prepare failed: near "INERT": syntax error',
         '... and original exception message got set correctly';
      is $_->near, 'INERT', '... and near token got set correctly';
   };

   try {
      my $sth = $dbh->prepare('INSERT INO amigos (name) VALUES (?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::Syntax';
      is $_->original, 'DBD::SQLite::db prepare failed: near "INO": syntax error',
         '... and original exception message got set correctly';
      is $_->near, 'INO', '... and near token got set correctly';
   };

   try {
      my $sth = $dbh->prepare('INSERT INTO amigos (name) VALUS (?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::Syntax';
      is $_->original, 'DBD::SQLite::db prepare failed: near "VALUS": syntax error',
         '... and original exception message got set correctly';
      is $_->near, 'VALUS', '... and near token got set correctly';
   };

   try {
      my $sth = $dbh->prepare('INSERT INTO amigos (name) VALUES ((?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::Syntax';
      is $_->original, 'DBD::SQLite::db prepare failed: near ")": syntax error',
         '... and original exception message got set correctly';
      is $_->near, ')', '... and near token got set correctly';
   };

   try {
      my $sth = $dbh->prepare('INSERT INTO amigos (name) VALUES (,?)');
      $sth->execute('frew');
   } catch {
      isa_ok $_, 'DBIx::Exception::Syntax';
      is $_->original, 'DBD::SQLite::db prepare failed: near ",": syntax error',
         '... and original exception message got set correctly';
      is $_->near, ',', '... and near token got set correctly';
   };
};

END { unlink 'dbfile' }
done_testing;
