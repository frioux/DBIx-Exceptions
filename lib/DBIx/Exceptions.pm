package DBIx::Exceptions;

use Exception::Class (
   'DBIx::Exception' => {
      fields => [ 'original' ],
   },
   'DBIx::Exception::NotUnique' => {
      isa => 'DBIx::Exception',
      fields => [ 'column' ],
   },
   'DBIx::Exception::Syntax' => {
      isa => 'DBIx::Exception',
      fields => [ 'near' ],
   },
   'DBIx::Exception::NoSuchTable' => {
      isa => 'DBIx::Exception',
      fields => [ 'table' ],
   },
   'DBIx::Exception::NoSuchColumn' => {
      isa => 'DBIx::Exception',
      fields => [ qw{column table} ],
   },
);

1;
