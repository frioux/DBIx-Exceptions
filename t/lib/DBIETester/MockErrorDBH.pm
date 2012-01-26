package DBIETester::MockErrorDBH;

use Moo;

has state  => ( is => 'ro');
has err    => ( is => 'ro' );
has errstr => ( is => 'ro');

1;

