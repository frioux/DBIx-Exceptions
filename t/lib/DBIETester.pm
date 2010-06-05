package DBIETester;

use Moose;

use Test::More;
use Try::Tiny;
use JSON;
use FindBin;
use DBI;
use DBIx::ParseException;
use DBIETester::MockErrorDBH;
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

has username => (
   isa      => 'Str',
   is       => 'ro',
   required => 0,
);

has password => (
   isa      => 'Str',
   is       => 'ro',
   required => 0,
);

has test_data => (
   isa        => 'HashRef',
   is         => 'ro',
   lazy_build => 1,
);

has capabilities => (
   is       => 'ro',
   lazy_build => 1,
);

sub _build_capabilities{
   DBIx::ParseException->capabilities({ dbh => $_[0]->dbh })
}

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
   my $dbh = DBI->connect($self->dsn, $self->username, $self->password);

   $dbh->{HandleError} = DBIx::ParseException->handler({ dbh => $dbh });
   return $dbh;
}

sub create_table {
   my $self = shift;

   $self->dbh->do(delete $self->test_data->{create_table});
}

sub non_unique {
   my $self = shift;
   my $cap = $self->capabilities;
   my $data = $self->test_data->{non_unique};
   return unless $cap->can_unique_constraint;
   subtest 'non-unique' => sub {
      my $e;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}}) for (1..2);
      } catch { $e = $_ };
      isa_ok $e, 'DBIx::Exception::NotUnique';
      like $e->original, qr/${\$data->{err}}/,
         '... and original message got set correctly';
      is $e->column, 'name', '... and column name got set correctly'
         if $cap->can_unique_constraint_column;
      done_testing;
   };
}

sub invalid_table {
   my $self = shift;
   my $cap = $self->capabilities;
   my $data = $self->test_data->{invalid_table};
   return unless $cap->can_no_such_table;
   my $e;
   subtest 'invalid table' => sub {
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch { $e = $_ };
      isa_ok $e, 'DBIx::Exception::NoSuchTable';
      like $e->original, qr/${\$data->{err}}/, '... and original message got set correctly';
      is $e->table, 'amigo', '... and table name got set correctly'
         if $cap->can_no_such_table_table;
      done_testing;
   };
}

sub invalid_column {
   my $self = shift;
   my $cap = $self->capabilities;
   my $data = $self->test_data->{invalid_column};
   return unless $cap->can_no_such_column;
   my $e;
   subtest 'invalid column' => sub {
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch { $e = $_ };
      isa_ok $e, 'DBIx::Exception::NoSuchColumn';
      like $e->original, qr/${\$data->{err}}/, '... and original message got set correctly';
      is $e->column, 'names', '... and column name got set correctly'
         if $cap->can_no_such_column_column;
      is $e->table, 'amigos', '... and table name got set correctly'
         if $cap->can_no_such_column_table;
      done_testing;
   };
}

sub syntax {
   my $self = shift;
   my $data = $self->test_data->{syntax};
   my $cap = $self->capabilities;

   return unless $cap->can_syntax;
   subtest 'syntax' => sub {
      my $e1;
      my $test = 0;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch { $e1 = $_   };

      isa_ok $e1, 'DBIx::Exception::Syntax';
      like $e1->original, qr/${\$data->[$test]{err}}/, '... and original message got set correctly';
      is $e1->near, 'INERT', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $e2;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch { $e2 = $_ };
      isa_ok $e2, 'DBIx::Exception::Syntax';
      like $e2->original, qr/${\$data->[$test]{err}}/, '... and original message got set correctly';
      is $e2->near, 'INO', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $e3;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch { $e3 = $_ };
      isa_ok $e3, 'DBIx::Exception::Syntax';
      like $e3->original, qr/${\$data->[$test]{err}}/, '... and original message got set correctly';
      is $e3->near, 'VALUS', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $e4;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch { $e4 = $_ };
      isa_ok $e4, 'DBIx::Exception::Syntax';
      like $e4->original, qr/${\$data->[$test]{err}}/, '... and original message got set correctly';
      is $e4->near, ')', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $e5;
      try {
         my $sth = $self->dbh->prepare($data->[$test]{stmt});
         $sth->execute($data->[$test]{vals});
      } catch { $e5 = $_ };
      isa_ok $e5, 'DBIx::Exception::Syntax';
      like $e5->original, qr/${\$data->[$test]{err}}/, '... and original message got set correctly';
      is $e5->near, ',', '... and near token got set correctly'
         if $cap->can_syntax_near;
      done_testing;
   };
}

# generic test which just uses the stmt in the test data, runs it against
# the live db and checks that the class and the tokens are set correctly
sub test_generic_live {
   my ($self, $test_name) = @_;
   my $data = $self->test_data->{ $test_name };
   subtest $test_name => sub {
      plan;
      try {
         my $sth = $self->dbh->prepare($data->{stmt});
         $sth->execute(@{$data->{vals}});
      } catch {
         isa_ok $_, $data->{class};
         like $_->original, qr/${\$data->{err}}/, '... and original message got set correctly';
         if (my $tkns = $data->{tokens}) {
            foreach my $col (keys %{$tkns}) {
               is $_->{$col}, $tkns->{$col}, "... and $col token got set correctly";
            }
         }
         done_testing();
      };
   };
}

sub test_generic_mock {
   my ($self, $test_name) = @_;
   my $data = $self->test_data->{ $test_name };
   my $driver = $self->dbh->{Driver}{Name};
   my $parser_class = 'DBIx::ParseException::' . $driver;
   eval "require $parser_class";
   my $mock_dbh_params = $data->{mock_dbh};
   my $mock_dbh = DBIETester::MockErrorDBH->new($mock_dbh_params);

   subtest $test_name => sub {
      plan;
      try {
         # what's the right way to do this?
         $parser_class->can('error_handler')->($mock_dbh->errstr, $mock_dbh);
      } catch {
         isa_ok $_, $data->{class};
         like $_->original, qr/${\$data->{err}}/, '... and original message got set correctly';
         if (my $tkns = $data->{tokens}) {
            foreach my $col (keys %{$tkns}) {
               is $_->{$col}, $tkns->{$col}, "... and $col token got set correctly";
            }
         }
         done_testing();
      }
   }


}

sub run_tests {
   my $self = shift;

   $self->create_table;

   # there are three levels of testing
   # 1) the test has a custom method in this class
   # 2) no custom method, but there is a stmt in the test_data
   #    which can be run against the live db using ->test_generic_live
   # 3) no custom method or stmt, but there is a sample error message
   #    in the test_data which can be thrown at the parser to check
   #    that the correct class and tokens are set (better than nothing basically)
   foreach my $test_name (keys %{$self->test_data}) {
      my $data = $self->test_data->{$test_name};
      if (my $sub = $self->can($test_name)) {
         $sub->($self);
      } else {
         if ($data->{stmt}) {
            $self->test_generic_live($test_name);
         } else {
            $self->test_generic_mock($test_name);
         }
      }
   }
   done_testing;
}

no Moose;
__PACKAGE__->meta->make_immutable();
1;

