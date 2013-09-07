use strict;
use warnings;

use Module::Build;

Module::Build->new(
    module_name       => 'Scalar::In',
    license           => 'perl',
    dist_abstract     => 'Scalar::In - replacement for smartmatch',
    dist_author       => 'Steffen Winkler <steffenw at cpan.org>',
    dist_version_from => 'lib/Scalar/In.pm',
    requires          => {
        perl    => '5.006',
        version => 0,
    },
    build_requires => {
        'Test::NoWarnings'  => 0,
        'Test::More'        => 0, # dist Test-Simple
    },
    recommends => {
        'Test::Pod'            => '1.14',
        'Test::Pod::Coverage'  => '1.04',
    },
    create_makefile_pl   => 'traditional',
    recursive_test_files => 0,
    add_to_cleanup       => [ qw(
        META.yml *.bak *.gz Makefile.PL
    ) ],
)->create_build_script;
