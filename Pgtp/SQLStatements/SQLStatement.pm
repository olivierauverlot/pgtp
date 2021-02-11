package Pgtp::SQLStatements::SQLStatement;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Array::Diff;

sub new {
    my($class,$_table,$_columnsContainer,$_pks) = @_;
    my $this = { 
        table => $_table,
        columnsContainer => $_columnsContainer,
        pks => $_pks
    };
    bless($this,$class);

    return $this;
}

sub getSQLStatement: Abstract;

sub getNotSerialPk {
    my ($this) = @_;
    return grep { !$this->isSerial($_) } @{ $this->{pks} };
}

sub getSerialPk {
    my ($this) = @_;
    return  map { substr($_, 1, (length($_)-1)) } grep { $this->isSerial($_) } @{ $this->{pks} };
}

sub getAllPk {
    my ($this) = @_;
    my @serialPk =  $this->getSerialPk();
    my @notSerialPk = $this->getNotSerialPk();
    return ( @serialPk,@notSerialPk );
}

sub getAllColumnNames {
    my ($this) = @_;
    return map { $_->getFieldName() } $this->{columnsContainer}->getColumns(); 
}

sub isSerial {
    my ($this,$column) = @_;
    return ($column =~ m/^\*.*?$/)?true:false;
}

sub getAllColumnsWithoutSerialsPK {
    my ($this) = @_;

    my @serialPKs = $this->getSerialPk();
    my @columns = $this->getAllColumnNames();
    my $diff = Array::Diff->diff( \@serialPKs, \@columns );

    return @{ $diff->added() };
}

sub columnsSeparatedByCommas {
    my ($this,$columns) = @_;
    return join( ',', @{ $columns } );
}

1;