package Pgtp::XMLNodes::XMLUpdateStatements;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::XMLNodes::XMLNode;

our @ISA = qw(Pgtp::XMLNodes::XMLNode);

sub new {
    my($class) = @_;
    my $this = $class->SUPER::new('UpdateStatements'); 

    bless($this,$class);
    return $this;
}

1;