package Scalar::In; ## no critic (TidyCode)

use strict;
use warnings;
use Sub::Exporter -setup => {
    exports => [ qw( string_in numeric_in ) ],
    groups  => {
        default => [ qw( string_in numeric_in ) ],
    },
};

our $VERSION = '0.001';

# using dualvars
my $true  = ! 0;
my $false = ! 1;

sub string_in ($+) { ## no critic (SubroutinePrototypes)
    my ( $string, $any ) = @_;

    if ( defined $string ) {
        $string = q{}. $string; # stingify object
    }
    my $ref = ref $any;
    my @any
        = $ref eq 'ARRAY'
        ? @{$any}
        : $ref eq 'HASH'
        ? keys %{$any}
        : $any;
    ITEM:
    for my $item ( @any ) {
        if ( ! defined $string || ! defined $item ) {
            return ! ( defined $string xor defined $item );
        }
        if ( ref $item eq 'Regexp' ) {
            $string =~ $item
                and return $true;
            next ITEM;
        }
        ref $item eq 'CODE'
            and return $item->($string);
        $string eq q{} . $item # stingify object
            and return $true;
    }

    return $false;
}

sub numeric_in ($+) { ## no critic (SubroutinePrototypes)
    my ( $numeric, $any ) = @_;

    if ( defined $numeric ) {
        $numeric += 0; # numify object
    }
    my $ref = ref $any;
    my @any
        = $ref eq 'ARRAY'
        ? @{$any}
        : $ref eq 'HASH'
        ? keys %{$any}
        : $any;
    ITEM:
    for my $item ( @any ) {
        if ( ! defined $numeric || ! defined $item ) {
            return ! ( defined $numeric xor defined $item );
        }
        if ( ref $item eq 'Regexp' ) {
            $numeric =~ $item
                and return $true;
            next ITEM;
        }
        ref $item eq 'CODE'
            and return $item->($numeric);
        $numeric == ( 0 + $item ) # numify object
            and return $true;
    }

    return $false;
}

# $Id$

1;

__END__

=head1 NAME

Scalar::In - replacement for smartmatch

=head1 VERSION

0.001

=head1 SYNOPSIS

    use Scalar::In;
    use Scalar::In qw( string_in numeric_in );

=head1 EXAMPLE

Inside of this Distribution is a directory named example.
Run this *.pl files.

=head1 DESCRIPTION

This module was written because the smartmatch operator ~~
was deprecated as experimental.

=head1 SUBROUTINES/METHODS

=head2 subroutine string_in

The given value will be used as string if it is defined.

true if $string is undef

    $boolean = string_in( $string, undef );

true if $string is eq 'string'

    $boolean = string_in( $string, 'string' );

true if $string contains abc or def

    $boolean = string_in( $string, qr{ abc | def }xms );

true if $string begins with abc

    $boolean = string_in(
        $string,
        sub {
            my $str = shift;
            return 0 == index $str, 'abc';
        },
    );

true if $object overloads C<""> and that is C<eq> 'string'.

    $boolean = string_in( $object, 'string' );

The array or array reference can contain undef, string and/or regex.
true if any in the array or array reference will match

    $boolean = string_in( $string, $arrayref );
    $boolean = string_in( $string, @array );

true if any key in the hash or hash reference will match

    $boolean = string_in( $string, $hashref );
    $boolean = string_in( $string, %hash );

Objects that overload C<""> also allowed as 2nd parameter
or in a array or array reference.

=head2 subroutine numeric_in

A given value will be used as numeric if it is defined.
Maybe that thows a numeric warning if a string looks not like numeric.
The difference to subroutine string_in is,
that here is operator C<==> used instead of operator C<eq>.

    $boolean = numeric_in( $numeric, undef );
    $boolean = numeric_in( $numeric, 123 );
    $boolean = numeric_in( $numeric, qr{ 123 | 456 }xms );
    $boolean = numeric_in( $numeric, $arrayref );
    $boolean = numeric_in( $numeric, @array );
    $boolean = numeric_in( $numeric, $hashref );
    $boolean = numeric_in( $numeric, %hash );

true if $numeric > 1

    $boolean = numeric_in(
        $numeric,
        sub {
            my $num = shift;
            return $num > 1;
        },
    );

true if $object overloads C<+> and that is C<==> 123.

    $boolean = numeric_in( $object, 'string' );

Objects that overload C<+> also allowed as 2nd parameter
or in a array or array reference.

=head1 DIAGNOSTICS

none

=head1 CONFIGURATION AND ENVIRONMENT

nothing

=head1 DEPENDENCIES

L<Sub::Exporter|Sub::Exporter>

=head1 INCOMPATIBILITIES

nothing

=head1 BUGS AND LIMITATIONS

nothing

=head1 SEE ALSO

smartmatch operator ~~

=head1 AUTHOR

Steffen Winkler

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013,
Steffen Winkler
C<< <steffenw at cpan.org> >>.
All rights reserved.

This module is free software;
you can redistribute it and/or modify it
under the same terms as Perl itself.
