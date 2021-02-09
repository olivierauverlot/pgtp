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
<DefaultPageProperties recordsPerPage="20" NavigatorPosition="2" quickEditAbility="0" insertAbilityMode="0" multiEditAbility="3" deleteAbilityMode="3" deleteSelectedAbilityMode="0" contentEncoding="UTF-8" detailButtonsPosition="1" exportAllRecordsAvailable="31" exportSelectedRecordsAvailable="31" exportSingleRecordFromGridAvailable="0" exportRecordFromViewFormAvailable="31" printAvailable="13" filterBuilderAvailable="false" highlightRowOnMouseHover="true" useActionImages="true" runtimeCustomizationAvailable="false" recordsComparisionAvailable="false"/>
  <DefaultDataFormats numberAfterDecimal="4" DecimalSeparator="." ThousandSeparator="," DateTimeFormat="d-m-Y H:i:s" DateFormat="d-m-Y" firstDayOfWeek="1"/>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);

ok($project->hasDefaultPageAbilityModes(),"Default Page ability modes");

my $abilities = $project->getDefaultPageAbilityModes();
ok($abilities->hasViewAbilityMode(),"View ability on");
is($abilities->hasInsertAbilityMode(),false,"Insert ability Off");
ok($abilities->hasCopyAbilityMode(),'Copy ability On');
ok($abilities->hasEditAbilityMode(),'Edit ability On');
ok($abilities->hasMultiEditAbilityMode(),'MultiEdit ability On');
ok($abilities->hasDeleteAbilityMode(),'Delete Ability On');
is($abilities->hasDeleteSelectedAbilityMode(),false,'Delete Selected Ability Off');