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
$dt->addChild($updateStatement);
ok(defined($updateStatement),'Update Statement is defined');

my $insertStatement = Pgtp::XMLNodes::XMLInsertStatement->new( [ "insert into matable('nom','prenom') values('Dupont','Pierre';" ] );
$dt->addChild($insertStatement);
ok(defined($insertStatement),'Insert Statement is defined');

my $deleteStatement = Pgtp::XMLNodes::XMLDeleteStatement->new( [ "delete from table mawhere cle=:cle" ] );
$dt->addChild($deleteStatement);
ok(defined($deleteStatement),'Delete Statement is defined');

# $dt->getNode()->toString;