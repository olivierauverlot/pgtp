use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Model::ColumnsContainer;
use Model::Column;

use Pgtp::SQLStatements::SQLSelectStatement;
use Pgtp::SQLStatements::SQLInsertStatement;
use Pgtp::SQLStatements::SQLUpdateStatement;
use Pgtp::SQLStatements::SQLDeleteStatement;

# cle is a serial value
my $pks = [ '*cle' , 'sigle' ];

my $columnsContainer = Model::ColumnsContainer->new(undef);

$columnsContainer->addColumn( Model::Column->new('cle','') );
$columnsContainer->addColumn( Model::Column->new('sigle','') );
$columnsContainer->addColumn( Model::Column->new('intitule','') );
$columnsContainer->addColumn( Model::Column->new('visible','') );

my $sqlSelectStatement = Pgtp::SQLStatements::SQLSelectStatement->new('public.table',$columnsContainer,$pks);
my $sqlInsertStatement = Pgtp::SQLStatements::SQLInsertStatement->new('public.table',$columnsContainer,$pks);
my $sqlUpdateStatement = Pgtp::SQLStatements::SQLUpdateStatement->new('public.table',$columnsContainer,$pks);
my $sqlDeleteStatement = Pgtp::SQLStatements::SQLDeleteStatement->new('public.table',$columnsContainer,$pks);

my @pks = $sqlSelectStatement->getAllPk();
is(scalar(@pks),2,"Get all primary keys");

my @notSerialPK = $sqlSelectStatement->getNotSerialPk();
is(scalar(@notSerialPK),1,"Get PK that haven't serial datatype");

my @serialPK = $sqlSelectStatement->getSerialPk();
is(scalar(@serialPK),1,"Get PK that have serial datatype");

my @allColumns = $sqlSelectStatement->getAllColumnNames();
is(scalar(@allColumns),4,'Get all columns');

ok($sqlSelectStatement->columnsSeparatedByCommas(\@allColumns) eq 'cle,sigle,intitule,visible',"Columns are separated byCommas");
ok($sqlSelectStatement->isSerial('*cle'),"'cle' is a serial");
is($sqlSelectStatement->isSerial('sigle'),false,"'sigle' is not a serial");

my @columnsNotSerial = $sqlSelectStatement->getAllColumnsWithoutSerialsPK();
is(scalar(@columnsNotSerial),3,"Get all columns that aren't primary key with serial datatype");

is($sqlSelectStatement->getSQLStatement(),'SELECT cle,sigle,intitule,visible FROM public.table;','Select statement');
is($sqlInsertStatement->getSQLStatement(),'INSERT INTO public.table(sigle,intitule,visible) VALUES(:sigle,:intitule,:visible);','Insert statement');
is($sqlUpdateStatement->getSQLStatement(),'UPDATE public.table SET sigle=:sigle,intitule=:intitule,visible=:visible WHERE cle=:OLD_cle AND sigle=:OLD_sigle;','Update statement');

=pod
is($sqlUpdateStatement->getSQLStatement(),'DELETE FROM public.table WHERE cle=:cle AND sigle=:sigle;','Delete statement');
=cut