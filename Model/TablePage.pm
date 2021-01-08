package Model::TablePage;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

our @ISA = qw(Model::Page);

sub new {
    my($class,$_fileName,$_datasourceName,$_shortCaption,$_caption) = @_;
    my $this = $class->SUPER::new($_fileName,$_datasourceName,$_shortCaption,$_caption);
    
    bless($this,$class);
    return $this;
}

sub isTablePage {
    my($this) = @_;
    return true;
}

sub getType {
    my($this) = @_;
    return 'Table'; 
}