package Model::QueryPage;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

our @ISA = qw(Model::Page);

sub new {
    my($class,$_fileName,$_datasourceName,$_shortCaption,$_caption,$_detailsPage) = @_;
    my $this = $class->SUPER::new($_fileName,$_datasourceName,$_shortCaption,$_caption,$_detailsPage);
    
    bless($this,$class);
    return $this;
}

sub isQueryPage {
    my($this) = @_;
    return true;
}

sub getType {
    my($this) = @_;
    return 'Query'; 
}