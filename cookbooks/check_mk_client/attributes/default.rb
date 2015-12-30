#
# Cookbook Name:: check_mk_client
# Author:: Ravi Bhure (<ravi.bhure@reancloud.com>)

# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

default['check_mk_client']['port'] = "6556"
default['check_mk_client']['plugins_dir'] = '/usr/local/lib/nagios/plugins'
default['app_environment'] = "production"
