package Pgtp::SQLStatements::SQLInsertStatement;

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
    my @columns = $this->getAllColumnsWithoutSerialsPK();
    my @values = map { ":$_"} $this->getAllColumnsWithoutSerialsPK();
    return 'INSERT INTO ' . $this->{table} . '(' . $this->columnsSeparatedBy(\@columns,',') . ') VALUES(' . $this->columnsSeparatedBy(\@values,',') . ');';
}

1;