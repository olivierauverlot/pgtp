package Pgtp::Report;

use strict;
use warnings;
use utf8;
use 5.010;
use boolean;
use FindBin;                
use lib "$FindBin::RealBin/.";
use Data::Printer;
use Attribute::Abstract;
use Term::Table;

use Model::Project;

sub new {
    my($class,$_project) = @_;
    my $this = { 
        project => $_project,
        header => undef,
        rows => [ ]
    };

    bless($this,$class);
    return $this;
}

sub extractData: Abstract;

sub output {
    my ($this) = @_;

    my $table = Term::Table->new(
        max_width      => 160,    
        pad            => 4,     
        allow_overflow => 0,    
        collapse       => 1, 
        header         => $this->{header},
        rows           => $this->extractData()
    );

    print "\n";
    say $_ for $table->render;
    exit(1);
}

1;