package Pgtp::XMLNodes::XMLQueryDataSource;

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
    my($class,$_name) = @_;
    my $this = $class->SUPER::new('DataSource');

    bless($this,$class);
    $this->addAttribute('name',$_name);
    $this->addAttribute('type','query');
    return $this;
}

1;