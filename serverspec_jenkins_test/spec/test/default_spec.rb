require 'spec_helper'

%w(xvfb python-ldap libradiusclient-ng2 unzip snmp php-pear php5-gd php5-cgi mysql-server libsnmp-perl libapache2-mod-python libapache2-mod-php5 php5-sqlite php5-mcrypt libapache2-mod-proxy-html traceroute dialog fping graphviz libapache2-mod-fcgid  libdbi-dev libltdl7 libnet-snmp-perl libpango1.0-0 libp11-2 libboost-program-options1.54.0 gdebi-core apache2-mpm-prefork apache2-utils libboost-system1.54.0 libevent-1.4-2 libreadline5 pyro smbclient).each do |pname|
  describe package(pname) do
    it {should be_installed}
  end
end

describe service ('omd') do
it {should be_running}
end

describe file("/omd/sites/rean/etc/check_mk/main.mk") do
  it {should exist}
  it { should be_file }
  its(:content){should match /ALL_HOSTS/}
end

describe file("/omd/sites/rean/etc/check_mk/conf.d/check_mk-base.mk") do
  it {should exist}
  it { should be_file}
  its(:content){should match /agent_port = 6556/}
  its(:content){should match /systemadmin/}
end


describe port(80) do
  it { should be_listening }
end

