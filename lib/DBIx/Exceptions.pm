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

   'DBIx::Exception::Deadlock' => {
      isa => 'DBIx::Exception',
      fields => [],
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

=pod

=head1 DEVELOPER RELEASE

This distribution is not ready for prime time AT ALL.  I'm only releasing it so
that the one person using it can use it more easily.  If you want to help make
this module more of a reality let me know.  I still want to finish it, I'm just
not there yet.
