package Model::ScreenModes::Factory;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Class::Inspector;

use Model::ScreenModes::ScreenMode;
use Model::ScreenModes::ListScreenMode;
use Model::ScreenModes::ViewScreenMode;
use Model::ScreenModes::EditScreenMode;
use Model::ScreenModes::InsertScreenMode;
use Model::ScreenModes::QuickFilterScreenMode;
use Model::ScreenModes::FilterBuilderScreenMode;
use Model::ScreenModes::PrintScreenMode;
use Model::ScreenModes::ExportScreenMode;
use Model::ScreenModes::CompareScreenMode;
use Model::ScreenModes::MultiEditScreenMode;

sub new {
    my($class) = @_;
    my $this = { 
        screenModesClasses => { }
    };

    # get all subclasses of Model::ScreenModes::ScreenMode
    foreach my $ScreenModeclass ( @{ Class::Inspector->subclasses('Model::ScreenModes::ScreenMode') } ) {
        $this->{screenModesClasses}{ $ScreenModeclass->getTagName() } = $ScreenModeclass;
    }
    
    bless($this,$class);
    return $this;
}

sub createFromTag {
    my ($this,$_tagName) = @_;
    my $ScreenModeclass = $this->{screenModesClasses}{ $_tagName };
    if(defined($ScreenModeclass)) {
        return $ScreenModeclass->new();
    }
}

1;