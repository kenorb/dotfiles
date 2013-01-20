use LWP::UserAgent;
use HTTP::Request::Common qw(POST GET);
use HTTP::Headers;
use strict;

# my $PROXY_URL = 'http://192.168.1.1:80/'; ### Proxy URL or Address + Port
my $PROXY_URL = "";                       # if you dont have a proxy
my $PROXYUSER = '';                   ### Proxy username
my $PROXYPASS = '';                   ### Proxy password

my $commandPrompt = '$';
my $command = '';
my $pwd = '';
my $initPwd = 1;
my ($content, $h, $res, $req);

my %sites = (
  'mysite1' => 'dev.site1.com',
  'mysite2' => 'dev.site2.com'
);

my $password = @ARGV[0] || '';
my $site = @ARGV[1] || 'mysite1';
my $siteUrl = $sites{$site};

my $TARGET_URL = "http://$siteUrl/scriptremote.cgi";

print "\nWelcome to RemoteShell v1.2 ($siteUrl)\n";
print "\nType 'q' to quit\n";

while ( ( $command ne "q" ) && ( $command ne "Q" ) ) {
    if ($initPwd) {
      print "\nSetting current directory....\n";
      # dummy command
      $command = 'cd getDirectory';
      $initPwd = 0;
    } else {
      print "[$site:$pwd]$commandPrompt ";
      $command = <STDIN>;
    }
    $command =~ s/[\n|\r]//g;

  if ($command eq '') {
    print "\n";
  } elsif (lc $command ne 'q') {
    $command = urlencode($command);
    $content = &getHTML($TARGET_URL."?command=$command&pwd=$pwd&password=$password",
      $PROXY_URL, $PROXYUSER, $PROXYPASS );
    if ($content =~ /change_pwd\=(.+)/) {
      $pwd = $1;
      print "\n";
    } else {
      print "\n", $content, "\n";
    }
  } else {
    print "\n","Goodbye!\n";
  }
}
exit(0);
###############################################################################
sub getHTML {
    my($targeturl, $proxyurl, $proxyuname, $proxypswd) = @_;
    my $ua, $h, $req, $res;

    $ua = LWP::UserAgent->new();
    $ua->proxy(['http'] => $proxyurl);

    $h = HTTP::Headers->new();
    $h->proxy_authorization_basic($proxyuname, $proxypswd);
    $req = HTTP::Request->new('GET', $targeturl, $h);

    my $res = $ua->request($req);
    if ($res->is_success) {
        return $res->content;
    }
    else {
       return "Error: " . $res->status_line . "\n";
    }
}
###############################################################################
# subroutine: urlencode a string
sub urlencode {
  my $ask = shift @_;
  my @a2 = unpack "C*", $ask;
  my $s2 = "";
  while (@a2) {
    $s2 .= sprintf "%%%X", shift @a2;
  }
    return $s2;
}
###############################################################################
