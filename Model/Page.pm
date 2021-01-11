package Model::Page;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

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
        abilityModes => [ ]
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
sub addAbilityMode {
    my($this,$aAbilityMode) = @_;
    push $this->{abilityModes},$aAbilityMode;
}

sub getAbilityModes {
    my($this) = @_;
    return @{ $this->{abilityModes} };
}

sub usesViewAbility {
    my($this) = @_;
    my @result = grep { $_->isViewAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub usesInsertAbilities {
    my($this) = @_;
    my @result = grep { ( $_->isInsertAbilityMode() or $_->isCopyAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub usesEditAbilities {
    my($this) = @_;
    my @result = grep { ( $_->isEditAbilityMode() or $_->isMultiEditAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub usesDeleteAbilities {
    my($this) = @_;
    my @result = grep { ( $_->isDeleteAbilityMode() or $_->isDeleteSelectedAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

1;