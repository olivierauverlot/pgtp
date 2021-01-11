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
use Term::Table;

use Model::Project;
use Pgtp::XMLParser;

use constant VERSION => '0.1 Build 20210104-1';

my $projectFileName;
my $mutation;
my $datasources;
my $pages;

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

sub displayTableFrom {
    my ($header,$rows) = @_;

    my $table = Term::Table->new(
        max_width      => 160,    
        pad            => 4,     
        allow_overflow => 0,    
        collapse       => 1, 
        header => $header,
        rows => $rows
    );

    print "\n";
    say $_ for $table->render;
    exit(1);
}

sub displayDatasources {
    my ($project) = @_;
    my @rows;

    foreach my $dt ( $project->getDatasources() ) {
        my @row;

        push @row,(
            $dt->getName(),
            $dt->getType(),
            $dt->isTopLevelPage() ? 'Yes' : 'No',
            join(',',$dt->getPrimaryKeyFields())
        );

        push @rows, \@row;
    }

    displayTableFrom( [ 'Name', 'Type', 'Top level page', 'Primary Key fields'], \@rows );

}

sub displayPages {
    my ($project) = @_;
    my @rows;

    foreach my $p ( $project->getPages() ) {
        my @row;

        push @row,(
            $p->getFileName(),
            $p->getType(),
            $p->getDatasourceName(),
            $p->getShortCaption(),
            $p->getCaption(),
            $p->isDetailsPage() ? 'Yes' : 'No'
        );

        push @rows, \@row;
    }

    displayTableFrom( [ 'Filename', 'Type', 'Datasource', 'Short caption','Caption','Details Page' ], \@rows );
}

# carton exec perl pgtp.pl "-v"
# carton exec perl pgtp.pl "-f test.pgtp -p mypassword --mutation  -t public.personne -q sql_personnes"
# carton exec perl pgtp.pl "--datasources -f test.pgtp"
# carton exec perl pgtp.pl "--pages -f test.pgtp -p mypassword"

my $result = GetOptions(
    'h|help' => sub { help() },
    'f|from=s' => \$projectFileName,
    'p|password=s' => \$password,
    't|table=s' => \$table,
    'q|query=s' => \$query,
    'v|version' => sub { version() },
    'mutation' => \$mutation,
    'datasources' => \$datasources,
    'pages' => \$pages
) or die "Invalid options passed to $0\n";

if(defined $projectFileName) {
    if(-e $projectFileName) {
        my $project = Model::Project->new();
        my $dom = XML::LibXML->load_xml( location => $projectFileName );
        my $parser = Pgtp::XMLParser->new($dom,$project);
        
        if($datasources) { 
            displayDatasources($project);
        }
        if($pages) { 
            displayPages($project);
        }

        if($mutation) {
            if(defined $password) {
                $project->getConnectionOptions()->setPassword($password);
                if(defined $table && defined $query) {
                } else {
                    exitOnError "You must indicate table name and query name";
                }
            } else {
                exitOnError "No database password";
            }
        }
    } else {
        exitOnError "$projectFileName not found";
    }
} else {
    exitOnError "No project file";
}

sub help {
    while (<DATA>) {
        print $_;
    }
    exit;
}

=pod
my $driver  = "Pg"; 

my $database = "si_dev";
my $dsn = "DBI:$driver:dbname = $database;host = server.domain.org;port = 5432";
my $userid = "username";
my $password = "password";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
   or die $DBI::errstr;

print "Opened database successfully\n";
=cut

__DATA__

NAME:
    pgtp - refactoring tool for SQL Maestro PHP Generator

SYNOPSIS:
    pgtp 

DESCRIPTION:

    Explore a PHP Generator project and refactor datasources

    Options:

            -f, --from
                            Set project file name
            
            -p, --password
                            Set database password

            --datasources
                            Return datasources list

            --pages
                            Return pages list

            --mutation
                            Refactoring a table datasource to a query datasource

            -t, --table
                            Set table name for mutation

            -q, --query
                            Set query name to generate

            -v, --version
                            Return version

            -h, --help
                            Display help


