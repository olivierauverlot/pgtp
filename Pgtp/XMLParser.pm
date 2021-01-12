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
        $page = Model::TablePage->new($node->findvalue('@fileName'),$node->findvalue('@tableName'),$node->findvalue('@shortCaption'),$node->findvalue('@caption'),$isDetails);
    } else {
        $page = Model::QueryPage->new($node->findvalue('@fileName'),$node->findvalue('@queryName'),$node->findvalue('@shortCaption'),$node->findvalue('@caption'),$isDetails);
    }

    # set the abilities
    my $abilityModes = Model::AbilityModes->new($page);
    $abilityModes->addAbilityMode( Model::Abilities::ViewAbilityMode->new( $node->findvalue('@viewAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::EditAbilityMode->new( $node->findvalue('@editAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::MultiEditAbilityMode->new( $node->findvalue('@multiEditAbility') ) );
    $abilityModes->addAbilityMode( Model::Abilities::InsertAbilityMode->new( $node->findvalue('@insertAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::CopyAbilityMode->new( $node->findvalue('@copyAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::DeleteAbilityMode->new( $node->findvalue('@deleteAbilityMode') ) );
    $abilityModes->addAbilityMode( Model::Abilities::DeleteSelectedAbilityMode->new( $node->findvalue('@deleteSelectedAbilityMode') ) );

    $page->setAbilityModes($abilityModes);

    # set the master page (if details page)
    if($isDetails) {
        $page->setMasterPage($masterPage);
    }

    $this->{project}->addPage($page);
    $page->setDetailsPages($this->extractPagesFrom( \@{ $node->findnodes("Details/Detail/Page") } , $page, true));

    return $page;
}


sub extractPages {
    my ($this) = @_;
    $this->extractPagesFrom( \@{ $this->{dom}->findnodes('/Project/Presentation/Pages/Page') } , undef, false );   
}
1;