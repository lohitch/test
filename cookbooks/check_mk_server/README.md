# check_mk_server

Use this cookbook to Installs/Configures The Check_MK Server

Description
===========

[Check_MK](http://mathias-kettner.de/check_mk.html) is described as a general purpose Nagios-plugin for retrieving data. This cookbook aims to Installs/Configures The Check_MK Server.

Check_MK UI open at following URL with username ```omdadmin``` and password ```omd```

* http://serverip/sitename/check_mk

Requirements
============

Platform
--------

### Currently supported platforms

* Ubuntu

### Platforms to be supported (TODO)

* RedHat
* CentOS

Depends cookbook
-------

* check_mk_client

Attributes
==========

Default attributes
------------------

The cookbook attributes

* `node['check_mk_server']['package_url']` - Check_MK omd distro package url  (Default: [Check_MK Package URI](http://files.omdistro.org/releases/debian_ubuntu/omd-1.20.trusty.amd64.deb))
* `node['check_mk_server']['site']` - Check_MK/omd site name (Default: "rean")
* `node['check_mk_server']['systemadmin']` - Check_MK contact email address, who will receive email alerts (Default: "ravi.bhure@reancloud.com")
* `node['check_mk_server']['agent_port']` - Check_MK agent port (Default: 6556)
