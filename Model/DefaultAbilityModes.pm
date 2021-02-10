package Model::DefaultAbilityModes;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::AbilityModes;

our @ISA = qw(Model::AbilityModes);

sub new {
    my($class,$_value) = @_;
    my $this = $class->SUPER::new($_value);

    bless($this,$class);
    return $this;
}

sub isAbilityModes {
    my($this) = @_;
    return false;
}

sub isDefaultAbilityModes {
    my($this) = @_;
    return true;
}

# I return the value of the specified ability
sub getAbilityValueFor {
    my ($this,$abilityName) = @_;
    my @ability = grep { $_->getAbilityName() eq $abilityName } @{ $this->{abilityModes} };
    return $ability[0]->getValue();
}

1;
