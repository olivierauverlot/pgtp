package Pgtp::Reports::ReportOfPage;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

use Pgtp::Reports::Report;

our @ISA = qw(Pgtp::Reports::Report);

sub new {
    my($class,$_project,$_pageShortCaption) = @_;
    my $this = $class->SUPER::new($_project);

    $this->{page} = $this->{project}->getPageFromShortCaption( $_pageShortCaption );
    if(!defined($this->{page})) {
        $this->exitOnError("Page '$_pageShortCaption' not found");
    }

    bless($this,$class);
    return $this;
}

1;