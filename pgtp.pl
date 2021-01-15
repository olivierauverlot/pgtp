use strict;
use warnings;
use utf8;
use 5.010;
use boolean;
use FindBin;                
use lib "$FindBin::RealBin/.";
use Getopt::Long;
use Data::Printer;
use XML::LibXML;
use Term::Table;

use Model::Project;
use Pgtp::MessageStatus;
use Pgtp::XMLParser;
use Pgtp::FieldsOfPageReport;
use Pgtp::DatasourcesReport;
use Pgtp::PagesReport;
use Pgtp::AbilityModesReportOfPage;

use constant VERSION => '0.1 Build 20210112-1';

# carton exec perl pgtp.pl "-v"
# carton exec perl pgtp.pl "-f test.pgtp --mutation  -t public.personne -q sql_personnes"
# carton exec perl pgtp.pl "-f test.pgtp --datasources"
# carton exec perl pgtp.pl "-f test.pgtp --pages"
# carton exec "perl pgtp.pl -f test.pgtp --columns Rapports"

my $projectFileName;
my $projectVersion;
my $mutation;
my $datasources;
my $pages;
my $abilityModes;
my $fieldsListOfPage;

my $table;
my $query;

sub exitOnError {
    my ($msg) = @_;
    say $msg;
    exit(0);
}

sub version {
    print "\n" . VERSION . "\n";
}

sub displayProjectVersion {
    my ($project) = @_;
    say $project->getVersion() . ' ' . $project->getEdition(); 
}

my $result = GetOptions(
    'h|help' => sub { help() },
    'f|from=s' => \$projectFileName,
    'projectVersion' => \$projectVersion,
    't|table=s' => \$table,
    'q|query=s' => \$query,
    'v|version' => sub { version() },
    'mutation' => \$mutation,
    'datasources' => \$datasources,
    'pages' => \$pages,
    'abilityModes=s' => \$abilityModes,
    'fields=s' => \$fieldsListOfPage
) or die "Invalid options passed to $0\n";

if(defined $projectFileName) {
    if(-e $projectFileName) {
        my $project = Model::Project->new();
        my $dom = XML::LibXML->load_xml( location => $projectFileName );
        my $parser = Pgtp::XMLParser->new($dom,$project);
        
        if($projectVersion) {
            displayProjectVersion($project);
        }

        if($datasources) { 
            Pgtp::DatasourcesReport->new($project)->output();
        }

        if($pages) { 
            Pgtp::PagesReport->new($project)->output();
        }

        if($abilityModes) {
            Pgtp::AbilityModesReportOfPage->new($project,$abilityModes)->output();
        }

        if($fieldsListOfPage) {
            Pgtp::FieldsOfPageReport->new($project,$fieldsListOfPage)->output();
        }

        if($mutation) {
            if(defined $table && defined $query) {
            } else {
                exitOnError "You must indicate table name and query name";
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

            --projectVersion
                            Returns the project file version

            --datasources
                            Returns datasources list

            --pages
                            Returns pages list
            
            --abilityModes
                            Returns ability modes of the specified page
            
            --fields

                            Returns columns of the specified page 

            --rename

                            Rename column

            --namespace 
                            Change namespace of a table datasource

            --mutation
                            Refactoring a table datasource to a query datasource

            --to
                            Set the new value for refactoring

            -t, --table
                            Set table name for mutation

            -q, --query
                            Set query name to generate

            -v, --version
                            Return version

            -h, --help
                            Display help


