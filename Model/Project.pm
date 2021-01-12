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
        version => undef,
        edition => undef,
        connectionOptions => undef,
        dataSources => [ ],
        pages => [ ]
    };

    bless($this,$class);
    return $this;
}

# ---------------------------------
# PHP Generator version
# ---------------------------------
sub setVersion {
    my($this,$version) = @_;
    $this->{version} = $version;
}

sub getVersion {
    my($this) = @_;
    return $this->{version};
}

sub setEdition {
    my($this,$aString) = @_;
    $this->{edition} = $aString;
}

sub getEdition {
    my($this) = @_;
    return $this->{edition};
}

sub isProfessionalEdition {
    my($this) = @_;
    return ($this->{edition} eq 'pro');
}

# ---------------------------------
# Database connection
# ---------------------------------
sub setConnectionOptions {
    my($this,$aConnectionOptions) = @_;
    $this->{connectionOptions} = $aConnectionOptions;
}

sub getConnectionOptions {
    my($this) = @_;
    return $this->{connectionOptions};
}

# ----------------------------------------------
# Datasources management
# ----------------------------------------------

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
    return (grep { $_->isTableDatasource() } $this->getDatasources() );
}

sub getQueryDatasources {
    my($this) = @_;
    return (grep { $_->isQueryDatasource() } $this->getDatasources() );  
}

sub getDatasourceFromName {
    my($this,$name) = @_;
    my @dt = grep { $_->getName() eq $name }  $this->getDatasources() ;
    if(scalar @dt > 0) {
        return $dt[0];
    } else {
        return undef;
    }
}

# ----------------------------------------------
# Pages management
# ----------------------------------------------
sub addPage {
    my($this,$aPage) = @_;
    push @{ $this->{pages} },$aPage;
}

sub getPages {
    my($this) = @_;
    return @{ $this->{pages} };
}

sub getTablePage {
    my($this) = @_;
    return (grep { $_->isTablePage() } $this->getPages() );
}

sub getQueryPage {
    my($this) = @_;
    return (grep { $_->isQueryPage() } $this->getPages() );
}

sub getPageFromShortCaption {
    my($this,$shortcaption) = @_;
    my @pages = grep { $_->getShortCaption() eq $shortcaption } $this->getPages();

    if(scalar @pages > 0) {
        return $pages[0];
    } else {
        return undef;
    }
}

return 1;