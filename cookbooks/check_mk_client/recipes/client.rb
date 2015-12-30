#
# Cookbook Name:: check_mk_client
# Recipe:: client
# Author:: Ravi Bhure (<ravi.bhure@reancloud.com>)
#
# Copyright 2015, REAN Cloud
#
# All rights reserved - Do Not Redistribute
#
# This is a Chef recipe file. It can be used to specify resources which will
# apply configuration to a server.

agent_port = node['check_mk_client']['port']

# Define xinetd service
execute 'service_xinetd' do
  command "service xinetd restart"
  action :nothing
end

# Install check_mk client packages
['xinetd', 'check-mk-agent', 'check-mk-agent-logwatch'].each do |p|
  package p
end

# Copying check_mk client config
template '/etc/xinetd.d/check_mk' do
  source "client/check_mk.erb"
  notifies :run, 'execute[service_xinetd]'
  variables(
     :agent_port => agent_port
     )
end

# Nagios plugins
directory node['check_mk_client']['plugins_dir'] do
  recursive true
  mode '0644'
  action :create
end

# mrpe conf dir
directory "/etc/check_mk" do
  recursive true
  mode '0644'
  action :create
end

# manage system service
service 'xinetd' do
  action :enable
end
