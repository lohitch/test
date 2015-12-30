require 'spec_helper'

%w(xinetd check-mk-agent check-mk-agent-logwatch).each do |pname|
  describe package(pname) do
    it {should be_installed}
  end
end

%w(/etc/check_mk /usr/local/lib/nagios/plugins).each do |cmkdir|
  describe file(cmkdir) do
    it {should exist}
    it {should be_directory}
    it {should be_mode '0644'}
  end
end

describe file("/etc/xinetd.d/check_mk") do
  it {should exist}
  it { should be_file }
  its(:content){should match /6556/}
end

describe service("xinetd") do
  it {should be_enabled}
  it {should be_running}
end

describe port(6556) do
  it {should be_listening}
end
