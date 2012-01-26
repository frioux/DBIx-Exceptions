package DBIx::ParseException::Role::ExtractFromDBH;

use Moo::Role;
use DBI;

sub extract_from_dbh {
   my ($self, $dbh) = @_;

   my $out;
   my $h; # junk
   if ($DBI::lasth) {
      $out .= "  lasth type: $DBI::lasth->{Type}\n"
         if ($DBI::lasth->{Type});
      $out .= "  lasth Statement ($DBI::lasth):\n    " .
                                                "$DBI::lasth->{Statement}\n"
                                                   if ($DBI::lasth->{Statement});
   }
   # get db handle if we have an st
   my $type = $dbh->{Type};
   my $sql;
   if ($type eq 'st') {    # given statement handle
      $dbh = $dbh->{Database};
      $sql = $dbh->{Statement};
   } else {
   # given db handle
   # We've got other stmts under this db but we'll deal with those later
      $sql = 'Possible SQL: ';
      $sql .= "/$h->{Statement}/" if (exists($h->{Statement}));
      $sql .= "/$dbh->{Statement}/"
         if ($dbh->{Statement} &&
               (exists($h->{Statement}) &&
                ($dbh->{Statement} ne $h->{Statement})));
   }

   my $dbname = exists($dbh->{Name}) ? $dbh->{Name} : "";
   my $username = exists($dbh->{Username}) ? $dbh->{Username} : "";
   $out .= "  DB: $dbname, Username: $username\n";
   $out .= "  handle type: $type\n  SQL: " . DBI::neat($sql) . "\n";
   $out .= '  db Kids=' . $dbh->{Kids} .  ', ActiveKids=' . $dbh->{ActiveKids} . "\n";
   $out .= "  DB errstr: " . $dbh->errstr . "\n";

   if (exists($h->{ParamValues}) && $h->{ParamValues}) {
      $out .= "  ParamValues captured in HandleSetErr:\n    ";
      foreach (sort keys %{$h->{ParamValues}}) {
         $out .= "$_=" . DBI::neat($h->{ParamValues}->{$_}) . ",";
      }
      $out .= "\n";
   }
   if ($type eq 'st') {
      my $str = "";
      if ($dbh->{ParamValues}) {
         foreach (sort keys %{$dbh->{ParamValues}}) {
            $str .= "$_=" . DBI::neat($dbh->{ParamValues}->{$_}) . ",";
         }
      }
      $out .= "  ParamValues: $str\n";
      $out .= "  " . Data::Dumper->Dump([$dbh->{ParamArrays}], ['ParamArrays'])
         if ($dbh->{ParamArrays});
   }
   my @substmts;
   # get list of statements under the db
   push @substmts, $_ for (grep { defined } @{$dbh->{ChildHandles}});
   $out .= "  " . scalar(@substmts) . " sub statements:\n";
   if (scalar(@substmts)) {
      foreach my $stmt (@substmts) {
         $out .= "  stmt($stmt):\n";
         $out .= '    SQL(' . $stmt->{Statement} . ")\n  "
               if ($stmt->{Statement} &&
                  (exists($h->{Statement}) &&
                   ($h->{Statement} ne $stmt->{Statement})));
               if (exists($stmt->{ParamValues}) && $stmt->{ParamValues}) {
               $out .= '   Params(';
                  foreach (sort keys %{$stmt->{ParamValues}}) {
                     $out .= "$_=" . DBI::neat($stmt->{ParamValues}->{$_}) . ",";
                  }
                  $out .= ")\n";
               }
      }
   }

   if (exists($dbh->{Callbacks})) {
      $out .= "  Callbacks exist for " .
      join(",", keys(%{$dbh->{Callbacks}})) . "\n";
   }
}

1;
