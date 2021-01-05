package Model::ConnectionOptions;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;

sub new {
    my($class,$_host,$_port,$_login,$_database,$_clientEncoding) = @_;
    my $this = { 
        host => $_host,
        port => $_port,
        login => $_login,
        database => $_database,
        clientEncoding => $_clientEncoding,
        password => undef
    };

    bless($this,$class);
    return $this;
}

sub getHost {
    my ($this) = @_;
    return $this->{host};
}

sub getPort {
    my ($this) = @_;
    return $this->{port};  
}

sub getLogin {
    my ($this) = @_;
    return $this->{login};  
}

sub getDatabase {
    my ($this) = @_;
    return $this->{database};  
}

sub getClientEncoding {
    my ($this) = @_;
    return $this->{clientEncoding};  
}

sub setPassword {
    my ($this,$_password) = @_;
    $this->{password} = $_password;
}

sub getPassword {
    my ($this) = @_;
    return $this->{password};  
}
1;