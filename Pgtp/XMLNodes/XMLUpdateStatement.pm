package Pgtp::XMLNodes::XMLUpdateStatement;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::XMLNodes::XMLDMLStatement;

our @ISA = qw(Pgtp::XMLNodes::XMLDMLStatement);

sub new {
    my($class,$_sqlRequests) = @_;
    my $this = $class->SUPER::new('UpdateStatement',$_sqlRequests);

    bless($this,$class);
    return $this;
}

1;