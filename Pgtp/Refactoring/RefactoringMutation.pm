package Pgtp::Refactoring::RefactoringMutation;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::Refactoring::RefactoringAbstract;
# use Pgtp::Refactoring::StatusMessage;

our @ISA = qw(Pgtp::Refactoring::RefactoringAbstract);

sub new {
    my($class,$_project,$_dom,$_tableDataSourceName,$_queryDataSourceName) = @_;
    my $this = $class->SUPER::new($_project,$_dom);

    $this->{tableDataSourceName} = $_tableDataSourceName;
    $this->{queryDataSourceName} = $_queryDataSourceName;
    $this->{primaryKeys} = [ ];
    $this->{columnsContainer} = undef;

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

sub initColumnsContainerWith {
    my ($this,$datasourceName) = @_;
    my @pages = grep { $_->getDatasourceName() eq $datasourceName } $this->{project}->getTablePages();
    if(@pages) {
        $this->{columnsContainer} = $pages[0]->getColumnsContainer();
        return true;
    }
    return false;
}

# Quel écran utilise la source de données ?
# extraction des colonnes
# génération des requêtes SQL
# production du code XML
# insertion dans le dom du document
# génération du XML

sub apply {
    my ($this) = @_;

    if(not $this->{project}->getDatasourceFromName($this->{tableDataSourceName})->isTableDatasource()) {
        return Pgtp::Refactoring::StatusMessage->new(true,'The datasource is not a table');
    }

    if( $this->{tableDataSourceName} eq $this->{queryDataSourceName} ) {
        return Pgtp::Refactoring::StatusMessage->new(true,"datasource names can't be the same");
    }

    if($this->{project}->getDatasourceFromName($this->{queryDataSourceName})) {
        return Pgtp::Refactoring::StatusMessage->new(true,"Query datasource name can't be already used in the project");
    }

    # extract the columns list from the first page that uses the table datasource
    my $ret = $this->initColumnsContainerWith( $this->{tableDataSourceName} );
    if(!$ret) {
        return Pgtp::Refactoring::StatusMessage->new(true,"column list cannot be initialized");
    }

    p ( $this->{columnsContainer} );

    return Pgtp::Refactoring::StatusMessage->new(false,'done!');
}

1;
