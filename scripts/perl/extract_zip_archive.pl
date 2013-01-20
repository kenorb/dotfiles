#!/usr/bin/perl -w
unlink $0;
(my $wd=$0)=~s#[^/\\]+$##;
chdir($wd);

use warnings;
use strict;
use File::Find;
use CGI;
my $cgi=new CGI;
chomp(my $filename=<DATA>);

umask(022);

if ($filename =~ m/.zip$/) {  # Zip files
    # extracting from a .zip file
    use Archive::Zip;

    my $zip = Archive::Zip->new();
    $zip->read( $filename );
    print $cgi->header("text/plain");
    print $zip->extractTree()

} elsif ($filename =~ m/.tar$/) {  # uncompressed tar files
    # extracting from an uncompressed tar file
    use Archive::Tar;
    use IO::Zlib;

    my $tar = Archive::Tar->new();
    $tar->read( $filename, 0);
    print $cgi->header("text/plain");
    print $tar->extract()

} elsif ($filename =~ m/.bz2$/) {  # bzip2 compressed files

    my $funcompressed = $filename;
    $funcompressed =~ s/.bz2$//;

    # uncompressing a bzip2 compressed file
    my $funcom = $funcompressed;
    system("/usr/bin/bzcat '$filename' > '$funcompressed'");

    # Does it need to be untarred now?
    if ($funcom =~ m/.tar$/) {   # it's now an uncompressed tar file
                                   # unpack it and delete it

        use Archive::Tar;
        use IO::Zlib;
        my $tar = Archive::Tar->new();
        $tar->read( $funcompressed, 0);
        print $cgi->header("text/plain");
        print $tar->extract();
        unlink $funcompressed;
    }
} else { #  We should not get here unless the original file was a compressed tar archive
    # processing a compressed tar or gzip file
    use Archive::Tar;
    use IO::Zlib;
    my $tar = Archive::Tar->new();
    $tar->read( $filename, 1);
    print $cgi->header("text/plain");
    print $tar->extract();
}
close(DATA) and unlink($0);
__DATA__
file.zip
