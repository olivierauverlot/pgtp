use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use boolean;
use Data::Printer;

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

my $dt = Pgtp::XMLNodes::XMLQueryDataSource->new('datasource');
ok(defined($dt),'Datasource node is defined');

my $pk1 = Pgtp::XMLNodes::XMLPrimaryKeyField->new("cle");
my $pk2 = Pgtp::XMLNodes::XMLPrimaryKeyField->new("num");
ok(defined($pk1),'Primary key field pk1 is defined');
ok(defined($pk1),'Primary key field pk2 is defined');

my $pks = Pgtp::XMLNodes::XMLPrimaryKeyFields->new();
$pks->addChild($pk1);
$pks->addChild($pk2); 
$dt->addChild($pks);
ok(defined($pks),'Primary key fields container is defined');

my $select = Pgtp::XMLNodes::XMLSelectStatement->new("select * from matable");
$dt->addChild($select);
ok(defined($select),'Select Statement is defined');

my $updateStatement = Pgtp::XMLNodes::XMLUpdateStatement->new( [ "update matable set nom='Dupont' where cle=:cle" ] );
ok(defined($updateStatement),'Update Statement is defined');

my $insertStatement = Pgtp::XMLNodes::XMLInsertStatement->new( [ "insert into matable('nom','prenom') values('Dupont','Pierre';" ] );
ok(defined($insertStatement),'Insert Statement is defined');

my $deleteStatement = Pgtp::XMLNodes::XMLDeleteStatement->new( [ "delete from table mawhere cle=:cle" ] );
ok(defined($deleteStatement),'Delete Statement is defined');

# containers for update, insert et delete statements
my $updateStatements = Pgtp::XMLNodes::XMLUpdateStatements->new();
$updateStatements->addChild($updateStatement);
$dt->addChild($updateStatements);
ok(defined($updateStatements),'Update Statements is defined');

my $insertStatements = Pgtp::XMLNodes::XMLInsertStatements->new();
$insertStatements->addChild($insertStatement);
$dt->addChild($insertStatements);
ok(defined($insertStatements),'Insert Statements is defined');

my $deleteStatements = Pgtp::XMLNodes::XMLDeleteStatements->new();
$deleteStatements->addChild($deleteStatement);
$dt->addChild($deleteStatements);
ok(defined($deleteStatements),'Delete Statements is defined');

# $dt->getNode()->toString;