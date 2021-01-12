package Model::ColumnsContainer;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$aParent) = @_;
    my $this = { 
        parent => $aParent,
        columns => [ ]
    };

    bless($this,$class);
    return $this;
}

sub addColumn {
    my($this,$aColumn) = @_;
    push @{ $this->{columns} } ,$aColumn;
}

sub getColumns {
    my($this) = @_;
    return @{ $this->{columns} };
}

sub getColumnFieldNames {
    my($this) = @_;
    my @fieldNames;

    foreach my $column ($this->getColumns) {
        push @fieldNames,$column->getFieldName();
    }
    return @fieldNames;
}

sub getColumnWithFieldName {
    my($this,$fieldName) = @_;
    my @columns = grep { $_->getFieldName() eq $fieldName } $this->getColumns();
    return $columns[0];
}

1;