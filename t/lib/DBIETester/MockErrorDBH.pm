package DBIETester::MockErrorDBH;

use Moose;

has state => (
   isa      => 'Str',
   is       => 'ro',
   required => 0,
);

has err => (
   isa      => 'Str',
   is       => 'ro',
   required => 0,
);

has errstr => (
   isa      => 'Str',
   is       => 'ro',
   required => 0,
);

1;




