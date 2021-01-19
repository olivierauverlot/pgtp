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
        screenModes => [ ]
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


# setter, getter and method to know if a column is visible in a mode (List, View, etc.)
sub addScreenMode {
    my ($this,$aScreenMode) = @_;
    push @{ $this->{screenModes} } , $aScreenMode;
}

sub getScreenModes {
    my ($this) = @_;
    return @{ $this->{screenModes} };
}

sub isVisibleInScreenMode {
    my ($this,$_screenModeTagName) = @_;

   return grep ( { ($_->getTagName() eq $_screenModeTagName) && $_->isVisible() } $this->getScreenModes() );
}

1;