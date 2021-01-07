package Model::QueryDatasource;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::Datasource;

our @ISA = qw(Model::Datasource);

sub new {
    my($class,$_name,$_topLevelPage) = @_;
    my $this = $class->SUPER::new($_name,$_topLevelPage);
    $this->{primaryKeyFields} = [ ];
    bless($this,$class);
    return $this;
}

sub isQueryDatasource {
    my ($this) = @_;
    return true;
}

sub addPrimaryKeyField {
    my ($this,$fieldName) = @_;
    push @{ $this->{primaryKeyFields} }, $fieldName;
}

sub getPrimaryKeyFields {
    my ($this) = @_;
    return @{ $this->{primaryKeyFields} };
}

sub getType {
    my ($this) = @_;
    return 'Query';
}

1;