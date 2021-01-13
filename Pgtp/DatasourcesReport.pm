package Pgtp::DatasourcesReport;

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

    $this->{header} = [ 'Name', 'Type', 'Top level page', 'Primary Key fields'];
    bless($this,$class);
    return $this;
}

sub extractData() {
    my ($this) = @_;
    
    my $page = $this->{project}->getPageFromShortCaption( $this->{pageShortCaption} );
    if(!defined($page)) {
        exitOnError("Page '$this->{pageShortCaption}' not found");
    }

    foreach my $dt ( $project->getDatasources() ) {
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