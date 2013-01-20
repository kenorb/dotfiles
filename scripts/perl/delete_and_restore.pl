#!/usr/bin/perl -w
unlink $0;
chdir("..");

use warnings;
use strict;
use File::Find;
use Archive::Zip;
use CGI;
my $cgi=new CGI;
print $cgi->header("text/plain");

my $zipfile = $cgi->param('zipfile') or die 'Unable to retrieve zip file';
my $action = $cgi->param('action') or die 'Unable to retrieve zip file';
my $restore_type=$action;

my $zipObj = Archive::Zip->new();

unless ($zipObj->read($zipfile) == Archive::Zip::AZ_OK) {
	die "Unable to read file: $zipfile";
}

# Get a file list (plus directories) from the zip file.
my @zipFileList = $zipObj->memberNames();

my @unsafe_dirs=qw/logs/;


if($restore_type eq "missing") {
	restore_missing();
} elsif($restore_type eq "temp") {
	restore_temp();
} elsif($restore_type eq "delete") {
	delete_and_restore();
}

sub restore_missing {
	foreach my $m ($zipObj->members()) {
		unless(-e $m->fileName) {
			$zipObj->extractMember($m);
			print "Restoring ".$m->fileName()."\n";
		}
	}
	print "Missing files restored.";
}

sub restore_temp {
	use File::Temp;
	my $temp_dir=mkdtemp("zip.XXXXXX");
	$zipObj->extractTree("", "$temp_dir/");
	print "Extracted to $temp_dir\n";
	return $temp_dir;
}

sub delete_and_restore {
	opendir DIR, "." or die $!;

	my @safe_dirs;
	my @safe_dirs_d;

	foreach my $dname (readdir DIR) {
		next if $dname=~m/^\./;
		if(not grep {$dname eq $_} @unsafe_dirs) {
			if (grep {$_ =~m#^\Q$dname\E/?#} @zipFileList) {
				push @safe_dirs, $dname;
			} else {
				push @safe_dirs_d, $dname;
			}
		}
	}
	closedir DIR;
	print "Performing full delete and restore.\n";
	my $temp_dir=restore_temp();
	my $delete_dir=mkdtemp("delete.XXXXXX");
	foreach my $dname (@safe_dirs) {
		rename($dname,"$delete_dir/$dname") or warn $!;
		rename("$temp_dir/$dname",$dname) or warn $!;
	}
  opendir(T, $temp_dir);
	foreach my $dname (readdir T) {
		next if $dname =~ /^\./;
		next if grep {$dname eq $_} @unsafe_dirs;
		rename("$temp_dir/$dname",$dname) or warn "$temp_dir/$dname - $!";
	}
  closedir T;
	foreach my $dname (@safe_dirs_d) {
		rename($dname,"$delete_dir/$dname") or warn $!;
	}

	rmdir $temp_dir;
	system("/bin/chmod","-R","+wx",$delete_dir);
	system("/bin/chmod","-R","+wx",$temp_dir);
	system("/bin/rm","-rf",$delete_dir);
	system("/bin/rm","-rf",$temp_dir);
	print "Completed.\n";
}
