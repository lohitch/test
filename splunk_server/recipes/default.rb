#
# Cookbook Name:: splunk_server
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'uri'

splunk_package_uri = URI.parse(node['splunk_server']['package']['url'])
splunk_package = File.join("/tmp", File.basename(splunk_package_uri.path))
puts splunk_package

remote_file splunk_package do
  action :create
  owner "root"
  group "root"
  mode "0644"
  source splunk_package_uri.to_s
end

package "splunk-server" do
  source splunk_package
  provider case File.extname(splunk_package)
            when ".deb"
              Chef::Provider::Package::Dpkg
            when ".rpm"
              Chef::Provider::Package::Rpm
            else
              Chef::Provider::Package
            end
end

template '/opt/splunk/etc/system/local/web.conf' do
  source 'web.erb'
  owner 'root'
  group 'root'
  variables({
     :port => node["splunk_server"]["splunk"]["port"],
     :ipaddress => node["splunk_server"]["ipaddress"]

    })
end


execute 'splunk-server start' do
  command "/opt/splunk/bin/splunk start --accept-license --answer-yes"
  action :run
end

include_recipe "splunk_server::forwarder"


