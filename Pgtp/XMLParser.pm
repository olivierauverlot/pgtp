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

sub new {
    my($class,$_dom,$_project) = @_;
    my $this = { 
        project => $_project,
        dom => undef
    };
    bless($this,$class);
    $this->{dom} = $_dom;
    $this->extractConnectionOptions();
    $this->extractDatasources();
    $this->extractPages();
    return $this;
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

sub extractPages {
    my ($this) = @_;
       
    my $page;
    my $filename;
    my $datasourcename;
    my $shortcaption;
    my $caption;

    foreach my $p ($this->{dom}->findnodes('/Project/Presentation/Pages/Page')) {
        $filename =  $p->findvalue('@fileName');
        $shortcaption = $p->findvalue('@shortCaption');
        $caption = $p->findvalue('@caption');

        if( $p->findvalue('@queryName') eq '' ) {
            $page = Model::TablePage->new($filename,$datasourcename,$shortcaption,$caption);
        } else {
            $page = Model::QueryPage->new($filename,$datasourcename,$shortcaption,$caption);
        }
        $this->{project}->addPage($page)
    }
}

1;