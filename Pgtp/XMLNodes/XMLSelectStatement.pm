package Pgtp::XMLNodes::XMLSelectStatement;

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
    my($class,$_sqlRequest) = @_;
    my $this = $class->SUPER::new('SelectStatement');

    bless($this,$class);
    $this->setText($_sqlRequest);
    return $this;
}

1;