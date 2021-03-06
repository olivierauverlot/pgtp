package Model::Abilities::CopyAbilityMode;

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
    $this->{defaultValue} = $this->{SEPARATED_PAGE};

    bless($this,$class);
    return $this;
}

sub getAbilityName {
    my ($this) = @_;
    return 'Copy';
}

sub isCopyAbilityMode {
    my ($this) = @_;
    return true;
}

1;