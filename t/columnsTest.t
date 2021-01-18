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
  <ConnectionOptions>
  </ConnectionOptions>
  <DataSources>
    <DataSource name="public.bap"/>
  </DataSources>
  <Presentation disableMagicQuotesRuntime="false" showEnvironmentVariables="false" showExecutedQueries="false" showPHPErrorsAndWarnings="false">
    <Pages>
      <Page type="table" tableName="public.bap" numberByDataSource="0" fileName="bap" caption="Bap" shortCaption="Bap" addSeparator="false" horizontalFilterCondition="" recordsPerPage="20" NavigatorPosition="3" insertAbilityMode="0" viewAbilityMode="0" editAbilityMode="2" deleteAbilityMode="3" deleteSelectedAbilityMode="3" contentEncoding="UTF-8" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" useActionImages="true" showKeyColumnsImagesInGridHeader="false">
        <BeforeGridText/>
        <DetailedDescription/>
        <ColumnPresentations>
          <ColumnPresentation fieldName="cle" caption="Cle" showColumnFilter="false" selectedFilterOperators="1573119">
            <ViewProperties type="text">
              <Format type="number" thousandSeparator=","/>
            </ViewProperties>
            <EditProperties type="textBox" maxLength="0"/>
          </ColumnPresentation>
          <ColumnPresentation fieldName="sigle" caption="Sigle" enabled="false" showColumnFilter="false" canSetNull="true" selectedFilterOperators="1589247">
            <ViewProperties type="text" maxLength="75"/>
            <EditProperties type="textArea" columnCount="50" rowCount="8" placeholder=""/>
          </ColumnPresentation>
          <ColumnPresentation fieldName="intitule" caption="Intitule" showColumnFilter="false" selectedFilterOperators="1589247">
            <ViewProperties type="text" maxLength="75"/>
            <EditProperties type="textArea" columnCount="50" rowCount="8" placeholder=""/>
          </ColumnPresentation>
          <ColumnPresentation fieldName="visible" caption="Visible" canSetNull="true" selectedFilterOperators="1572867">
            <ViewProperties type="checkBox" displayType="image"/>
            <EditProperties type="checkBox"/>
          </ColumnPresentation>
        </ColumnPresentations>
        <Columns>
          <List>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </List>
          <View>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </View>
          <Edit>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </Edit>
          <Insert>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </Insert>
          <QuickFilter>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </QuickFilter>
          <FilterBuilder>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </FilterBuilder>
          <Print>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </Print>
          <Export>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </Export>
          <Compare>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </Compare>
          <MultiEdit>
            <Column fieldName="cle" visible="false"/>
            <Column fieldName="sigle"/>
            <Column fieldName="intitule"/>
            <Column fieldName="visible"/>
          </MultiEdit>
        </Columns>
      </Page>
    </Pages>
  </Presentation>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

my @pages = $project->getPages();
my $bap = $project->getPageFromShortCaption("Bap");

ok($bap->hasColumnsContainer,"Bap has a columns container");

my $columnsContainer = $bap->getColumnsContainer();
is(scalar $columnsContainer->getColumns(),4,"Four columns in Bap table");

my @columnFieldNames = $columnsContainer->getColumnFieldNames();
my %names = map { $_ => 1 } @columnFieldNames;

ok(exists($names{'cle'}),"'cle' column found");
ok(exists($names{'sigle'}),"'sigle' column found");
ok(exists($names{'intitule'}),"'intitule' column found");
ok(exists($names{'visible'}),"'visible' column found");

my $colcle = $columnsContainer->getColumnWithFieldName('cle');
ok(defined($colcle),"'cle' column is defined");
is($colcle->getFieldName(),'cle',"'cle' is the fieldname of the 'cle' column");
is($colcle->getCaption(),'Cle',"'Cle' is the caption of the 'cle' column");
is($colcle->canSetNull(),false,"'cle' column can't be NULL");
is($colcle->isEnabled(),true,"'cle' is enabled");

my $colsigle = $columnsContainer->getColumnWithFieldName('sigle');
ok(defined($colsigle),"'sigle' column is defined");
ok($colsigle->canSetNull(),"'sigle' column can be NULL");
is($colsigle->isEnabled(),false,"'sigle' is not enabled");






