package DBIETester;

use Moose;

use Test::More;
use Try::Tiny;
use JSON;
use FindBin;
use DBI;
use DBIx::ParseException;

use Test::Exception;

has driver => (
   isa      => 'Str',
   is       => 'ro',
   required => 1,
);

has dsn => (
   isa      => 'Str',
   is       => 'ro',
   required => 1,
);

has test_data => (
   isa        => 'HashRef',
   is         => 'ro',
   lazy_build => 1,
);

has dbh => (
   isa      => 'DBI::db',
   is       => 'ro',
   lazy_build => 1,
);

sub _build_test_data {
   my $self = shift;
   my $json;
   {
      my $filename = "$FindBin::Bin/".$self->driver.".json";
      open( my $fh, '<', $filename)
         or die "could not open $filename: $!";
      my @json = <$fh>;
      $json = join '',@json;
   }
   return from_json($json);
}

sub _build_dbh {
   my $self = shift;
   my $dbh = DBI->connect($self->dsn);

   $dbh->{HandleError} = DBIx::ParseException->handler({ dbh => $dbh });
   return $dbh;
}

sub create_table {
   my $self = shift;
   $self->dbh->do($self->test_data->{create_table});
}

sub non_unique {
   my $self = shift;
   my $data = $self->test_data->{non_unique};
   subtest 'non-unique' => sub {
      plan tests => 3;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}}) for (1..2);
      } catch {
         isa_ok $_, 'DBIx::Exception::NotUnique';
         is $_->original, $data->{err}, '... and original message got set correctly';
         is $_->column, 'name', '... and column name got set correctly';
      };
   };
}

sub invalid_table {
   my $self = shift;
   my $data = $self->test_data->{invalid_table};
   subtest 'invalid table' => sub {
      plan tests => 3;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch {
         isa_ok $_, 'DBIx::Exception::NoSuchTable';
         is $_->original, $data->{err}, '... and original message got set correctly';
         is $_->table, 'amigo', '... and table name got set correctly';
      };
   };
}

sub invalid_column {
   my $self = shift;
   my $data = $self->test_data->{invalid_column};
   subtest 'invalid column' => sub {
      plan tests => 4;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch {
         isa_ok $_, 'DBIx::Exception::NoSuchColumn';
         is $_->original, $data->{err}, '... and original message got set correctly';
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
      plan tests => 15;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->original, $data->[$test]{err}, '... and original message got set correctly';
         is $_->near, 'INERT', '... and near token got set correctly';
      };

      $test++;

      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->original, $data->[$test]{err}, '... and original message got set correctly';
         is $_->near, 'INO', '... and near token got set correctly';
      };

      $test++;

      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->original, $data->[$test]{err}, '... and original message got set correctly';
         is $_->near, 'VALUS', '... and near token got set correctly';
      };

      $test++;

      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->original, $data->[$test]{err}, '... and original message got set correctly';
         is $_->near, ')', '... and near token got set correctly';
      };

      $test++;

      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch {
         isa_ok $_, 'DBIx::Exception::Syntax';
         is $_->original, $data->[$test]{err}, '... and original message got set correctly';
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

