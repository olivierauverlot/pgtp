package Pgtp::SQLStatements::SQLDeleteStatement;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Pgtp::SQLStatements::SQLStatement;

our @ISA = qw(Pgtp::SQLStatements::SQLStatement);

sub new {
    my($class,$_table,$_columnsContainer,$_pks) = @_;
    my $this = $class->SUPER::new($_table,$_columnsContainer,$_pks);

    bless($this,$class);
    return $this;
}

sub getSQLStatement {
    my ($this) = @_;
    my @conditions = map { "$_=:$_" } $this->getAllPk();
    return 'DELETE FROM ' . $this->{table} . ' WHERE ' . $this->columnsSeparatedBy(\@conditions,' AND ') . ';';
}

1;