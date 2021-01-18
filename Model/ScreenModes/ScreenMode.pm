package Model::ScreenModes::ScreenMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

sub new {
    my($class) = @_;
    my $this = { 
        visible => true
    };

    bless($this,$class);
    return $this;
}

# getTagName is a class method
sub getTagName: Abstract;

sub isVisible {
    my ($this) = @_;
    return $this->{visible};
}

sub notVisible {
    my ($this) = @_;
    $this->{visible} = false;
}

sub isListScreenMode {
    my ($this) = @_;
    return false;
}

sub isViewScreenMode {
    my ($this) = @_;
    return false;
}

sub isEditScreenMode {
    my ($this) = @_;
    return false;
}

sub isInsertScreenMode {
    my ($this) = @_;
    return false;
}

sub isQuickFilterScreenMode {
    my ($this) = @_;
    return false;
}

sub isFilterBuilderScreenMode {
    my ($this) = @_;
    return false;
}

sub isPrintScreenMode {
    my ($this) = @_;
    return false;
}

sub isExportScreenMode {
    my ($this) = @_;
    return false;
}

sub isCompareScreenMode {
    my ($this) = @_;
    return false;
}

sub isMultiEditScreenMode {
    my ($this) = @_;
    return false;
}

1;