use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Pgtp::XMLParser;
use Model::Project;
use Pgtp::Refactoring::RefactoringMutation;

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro">
  <ConnectionOptions>
  </ConnectionOptions>
  <DataSources>
    <DataSource name="demandes" type="query">
      <PrimaryKeyFields>
        <Field name="cle"/>
      </PrimaryKeyFields>
      <SelectStatement>
SELECT * from table
      </SelectStatement>
    </DataSource>
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
            <Column fieldName="intitule" visible="false"/>
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

# datasource can't be a request
my $merr1 = Pgtp::Refactoring::RefactoringMutation->new( $project,$dom,'demandes','sqldemandes' );
my $r1 = $merr1->apply();
ok($r1->isError,$r1->getMessage());

# datasource names can't be the same
my $merr2 = Pgtp::Refactoring::RefactoringMutation->new( $project,$dom,'public.bap','public.bap' );
my $r2 = $merr2->apply();
ok($r2->isError,$r2->getMessage());

# the query datasource name can't be already used in the project
my $merr3 = Pgtp::Refactoring::RefactoringMutation->new( $project,$dom,'public.bap','demandes' );
my $r3 = $merr3->apply();
ok($r3->isError,$r3->getMessage());

# launch a full mutation process
# the primary key (simple and composite) must be passed in an array 
# non numeric fields must be surrounded by simple quotes
my $mutation = Pgtp::Refactoring::RefactoringMutation->new( $project,$dom,'public.bap','sqlbap' );
$mutation->addPrimaryKey('cle');
$mutation->addPrimaryKey("'sigle'");
my $result = $mutation->apply();

ok($result->isOk,"Mutation process done");

my $data = $mutation->getXMLData();

# the result of the refactoring is reparsed to validate the work
my $newproject = Model::Project->new();
my $newdom = XML::LibXML->load_xml( string => $data );
my $newparser = Pgtp::XMLParser->new($newdom,$newproject);

my @datasources = $newproject->getDatasources();

is( scalar @datasources,1, 'One datasource defined');
is( scalar $project->getQueryDatasources(),1, 'One query defined');

my $bap = $project->getDatasourceFromName('bap');
is ( (defined $bap && $bap->getName() eq 'bap') , true, "'Bap' query datasource is defined");

my @fields = $bap->getPrimaryKeyFields();
is ( scalar @fields, 2, 'Two primary key field is defined in Bap query datasource');
