package Pgtp::AbilityMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$_value) = @_;
    my $this = { 
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
        return $this->{defaultValue};
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