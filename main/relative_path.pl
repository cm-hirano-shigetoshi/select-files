#!/usr/bin/env perl
use strict;
use warnings;

my $prefix = quotemeta($ARGV[0]);
if ($prefix eq "\\.") {
    $prefix = "";
}

while (<STDIN>) {
    s/[\r\n]//g;
    if ($_ eq "../") {
        print $_ . "\n";
        next;
    }
    if (/^$prefix(.*)$/) {
        print($1 . "\n");
    } else {
        print $_ . "\n";
    }
}

