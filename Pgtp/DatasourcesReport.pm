package Pgtp::DatasourcesReport;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

use Model::Project;

# Displays the datasources of the specified page

our @ISA = qw(Pgtp::Report);

sub new {
    my($class,$_project) = @_;
    my $this = $class->SUPER::new($_project);

    $this->{header} = [ 'Name', 'Type', 'Top level page', 'Primary Key fields'];
    bless($this,$class);
    return $this;
}

sub extractData() {
    my ($this) = @_;

    foreach my $dt ( $this->{project}->getDatasources() ) {
        my @row;

        push @row,(
            $dt->getName(),
            $dt->getType(),
            $dt->isTopLevelPage() ? 'Yes' : 'No',
            join(',',$dt->getPrimaryKeyFields())
        );

        push @{ $this->{rows} }, \@row;
    }
    
    return $this->{rows};
}

1;