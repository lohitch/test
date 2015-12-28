#
# Cookbook Name:: splunk_server
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'uri'

splunk_forwarder_uri = URI.parse(node['splunk_server']['forwarder']['package']['url'])
splunk_forwarder = File.join("/tmp", File.basename(splunk_forwarder_uri.path))
puts splunk_forwarder
remote_file splunk_forwarder do
  action :create
  owner "root"
  group "root"
  mode "0644"
  source splunk_forwarder_uri.to_s
end


package "splunk-forwarder" do
  source splunk_forwarder
  provider case File.extname(splunk_forwarder)
            when ".deb"
              Chef::Provider::Package::Dpkg
            when ".rpm"
              Chef::Provider::Package::Rpm
            else
              Chef::Provider::Package
            end
end

template '/opt/splunkforwarder/etc/system/local/web.conf' do
  source 'web.erb'
  owner 'root'
  group 'root'
  variables ({
     :port => node["splunk_server"]["forwarder"]["port"],
     :ipaddress => node["splunk_server"]["ipaddress"]
  })
end

template '/opt/splunkforwarder/etc/system/local/inputs.conf' do
  source 'input.erb'
  owner 'root'
  group 'root'
end

template '/opt/splunkforwarder/etc/system/local/outputs.conf' do
  source 'output.erb'
  owner 'root'
  group 'root'
end

execute 'splunk-forwarder start' do
  command "/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes"
  action :run
end
