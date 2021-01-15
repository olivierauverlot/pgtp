package Pgtp::ReportOfPage;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

use Pgtp::Report;

our @ISA = qw(Pgtp::Report);

sub new {
    my($class,$_project,$_pageShortCaption) = @_;
    my $this = $class->SUPER::new($_project);

    $this->{page} = $this->{project}->getPageFromShortCaption( $_pageShortCaption );
    if(!defined($this->{page})) {
        exitOnError("Page '$_pageShortCaption' not found");
    }

    bless($this,$class);
    return $this;
}

1;