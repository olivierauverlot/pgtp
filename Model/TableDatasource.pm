package Model::TableDatasource;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::Datasource;

our @ISA = qw(Model::Datasource);

sub new {
    my($class,$_name,$_topLevelPage) = @_;
    my $this = $class->SUPER::new($_name,$_topLevelPage);

    bless($this,$class);
    return $this;
}

sub isTableDatasource {
    my ($this) = @_;
    return true;
}

1;