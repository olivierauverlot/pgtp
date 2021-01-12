use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Pgtp::XMLParser;
use Model::Project;

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro" localizationFileName="" phpDriver="1" outputPath="" copySystemFiles="true" generateModifiedDataOnly="false" outputFilesExtension="php" colorSchemeName="facebook">
    <Presentation disableMagicQuotesRuntime="false" showEnvironmentVariables="false" showExecutedQueries="false" showPHPErrorsAndWarnings="false">
        <Pages>
            <Page type="table" tableName="public.bap" fileName="bap" caption="Bap" shortCaption="Bap" insertAbilityMode="0" viewAbilityMode="0" editAbilityMode="2" deleteAbilityMode="3" deleteSelectedAbilityMode="3">
            </Page>
        </Pages>
    </Presentation>
    <DefaultPageProperties insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" deleteSelectedAbilityMode="3"/>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my $page = $project->getPageFromShortCaption("Bap");
ok($page->hasAbilityModesContainer(),"Page 'Bap' has ability modes container");

my $abilities = $page->getAbilityModesContainer();
is($abilities->hasViewAbilityMode(),false,"View ability Off");
is($abilities->hasInsertAbilityMode(),false,"Insert ability Off");
ok($abilities->hasCopyAbilityMode(),'Copy ability On');
ok($abilities->hasEditAbilityMode(),'Edit ability On');
ok($abilities->hasMultiEditAbilityMode,'MultiEdit ability On');
ok($abilities->hasDeleteAbilityMode,'Delete Ability On');
ok($abilities->hasDeleteSelectedAbilityMode,'Delete Selected Ability On');

# tests on groups of ability modes
ok($abilities->hasInsertAbilityModes(),"Insert abilities");
ok($abilities->hasEditAbilitieModes(),'Edit abilities');
ok($abilities->hasDeleteAbilityModes(),'Delete abilities');



