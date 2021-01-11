package Model::Page;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Pgtp::AbilityModes;

sub new {
    my($class,$_fileName,$_datasourceName,$_shortCaption,$_caption,$_detailsPage) = @_;
    my $this = { 
        fileName => $_fileName,
        datasourceName => $_datasourceName,
        shortCaption => $_shortCaption,
        caption => $_caption,
        detailsPage => $_detailsPage,
        masterPage => undef,
        detailsPages => [ ],
        abilityModes => undef
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
    return $this->{detailsPage};
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
sub setAbilityModes {
    my ($this,$aAbilityModes) = @_;
    $this->{abilityModes} = $aAbilityModes;
}

sub getAbilityModes {
    my ($this) = @_;
    $this->{abilityModes};
}

sub hasAbilityModes {
    my ($this) = @_;
    return defined($this->{abilityModes});
}

1;