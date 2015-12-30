# check_mk_client

Use this cookbook to Installs/Configures The Check_MK Client

Description
===========

[Check_MK](http://mathias-kettner.de/check_mk.html) is described as a general purpose Nagios-plugin for retrieving data. This cookbook aims to Installs/Configures The Check_MK Client.

Requirements
============

Platform
--------

### Currently supported platforms

* Ubuntu

### Platforms to be supported (TODO)

* RedHat
* CentOS

Attributes
==========

Default attributes
------------------

The cookbook attributes

* `node['check_mk_client']['port']` - Check_MK agent port (Default: 6556)
* `node['check_mk_client']['plugins_dir']` - Nagios plugins directory, used primarily to target plugins from the agent (MRPE) (Default: /usr/local/lib/nagios/plugins)
* `node['app_environment']` - Check_MK agent environment, which will use to search nodes on check_mk server (Default: production)

