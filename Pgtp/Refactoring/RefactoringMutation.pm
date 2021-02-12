package Pgtp::Refactoring::RefactoringMutation;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use Pgtp::Refactoring::RefactoringAbstract;
use Pgtp::SQLStatements::SQLSelectStatement;
use Pgtp::SQLStatements::SQLInsertStatement;
use Pgtp::SQLStatements::SQLUpdateStatement;
use Pgtp::SQLStatements::SQLDeleteStatement;

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
    my ($this,$pkName) = @_;
    push @{ $this->{primaryKeys} }, $pkName;
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

    # datasource can't be a table
    if(not $this->{project}->getDatasourceFromName($this->{tableDataSourceName})->isTableDatasource()) {
        return Pgtp::Refactoring::StatusMessage->new(true,'The datasource is not a table');
    }

    # Datasource names can't be the same
    if( $this->{tableDataSourceName} eq $this->{queryDataSourceName} ) {
        return Pgtp::Refactoring::StatusMessage->new(true,"Datasource names can't be the same");
    }

    # Query datasource name can't be already used in the project
    if($this->{project}->getDatasourceFromName($this->{queryDataSourceName})) {
        return Pgtp::Refactoring::StatusMessage->new(true,"Query datasource name can't be already used in the project");
    }

    # extract the columns list from the first page that uses the table datasource
    my $ret = $this->initColumnsContainerWith( $this->{tableDataSourceName} );
    if(!$ret) {
        return Pgtp::Refactoring::StatusMessage->new(true,"Column list cannot be initialized");
    }

    # create the new SQL Request datasource
    my $queryDataSource = Pgtp::XMLNodes::XMLQueryDataSource->new( $this->{queryDataSourceName} );
    # with the primary keys
    my $pks = Pgtp::XMLNodes::XMLPrimaryKeyFields->new();
    foreach my $pk ( @{ $this->{primaryKeys} } ) {
        $pks->addChild( Pgtp::XMLNodes::XMLPrimaryKeyField->new($this->removeStarOnSerialPk($pk)) );
    }
    # the primary keys declaration section is added to the datasource
    $queryDataSource->addChild($pks);

    # add the SELECT statement
    my $sqlSelectStatement = Pgtp::SQLStatements::SQLSelectStatement->new($this->{queryDataSourceName},$this->{columnsContainer},$this->{primaryKeys} );
    $queryDataSource->addChild( Pgtp::XMLNodes::XMLSelectStatement->new( $sqlSelectStatement->getSQLStatement() ) );

    # create the INSERT statement
    my $xmlInsertStatements = Pgtp::XMLNodes::XMLInsertStatements->new();
    my $sqlInsertStatement = Pgtp::SQLStatements::SQLInsertStatement->new($this->{queryDataSourceName},$this->{columnsContainer},$this->{primaryKeys} );
    $xmlInsertStatements->addChild( Pgtp::XMLNodes::XMLInsertStatement->new( [ $sqlInsertStatement->getSQLStatement() ] ) );
    $queryDataSource->addChild( $xmlInsertStatements );

    # create the UPDATE statement
    my $xmlUpdateStatements = Pgtp::XMLNodes::XMLUpdateStatements->new();
    my $sqlUpdateStatement = Pgtp::SQLStatements::SQLUpdateStatement->new($this->{queryDataSourceName},$this->{columnsContainer},$this->{primaryKeys} );
    $xmlUpdateStatements->addChild( Pgtp::XMLNodes::XMLUpdateStatement->new( [ $sqlUpdateStatement->getSQLStatement() ] ) );
    $queryDataSource->addChild( $xmlUpdateStatements );

    # create the DELETE statement
    my $xmlDeleteStatements = Pgtp::XMLNodes::XMLDeleteStatements->new();
    my $sqlDeleteStatement = Pgtp::SQLStatements::SQLDeleteStatement->new($this->{queryDataSourceName},$this->{columnsContainer},$this->{primaryKeys} );
    $xmlDeleteStatements->addChild( Pgtp::XMLNodes::XMLDeleteStatement->new( [ $sqlDeleteStatement->getSQLStatement() ] ) );
    $queryDataSource->addChild( $xmlDeleteStatements );

    p( $queryDataSource->getNode()->toString );

    return Pgtp::Refactoring::StatusMessage->new(false,'done!');
} 

1;
