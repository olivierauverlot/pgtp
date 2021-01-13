package Pgtp::FieldsOfPageReport;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;
use FindBin;                
use lib "$FindBin::RealBin/.";
use Data::Printer;
use Term::Table;

use Pgtp::Report;
use Model::Project;

# Displays the columns of the specified page

our @ISA = qw(Pgtp::Report);

sub new {
    my($class,$_project) = @_;
    my $this = $class->SUPER::new($_project);
    $this->{pageShortCaption} = '';

    $this->{header} = [ 'Fieldname', 'Caption', 'Can set NULL'];
    bless($this,$class);
    return $this;
}

sub setPageShortCaption {
    my ($this,$_pageShortCaption) = @_;
    $this->{pageShortCaption} = $_pageShortCaption;
}

sub extractData() {
    my ($this) = @_;
    
    my $page = $this->{project}->getPageFromShortCaption( $this->{pageShortCaption} );
    if(!defined($page)) {
        exitOnError("Page '$this->{pageShortCaption}' not found");
    }

    foreach my $c ( $page->getColumnsContainer()->getColumns() ) {
        my @row;

        push @row,(
            $c->getFieldName(),
            $c->getCaption(),
            $c->canSetNull() ? 'Yes' : 'No'
        );
        push @{ $this->{rows} }, \@row;
    }
    return $this->{rows};
}

1;