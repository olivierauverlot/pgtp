use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use boolean;
use Data::Printer;

use Pgtp::XMLParser;
use Model::Project;
use Model::Datasource;
use Model::TableDatasource;
use Model::QueryDatasource;

my $xml = <<XML;
<Project>
    <DataSources>
        <DataSource name="admission.inscription"/>
        <DataSource name="public.personne" createTopLevelPage="false"/>
        <DataSource name="trombinoscope" type="query">
        <PrimaryKeyFields>
            <Field name="clepersonne"/>
        </PrimaryKeyFields>
        <SelectStatement>
    SELECT
        clepersonne,
        sexe,      
        nompersonne,
        prenompersonne,
    FROM  vue_annuaire_membres
    ORDER BY
        nompersonne,
        prenompersonne      </SelectStatement>
        </DataSource>
    </DataSources>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my @datasources = $project->getDatasources();

is( scalar @datasources,3, 'Three datasources defined');

is( scalar $project->getTableDatasources(),2, 'Two table defined');
is( scalar $project->getQueryDatasources(),1, 'One query defined');

my $tdt = $project->getDatasourceFromName('public.personne');
is ( (defined $tdt && $tdt->getName() eq 'public.personne'), true, 'public.personne datasource is defined');

my $qdt = $project->getDatasourceFromName('trombinoscope');
is ( (defined $qdt && $qdt->getName() eq 'trombinoscope') , true, 'Trombinoscope datasource is defined');

my @fields = $qdt->getPrimaryKeyFields();
is ( scalar @fields, 1, 'One primary key field is defined in trombinoscope query datasource');