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

sub setParent {
    my ($this,$parent) = @_;
    $this->{parent} = $parent;
}

sub getParent {
    my ($this) = @_;
    return $this->{parent};
}

sub addAbilityMode {
    my($this,$aAbilityMode) = @_;
    $aAbilityMode->setParent($this);
    push @{ $this->{abilityModes} } ,$aAbilityMode;
}

sub getAbilityModes {
    my($this) = @_;
    return $this->{abilityModes};
}

sub isAbilityModes {
    my($this) = @_;
    return true;
}

sub isDefaultAbilityModes {
    my($this) = @_;
    return false;
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
    return grep { ( $_->isEditAbilityMode() or $_->isMultiEditAbilityMode() ) and $_->isEnabled() }  @{ $this->getAbilityModes } ;
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

# resolve the default value of an page ability
# to do that, I ask the value the default ability through the DefaultAbilityModes class.
sub getDefaultPageAbilityValueFor {
    my ($this,$ability) = @_;
    # what is the page of the abilities container ?
    my $page = $this->getParent();

    # I must get the default page ability modes of the project
    my $defaultPageAbilityModes = $page->getProject()->getDefaultPageAbilityModes();
    
    # and now, I return the default value of the ability 
    return $defaultPageAbilityModes->getAbilityValueFor($ability->getAbilityName());
}

1;