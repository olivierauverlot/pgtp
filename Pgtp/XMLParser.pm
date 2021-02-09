package Pgtp::XMLParser;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;
use Data::Printer;
use XML::LibXML;

use Model::ConnectionOptions;
use Model::TableDatasource;
use Model::QueryDatasource;
use Model::Page;
use Model::TablePage;
use Model::Querypage;

use Model::AbilityModes;
use Model::Abilities::ViewAbilityMode;
use Model::Abilities::EditAbilityMode;
use Model::Abilities::MultiEditAbilityMode;
use Model::Abilities::InsertAbilityMode;
use Model::Abilities::CopyAbilityMode;
use Model::Abilities::DeleteAbilityMode;
use Model::Abilities::DeleteSelectedAbilityMode;

use Model::ScreenModes::Factory;
use Model::ScreenModes::ScreenMode;

use Model::ColumnsContainer;
use Model::Column;

sub new {
    my($class,$_dom,$_project) = @_;
    my $this = { 
        project => $_project,
        dom => undef
    };
    bless($this,$class);
    $this->{dom} = $_dom;
    $this->extractProjectVersion();
    $this->extractConnectionOptions();
    $this->extractDatasources();
    $this->extractDefaultPageProperties();
    $this->extractPages();
    return $this;
}

sub extractProjectVersion {
    my($this) = @_;
    my $edition = $this->{dom}->findvalue( '/Project/@edition' );

    $this->{project}->setVersion( $this->{dom}->findvalue( '/Project/@version' ) );
    $this->{project}->setEdition( $this->{dom}->findvalue( '/Project/@edition' ) );
}

sub extractConnectionOptions {
    my($this) = @_;

    my $host = $this->{dom}->findvalue( '/Project/ConnectionOptions/@host' );
    my $port = $this->{dom}->findvalue( '/Project/ConnectionOptions/@port' );
    my $login = $this->{dom}->findvalue( '/Project/ConnectionOptions/@login' );
    my $database = $this->{dom}->findvalue( '/Project/ConnectionOptions/@database' );
    my $clientEncoding = $this->{dom}->findvalue( '/Project/ConnectionOptions/@client_encoding' );

    my $connectionOptions = Model::ConnectionOptions->new($host,$port,$login,$database,$clientEncoding);  
    $this->{project}->setConnectionOptions($connectionOptions);
}

sub extractDatasources {
    my($this) = @_;

    foreach my $dt ($this->{dom}->findnodes('/Project/DataSources/DataSource')) {
        my $datasource;
        my $toplevelpage;
        
        $toplevelpage = ( $dt->findvalue('@createTopLevelPage') eq '' ) ? true : false;

        if( $dt->findvalue('@type') eq '') {
            $datasource = Model::TableDatasource->new($dt->findvalue('@name'),$toplevelpage);
        } else {
            $datasource = Model::QueryDatasource->new($dt->findvalue('@name'),$toplevelpage);
            # extract Primary Key Fields
            my @fields = $dt->findnodes('PrimaryKeyFields/Field');
            foreach my $field (@fields) {
                $datasource->addPrimaryKeyField($field->findvalue('@name'));
            }
        }
        $this->{project}->addDatasource($datasource);
    }
}

sub extractDefaultPageProperties {
    my($this) = @_;

    my @nodes = $this->{dom}->findnodes( '/Project/DefaultPageProperties' );

    if(@nodes) {
        my $abilityModes = Model::AbilityModes->new( $this->{project} );
        $abilityModes->addAbilityMode( Model::Abilities::ViewAbilityMode->new( $nodes[0]->findvalue('@viewAbilityMode') ) );
        $abilityModes->addAbilityMode( Model::Abilities::EditAbilityMode->new( $nodes[0]->findvalue('@editAbilityMode') ) );
        $abilityModes->addAbilityMode( Model::Abilities::MultiEditAbilityMode->new( $nodes[0]->findvalue('@multiEditAbility') ) );
        $abilityModes->addAbilityMode( Model::Abilities::InsertAbilityMode->new( $nodes[0]->findvalue('@insertAbilityMode') ) );
        $abilityModes->addAbilityMode( Model::Abilities::CopyAbilityMode->new( $nodes[0]->findvalue('@copyAbilityMode') ) );
        $abilityModes->addAbilityMode( Model::Abilities::DeleteAbilityMode->new( $nodes[0]->findvalue('@deleteAbilityMode') ) );
        $abilityModes->addAbilityMode( Model::Abilities::DeleteSelectedAbilityMode->new( $nodes[0]->findvalue('@deleteSelectedAbilityMode') ) );

        $this->{project}->setDefaultPageAbilityModes($abilityModes);
    }
}

sub extractPagesFrom {
    my ($this,$nodes,$masterPage,$isDetails) = @_;

    my @pages;

    foreach my $n ( @{ $nodes } ) {
        push @pages,$this->extractPage($n,$masterPage,$isDetails);
    }
    return \@pages;
}

sub extractPage {
    my ($this,$node,$masterPage,$isDetails) = @_;

    my $page;

    if( $node->findvalue('@queryName') eq '' ) {
        $page = Model::TablePage->new($node->findvalue('@fileName'),$this->{project}->getDatasourceFromName($node->findvalue('@tableName')),$node->findvalue('@shortCaption'),$node->findvalue('@caption'),$isDetails);
    } else {
        $page = Model::QueryPage->new($node->findvalue('@fileName'),$this->{project}->getDatasourceFromName($node->findvalue('@queryName')),$node->findvalue('@shortCaption'),$node->findvalue('@caption'),$isDetails);
    }

    # set the abilities
    # -------------------------------------------
    my $abilityModes = Model::AbilityModes->new($page);
    $abilityModes->addAbilityMode( Model::Abilities::ViewAbilityMode->new( $node->findvalue('@viewAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::EditAbilityMode->new( $node->findvalue('@editAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::MultiEditAbilityMode->new( $node->findvalue('@multiEditAbility') ) );
    $abilityModes->addAbilityMode( Model::Abilities::InsertAbilityMode->new( $node->findvalue('@insertAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::CopyAbilityMode->new( $node->findvalue('@copyAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::DeleteAbilityMode->new( $node->findvalue('@deleteAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::DeleteSelectedAbilityMode->new( $node->findvalue('@deleteSelectedAbilityMode') ) );

    $page->setAbilityModesContainer($abilityModes);

    # set the master page (if details page)
    # -------------------------------------------
    if($isDetails) {
        $page->setMasterPage($masterPage);
    }

    # set the columns
    # -------------------------------------------
    my $factory = Model::ScreenModes::Factory->new();

    my $columns = Model::ColumnsContainer->new($page);
    
    foreach my $colNode (@{ $node->findnodes('ColumnPresentations/ColumnPresentation') } ) {
        my $fieldName = $colNode->findvalue('@fieldName');

        my $column = Model::Column->new($fieldName,$colNode->findvalue('@caption'));
        if($colNode->findvalue('@canSetNull') ne '') {
            $column->notNull();
        }
        if($colNode->findvalue('@enabled') ne '') {
            $column->notEnabled();
        }
        
        # set the visibility of the column in screen modes
        my $modeSearchPath = 'Columns/*/Column[@fieldName=\'' . $fieldName . '\']';
        foreach my $colModeNode (@{ $node->findnodes($modeSearchPath) } ) {
            my $mode = $factory->createFromTag( $colModeNode->parentNode->nodeName );
            if($colModeNode->findvalue('@visible') ne '') {
                $mode->notVisible();
            }
            $column->addScreenMode($mode);
        }
        $columns->addColumn($column);
    }

    # columns are added to the page
    $page->setColumnContainer($columns);

    # the current page is added to the model
    # -------------------------------------------
    $this->{project}->addPage($page);
    $page->setDetailsPages($this->extractPagesFrom( \@{ $node->findnodes("Details/Detail/Page") } , $page, true));

    return $page;
}


sub extractPages {
    my ($this) = @_;
    $this->extractPagesFrom( \@{ $this->{dom}->findnodes('/Project/Presentation/Pages/Page') } , undef, false );   
}
1;