package Pgtp::Refactoring::RefactoringMutation;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::Refactoring::RefactoringAbstract;

our @ISA = qw(Pgtp::Refactoring::RefactoringAbstract);

sub new {
    my($class,$_project,$_dom,$_tableDataSourceName,$_queryDataSourceName) = @_;
    my $this = $class->SUPER::new($_project,$_dom);

    $this->{tableDataSourceName} = $_tableDataSourceName;
    $this->{queryDataSourceName} = $_queryDataSourceName;
    $this->{primaryKeys} = [ ];

    bless($this,$class);
    return $this;
}

sub addPrimaryKey {
    my ($this,$pkName);
    push @{ $this->{primaryKeys} } , $pkName;
}

sub getPrimaryKeys {
    my ($this) = @_;
    return @{ $this->{primaryKeys} };
}

sub get
sub apply {
    my ($this) = @_;
    return true;
}

1;
