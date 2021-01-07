use strict;
use Test::More 'no_plan';
use FindBin;                
use lib "$FindBin::RealBin/../";

use Pgtp::XMLParser;
use Model::Project;
use Model::ConnectionOptions;

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro" localizationFileName="" phpDriver="1" outputPath="" copySystemFiles="true" generateModifiedDataOnly="false" outputFilesExtension="php" colorSchemeName="facebook">
  <ConnectionOptions host="pg.domain.org" port="5432" login="username" password="!!++==" database="mybase" client_encoding="UTF8">
    <ssh_secure secure="false" port="22" authentication_mode="0"/>
    <http_tunnel tunneling="false" url="">
      <http_proxy_server use_proxy="false" port="8080"/>
      <http_authentication/>
    </http_tunnel>
  </ConnectionOptions>
</Project>
XML

my $project = Model::Project->new();
my $dom = XML::LibXML->load_xml( string => $xml );
my $parser = Pgtp::XMLParser->new($dom,$project);
my $options = $project->getConnectionOptions();

is( $options->getHost(), 'pg.domain.org',  'Hostname found' );
is( $options->getPort(), 5432,  'database port found' );
is( $options->getLogin(), 'username',  'Login found' );
is( $options->getDatabase(), 'mybase',  'Database found' );
is( $options->getClientEncoding(), 'UTF8',  'Client encoding found' );