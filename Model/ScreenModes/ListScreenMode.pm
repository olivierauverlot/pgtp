package Model::ScreenModes::ListScreenMode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

use Model::ScreenModes::ScreenMode;

our @ISA = qw(Model::ScreenModes::ScreenMode);

sub new {
    my($class,$aParent) = @_;
    my $this = $class->SUPER::new();

    bless($this,$class);
    return $this;
}

sub getTagName {
    my ($class) = @_;
    return 'List';
}

sub isListScreenMode {
    my ($this) = @_;
    return true;
}

1;