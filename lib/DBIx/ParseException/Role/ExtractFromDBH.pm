package DBIx::ParseException::Role::ExtractFromDBH;

use Moo::Role;
use DBI;

sub extract_from_dbh {
   my ($self, $dbh) = @_;

   my %out;
   if ($DBI::lasth) {
      $out{lasth}           = $DBI::lasth;
      $out{lasth_type}      = $DBI::lasth->{Type};
      $out{lasth_statement} = $DBI::lasth->{Statement};
   }

   my $type = $dbh->{Type} || '';
   if ($type eq 'st') {
      $dbh               = $dbh->{Database};
      $out{param_values} = $dbh->{ParamValues};
      $out{param_arrays} = $dbh->{ParamArrays};
   }

   $out{name}         = $dbh->{Name};
   $out{username}     = $dbh->{Username};
   $out{type}         = $type;
   $out{statement}    = $dbh->{Statement};
   $out{kids}         = $dbh->{Kids};
   $out{active_kids}  = $dbh->{ActiveKids};
   $out{error_string} = $dbh->errstr;
   $out{callbacks}    = $dbh->{Callbacks} || {};

   # this should probably be:
   # @substmts = map $self->extract_from_dbh($stmt),
   #    grep { defined } @{$dbh->{ChildHandles}};
   #
   # but we'll start with what we already have
   $out{substatements} = [map +{
      statement    => $_->{Statement},
      param_values => $_->{ParamValues},
   }, grep { defined } @{$dbh->{ChildHandles}}];

   \%out
}

1;
