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
        canSetNull => false,
        enabled => true,
        modes => {
            'List' => false,
            'View' => false,
            'Edit' => false,
            'Insert' => false,
            'QuickFilter' => false,
            'FilterBuilder' => false,
            'Print' => false,
            'Export' => false,
            'Compare' => false,
            'MultiEdit' => false
        }
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

sub isEnabled {
    my ($this) = @_;
    return $this->{enabled}; 
}

sub notEnabled {
    my ($this) = @_;
    $this->{enabled} = false;  
}


# setter & getter to know if a column is used in a mode (List, View, etc.)
sub usedInMode {
    my ($this,$mode) = @_;
    $this->{modes}->{$mode} = true;
}

sub isUsedInMode {
    my ($this,$mode) = @_;
    return $this->{modes}->{$mode};
}

=pod
        list => false,
        view => false,
        edit => false,
        insert => false,
        quickFilter => false,
        filterBuilder => false,
        print => false,
        export => false,
        compare => false,
        multiEdit => false
=cut
1;