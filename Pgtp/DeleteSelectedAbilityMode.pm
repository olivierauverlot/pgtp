package Pgtp::DeleteSelectedAbilityMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Pgtp::AbilityMode;

our @ISA = qw(Pgtp::AbilityMode);

sub new {
    my($class) = @_;
    my $this = $class->SUPER::new();
    $this->defaultValue = $this->{DISABLED};

    bless($this,$class);
    return $this;
}

sub isDeleteSelectedAbilityMode {
    my ($this) = @_;
    return true;
}

1;