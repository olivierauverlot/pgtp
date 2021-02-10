package Model::Abilities::DeleteAbilityMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::Abilities::AbilityMode;

our @ISA = qw(Model::Abilities::AbilityMode);

sub new {
    my($class,$_value) = @_;
    my $this = $class->SUPER::new($_value);
    $this->{defaultValue} = $this->{DISABLED};

    bless($this,$class);
    return $this;
}

sub getAbilityName {
    my ($this) = @_;
    return 'Delete';
}

sub isDeleteAbilityMode {
    my ($this) = @_;
    return true;
}

1;