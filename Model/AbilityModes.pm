package Model::AbilityModes;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::Abilities::ViewAbilityMode;
use Model::Abilities::EditAbilityMode;
use Model::Abilities::MultiEditAbilityMode;
use Model::Abilities::InsertAbilityMode;
use Model::Abilities::CopyAbilityMode;
use Model::Abilities::DeleteAbilityMode;
use Model::Abilities::DeleteSelectedAbilityMode;

sub new {
    my($class,$aParent) = @_;
    my $this = { 
        parent => $aParent,
        abilityModes => [ ]
    };

    bless($this,$class);
    return $this;
}

sub addAbilityMode {
    my($this,$aAbilityMode) = @_;
    push @{ $this->{abilityModes} } ,$aAbilityMode;
}

sub getAbilityModes {
    my($this) = @_;
    return $this->{abilityModes} ;
}

sub hasViewAbilityMode {
    my($this) = @_;
    return grep { $_->isViewAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasInsertAbilityMode {
    my($this) = @_;
    return grep { $_->isInsertAbilityMode() and $_->isEnabled() } @{ $this->getAbilityModes } ;
}

sub hasCopyAbilityMode {
    my($this) = @_;
    return grep { $_->isCopyAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasInsertAbilityModes {
    my($this) = @_;
    return grep { ( $_->isInsertAbilityMode() or $_->isCopyAbilityMode() )  and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasEditAbilityMode {
    my($this) = @_;
    return grep { $_->isEditAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasMultiEditAbilityMode {
    my($this) = @_;
    return grep { $_->isMultiEditAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasEditAbilitieModes {
    my($this) = @_;
    return grep { ( $_->isEditAbilityMode() or $_->isMultiEditAbilityMode() )  and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasDeleteAbilityMode {
    my($this) = @_;
    return grep { $_->isDeleteAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasDeleteSelectedAbilityMode {
    my($this) = @_;
    return grep { $_->isDeleteSelectedAbilityMode() and $_->isEnabled() }  @{ $this->getAbilityModes } ;
}

sub hasDeleteAbilityModes {
    my($this) = @_;
    return grep { ( $_->isDeleteAbilityMode() or $_->isDeleteSelectedAbilityMode() )  and $_->isEnabled() }  @{  $this->getAbilityModes } ;
}

1;