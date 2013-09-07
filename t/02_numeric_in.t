#!perl -T

use strict;
use warnings;
use overload q{+} => sub { 0 };

use Test::More tests => 32;
use Test::NoWarnings;

BEGIN {
    use_ok('Scalar::In');
}

my $object = bless {}, __PACKAGE__;

note 'Scalar';
ok
    numeric_in( undef, undef ),
    'undef true';
ok
    ! numeric_in( undef, 0 ),
    'undef left';
ok
    ! numeric_in( 0, undef ),
    'undef right';
ok
    numeric_in( 0, '00' ),
    'numeric string true';
ok
    numeric_in( '00', 0 ),
    'string numeric true';
ok
    numeric_in( '00', qr{ \A [0] \z }xms ),
    'string regex true';
ok
    ! numeric_in( 0, 1 ),
    'numeric false';
ok
    ! numeric_in( '00', qr{ \A [0]{2} \z }xms ),
    'string regex false';
ok
    numeric_in( $object, 0 ),
    'object left true';
ok
    numeric_in( 0, $object ),
    'object right true';

note 'Array reference';
ok
    numeric_in( undef, [ undef ] ),
    'undef true';
ok
    ! numeric_in( undef, [ 0 ] ),
    'undef left';
ok
    ! numeric_in( 0, [ undef ] ),
    'undef right';
ok
    numeric_in( 0, [ 0 ] ),
    'numeric true';
ok
    numeric_in( '00', [ qr{ \A [0] \z }xms ] ),
    'string regex true';
ok
    ! numeric_in( 0, [ 1 ] ),
    'numeric false';
ok
    ! numeric_in( '00', [ qr{ \A [0]{2} \z }xms ] ),
    'string regex false';

note 'Array';
ok
    numeric_in( undef, @{[ undef ]} ),
    'undef true';
ok
    ! numeric_in( undef, @{[ 0 .. 2 ]} ),
    'undef left';
ok
    ! numeric_in( 1, @{[ undef ]} ),
    'undef right';
ok
    numeric_in( 1, @{[ 0 .. 2 ]} ),
    'numeric true';
ok
    numeric_in( 1, @{[ qr{ \A [012] \z }xms ]} ),
    'numeric regex true';
ok
    ! numeric_in( 1, @{[ 0, 2 ]} ),
    'numeric false';
ok
    ! numeric_in( 1, @{[ qr{ \A [02] \z }xms ]} ),
    'numeric regex false';

note 'Hash reference';
ok
    ! numeric_in( undef, { 0 => undef } ),
    'undef left';
ok
    numeric_in( 0, { 0 => undef } ),
    'numeric true';
ok
    ! numeric_in( 0, { 1 => undef } ),
    'numeric false';

note 'Hash';
ok
    ! numeric_in( undef, %{{ 1 => undef }} ),
    'undef left';
ok
    numeric_in( 1, %{{ 0 => undef, 1 => undef, 2 => undef }} ),
    'numeric true';
ok
    ! numeric_in( 1, %{{ 0 => undef, 2 => undef }} ),
    'numeric false';
