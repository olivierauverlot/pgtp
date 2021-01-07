package Model::Datasource;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$_name,$_topLevelPage) = @_;
    my $this = { 
        name => $_name,
        topLevelPage => $_topLevelPage
    };

    bless($this,$class);
    return $this;
}

sub isTableDatasource {
    my ($this) = @_;
    return false;
}

sub isQueryDatasource {
    my ($this) = @_;
    return false;
}

sub isTopLevelPage {
    my ($this) = @_;
    return $this->{topLevelPage};
}

sub getName {
    my ($this) = @_;
    return $this->{name};
}

1;