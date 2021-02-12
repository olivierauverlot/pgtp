package Pgtp::Refactoring::RefactoringAbstract;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::Refactoring::StatusMessage;

use Pgtp::XMLNodes::XMLQueryDataSource;
use Pgtp::XMLNodes::XMLPrimaryKeyField;
use Pgtp::XMLNodes::XMLPrimaryKeyFields;
use Pgtp::XMLNodes::XMLSelectStatement;
use Pgtp::XMLNodes::XMLUpdateStatement;
use Pgtp::XMLNodes::XMLInsertStatement;
use Pgtp::XMLNodes::XMLDeleteStatement;
use Pgtp::XMLNodes::XMLUpdateStatements;
use Pgtp::XMLNodes::XMLInsertStatements;
use Pgtp::XMLNodes::XMLDeleteStatements;

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

sub removeStarOnSerialPk {
    my ($this,$pkName) = @_;
    my $name = $pkName =~ s/^\*//r;
    return $name;
}

sub getXMLData {
    my ($this) = @_;
    return $this->{xmlData};
}

# Apply the refactoring
# return true if refactoring is done
sub apply: Abstract;

1;