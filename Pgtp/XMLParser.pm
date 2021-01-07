package Pgtp::XMLParser;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use XML::LibXML;

use Model::ConnectionOptions;

sub new {
    my($class,$_dom,$_project) = @_;
    my $this = { 
        project => $_project,
        dom => undef
    };
    bless($this,$class);
    $this->{dom} = $_dom;
    $this->extractConnectionOptions();
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
    
=pod
    foreach my $node ($this->{dom}->findnodes('//ConnectionOptions')) {
        my @attributelist = $node->attributes();
        p (@attributelist);
    }
=cut
}
1;