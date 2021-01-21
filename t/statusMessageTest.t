use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Pgtp::Refactoring::StatusMessage;

my $done = Pgtp::Refactoring::StatusMessage->new(true,'error');
ok($done->isError(),'Status is an error');
is($done->isOk(),false,'Status is not an ok message');
is($done->getMessage(),'error',"The message is 'error'");

my $ok = Pgtp::Refactoring::StatusMessage->new(false,'done');
is($ok->isError(),false,'Status is not an error');
ok($ok->isOk(),'Status is an ok message');
