package Model::Project;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;

use Model::ConnectionOptions;
use Model::TableDatasource;
use Model::QueryDatasource;

sub new {
    my($class) = @_;
    my $this = { 
        connectionOptions => undef,
        dataSources => [ ]
    };

    bless($this,$class);
    return $this;
}

sub setConnectionOptions {
    my($this,$aConnectionOptions) = @_;
    $this->{connectionOptions} = $aConnectionOptions;
}

sub getConnectionOptions {
    my($this) = @_;
    return $this->{connectionOptions};
}

sub addDatasource {
    my($this,$datasource) = @_;
    push @{ $this->{dataSources} },$datasource;
}

sub getDatasources {
    my($this) = @_;
    return @{ $this->{dataSources} };
}

sub getTableDatasources {
    my($this) = @_;
    return (grep { $_->isTableDatasource() } @{ $this->{dataSources} } );
}

sub getQueryDatasources {
    my($this) = @_;
    return (grep { $_->isQueryDatasource() } @{ $this->{dataSources} } );  
}

sub getDatasourceFromName {
    my($this,$name) = @_;
    my @dt = grep { $_->getName() eq $name } @{ $this->{dataSources} };
    if(scalar @dt > 0) {
        return $dt[0];
    } else {
        return undef;
    }
}

return 1;