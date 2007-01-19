#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;
use WWW::Mechanize;

use WWW::Moreshet;

# change mode:
my %MODE = (
    1 => "controlled",
    2 => "partialy opened",
    5 => "fully opened",
);
my $url = 'http://safe.moreshet.co.il';


my %opts;
usage() if not @ARGV;
GetOptions(\%opts, 
        'user=s', 'password=s', 
        'list', 
        'mode=s',
        'help',
) or usage();
usage() if $opts{help};



my $w = WWW::Mechanize->new();
$w->get($url);
$w->submit_form(
    fields => {
        user => $opts{user},
        pass => $opts{password},
    },
);

# list sites
if ($opts{list}) {
    $w->follow_link(url => "doseek.asp");
    # TODO: show also if they are open or not
    foreach my $link ($w->links) {
        print $link->url;
        if (substr($link->url, 7) eq $link->text) {
            print "  *";
        }
        print "\n";
    }
    exit;
}

#main navigation page
#$w->follow_link(url => "$url/main.asp");
#

if ($opts{mode} and $MODE{ $opts{mode} }) {
    $w->get("$url/statnew.asp?change=$opts{mode}");
}

sub usage {
    print <<"END_USAGE";
Moreshet filter configuration $WWW::Moreshet::VERSION

Usage: $0
        --help


        --user      USERNAME
        --password  PASSWORD

        --list                   list urls
        --mode      MODE_NUMBER  set the given mode

        modes:
END_USAGE
    foreach my $mode (sort {$a <=> $b} keys %MODE) {
        print "            $mode  $MODE{$mode}\n";
    }
    exit;
}

