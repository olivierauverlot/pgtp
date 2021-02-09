use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Pgtp::XMLParser;
use Model::Project;
use Pgtp::Reports::AbilityModesReportOfPage;

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro" localizationFileName="" phpDriver="1" outputPath="" copySystemFiles="true" generateModifiedDataOnly="false" outputFilesExtension="php" colorSchemeName="facebook">
    <DataSources>
        <DataSource name="public.bap"/>
    </DataSources>
    <Presentation disableMagicQuotesRuntime="false" showEnvironmentVariables="false" showExecutedQueries="false" showPHPErrorsAndWarnings="false">
        <Pages>
            <Page type="table" tableName="public.bap" fileName="rcd" caption="rcd" shortCaption="rcd" insertAbilityMode="1" viewAbilityMode="1" editAbilityMode="0" deleteAbilityMode="1" deleteSelectedAbilityMode="0">
            </Page>
            <Page type="table" tableName="public.bap" fileName="rd" caption="rd" shortCaption="rd" insertAbilityMode="0" viewAbilityMode="1" editAbilityMode="0" deleteAbilityMode="1" deleteSelectedAbilityMode="0">
            </Page>
        </Pages>
    </Presentation>
    <DefaultPageProperties insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" deleteSelectedAbilityMode="3"/>
</Project>
XML


my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my $rcd = $project->getPageFromShortCaption("rcd");
ok($rcd->hasAbilityModesContainer(),"Page 'rcd' has ability modes container");

my $rcdAbilities = $rcd->getAbilityModesContainer();
ok($rcdAbilities->hasInsertAbilityModes(),"Insert abilities");
is($rcdAbilities->hasEditAbilitieModes(),false,'No edit abilities');
ok($rcdAbilities->hasDeleteAbilityModes(),'Delete abilities');

Pgtp::Reports::AbilityModesReportOfPage->new($project,'rcd')->output();

my $rd = $project->getPageFromShortCaption("rd");
ok($rd->hasAbilityModesContainer(),"Page 'rd' has ability modes container");

my $rdAbilities = $rd->getAbilityModesContainer();
is($rdAbilities->hasInsertAbilityModes(),false,"No insert abilities");
is($rdAbilities->hasEditAbilitieModes(),false,'No edit abilities');
ok($rdAbilities->hasDeleteAbilityModes(),'Delete abilities');



# Pgtp::Reports::AbilityModesReportOfPage->new($project,'rd')->output();
