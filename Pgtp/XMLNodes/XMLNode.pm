package Pgtp::XMLNodes::XMLNode;

use strict;
use warnings;
use utf8;
use 5.010;
use Data::Printer;
use boolean;
use Attribute::Abstract;

use XML::LibXML;

sub new {
    my($class,$_name) = @_;
    my $this = { 
        node => undef
    };
    bless($this,$class);

    $this->{node} = XML::LibXML::Element->new($_name);
    return $this;
}

sub addChild {
    my ($this,$child) = @_; 
    $this->{node}->addChild($child->getNode());
}

sub addAttribute {
    my ($this,$name,$value) = @_; 
    $this->{node}->setAttribute($name,$value);
}

sub setText {
    my ($this,$text) = @_;
    $this->{node}->addChild(XML::LibXML::Text->new($text));
}

sub getNode {
    my ($this) = @_;
    return $this->{node};
}

1;