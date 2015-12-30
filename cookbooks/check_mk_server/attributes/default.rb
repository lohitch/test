#
# Cookbook Name:: check_mk_server
# Author:: Ravi Bhure (<ravi.bhure@reancloud.com>)

# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

default['check_mk_server']['package_url'] = 'http://files.omdistro.org/releases/debian_ubuntu/omd-1.20.trusty.amd64.deb'
default['check_mk_server']['site'] = "rean"
default['check_mk_server']['omd_dir'] = "/omd/sites/#{node['check_mk_server']['site']}"
default['check_mk_server']['systemadmin'] = "ravi.bhure@reancloud.com"
default['check_mk_server']['agent_port'] = "6556"