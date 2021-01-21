package StatusMessage;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;

sub new {
    my($class,$_error,$_message) = @_;
    my $this = { 
        error => $_error,
        message => $_message
    };

    bless($this,$class);
    return $this;
}

sub isError {
    my ($this) = @_;
    return $this->{error};
}

sub getMessage {
    my ($this) = @_;
    return $this->{message};
}

1;