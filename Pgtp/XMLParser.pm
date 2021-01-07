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
        }
        $this->{project}->addDatasource($datasource);
    }
}

1;