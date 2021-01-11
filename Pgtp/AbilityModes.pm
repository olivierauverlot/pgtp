package Pgtp::AbilityModes;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Pgtp::ViewAbilityMode;
use Pgtp::EditAbilityMode;
use Pgtp::MultiEditAbilityMode;
use Pgtp::InsertAbilityMode;
use Pgtp::CopyAbilityMode;
use Pgtp::deleteAbilityMode;
use Pgtp::DeleteSelectedAbilityMode;

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
    return @{ $this->{abilityModes} };
}

sub hasViewAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isViewAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasInsertAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isInsertAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasCopyAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isCopyAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasInsertAbilityModes {
    my($this) = @_;
    my @result = grep { ( $_->isInsertAbilityMode() or $_->isCopyAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasEditAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isEditAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasMultiEditAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isMultiEditAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasEditAbilitieModes {
    my($this) = @_;
    my @result = grep { ( $_->isEditAbilityMode() or $_->isMultiEditAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasDeleteAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isDeleteAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasDeleteSelectedAbilityMode {
    my($this) = @_;
    my @result = grep { $_->isDeleteSelectedAbilityMode() and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

sub hasDeleteAbilityModes {
    my($this) = @_;
    my @result = grep { ( $_->isDeleteAbilityMode() or $_->isDeleteSelectedAbilityMode() )  and $_->isEnabled() }  $this->getAbilityModes ;
    return (scalar @result > 0);
}

1;