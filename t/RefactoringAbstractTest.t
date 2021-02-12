use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Pgtp::Refactoring::RefactoringAbstract;

my $refactoring = Pgtp::Refactoring::RefactoringAbstract->new(undef,undef);

is($refactoring->removeStarOnSerialPk('*cle'),'cle',"'*' character removed on the primary key name");
is($refactoring->removeStarOnSerialPk('name'),'name',"'*' character has not been removed on the primary key name");


