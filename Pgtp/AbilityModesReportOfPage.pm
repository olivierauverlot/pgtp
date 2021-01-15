package Pgtp::AbilityModesReportOfPage;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

use Pgtp::ReportOfPage;

# Displays the ability modes of the specified page

our @ISA = qw(Pgtp::ReportOfPage);

sub new {
    my($class,$_project,$_pageShortCaption) = @_;
    my $this = $class->SUPER::new($_project,$_pageShortCaption);

    $this->{header} = [ 'View','Insert','Copy','Edit','MultiEdit','Delete','DeleteSelected'];
    bless($this,$class);
    return $this;
}

sub extractData() {
    my ($this) = @_;
    my @row;
    
    my $abilities = $this->{page}->getAbilityModesContainer();
    
    push @row,(
            $abilities->hasViewAbilityMode() ? 'Yes' : 'No',
            $abilities->hasInsertAbilityMode() ? 'Yes' : 'No',
            $abilities->hasCopyAbilityMode() ? 'Yes' : 'No',
            $abilities->hasEditAbilityMode() ? 'Yes' : 'No',
            $abilities->hasMultiEditAbilityMode() ? 'Yes' : 'No',
            $abilities->hasDeleteAbilityMode() ? 'Yes' : 'No',
            $abilities->hasDeleteSelectedAbilityMode() ? 'Yes' : 'No'
    );
    push @{ $this->{rows} }, \@row;

    return $this->{rows};
}

1;