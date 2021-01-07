use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use boolean;
use Data::Printer;

use Pgtp::XMLParser;
use Model::Project;
use Model::Page;

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
      <Presentation disableMagicQuotesRuntime="false" showEnvironmentVariables="false" showExecutedQueries="false" showPHPErrorsAndWarnings="false" menuMode="1" hasHomePage="false">
    <Pages>
      <Page type="table" tableName="admission.inscription" numberByDataSource="0" fileName="admission.inscription" caption="Demandes d'admission" shortCaption="Demandes d'admission" allowAddMultipleRecords="false" groupName="Gestion des membres" addSeparator="false" horizontalFilterCondition="(valide = false)" recordsPerPage="20" NavigatorPosition="2" insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" copyAbilityMode="0" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" detailButtonsPosition="1" sortingByClickAvailable="false" sortingByDialogAvailable="false" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" useFixedGridHeader="true" showKeyColumnsImagesInGridHeader="false" runtimeCustomizationAvailable="false">
      </page>
      <Page type="query" queryName="trombinoscope" numberByDataSource="0" fileName="admission.inscription" caption="Demandes d'admission" shortCaption="Demandes d'admission" allowAddMultipleRecords="false" groupName="Gestion des membres" addSeparator="false" horizontalFilterCondition="(valide = false)" recordsPerPage="20" NavigatorPosition="2" insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" copyAbilityMode="0" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" detailButtonsPosition="1" sortingByClickAvailable="false" sortingByDialogAvailable="false" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" useFixedGridHeader="true" showKeyColumnsImagesInGridHeader="false" runtimeCustomizationAvailable="false">
      </page>
    </Pages>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my @pages = $project->getPages();