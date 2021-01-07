#!/usr/bin/env perl

use strict;
use Test::More 'no_plan';

my $xml = <<XML;
<Project version="20.5.0.4" edition="pro" localizationFileName="C:\Bitnami\wappstack\apache2\htdocs\membres_v2\lang.fr.php" phpDriver="1" outputPath="C:\Bitnami\wappstack\apache2\htdocs\membres_v2" copySystemFiles="true" generateModifiedDataOnly="false" outputFilesExtension="php" colorSchemeName="facebook">
  <ConnectionOptions host="pg96.priv.lifl.fr" port="5432" login="silifl" password="^^CT[?K\JJH~" database="si_dev" client_encoding="">
    <ssh_secure secure="false" port="22" authentication_mode="0"/>
    <http_tunnel tunneling="false" url="">
      <http_proxy_server use_proxy="false" port="8080"/>
      <http_authentication/>
    </http_tunnel>
  </ConnectionOptions>
</Project>
XML

my $project = Model::Project->new();
my $parser = Pgtp::XMLParser->new($xml,$project);

is( 1, 1,  "I'm ok" );