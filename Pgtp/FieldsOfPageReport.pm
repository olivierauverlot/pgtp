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

use Pgtp::ReportOfPage;
use Model::Project;

# Displays the columns of the specified page

our @ISA = qw(Pgtp::ReportOfPage);

sub new {
    my($class,$_project,$_pageShortCaption) = @_;
    my $this = $class->SUPER::new($_project,$_pageShortCaption);

    $this->{header} = [ 'Fieldname', 'Caption', 'Can set NULL'];
    bless($this,$class);
    return $this;
}

sub extractData() {
    my ($this) = @_;

    foreach my $c ( $this->{page}->getColumnsContainer()->getColumns() ) {
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