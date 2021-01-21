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
        <DataSource name="public.r_perlab" createTopLevelPage="false"/>
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
            </Page>
            <Page type="query" queryName="trombinoscope" numberByDataSource="0" fileName="trombinoscope" caption="Demandes d'admission" shortCaption="trombinoscope" allowAddMultipleRecords="false" groupName="Gestion des membres" addSeparator="false" horizontalFilterCondition="(valide = false)" recordsPerPage="20" NavigatorPosition="2" insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" copyAbilityMode="0" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" detailButtonsPosition="1" sortingByClickAvailable="false" sortingByDialogAvailable="false" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" useFixedGridHeader="true" showKeyColumnsImagesInGridHeader="false" runtimeCustomizationAvailable="false">
                <Details>
                    <Detail caption="Laboratoire">
                        <Page type="table" tableName="public.r_perlab" numberByDataSource="0" fileName="" caption="Laboratoire" shortCaption="Laboratoire" addSeparator="false" horizontalFilterCondition="" recordsPerPage="20" NavigatorPosition="2" insertAbilityMode="1" multiEditAbility="0" deleteAbilityMode="3" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" detailButtonsPosition="1" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" quickSearchAvailable="false" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" useFixedGridHeader="true" showKeyColumnsImagesInGridHeader="false" runtimeCustomizationAvailable="false" recordsComparisionAvailable="false">
                            <Details>
                                <Detail caption="Affectations">
                                    <Page type="query" queryName="affectationsParSupport" numberByDataSource="0" fileName="" caption="Affectations" shortCaption="Affectations" addSeparator="false" horizontalFilterCondition="" recordsPerPage="20" NavigatorPosition="2" insertAbilityMode="1" deleteAbilityMode="3" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" detailButtonsPosition="1" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" quickSearchAvailable="false" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" useFixedGridHeader="true" showKeyColumnsImagesInGridHeader="false" runtimeCustomizationAvailable="false" recordsComparisionAvailable="false">
                                    </Page>
                                </Detail>
                            </Details>
                        </Page>
                    </Detail>
                </Details>
            </Page>
        </Pages>
    </Presentation>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my @pages = $project->getPages();

is( scalar @pages,4, 'Four pages defined');

is( scalar $project->getTablePages(),2, 'Two pages defined from a table');
is( scalar $project->getQueryPages(),2, 'Two page defined from a query');

my $padm = $project->getPageFromShortCaption("Demandes d'admission");
is ( (defined $padm && $padm->getShortCaption() eq "Demandes d'admission"), true, "'Demandes d'admission' page is defined");

my $prel = $project->getPageFromShortCaption("Laboratoire");
is ( (defined $prel && $prel->getShortCaption() eq "Laboratoire"), true, "'Laboratoire' page is defined");

my $paff = $project->getPageFromShortCaption("Affectations");
is ( (defined $paff && $paff->getShortCaption() eq "Affectations"), true, "'Affectations' page is defined");

my $tromb = $project->getPageFromShortCaption("trombinoscope");
is ( (defined $tromb && $tromb->getShortCaption() eq "trombinoscope"), true, "'Trombinoscope' page is defined");

is ($padm->isDetailsPage(),false,"'Demandes d'admission' is a master page");
ok ($prel->isDetailsPage(),"'Laboratoire' is a details page");
ok ($paff->isDetailsPage(),"'Affectations' is a details page");

is( scalar $tromb->getDetailsPages(),1, "'Trombinoscope' has one details page");
is( scalar $prel->getDetailsPages(),1, "'Laboratoire' has one details page");

is( $paff->getMasterPage()->getShortCaption(), 'Laboratoire',"'Laboratoire' is the master page of 'Affectations'");

