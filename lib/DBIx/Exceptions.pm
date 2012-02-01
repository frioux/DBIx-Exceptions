package DBIx::Exceptions;

# ABSTRACT: Get full exception objects from DBI

package DBIx::Exception;

use Moo;

has $_ => ( is => 'ro' ) for qw(
   original
   lasth
   lasth_type
   lasth_statement
   type
   param_values
   param_arrays
   name
   username
   statement
   kids
   active_kids
   error_string
   callbacks
   substatements
);

1;

package DBIx::Exception::ConstraintViolation;

use Moo;

extends 'DBIx::Exception';

has column => ( is => 'ro' );
has constraint => ( is => 'ro' );

1;

package DBIx::Exception::NotUnique;

use Moo;

extends 'DBIx::Exception::ConstraintViolation';

1;

package DBIx::Exception::NotNull;

use Moo;

extends 'DBIx::Exception::ConstraintViolation';

1;

package DBIx::Exception::ForeignKey;

use Moo;

extends 'DBIx::Exception::ConstraintViolation';

1;

package DBIx::Exception::Timeout;

use Moo;

extends 'DBIx::Exception';

1;

package DBIx::Exception::QueryCanceled;

use Moo;

extends 'DBIx::Exception';

1;

package DBIx::Exception::Deadlock;

use Moo;

extends 'DBIx::Exception';

1;

package DBIx::Exception::Syntax;

use Moo;

extends 'DBIx::Exception';

has near => ( is => 'ro' );

1;

package DBIx::Exception::NoSuchTable;

use Moo;

extends 'DBIx::Exception';

has table => ( is => 'ro' );

1;

package DBIx::Exception::NoSuchColumn;

use Moo;

extends 'DBIx::Exception';

has table => ( is => 'ro' );
has column => ( is => 'ro' );

1;

1;

=pod

=head1 DEVELOPER RELEASE

This distribution is not ready for prime time AT ALL.  I'm only releasing it so
that the one person using it can use it more easily.  If you want to help make
this module more of a reality let me know.  I still want to finish it, I'm just
not there yet.
