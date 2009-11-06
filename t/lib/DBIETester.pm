package DBIETester;

use Moose;

use Test::More;
use Try::Tiny;

use Test::Exception;

has test_data => (
   isa      => 'HashRef',
   is       => 'ro',
   required => 1,
);

has dbh => (
   isa      => 'DBI::db',
   is       => 'ro',
   required => 1,
);

sub create_table {
   my $self = shift;
   $self->dbh->do($self->test_data->{create_table});
}

sub non_unique {
   my $self = shift;
   my $data = $self->test_data->{non_unique};
   subtest 'non-unique' => sub {
      plan tests => 2;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}}) for (1..2);
      } catch {
         isa_ok $_, 'DBIx::Exception::NotUnique';
         is $_->column, 'name', '... and column name got set correctly';
      };
   };
}

sub invalid_table {
   my $self = shift;
   my $data = $self->test_data->{invalid_table};
   subtest 'invalid table' => sub {
      plan tests => 2;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch {
         isa_ok $_, 'DBIx::Exception::NoSuchTable';
         is $_->table, 'amigo', '... and table name got set correctly';
      };
   };
}

sub invalid_column {
   my $self = shift;
   my $data = $self->test_data->{invalid_column};
   subtest 'invalid column' => sub {
      plan tests => 3;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch {
         isa_ok $_, 'DBIx::Exception::NoSuchColumn';
         is $_->column, 'names', '... and column name got set correctly';
         is $_->table, 'amigos', '... and table name got set correctly';
      };
   };
}

sub syntax {
   my $self = shift;
   my $data = $self->test_data->{syntax};

   subtest 'syntax' => sub {
      my $test = 0;
      plan tests => 10;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute('frew');
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->near, 'INERT', '... and near token got set correctly';
      };

      try {
         my $sth = $self->dbh->prepare('INSERT INO amigos (name) VALUES (?)');
         $sth->execute('frew');
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->near, 'INO', '... and near token got set correctly';
      };

      try {
         my $sth = $self->dbh->prepare('INSERT INTO amigos (name) VALUS (?)');
         $sth->execute('frew');
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->near, 'VALUS', '... and near token got set correctly';
      };

      try {
         my $sth = $self->dbh->prepare('INSERT INTO amigos (name) VALUES ((?)');
         $sth->execute('frew');
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->near, ')', '... and near token got set correctly';
      };

      try {
         my $sth = $self->dbh->prepare('INSERT INTO amigos (name) VALUES (,?)');
         $sth->execute('frew');
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->near, ',', '... and near token got set correctly';
      };
   };
}

sub run_tests {
   my $self = shift;
   $self->create_table;
   $self->non_unique;
   $self->invalid_table;
   $self->invalid_column;
   $self->syntax;
   done_testing;
}

no Moose;
__PACKAGE__->meta->make_immutable();
1;

