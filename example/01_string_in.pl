#!perl -T ## no critic (TidyCode)

use strict;
use warnings;
use overload q{""} => sub { return q{A} };

use Scalar::In;

our $VERSION = '0.001';

my $object = bless {}, __PACKAGE__;

() = print
    'Scalar: ',
    0 + string_in( undef, undef ),
    0 + string_in( undef, 'A' ),
    0 + string_in( 'A', undef ),
    0 + string_in( 'A', 'A' ),
    0 + string_in( 'A', qr{ \A [A] \z }xms ),
    0 + string_in( 'A', 'AA' ),
    0 + string_in( 'A', qr{ \A [A]{2} \z }xms ),
    0 + string_in( $object, 'A' ),
    0 + string_in( 'A', $object ),
    "\nArray reference: ",
    0 + string_in( undef, [ undef ] ),
    0 + string_in( undef, [ 'A' ] ),
    0 + string_in( 'A', [ undef ] ),
    0 + string_in( 'A', [ 'A' ] ),
    0 + string_in( 'A', [ qr{ \A [A] \z }xms ] ),
    0 + string_in( 'A', [ 'AA' ] ),
    0 + string_in( 'A', [ qr{ \A [A]{2} \z }xms ] ),
    "\nArray: ",
    0 + string_in( undef, @{[ undef ]} ),
    0 + string_in( undef, @{[ 'A' .. 'C' ]} ),
    0 + string_in( 'A', @{[ undef ]} ),
    0 + string_in( 'A', @{[ 'A' .. 'C' ]} ),
    0 + string_in( 'A', @{[ qr{ \A [ABC] \z }xms ]} ),
    0 + string_in( 'A', @{[ 'B' .. 'C' ]} ),
    0 + string_in( 'A', @{[ qr{ \A [BC] \z }xms ]} ),
    "\nHash reference: ",
    0 + string_in( undef, { A => undef } ),
    0 + string_in( 'A', { A => undef } ),
    0 + string_in( 'A', { B => undef } ),
    "\nHash: ",
    0 + string_in( undef, %{{ A => undef }} ),
    0 + string_in( 'A', %{{ A => undef, B => undef, C => undef }} ),
    0 + string_in( 'A', %{{ B => undef, C => undef }} ),
    "\n";

# $Id$

__END__

Output:

Scalar: 100110011
Array reference: 1001100
Array: 1001100
Hash reference: 010
Hash: 010
