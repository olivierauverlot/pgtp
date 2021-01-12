package Model::Column;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$_fieldName,$_caption) = @_;
    my $this = { 
        fieldName => $_fieldName,
        caption =>  $_caption,
        canSetNull => false
    };

    bless($this,$class);
    return $this;
}

sub getFieldName {
    my ($this) = @_;   
    return $this->{fieldName};
}

sub getCaption {
    my ($this) = @_;   
    return $this->{caption};
}

sub notNull {
    my ($this) = @_;
    $this->{canSetNull} = true;
}

sub canSetNull {
    my ($this) = @_;   
    return $this->{canSetNull};
}

1;