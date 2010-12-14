package DBIETester::MockErrorDBH;

use Moo;

has state => (
   isa      => 'Str',
   is       => 'ro',
);

has err => (
   isa      => 'Str',
   is       => 'ro',
);

has errstr => (
   isa      => 'Str',
   is       => 'ro',
);

1;




