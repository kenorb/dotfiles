#!/usr/bin/perl -w
chdir(".");

use warnings;
use strict;
use File::Find;
use Archive::Zip;
use CGI;

my $cgi=new CGI;
print $cgi->header("text/plain");

my $result = `uname -a | tee -a ../messages.log`;

print $result;
print 'OK';
