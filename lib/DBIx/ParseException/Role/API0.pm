package DBIx::ParseException::Role::API0;

# ABSTRACT: Version 0 of the exception types

use Moo::Role;

with 'DBIx::ParseException::Role::API';

1;

=pod

=head1 DBIx::Exception

=head2 original

The string that got passed to the parser

=head2 lasth

L<DBI/lasth>

=head2 type

L<DBI/Type>

=head2 param_values

L<DBI/ParamValues>

=head2 param_arrays

L<DBI/ParamArrays>

=head2 name

L<DBI/Name>

=head2 username

L<DBI/Username>

=head2 statement

L<DBI/Statement>

=head2 kids

L<DBI/Kids>

=head2 active_kids

L<DBI/ActiveKids>

=head2 error_string

L<DBI/errstr>

=head2 callbacks

L<DBI/Callbacks>

=head2 substatements

=head1 DBIx::Exception::ConstraintViolation

Inherits from L</DBIx::Exception>.

=head2 column

The column that caused the constraint violation

=head2 constraint

The constraint that was violated

=head1 DBIx::Exception::NotUnique

Inherits from L</DBIx::Exception::ConstraintViolation>.

=head1 DBIx::Exception::NotNull

Inherits from L</DBIx::Exception::ConstraintViolation>.

=head1 DBIx::Exception::ForeignKey

Inherits from L</DBIx::Exception::ConstraintViolation>.

=head1 DBIx::Exception::Timeout

Inherits from L</DBIx::Exception>.

=head1 DBIx::Exception::QueryCanceled

Inherits from L</DBIx::Exception>.

=head1 DBIx::Exception::Deadlock

Inherits from L</DBIx::Exception>.

=head1 DBIx::Exception::Syntax

Inherits from L</DBIx::Exception>.

=head2 near

The token that the syntax error was near

=head1 DBIx::Exception::NoSuchTable

Inherits from L</DBIx::Exception>.

=head2 table

The table that does not exist

=head1 DBIx::Exception::NoSuchColumn

Inherits from L</DBIx::Exception>.

=head2 table

The table that for the referenced column

=head2 column

The column that does not exist
