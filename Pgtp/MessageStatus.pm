package MessageStatus;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;

sub new {
    my($class) = @_;
    my $this = { 
        error => false,
        message => ''
    };

    bless($this,$class);
    return $this;
}

sub isError {
    my ($this) = @_;
    return $this->{error};
}

sub setError {
    my ($this) = @_;
    $this->{error} = true;   
}

sub getMessage {
    my ($this) = @_;
    return $this->{message};
}

sub setMessage {
    my ($this,$_message) = @_;
    $this->{message} = $_message;    
}

sub exitOnError {
    my ($this) = @_;
    if($this->isError()) {
        say $this->{message};
        exit(0);
    }
}

1;
