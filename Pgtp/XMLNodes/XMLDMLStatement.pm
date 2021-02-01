package Pgtp::XMLNodes::XMLDMLStatement;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::XMLNodes::XMLNode;
use Pgtp::XMLNodes::XMLStatement;

our @ISA = qw(Pgtp::XMLNodes::XMLNode);

sub new {
    my($class,$_name,$_sqlRequests) = @_;
    my $this = $class->SUPER::new($_name);

    foreach my $request ( @{ $_sqlRequests} ) {
        $this->addChild(Pgtp::XMLNodes::XMLStatement->new($request));
    }

    bless($this,$class);
    return $this;
}

1;