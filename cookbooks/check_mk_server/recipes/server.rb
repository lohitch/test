#
# Cookbook Name:: check_mk_server
# Recipe:: server
# Author:: Ravi Bhure (<ravi.bhure@reancloud.com>)
#
# Copyright 2015, REAN Cloud
#
# All rights reserved - Do Not Redistribute
#
# This is a Chef recipe file. It can be used to specify resources which will
# apply configuration to a server.

include_recipe "check_mk_client"

omd_site = node['check_mk_server']['site']
omd_path = node['check_mk_server']['omd_dir']
systemadmin = node['check_mk_server']['systemadmin']
agent_port = node['check_mk_server']['agent_port']

nodes = search(:node, "app_environment:prod*")
#nodes = ''

if (nodes.nil? || nodes.empty?)
  Chef::Log.info("No nodes returned from search, using this node so main.mk has data")
  nodes = Array.new
  nodes << node
end

# Update apt cache
execute "aptupdate" do
  command "apt-get update"
end

#dpkg_package won't install deps for me :-(
%w(xvfb python-ldap libradiusclient-ng2 unzip snmp php-pear php5-gd php5-cgi mysql-server libsnmp-perl libapache2-mod-python libapache2-mod-php5 php5-sqlite php5-mcrypt libapache2-mod-proxy-html traceroute dialog fping graphviz libapache2-mod-fcgid  libdbi-dev libltdl7 libnet-snmp-perl libpango1.0-0 libp11-2 libboost-program-options1.54.0 gdebi-core libsnmp-python apache2-mpm-prefork apache2-utils libboost-system1.54.0 libevent-1.4-2 libreadline5 pyro smbclient).each do |p|
  package p
end

# Download omd package
pkg_cache_path = File.join(Chef::Config[:file_cache_path], File.basename(node['check_mk_server']['package_url']))

remote_file pkg_cache_path do
  source node['check_mk_server']['package_url']
end

# Install omd
dpkg_package 'omd' do
  source pkg_cache_path
end

# Create omd/check_mk site
execute 'create_omd_site' do
  command "/usr/bin/omd create #{omd_site}"
  action :run
  not_if "test -d /omd/sites/#{omd_site}"
end

# omd/check_mk start
execute 'start_omd_site' do
  command "/usr/bin/omd restart #{omd_site}"
  action :run
  not_if "/usr/bin/omd status #{omd_site}"
end

# define check_mk inventory hosts
execute 'cmk_reinventory' do
  command "/bin/su -l -c '#{omd_path}/bin/check_mk --cache -II' #{omd_site}"
  action :nothing
end

# define check_mk reload
execute 'cmk_reload' do
  command "/bin/su -l -c '#{omd_path}/bin/check_mk -O' #{omd_site}"
  action :nothing
end

# check_mk main.mk config
template "#{omd_path}/etc/check_mk/main.mk" do
  source "server/main.mk.erb"
  owner omd_site
  group omd_site
  notifies :run, 'execute[cmk_reinventory]', :immediately
  notifies :run, 'execute[cmk_reload]', :delayed
  variables(
     :nodes => nodes,
     :agent_port => agent_port
     )
end

# check_mk check_mk-base.mk config
template "#{omd_path}/etc/check_mk/conf.d/check_mk-base.mk" do
  source "server/check_mk-base.mk.erb"
  owner omd_site
  group omd_site
  notifies :run, 'execute[cmk_reinventory]', :immediately
  notifies :run, 'execute[cmk_reload]', :delayed
  variables(
     :systemadmin => systemadmin,
     :agent_port => agent_port
     )
end
