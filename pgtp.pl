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
use XML::LibXML;

use Model::Project;
use Pgtp::XMLParser;

use constant VERSION => '0.1 Build 20210104-1';

my $projectFileName;
my $mutation;
my $password;
my $table;
my $query;

sub version {
    print "\n" . VERSION . "\n";
}

sub exitOnError {
    my ($msg) = @_;
    say $msg;
    exit(0);
}

# carton exec perl pgtp.pl "-v"
# carton exec perl pgtp.pl "-f test.pgtp -p mypassword --mutation  -t public.personne -q sql_personnes"
# carton exec perl pgtp.pl "--datasources -f test.pgtp -p mypassword"
# carton exec perl pgtp.pl "--pages -f test.pgtp -p mypassword"

my $result = GetOptions(
    'f|from=s' => \$projectFileName,
    'p|password=s' => \$password,
    't|table=s' => \$table,
    'q|query=s' => \$query,
    'v|version' => sub { version() },
    'mutation' => \$mutation
) or die "Invalid options passed to $0\n";

if(defined $projectFileName) {
    if(-e $projectFileName) {
        if(defined $password) {
            my $project = Model::Project->new();
            my $dom = XML::LibXML->load_xml( location => $projectFileName );
            my $parser = Pgtp::XMLParser->new($dom,$project);
            $project->getConnectionOptions()->setPassword($password);
            p( $project->getConnectionOptions());
            if($mutation) {
                if(defined $table && defined $query) {
                } else {
                    exitOnError "You must indicate table name and query name";
                }
            }
        } else {
            exitOnError "No database password";
        }
    } else {
        exitOnError "$projectFileName not found";
    }
} else {
    exitOnError "No project file";
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