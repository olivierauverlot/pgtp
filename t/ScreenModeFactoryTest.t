use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";
use Data::Printer;
use boolean;

use Model::ScreenModes::Factory;
use Model::ScreenModes::ScreenMode;
use Model::ScreenModes::ViewScreenMode;

is(Model::ScreenModes::ViewScreenMode->getTagName(),'View',"Tag name of Model::ScreenModes::ViewScreenMode is 'View'");
is(Model::ScreenModes::QuickFilterScreenMode->getTagName(),'QuickFilter',"Tag name of Model::ScreenModes::QuickFilterScreenMode is 'QuickFilter'");

my $factory = Model::ScreenModes::Factory->new();

my $viewMode = $factory->createFromTag('View');
ok($viewMode->isViewScreenMode(),"The factory class have produced an instance of ViewScreenMode");
is($viewMode->isListScreenMode(),false,"The factory class haven't produced an instance of ListScreenMode");