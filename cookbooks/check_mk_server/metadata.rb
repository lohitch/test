name             "check_mk_server"
maintainer       "REAN Cloud Inc"
maintainer_email "ravi.bhure@reancloud.com"
license          "Copyright (c) 2015 REAN Cloud, Inc.  All rights reserved."
description      "Installs/Configures Check_MK Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

# We only support LTS version
supports 'ubuntu'

depends 'check_mk_client'
