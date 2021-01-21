package Pgtp::Refactoring::RefactoringAbstract;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::Refactoring::StatusMessage;

sub new {
    my($class,$_project,$_dom) = @_;
    my $this = { 
        project => $_project,
        dom => $_dom,
        xmlData => ''
    };

    bless($this,$class);
    return $this;
}

sub getXMLData {
    my ($this) = @_;
    return $this->{xmlData};
}

# Apply the refactoring
# return true if refactoring is done
sub apply: Abstract;

1;