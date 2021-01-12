use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use boolean;
use Data::Printer;

use Pgtp::XMLParser;
use Model::Project;

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro">
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

is( $project->getVersion(), '20.5.0.4',  'Version 20.5.0.4' );
ok( $project->isProfessionalEdition(), 'Professional Edition');