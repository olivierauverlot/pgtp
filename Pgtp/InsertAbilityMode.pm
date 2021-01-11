package Pgtp::InsertAbilityMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Pgtp::AbilityMode;

our @ISA = qw(Pgtp::AbilityMode);

sub new {
    my($class,$_value) = @_;
    my $this = $class->SUPER::new($_value);
    $this->{defaultValue} = $this->{SEPARATED_PAGE};

    bless($this,$class);
    return $this;
}

sub isInsertAbilityMode {
    my ($this) = @_;
    return true;
}

1;