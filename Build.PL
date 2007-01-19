use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name           => 'WWW::Moreshet',
    license               => 'perl',
    dist_author           => 'Gabor Szabo',
    create_makefile_pl    => 'traditional',
    create_readme         => 0,
    recursive_test_files  => 0,
    script_files          => [qw(bin/moreshet.pl)],
    requires              => {
        'WWW::Mechanize'         => 0,
        'Getopt::Long'           => 0,
    },
    build_requires        => {
        'Test::More'                => '0.47',
    },
);

$builder->create_build_script();
