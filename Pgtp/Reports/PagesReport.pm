package Pgtp::Reports::PagesReport;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

use Model::Project;

# Displays the pages of the project

our @ISA = qw(Pgtp::Reports::Report);

sub new {
    my($class,$_project) = @_;
    my $this = $class->SUPER::new($_project);

    $this->{header} = [ 'Filename', 'Type', 'Datasource', 'Short caption','Caption','Master page' ];
    bless($this,$class);
    return $this;
}

sub extractData() {
    my ($this) = @_;

    foreach my $p ( $this->{project}->getPages() ) {
        my @row;

        push @row,(
            $p->getFileName(),
            $p->getType(),
            $p->getDatasourceName(),
            $p->getShortCaption(),
            $p->getCaption(),
            defined $p->getMasterPage() ? $p->getMasterPage()->getShortCaption() : ''
        );

        push @{ $this->{rows} }, \@row;
    }
    
    return $this->{rows};
}

1;