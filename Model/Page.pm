package Model::Page;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::AbilityModes;

sub new {
    my($class,$_fileName,$_datasourceName,$_shortCaption,$_caption,$_isDetailsPage) = @_;
    my $this = { 
        fileName => $_fileName,
        datasourceName => $_datasourceName,
        shortCaption => $_shortCaption,
        caption => $_caption,
        isDetailsPage => $_isDetailsPage,
        masterPage => undef,
        detailsPages => [ ],
        abilityModesContainer => undef,
        columnsContainer => undef
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

sub isDetailsPage {
    my($this) = @_;
    return $this->{isDetailsPage};
}

sub setMasterPage {
    my($this,$aMasterPage) = @_;
    $this->{masterPage} = $aMasterPage;
}

sub getMasterPage {
    my($this) = @_;
    return $this->{masterPage};
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

# -------------------------------------------
# Details pages management
# -------------------------------------------
sub setDetailsPages {
    my($this,$detailsPages) = @_;
    $this->{detailsPages} = $detailsPages;
}

sub getDetailsPages {
    my($this,$detailsPages) = @_;
    return @{ $this->{detailsPages} };
}

# -------------------------------------------
# Abilities management
# -------------------------------------------
sub setAbilityModesContainer {
    my ($this,$aAbilityModesContainer) = @_;
    $this->{abilityModesContainer} = $aAbilityModesContainer;
}

sub getAbilityModesContainer {
    my ($this) = @_;
    $this->{abilityModesContainer};
}

sub hasAbilityModesContainer {
    my ($this) = @_;
    return defined($this->{abilityModesContainer});
}

# -------------------------------------------
# Columns management
# -------------------------------------------
sub getColumnsContainer {
    my ($this) = @_;
    return $this->{columnsContainer};
}

sub setColumnContainer {
    my ($this,$aColumnsContainer) = @_;
    $this->{columnsContainer} = $aColumnsContainer;
}

sub hasColumnsContainer {
    my ($this) = @_;
    return defined($this->{columnsContainer});
}

1;