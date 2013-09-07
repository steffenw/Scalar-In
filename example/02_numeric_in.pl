#!perl -T ## no critic (TidyCode)

use strict;
use warnings;
use overload q{+} => sub { return 0 };

use Scalar::In;

our $VERSION = '0.001';

my $object = bless {}, __PACKAGE__;

() = print
    'Scalar: ',
    0 + numeric_in( undef, undef ),
    0 + numeric_in( undef, 0 ),
    0 + numeric_in( 0, undef ),
    0 + numeric_in( 0, '00' ),
    0 + numeric_in( '00', 0 ),
    0 + numeric_in( '00', qr{ \A [0] \z }xms ),
    0 + numeric_in( 0, 1 ),
    0 + numeric_in( '00', qr{ \A [0]{2} \z }xms ),
    0 + numeric_in( $object, qr{ \A [0] \z }xms ),
    "\nArray reference: ",
    0 + numeric_in( undef, [ undef ] ),
    0 + numeric_in( undef, [ 0 ] ),
    0 + numeric_in( 0, [ undef ] ),
    0 + numeric_in( 0, [ 0 ] ),
    0 + numeric_in( '00', [ qr{ \A [0] \z }xms ] ),
    0 + numeric_in( 0, [ 1 ] ),
    0 + numeric_in( '00', [ qr{ \A [0]{2} \z }xms ] ),
    "\nArray: ",
    0 + numeric_in( undef, @{[ undef ]} ),
    0 + numeric_in( undef, @{[ 0 .. 2 ]} ),
    0 + numeric_in( 1, @{[ undef ]} ),
    0 + numeric_in( 1, @{[ 0 .. 2 ]} ),
    0 + numeric_in( 1, @{[ qr{ \A [012] \z }xms ]} ),
    0 + numeric_in( 1, @{[ 0, 2 ]} ),
    numeric_in( 1, @{[ qr{ \A [02] \z }xms ]} ),
    "\nHash reference: ",
    0 + string_in( undef, { 0 => undef } ),
    0 + numeric_in( 0, { 0 => undef } ),
    0 + numeric_in( 0, { 1 => undef } ),
    "\nHash: ",
    0 + numeric_in( undef, %{{ 1 => undef }} ),
    0 + numeric_in( 1, %{{ 0 => undef, 1 => undef, 2 => undef }} ),
    0 + numeric_in( 1, %{{ 0 => undef, 2 => undef }} ),
    "\n";

# $Id$

__END__

Output:

Scalar: 100111001
Array reference: 1001100
Array: 100110
Hash reference: 010
Hash: 010
