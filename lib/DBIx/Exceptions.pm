package DBIx::Exceptions;

use Exception::Class (
   'DBIx::Exception' => {
      fields => [ 'original' ],
   },
   'DBIx::Exception::ConstraintViolation' => {
      isa => 'DBIx::Exception',
      fields => [ 'column', 'constraint' ],
   },
   'DBIx::Exception::NotUnique' => {
      isa => 'DBIx::Exception::ConstraintViolation',
   },
   'DBIx::Exception::NotNull' => {
      isa => 'DBIx::Exception::ConstraintViolation',
   },
   'DBIx::Exception::ForeignKey' => {
      isa => 'DBIx::Exception::ConstraintViolation',
   },

   'DBIx::Exception::Timeout' => {
      isa => 'DBIx::Exception',
      fields => [],
   },
   'DBIx::Exception::QueryCanceled' => {
      isa => 'DBIx::Exception::Timeout'
   },

   'DBIx::Exception::NotUnique' => {
      isa => 'DBIx::Exception::ConstraintViolation',
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
