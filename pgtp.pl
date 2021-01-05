use strict;
use warnings;
use utf8;
use 5.010;
use boolean;
use FindBin;                
use lib "$FindBin::RealBin/.";
use Getopt::Long;
use Data::Printer;
use DBI;

use Model::Project;
use Pgtp::XMLParser;

use constant VERSION => '0.1 Build 20210104-1';

my $projectFileName;

sub version {
    print "\n" . VERSION . "\n";
}

my $result = GetOptions(
    'p|project=s' => \$projectFileName,
    'v|version' => sub { version() },
) or die "Invalid options passed to $0\n";

if(defined $projectFileName) {
    if(-e $projectFileName) {
        my $project = Model::Project->new();
        my $parser = Pgtp::XMLParser->new($projectFileName,$project);
        p( $project->getConnectionOptions());
    } else {
        say "$projectFileName not found";
        exit 0;
    }
} else {
    say "No project file";
    exit 0;
}


=pod
my $driver  = "Pg"; 

my $database = "si_dev";
my $dsn = "DBI:$driver:dbname = $database;host = pg96.priv.lifl.fr;port = 5432";
my $userid = "silifl";
my $password = "cplubd22";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
   or die $DBI::errstr;

print "Opened database successfully\n";
=cut