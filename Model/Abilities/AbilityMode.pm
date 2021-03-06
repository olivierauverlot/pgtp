package Model::Abilities::AbilityMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

sub new {
    my($class,$_value) = @_;
    my $this = { 
        parent => undef,
        defaultValue => undef,
        value => undef,
        DISABLED => 0,
        SEPARATED_PAGE => 1,
        INLINE_MODE => 2,
        MODAL => 3,
        ON => 3
    };

    bless($this,$class);

    if($_value ne '') {
        $this->{value} = $_value;
    }

    return $this;
}

sub getAbilityName: Abstract;

sub setParent {
    my ($this,$parent) = @_;
    $this->{parent} = $parent;
}

sub getParent {
    my ($this) = @_;
    return $this->{parent};
}

sub isViewAbilityMode {
    my ($this) = @_;
    return false;
}

sub isEditAbilityMode {
    my ($this) = @_;
    return false;
}

sub isMultiEditAbilityMode {
    my ($this) = @_;
    return false;
}

sub isInsertAbilityMode {
    my ($this) = @_;
    return false;
}

sub isCopyAbilityMode {
    my ($this) = @_;
    return false;
}

sub isDeleteAbilityMode {
    my ($this) = @_;
    return false;
}

sub isDeleteSelectedAbilityMode {
    my ($this) = @_;
    return false;
}

sub getValue {
    my ($this) = @_;
    if( defined($this->{value}) ) {
        return $this->{value};
    } else {
        if($this->getParent()->isDefaultAbilityModes()) {
            # if the abilitie is a default page ability, we must return the default value
            return $this->{defaultValue};
        } else {
            # if the abilitie is a page ability, we must get the defaut page ability value
            return $this->getParent()->getDefaultPageAbilityValueFor($this);
        }
    }
}

sub setValue {
    my ($this,$aValue) = @_;
    $this->{value} = $aValue;
}

sub isDisabled {
    my ($this) = @_;
    return ( $this->getValue() == $this->{DISABLED} );
}

sub isEnabled {
    my ($this) = @_;
    return ( $this->getValue() != $this->{DISABLED} );
}

1;