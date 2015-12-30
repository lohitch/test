require 'spec_helper'

describe service('splunk') do
it {should be_running}
end

describe file("/opt/splunk/etc/system/local/web.conf") do
  it {should exist}
  it { should be_file }
end
