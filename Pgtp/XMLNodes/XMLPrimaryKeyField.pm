package Pgtp::XMLNodes::XMLPrimaryKeyField;

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
    my($class,$_fieldName) = @_;
    my $this = $class->SUPER::new('Field');

    bless($this,$class);
    $this->addAttribute('name',$_fieldName);
    return $this;
}

1;