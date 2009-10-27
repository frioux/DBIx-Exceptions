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
);

1;
