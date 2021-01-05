package Model::Project;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;

use Model::ConnectionOptions;

sub new {
    my($class) = @_;
    my $this = { 
        connectionOptions => undef
    };

    bless($this,$class);
    return $this;
}

sub setConnectionOptions {
    my($this,$aConnectionOptions) = @_;
    $this->{connectionOptions} = $aConnectionOptions;
}

sub getConnectionOptions {
    my($this) = @_;
    return $this->{connectionOptions};
}

return 1;