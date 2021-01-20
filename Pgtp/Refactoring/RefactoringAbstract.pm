package Pgtp::Refactoring::RefactoringAbstract;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

sub new {
    my($class) = @_;
    my $this = { };

    bless($this,$class);
    return $this;
}

sub aMethod: Abstract;

1;