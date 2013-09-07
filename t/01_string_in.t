#!perl -T

use strict;
use warnings;
use overload q{""} => sub { 'A' };

use Test::More tests => 31;
use Test::NoWarnings;

BEGIN {
    use_ok('Scalar::In');
}

my $object = bless {}, __PACKAGE__;

note 'Scalar';
ok
    string_in( undef, undef ),
    'undef true';
ok
    ! string_in( undef, 'A' ),
    'undef left';
ok
    ! string_in( 'A', undef ),
    'undef right';
ok
    string_in( 'A', 'A' ),
    'string true';
ok
    string_in( 'A', qr{ \A [A] \z }xms ),
    'string regex true';
ok
    ! string_in( 'A', 'AA' ),
    'string false';
ok
    ! string_in( 'A', qr{ \A [A]{2} \z }xms ),
    'string regex false';
ok
    string_in( $object, 'A' ),
    'object left true';
ok
    string_in( 'A', $object ),
    'object right true';

note 'Array reference';
ok
    string_in( undef, [ undef ] ),
    'undef true';
ok
    ! string_in( undef, [ 'A' ] ),
    'undef left';
ok
    ! string_in( 'A', [ undef ] ),
    'undef right';
ok
    string_in( 'A', [ 'A' ] ),
    'string true';
ok
    string_in( 'A', [ qr{ \A [A] \z }xms ] ),
    'string regex true';
ok
    ! string_in( 'A', [ 'AA' ] ),
    'string false';
ok
    ! string_in( 'A', [ qr{ \A [A]{2} \z }xms ] ),
    'string regex false';

note 'Array';
ok
    string_in( undef, @{[ undef ]} ),
    'undef true';
ok
    ! string_in( undef, @{[ 'A' .. 'C' ]} ),
    'undef left';
ok
    ! string_in( 'A', @{[ undef ]} ),
    'undef right';
ok
    string_in( 'A', @{[ 'A' .. 'C' ]} ),
    'string true';
ok
    string_in( 'A', @{[ qr{ \A [ABC] \z }xms ]} ),
    'string regex true';
ok
    ! string_in( 'A', @{[ 'B' .. 'C' ]} ),
    'string false';
ok
    ! string_in( 'A', @{[ qr{ \A [BC] \z }xms ]} ),
    'string regex false';

note 'Hash reference';
ok
    ! string_in( undef, { A => undef } ),
    'undef left';
ok
    string_in( 'A', { A => undef } ),
    'string true';
ok
    ! string_in( 'A', { B => undef } ),
    'string false';

note 'Hash';
ok
    ! string_in( undef, %{{ A => undef }} ),
    'undef left';
ok
    string_in( 'A', %{{ A => undef, B => undef, C => undef }} ),
    'string true';
ok
    ! string_in( 'A', %{{ B => undef, C => undef }} ),
    'string false';
