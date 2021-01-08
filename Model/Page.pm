package Model::Page;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$_fileName,$_datasourceName,$_shortCaption,$_caption) = @_;
    my $this = { 
        fileName => $_fileName,
        datasourceName => $_datasourceName,
        shortCaption => $_shortCaption,
        caption => $_caption
    };

    bless($this,$class);
    return $this;
}

sub isTablePage {
    my($this) = @_;
    return false;
}

sub isQueryPage {
    my($this) = @_;
    return false;
}

sub getFileName {
    my($this) = @_;
    return $this->{fileName};
}

sub getDatasourceName {
    my($this) = @_;
    return $this->{datasourceName};
}

sub getShortCaption {
    my($this) = @_;
    return $this->{shortCaption};
}

sub getCaption {
    my($this) = @_;
    return $this->{caption}; 
}

1;