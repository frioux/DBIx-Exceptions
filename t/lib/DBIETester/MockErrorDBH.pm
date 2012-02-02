package DBIETester::MockErrorDBH;

sub new {
   my ($class, $hashref) = @_;
   $hashref ||= {};
   $hashref->{Type}  ||= 'st';
   $hashref->{Database} = $hashref;

   bless($hashref, $class);
}

sub state { $_[0]->{state}  }
sub err   { $_[0]->{err}    }
sub errstr{ $_[0]->{errstr} }

1;

