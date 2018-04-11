requires 'parent';
requires 'Moo';
requires 'Exception::Class';
requires 'Try::Tiny';
requires 'DBI';
requires 'Carp';
requires 'JSON';

on test => sub {
   requires 'DBD::SQLite';
   requires 'Test::More', 0.94;
   requires 'Test::Exception';
};
