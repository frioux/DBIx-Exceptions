package DBIETester;

use Moo;

use Test::More;
use Try::Tiny;
use JSON;
use DBIx::ParseException;
use DBIETester::MockErrorDBH;
use Test::Exception;

has database => (
   is       => 'ro',
   required => 1,
);

has capabilities => ( is => 'lazy');
sub _build_capabilities{ shift->parser->capabilities }

has parser => ( is => 'lazy' );
sub _build_parser { DBIx::ParseException->new({ database => shift->database }) }

has test_data => ( is => 'lazy');
sub _build_test_data {
   my $self = shift;
   my $json;
   {
      my $filename = "t/".$self->database.".json";
      open( my $fh, '<', $filename)
         or die "could not open $filename: $!";
      my @json = <$fh>;
      $json = join '',@json;
   }
   return from_json($json);
}

sub non_unique {
   my $self = shift;
   my $cap = $self->capabilities;
   my $error = $self->test_data->{non_unique}{error};
   my $dbh = DBIETester::MockErrorDBH->new($self->test_data->{non_unique}{dbh}||{});
   return unless $cap->can_unique_constraint;
   subtest 'non-unique' => sub {
      my $e = $self->parser->parse($error, $dbh);
      isa_ok $e, 'DBIx::Exception::NotUnique';
      like $e->original, qr/\Q$error\E/,
         '... and original message got set correctly';
      is $e->column, 'name', '... and column name got set correctly'
         if $cap->can_unique_constraint_column;
      done_testing;
   };
}

sub invalid_table {
   my $self = shift;
   my $cap = $self->capabilities;
   my $error = $self->test_data->{invalid_table}{error};
   my $dbh = DBIETester::MockErrorDBH->new($self->test_data->{invalid_table}{dbh}||{});
   return unless $cap->can_no_such_table;
   subtest 'invalid table' => sub {
      my $e = $self->parser->parse($error, $dbh);
      isa_ok $e, 'DBIx::Exception::NoSuchTable';
      like $e->original, qr/\Q$error\E/, '... and original message got set correctly';
      is $e->table, 'amigo', '... and table name got set correctly'
         if $cap->can_no_such_table_table;
      done_testing;
   };
}

sub invalid_column {
   my $self = shift;
   my $cap = $self->capabilities;
   my $error = $self->test_data->{invalid_column}{error};
   my $dbh = DBIETester::MockErrorDBH->new($self->test_data->{invalid_column}{dbh}||{});
   return unless $cap->can_no_such_column;
   subtest 'invalid column' => sub {
      my $e = $self->parser->parse($error, $dbh);
      isa_ok $e, 'DBIx::Exception::NoSuchColumn';
      like $e->original, qr/\Q$error\E/, '... and original message got set correctly';
      is $e->column, 'names', '... and column name got set correctly'
         if $cap->can_no_such_column_column;
      is $e->table, 'amigos', '... and table name got set correctly'
         if $cap->can_no_such_column_table;
      done_testing;
   };
}

sub syntax {
   my $self = shift;
   my @errors = @{$self->test_data->{syntax}};
   my $cap = $self->capabilities;

   return unless $cap->can_syntax;
   subtest 'syntax' => sub {
      my $test = 0;
      my $dbh1 = DBIETester::MockErrorDBH->new($errors[$test]->{dbh}||{});
      my $e1 = $self->parser->parse($errors[$test]->{error}, $dbh1);
      isa_ok $e1, 'DBIx::Exception::Syntax';
      like $e1->original, qr/\Q$errors[$test]->{error}\E/, '... and original message got set correctly';
      is $e1->near, 'INERT', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $dbh2 = DBIETester::MockErrorDBH->new($errors[$test]->{dbh}||{});
      my $e2 = $self->parser->parse($errors[$test]->{error}, $dbh2);
      isa_ok $e2, 'DBIx::Exception::Syntax';
      like $e2->original, qr/\Q$errors[$test]->{error}\E/, '... and original message got set correctly';
      is $e2->near, 'INO', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $dbh3 = DBIETester::MockErrorDBH->new($errors[$test]->{dbh}||{});
      my $e3 = $self->parser->parse($errors[$test]->{error}, $dbh3);
      isa_ok $e3, 'DBIx::Exception::Syntax';
      like $e3->original, qr/\Q$errors[$test]->{error}\E/, '... and original message got set correctly';
      is $e3->near, 'VALUS', '... and near token got set correctly'
         if $cap->can_syntax_near;

      $test++;
      my $dbh4 = DBIETester::MockErrorDBH->new($errors[$test]->{dbh}||{});
      my $e4 = $self->parser->parse($errors[$test]->{error}, $dbh4);
      isa_ok $e4, 'DBIx::Exception::Syntax';
      like $e4->original, qr/\Q$errors[$test]->{error}\E/, '... and original message got set correctly';
      is $e4->near, '.', '... and near token got set correctly'
         if $cap->can_syntax_near_end;

      $test++;
      my $dbh5 = DBIETester::MockErrorDBH->new($errors[$test]->{dbh}||{});
      my $e5 = $self->parser->parse($errors[$test]->{error}, $dbh5);
      isa_ok $e5, 'DBIx::Exception::Syntax';
      like $e5->original, qr/\Q$errors[$test]->{error}\E/, '... and original message got set correctly';
      is $e5->near, ',', '... and near token got set correctly'
         if $cap->can_syntax_near;
      done_testing;
   };
}

sub run_tests {
   my $self = shift;

   $self->non_unique;
   $self->invalid_table;
   $self->invalid_column;
   $self->syntax;
   done_testing;
}

no Moo;
1;

