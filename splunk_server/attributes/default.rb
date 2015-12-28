case platform
  
  when "debian", "ubuntu"
    default["splunk_server"]["package"]["url"] = "http://download.splunk.com/products/splunk/releases/6.3.2/splunk/linux/splunk-6.3.2-aaff59bb082c-linux-2.6-amd64.deb"
    default["splunk_server"]["forwarder"]["package"]["url"] = "http://download.splunk.com/products/splunk/releases/6.3.2/universalforwarder/linux/splunkforwarder-6.3.2-aaff59bb082c-linux-2.6-amd64.deb"  
  when "centos", "redhat", "amazon", "scientific"
    default["splunk_server"]["package"]["url"] = "http://download.splunk.com/products/splunk/releases/6.3.2/splunk/linux/splunk-6.3.2-aaff59bb082c-linux-2.6-x86_64.rpm"
    default["splunk_server"]["forwarder"]["package"]["url"] = "http://download.splunk.com/products/splunk/releases/6.3.2/universalforwarder/linux/splunkforwarder-6.3.2-aaff59bb082c-linux-2.6-x86_64.rpm"
end

    default["splunk_server"]["splunk"]["port"] =  8089
    default["splunk_server"]["forwarder"]["port"] = 8888

    default["splunk_server"]["ipaddress"] = "127.0.0.1"