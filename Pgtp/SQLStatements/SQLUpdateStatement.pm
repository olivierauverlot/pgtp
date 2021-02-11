package Pgtp::SQLStatements::SQLUpdateStatement;

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

# UPDATE public.table SET sigle=:sigle,intitule=:intitule,visible=:visible WHERE cle=:OLD_cle AND sigle=:OLD_sigle;

sub getSQLStatement {
    my ($this) = @_;
    my $affectations = '';

    my @affectations =  map { "$_=:$_"} $this->getAllColumnsWithoutSerialsPK();
    my @conditions = map { "$_=:OLD_$_" } $this->getAllPk();
    
    return 'UPDATE ' . $this->{table} . ' SET ' . $this->columnsSeparatedBy(\@affectations,',') . ' WHERE ' . $this->columnsSeparatedBy(\@conditions,' AND ') . ';';
}

1;